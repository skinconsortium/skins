#include <lib/std.mi>
#define WIDTH_SLAYER 90

Function causeGlow(int obj, int mode, boolean reverse);
Function playPause(boolean revp);

Global GuiObject play, pause;
Global slider seekSlider;
Global layer sLayer;
Global timer tmr;

Global text Songticker;

System.onScriptLoaded() {
	group butg=getScriptGroup();
	play=butg.getObject("play");
	pause=butg.getObject("pause");

	songticker = butg.findObject("songticker");

	sLayer=butg.getObject("seek.layer");
	seekSlider=butg.getObject("seek");

	sLayer.setXMLParam("w", integerToString((seekSlider.getPosition()*WIDTH_SLAYER)/255));
	  tmr = new Timer;
	  tmr.setDelay(1000);
}

System.onScriptUnloading() {
	if (tmr) {
		tmr.stop();
		delete tmr;
	}
}

sLayer.onsetVisible(int v) {
	if (v) tmr.start();
	else tmr.stop();
}

tmr.onTimer() {
	layout l = sLayer.getParentLayout();
	int x = l.getGuiX();
	int y = l.getGuiY();
	int h = l.getGuiH();
	int w = l.getGuiW();

	if (x+w < 0 || y+h < -1 || x > getViewPortWidth() /*|| y > getViewPortHeight() + 1*/) {
		l.center();
	}
	
}

playPause(boolean revp) {
	if(revp) {
		pause.hide();
		play.hide();
		play.hide();
		pause.show();
	} else if(!revp) {
		pause.hide();
		play.hide();
		pause.hide();
		play.show();
	}
}

seekSlider.onPostedPosition(int newpos) {
	sLayer.setXMLParam("w", integerToString((seekSlider.getPosition()*WIDTH_SLAYER)/255));
}
seekSlider.onSetPosition(int newpos) {
Songticker.sendAction("setText", "Seek to: " + System.integerToTime(newpos/255*getPlayitemLength()) + "/" + integerToTime(getPlayitemLength()), 0, 0, 0, 0);

	seekSlider.onPostedPosition(newpos);
}

seekSlider.onSetFinalPosition(int newpos) {
	seeksLider.onPostedPosition(newpos);
}

System.onStop() {sLayer.setXMLParam("w", "0"); }

seekSlider.onEnterArea() {
	sLayer.setXMLParam("image", "shadesongd");
}

seekSlider.onLeaveArea() {
	sLayer.setXMLParam("image", "shadesong");
}