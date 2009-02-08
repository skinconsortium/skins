/*************************************************************

  seeker.m
  by Leechbite

  Controls the seeker mainly the temptext.

*************************************************************/


#define ENABLE_TEMPTEXT

#include <lib/std.mi>

function updateseeker(int x);

Global group frameGroup;
Global layout main;
Global slider dummySlider;
Global guiObject seeker, seekerBase;
Global boolean seekChanging = 0;
Global int w, woff;

Global string origright;
Global int lastsmallwid;

System.onScriptLoaded() {
  frameGroup = getScriptGroup();
  main = frameGroup.getParentLayout();
  string param = getParam();

  dummySlider = frameGroup.getObject(getToken(param,",",0));
  seeker = frameGroup.getObject(getToken(param,",",1));
  seekerbase = frameGroup.getObject(getToken(param,",",2));
  
  origright = seeker.getXMLParam("right");

  woff = 14;
}

System.onScriptUnloading() {
  return;
}

dummySlider.onLeftButtonDown(int x, int y) {
  if (getPlayItemLength() > 0) { 
    SeekChanging = 1;
    updateSeeker(getPosition());
  }
}

dummySlider.onLeftButtonUp(int x, int y) {
  float l;
  if (SeekChanging) {

    int p = x - seekerbase.getLeft();
    w = seekerbase.getWidth()-woff;
    if (p > w) p=w;
	if (p < 0) p=0;
    if (w<0) w = 1;

    //seekTo(System.getPlayItemLength()*p/w);
    
    SeekChanging = 0;
    updateSeeker(getPosition());
  }
}


dummySlider.onMouseMove(int x, int y) {
	if (SeekChanging) {
		updateSeeker(getPosition());
	}
}

dummySlider.onSetPosition(int newpos) {
	if (SeekChanging) return;
	
	int neww = (seekerbase.getWidth()-woff)*newpos;
	int mod = neww % 255;
	neww = neww/255;
	
	if (mod > 127) neww++;
	
	seeker.setXMLParam("w", integerToString(neww));
}

dummySlider.onPostedPosition(int newpos) {
	dummySlider.onSetPosition(newpos);
}

seekerbase.onResize(int x, int y, int w, int h) {
	
	dummySlider.onsetPosition(dummySlider.getPosition());
}

seeker.onResize(int x, int y, int w, int h) {
	if (w < 30 && !lastsmallwid) {
		setXMLParam("right","");
		lastsmallwid = 1;
	} else if (w >= 30 && lastsmallwid) {
		setXMLParam("right",origright);
		lastsmallwid = 0;
	}
}

updateSeeker(int x) {

	w = seekerbase.getWidth()-woff;

	int p = x;
	
	if (p < 0) p=0;
    if (w<0) w = 1;

	float len = System.getPlayItemLength();
	int s = (x * len) / w;
	main.sendAction("INDTEXT", "Seek: " + integerToTime(s) + "/" + integerToTime(len) + " ("+integerToString(p*100/255)+"%)", 0,0,0,0);
	
	seeker.setXMLParam("w", integerToString(x*w/255));

}

System.onTitleChange(String newtitle) {
	int len = getPlayItemLength();
	if (len > 0)
		seeker.setXMLParam("w", integerToString((seekerbase.getWidth()-woff)*getPosition()/getPlayItemLength()));
	else
		seeker.setXMLParam("w", "0");
}