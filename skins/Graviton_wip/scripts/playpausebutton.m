#include "../../../lib/std.mi"
#include "defines.m"

Global Layout lShade;
Global Group gShade;
Global Button shadePlay, shadePause;

function changebut(boolean s);
function fadeinout(guiobject g, int alph, int speed);

system.onScriptLoaded() {
	lShade = getContainer("main").getLayout("winshade");

	gShade = lShade.getObject("winshade.control.buttons");

	shadePlay = gShade.getObject("shade.play");
	shadePause = gShade.getObject("shade.pause");
	
	//catch if refresh or onload
	if (System.getStatus()==STATUS_PAUSED || System.getStatus()==STATUS_STOPPED) 
	{
		shadePlay.show();
		shadePause.hide();
	} 
	else 
	{
		shadePlay.hide();
		shadePause.show();
	}

}

system.onPlay() {
	changebut(0);
}

system.onPause() {
	changebut(1);
}

system.onResume() {
	changebut(0);
}

system.onStop() {
	changebut(1);
}

changebut(boolean s) {
	if(s) {
		fadeinout(shadePause, 0, 1);
	} else {
		fadeinout(shadePlay, 0, 1);
	}
}

shadePlay.onTargetReached() {
	if(shadePlay.getAlpha()==0) {
		shadePlay.hide();
		fadeinout(shadePause, 255, 1);
	}
}

shadePause.onTargetReached() {
	if(shadePause.getAlpha()==0) {
		shadePause.hide();
		fadeinout(shadePlay, 255, 1);
	}
}

fadeinout(guiobject g, int alph, int speed) {
	g.show();
	g.setTargetA(alph);
	g.setTargetSpeed(0.5);
	g.gotoTarget();
}