#include "../../../lib/std.mi"
#include "defines.m"

Global Group gMain;
Global Button butPlay, butPause, butPrev, butNext, butLoad, butStop;
Global Layer layerPlay, layerPause, layerPrev, layerNext, layerLoad, layerStop;

function changebut(boolean s, guiobject obj);
function changestatus(boolean s);
function fadeinout(guiobject g, int alph, int speed);

system.onScriptLoaded() {
	
	gMain = getScriptGroup();

	butPlay = gMain.getObject("play");
	butPause = gMain.getObject("pause");
	butPrev = gMain.getObject("prev");
	butNext = gMain.getObject("next");
	butLoad = gMain.getObject("load");
	butStop = gMain.getObject("stop");

	layerPlay = gMain.getObject("layer.play");
	layerPause = gMain.getObject("layer.pause");
	layerPrev = gMain.getObject("layer.prev");
	layerNext = gMain.getObject("layer.next");
	layerLoad = gMain.getObject("layer.load");
	layerStop = gMain.getObject("layer.stop");

	if(getStatus() == 1) {
		butPlay.hide();
		layerPlay.hide();
	} else {
		butPause.hide();
		layerPause.hide();
	}
}

system.onPlay() {
	changestatus(0);
}

system.onPause() {
	changestatus(1);
}

system.onResume() {
	changestatus(0);
}

system.onStop() {
	changestatus(1);
}

layerPlay.onEnterArea() {
	changebut(1, layerPlay);
}

layerPause.onEnterArea() {
	changebut(1, layerPause);
}

layerPrev.onEnterArea() {
	changebut(1, layerPrev);
}

layerNext.onEnterArea() {
	changebut(1, layerNext);
}

layerLoad.onEnterArea() {
	changebut(1, layerLoad);
}

layerStop.onEnterArea() {
	changebut(1, layerStop);
}

butPlay.onLeaveArea() {
	changebut(0, layerPlay);
}

butPause.onLeaveArea() {
	changebut(0, layerPause);
}

butPrev.onLeaveArea() {
	changebut(0, layerPrev);
}

butNext.onLeaveArea() {
	changebut(0, layerNext);
}

butLoad.onLeaveArea() {
	changebut(0, layerLoad);
}

butStop.onLeaveArea() {
	changebut(0, layerStop);
}

butPlay.onTargetReached() {
	if(butPlay.getAlpha()==0) {
		butPlay.hide();
		layerPlay.hide();
		fadeinout(butPause, 255, 1);
		fadeinout(layerPause, 255, 1);
	}
}

butPause.onTargetReached() {
	if(butPause.getAlpha()==0) {
		butPause.hide();
		layerPause.hide();
		fadeinout(butPlay, 255, 1);
		fadeinout(layerPlay, 255, 1);
	}
}

changebut(boolean s, guiobject obj) {
	if(s) {
		fadeinout(obj, 1, 1);
		obj.setxmlparam("ghost", "1");
	} else {
		fadeinout(obj, 255, 1);
		obj.setxmlparam("ghost", "0");
	}
}

changestatus(boolean s) {
	if(s) {
		fadeinout(butPause, 0, 1);
		fadeinout(layerPause, 0, 1);
	} else {
		fadeinout(butPlay, 0, 1);
		fadeinout(layerPlay, 0, 1);
	}
}

fadeinout(guiobject g, int alph, int speed) {
	g.show();
	g.setTargetA(alph);
	g.setTargetSpeed(0.5);
	g.gotoTarget();
}