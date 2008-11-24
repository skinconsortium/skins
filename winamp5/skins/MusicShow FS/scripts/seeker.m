/*************************************************************

  seeker.m
  by Leechbite

  Controls the seeker mainly the temptext.

*************************************************************/


#define ENABLE_TEMPTEXT

#include <lib/std.mi>

function updateseeker(int x);

Global group frameGroup;
Global slider dummySlider;
Global guiObject seeker, seekerBase;
Global boolean seekChanging = 0;
Global int w, woff;

System.onScriptLoaded() {
  frameGroup = getScriptGroup();
  string param = getParam();

  dummySlider = frameGroup.getObject(getToken(param,",",0));
  seeker = frameGroup.getObject(getToken(param,",",1));
  seekerbase = frameGroup.getObject(getToken(param,",",2));

  woff = 14;
}

System.onScriptUnloading() {
  return;
}

seekerbase.onLeftButtonDown(int x, int y) {
  if (getPlayItemLength() > 0) { 
    SeekChanging = 1;
    updateSeeker(x);
  }
}

seekerbase.onLeftButtonUp(int x, int y) {
  float l;
  if (SeekChanging) {

    int p = x - seekerbase.getLeft();
    w = seekerbase.getWidth()-woff;
    if (p > w) p=w;
	if (p < 0) p=0;
    if (w<0) w = 1;

    seekTo(System.getPlayItemLength()*p/w);
    
    SeekChanging = 0;
  }
}


seekerbase.onMouseMove(int x, int y) {
	if (SeekChanging) {
		updateSeeker(x);
	}
}

dummySlider.onSetPosition(int newpos) {
	if (SeekChanging) return;
	
	seeker.setXMLParam("w", integerToString((seekerbase.getWidth()-woff)*newpos/255));
}

dummySlider.onPostedPosition(int newpos) {
	dummySlider.onSetPosition(newpos);
}

seekerbase.onResize(int x, int y, int w, int h) {
	dummySlider.onsetPosition(dummySlider.getPosition());
}

updateSeeker(int x) {

	w = seekerbase.getWidth()-woff;
	int p = x - seekerbase.getLeft();
	
	if (p > w) p=w;
	if (p < 0) p=0;
    if (w<0) w = 1;
    
	if (p >= 0) {

		float len = System.getPlayItemLength();
		int s = (p * len) / w;
		//setTempText("Seek: " + integerToTime(s) + "/" + integerToTime(len) + " ("+integerToString(p*100/w)+"%)");
		
		seeker.setXMLParam("w", integerToString(p));
	} else {
		seeker.setXMLParam("w", "0");
	}
}

System.onTitleChange(String newtitle) {
	int len = getPlayItemLength();
	if (len > 0)
		seeker.setXMLParam("w", integerToString((seekerbase.getWidth()-woff)*getPosition()/getPlayItemLength()));
	else
		seeker.setXMLParam("w", "0");
}