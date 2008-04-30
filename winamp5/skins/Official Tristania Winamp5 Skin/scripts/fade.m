/*---------------------------------------------------
-----------------------------------------------------
Filename:	fade.m

Type:		maki/source
Version:	skin version 1.1
Date:		31. Dez. 2005 - 11:56 
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
		www.skinconsortium.com
-----------------------------------------------------
--------------------INCLUDES-------------------------
-fadeBand
-----------------------------------------------------
----------------------NOTE---------------------------
I've written all the scripts on my own. I was only
inspired by other ones, but I never copied a whole
script or parts of it! 'Cause everyone has to learn
or inspire I implement the source files too.
But if you use parts or the entire script, mail me:
Give me your name, write a little text about your
skin and a skinshot! Then leave my header in the .m
file and implement it in your skin and leave credit
to my name, email and homepage where credit is done!
THX! Deimos
-----------------------------------------------------
---------------------------------------------------*/
#include "../../../lib/std.mi"


Function fillBand(int newpos);
Function updateSeekAnim(int x, int y);

Global Map eqmap;
Global Layer fill;
Global Slider eqband;

Global String str_container = "this";
Global Timer textfader;
Global Text SongTicker;
Global int i_count, su;


System.onScriptUnloading() {

	delete eqmap;
	delete textfader;

}

System.onSetXuiParam(String stringParam, String stringValue) {
	if (strlower(stringParam) == "link") {
		eqband = getScriptGroup().getParent().findObject(stringValue);

		fill = getScriptGroup().findObject("fill");
		eqband.bringtoFront();
		eqmap = new Map;
		eqmap.loadMap("fade.slider.map");

		su = 1;
		fillBand(eqband.getPosition());
		su = 0;
	}
	if (strlower(stringParam) == "songtickercontainer") str_container = stringValue;
}

System.onScriptLoaded() {
	str_container = "this";
	textfader = new Timer;
	textfader.setDelay(1000);
}

fillBand(int newpos) {
	Region fillreg = new Region;
	fillreg.loadFromMap(eqmap, newpos * 12.75, 1);
	fill.setRegion(fillreg);
	delete fillreg;

	if (su) return;
	layout _main_normal;
	if (str_container == "this") _main_normal = eqband.getParentLayout();
	else { 
		container c = System.getContainer(getToken(str_container, ";", 0));
		if (!c) return;
		_main_normal = c.getLayout(getToken(str_container, ";", 1));
	}
	if (!_main_normal) return;
	SongTicker = _main_normal.findObject("Songticker");
	textfader.stop();
	SongTicker.setAlternateText("X-FADE: " + integerToString(newpos) + " sec");
	i_count = 0;
	textfader.start();
}
textfader.onTimer() {
	i_count++;
	if (i_count == 1) {
		SongTicker.setAlternateText("");
	}
}

eqband.onSetPosition(int pos) { fillBand(pos); }
eqband.onPostedPosition(int pos) { fillBand(pos); }
eqband.onSetFinalPosition(int pos) { fillBand(pos); }
/*System.onEqBandChanged(int band, int newvalue) {
	string s = eqband.getXMLParam("param");
	if ((integerToString(band + 1)) == s) fillBand(newvalue);
}
System.onEqPreampChanged(int newvalue) {
	string s = eqband.getXMLParam("param");
	if ("preamp" == s) fillBand(newvalue);
}*/