/*---------------------------------------------------
-----------------------------------------------------
Filename:	pan.m

Type:		maki/source
Version:	skin version 1.1
Date:		02. Jan. 2006 - 13:19 
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
		www.skinconsortium.com
-----------------------------------------------------
--------------------INCLUDES-------------------------
-Balance Knob
-----------------------------------------------------
---------------------------------------------------*/
#include "../../../lib/std.mi"

Function setAnim(int newpos);

Global AnimatedLayer knob, bg;
Global Slider pan;

Global String str_container = "this";
Global Timer textfader;
Global Text SongTicker;
Global int i_count, su;


System.onScriptLoaded() {
	pan = getScriptGroup().findObject("Balance");

	knob = getScriptGroup().findObject("pan.knobanim");
	bg = getScriptGroup().findObject("pan.anim");

	str_container = "this";
	str_container = getToken(getParam(), ":", 1);
	textfader = new Timer;
	textfader.setDelay(1000);

	su = 1;
	setAnim(pan.getPosition());
	su = 0;
}

setAnim(int newpos) {
	int v = newpos/255*19;
	knob.gotoFrame(v);
	bg.gotoFrame(v);

	if (su) return;
	layout _main_normal;
	if (str_container == "this") _main_normal = knob.getParentLayout();
	else { 
		container c = System.getContainer(getToken(str_container, ";", 0));
		if (!c) return;
		_main_normal = c.getLayout(getToken(str_container, ";", 1));
	}
	if (!_main_normal) return;
	SongTicker = _main_normal.findObject("Songticker");
	textfader.stop();

	if (newpos == 127) SongTicker.setAlternateText("Balance: Center");
	else if (newpos < 127) SongTicker.setAlternateText("Balance: " + integerToString((-1) * (newpos - 127) / 127 * 100) + "% Left");
	else if (newpos > 127) SongTicker.setAlternateText("Balance: " + integerToString((newpos - 128) / 127 * 100) + "% Right");	
	i_count = 0;
	textfader.start();
}
textfader.onTimer() {
	i_count++;
	if (i_count == 1) {
		SongTicker.setAlternateText("");
	}
}

pan.onSetPosition(int pos) { 
	setAnim(pos); 
}

pan.onPostedPosition(int newpos) { 
	setAnim(pos); 
}
pan.onSetFinalPosition(int pos) { 
	setAnim(pos); 
}
