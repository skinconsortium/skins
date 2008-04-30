/*---------------------------------------------------
-----------------------------------------------------
Filename:	eq.m

Type:		maki/source
Version:	skin version 1.1
Date:		31. Dez. 2005 - 11:56 
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
		www.skinconsortium.com
-----------------------------------------------------
--------------------INCLUDES-------------------------
-EqBands
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
Global string link;


System.onScriptUnloading() {

	delete eqmap;
	delete textfader;

}

System.onSetXuiParam(String stringParam, String stringValue) {
	if (strlower(stringParam) == "link") {
		link = stringValue;
		eqband = getScriptGroup().getParent().findObject(stringValue);

		fill = getScriptGroup().findObject("fill");
		eqband.bringtoFront();
		eqmap = new Map;
		eqmap.loadMap("eq.slider.map");

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
//	if (eqband.getXMLParam("param") == "preamp") {
		if (newpos >= -3 && newpos <= 3 && newpos != 0) {
			eqband.onSetPosition(0);
			return;
		}
//	}
	Region fillreg = new Region;
	fillreg.loadFromMap(eqmap, 128+newpos, 1);
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
	float f = newpos / 127 * 20;
	string w;
	if (link == "preamp") { w="Preamp"; }
	if (link == "eq1") { w="60Hz"; }
	if (link == "eq2") { w="170Hz"; }
	if (link == "eq3") { w="310Hz"; }
	if (link == "eq4") { w="600Hz"; }
	if (link == "eq5") { w="1kHz"; }
	if (link == "eq6") { w="3kHz"; }
	if (link == "eq7") { w="6kHz"; }
	if (link == "eq8") { w="12kHz"; }
	if (link == "eq9") { w="14kHz"; }
	if (link == "eq10") { w="16kHz"; }

	SongTicker.setAlternateText("EQ: " + w + ": " + floatToString(f, 1) + " dB");
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
System.onEqBandChanged(int band, int newvalue) {
	string s = eqband.getXMLParam("param");
	if ((integerToString(band + 1)) == s) fillBand(newvalue);
}
System.onEqPreampChanged(int newvalue) {
	string s = eqband.getXMLParam("param");
	if ("preamp" == s) fillBand(newvalue);
}