/*---------------------------------------------------
-----------------------------------------------------
Filename:	eq.m

Type:		maki/source
Version:	skin version 1.1
Date:		07. Sep. 2005 - 09:58 
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
---------------------------------------------------*/

#include "../../../lib/std.mi"
#include "attribs.m"

Function fade(GuiObject obj, float speed, int alpha);
Function extractString(string baseString, string toreplace);

Global Group g_eq, g_vis;
Global ToggleButton tgb_eq;
Global Int attribs_mychange;
Global AnimatedLayer titananim;
Global Layer titananimbg;
Global Text t_Songticker;

Global Slider slidercb;
Global Text fadertext;
Global Button CFIncrease, CFDecrease;
Global ToggleButton Crossfade;
Global ConfigAttribute ca_crossfade;

Global Button btn_ctNext;
Global Timer tmr;
Global String lastct;

Global String left, right;

System.onScriptLoaded() {
	initAttribs();
	g_eq = getScriptGroup().findObject("player.eq");
	g_eq.setAlpha(0);
	g_eq.hide();
	g_vis = getScriptGroup().findObject("player.vis");
	g_vis.setAlpha(0);
	g_vis.hide();
	t_Songticker = getScriptGroup().findObject("Songticker");

	tgb_eq = getScriptGroup().getParentLayout().findObject("eq");
	eq_visible_attrib.onDataChanged();

	slidercb = g_eq.findObject("sCrossfade");
	fadertext = g_eq.findObject("CFDisplay");
	CFIncrease = g_eq.findObject("CrossfadeIncrease");
	CFDecrease = g_eq.findObject("CrossfadeDecrease");
	Crossfade = g_eq.findObject("Crossfade");
	slidercb.onSetPosition(slidercb.getPosition());

	if (!Crossfade.getActivated()) fadertext.setAlpha(130); else fadertext.setAlpha(255);

	extractString(getSkinName(), "_");

	btn_ctNext = getScriptGroup().findObject("ctNext.dummy");
	lastct = getPrivateString("Color Themes/"+left, right , "Panther (Default)");
	colortheme_attrib.setData(lastct);

	tmr = new Timer;
	tmr.setDelay(500);
	tmr.start();
/*
	titananim = playerdisplay.findObject("titananim");
	titananimbg = PlayerDisplay.findObject("titananimbg");

	titananim.play();*/
}
/*
titananim.onStop() {
	fade(titananim, 0.5, 0);
	fade(titananimbg, 0.5, 0);
}

titananim.onTargetReached() {
	eq_visible_attrib.onDataChanged();
}
*/
eq_visible_attrib.onDataChanged() {
	if (attribs_mychange) return;
	tgb_eq.setActivated(stringToInteger(getData()));
	if (getData() == "1") {
		g_eq.show();
		g_vis.hide();
		fade(g_vis, 0.5, 0);
		t_songticker.setXMLParam("x", "135");
		t_songticker.setXMLParam("w", "-137");
	} if (getData() == "0") {
		g_vis.show();
		g_eq.hide();
		fade(g_eq, 0.5, 0);
	}
}

tgb_eq.onToggle(Boolean onoff) {
	attribs_mychange = 1;
	eq_visible_attrib.setData(integerToString(onoff));
	if (onoff == 1) {
		g_eq.show();
		g_vis.hide();
		fade(g_vis, 0.5, 0);
		t_songticker.setXMLParam("x", "135");
		t_songticker.setXMLParam("w", "-137");
	} if (onoff == 0) {
		g_vis.show();
		g_eq.hide();
		fade(g_eq, 0.5, 0);
	}
	attribs_mychange = 0;
}
g_eq.onTargetReached() {
	if (getAlpha() == 0) fade(g_vis, 0.5, 255);
}
g_vis.onTargetReached() {
	if (getAlpha() == 0) fade(g_eq, 0.5, 255);
	if (getAlpha() == 255) {
		t_songticker.setXMLParam("x", "13");
		t_songticker.setXMLParam("w", "-15");
	}
}

fade(GuiObject obj, float speed, int alpha) {
	obj.setTargetSpeed(speed);
	obj.setTargetA(alpha);
	obj.gotoTarget();
}


slidercb.onSetPosition(int val) {
	String s = IntegerToString(val);
	fadertext.setText(s);
}

ca_crossfade.onDataChanged() {
	fadertext.setText(getData());
}

CFIncrease.onLeftClick() {
	slidercb.SetPosition(slidercb.getPosition()+1);
}

CFDecrease.onLeftClick() {
	slidercb.SetPosition(slidercb.getPosition()-1);
}

Crossfade.onToggle(boolean on) {
	if (!on) fadertext.setAlpha(130); else fadertext.setAlpha(255);
}

/** Colorthemes **/

System.onTitleChange(string s) {
	if(colorthemes_random_attrib.getData() == "1") btn_ctNext.leftClick();
}

tmr.onTimer() {
	string xct = lastct;
	lastct = getPrivateString("Color Themes/"+left, right , "Panther (Default)");
	if (lastct != xct) {
		colortheme_attrib.setData(lastct);
	}
}

extractString(string baseString, string toreplace) {
	int i = strsearch(baseString, toreplace);
	if (i == -1) return baseString;
	left = strleft(baseString, i);
	right = strright(basestring, strlen(basestring) - i - strlen(toreplace));
}