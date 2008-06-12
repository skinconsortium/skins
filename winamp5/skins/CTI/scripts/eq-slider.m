/*---------------------------------------------------
-----------------------------------------------------
Filename:	eq-slider.m
Version:	1.1

Type:		maki
Date:		07. Aug. 2006 - 18:35 
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
-----------------------------------------------------
---------------------------------------------------*/
#include "../../../lib/std.mi"


Function fillBand(int newpos);
Function updateSeekAnim(int x, int y);

Global Map eqmap;
Global Layer fill;
Global Slider eqband;

Global String str_container = "this";
Global Text SongTicker;
Global int i_count, su;
Global string link;


System.onScriptUnloading() {

	delete eqmap;

}

System.onSetXuiParam(String stringParam, String stringValue) {
	if (strlower(stringParam) == "link") {
		link = stringValue;
		eqband = getScriptGroup().getParent().findObject(stringValue);

		fill = getScriptGroup().findObject("fill");
		eqband.bringtoFront();
		eqmap = new Map;
		eqmap.loadMap("player.eq.map");

	}
	if (strlower(stringParam) == "songtickercontainer") str_container = stringValue;

}

System.onScriptLoaded() {
	str_container = "this";
}

fillBand(int newpos) {
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

	SongTicker.sendAction("showinfo", "EQ: " + w + ": " + floatToString(f, 1) + " dB", 0, 0, 0, 0);
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