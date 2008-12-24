/*************************************************************

  volumeslider.m
  by Leechbite.com

  Controls the volume led-style slider.
  
  param = "vol_layer_ID,vol_mousetrap_ID,orientation"
  orientation - horizontal, vertical. default is horizontal

*************************************************************/


#include <lib/std.mi>

Global group frameGroup;
Global guiObject volTrap;
Global guiObject volAnim;
Global boolean volChanging = false, blink;
Global string orientation;
Global int lastVol; // records last volume before mute/att

System.onScriptLoaded() {

	frameGroup = getScriptGroup();
	string param = getParam();

	volAnim = frameGroup.getObject(getToken(param,",",0));
	volTrap = frameGroup.getObject(getToken(param,",",1));
	
	orientation = strlower(getToken(param,",",2));
	if (orientation == "") orientation = "horizontal";

	System.onVolumeChanged(getVolume());
}

System.onScriptUnloading() {
	return;
}

System.onVolumeChanged(int newvol) {
	//if (!volAnim) return;
	
	if (orientation == "vertical")
		volAnim.setXMLParam("h", integerToString(newvol*volTrap.getHeight()/255));
	else
		volAnim.setXMLParam("w", integerToString(newvol*volTrap.getWidth()/255));
}

volTrap.onLeftButtonDown(int x, int y) {
	volChanging = true;
  
	if (orientation == "vertical")
		setVolume(255-(y-getTop())*255/getHeight());
	else
		setVolume((x-getLeft())*255/getWidth());
}

volTrap.onMouseMove(int x, int y) {
	if (!volChanging) return;
  
	if (y < getTop()) y = getTop();
	if (y > (getTop()+getHeight())) y = getTop()+getHeight();
	if (x < getLeft()) x = getLeft();
	if (x > (getLeft()+getWidth())) x = getLeft()+getWidth();
  
	if (orientation == "vertical")
		setVolume(255-(y-getTop())*255/getHeight());
	else
		setVolume((x-getLeft())*255/getWidth());
}

volTrap.onLeftButtonUp(int x, int y) {
	volChanging = false;
}