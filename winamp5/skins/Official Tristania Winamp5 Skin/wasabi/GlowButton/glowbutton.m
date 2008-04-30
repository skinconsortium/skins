/*---------------------------------------------------
-----------------------------------------------------
Filename:	glowbutton.m

Type:		maki/source
Version:	skin version 1.2
Date:		10:11 30.08.2004
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
-----------------------------------------------------
--------------------INCLUDES-------------------------
-Handling for Glowbuttons
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

#include "../../../../lib/std.mi"
#include "../../../../lib/config.mi"

#define FILENAME "glowbutton.m"
#include "../../../../lib/ripprotection.mi"

Function startGlow();
Function stopGlow();
Function getGlowLink(string str_GB_id);
Function loadForStatus(string statusId);

Class ToggleButton GlowButton;

Global GuiObject XUIGroup;
Global GlowButton _Glowbutton;
Global Layer l_glowN, l_glowH;
Global Float targetspeedin;
Global Float targetspeedout;
Global Boolean _status = 0;
Global String str_statusId = "";
Global String str_stmsg = "_ERROR_";
Global Timer textfader, beat;
Global Text SongTicker;
Global Int i_count = 0;
Global String str_fade, str_oldtxt, overid, actoverid;
Global String str_container = "this";
Global Boolean b_extstm = 0, tgifact = 0, nocfgvals = 0;

//Global Layout _main_normal;
Global Group PlayerContent, PlayerDisplay;

Global Layer l_overlay;

Global ConfigAttribute ca_beat, ca_speed;

System.onScriptLoaded() {

	XUIGroup = getScriptGroup();
	str_container = "this";

	_Glowbutton = XUIGroup.findObject("glowbutton.button");
	l_glowN = XUIGroup.findObject("glowbutton.glow.normal");
	l_glowH = XUIGroup.findObject("glowbutton.glow.hover");

	l_overlay = XUIGroup.findObject("glowbutton.overlay");

	targetspeedin = getPrivateInt("Deimos/GlowButtons/time", "fadein", 5)/10;
	targetspeedout = getPrivateInt("Deimos/GlowButtons/time", "fadeout", 15)/10;

	ca_beat = Config.getItemByGuid("{A8EFDFF8-9667-4a38-AA38-A449A85EDCC0}").getAttribute("On Beat Pulsation");
	ca_speed = Config.getItemByGuid("{E9C2D926-53CA-400f-9A4D-85E31755A4CF}").getAttribute("Visspeed");

	beat = new Timer;
	beat.setDelay(stringToInteger(ca_speed.getData()) + 1);
	if (ca_beat.getData() == "1") {
		beat.start();
	}

	textfader = new Timer;
	textfader.setDelay(1000);

	ripProtection("tristania");
}

System.onSetXuiParam(String stringParam, String stringValue) {
	if (strlower(stringParam) == "glowimage") l_glowN.setXmlParam("image", stringValue);
	if (strlower(stringParam) == "glowhoverimage") l_glowH.setXmlParam("image", stringValue);
	if (strlower(stringParam) == "showonstatus") loadForStatus(stringValue);
	if (strlower(stringParam) == "songtickermessage") str_stmsg = stringValue;
	if (strlower(stringParam) == "glowlink") getGlowLink(stringValue);
	if (strlower(stringParam) == "extendedsongtickermessage") if (stringValue != "") { b_extstm = 1; str_stmsg = stringValue; }
	if (strlower(stringParam) == "overlay") {
		overid = stringValue;
		l_Overlay.setXmlParam("image", stringValue);
	}
	if (strlower(stringParam) == "activeoverlay") {
		tgifact = 1;
		actoverid = stringValue ;
		l_Overlay.hide();
	}
	if (strlower(stringParam) == "songtickercontainer") str_container = stringValue;
	if (strlower(stringParam) == "nocfgvals") nocfgvals = stringtointeger(stringValue);
}

_Glowbutton.onActivate(Boolean onoff) {
	if (!tgifact) return;
	l_Overlay.show();
	XUIGroup.getParent().findObject(XUIGroup.getID() + "_load").hide();
	if (onoff) l_Overlay.setXmlParam("image", actoverid);	
	else l_Overlay.setXmlParam("image", overid);	
}

/*
System.onShowLayout(Layout _layout) {
	Container cont = _layout.getContainer();
	if (cont.getID() == "main" ) str_layout = _layout.getID();
}
*/
getGlowLink(string str_GB_id) {
	GuiObject _parent = XUIGroup.getParent();
	Glowbutton LinkButton = _parent.findObject(str_GB_id);
	l_glowN = LinkButton.findObject("glowbutton.glow.normal");
	l_glowH = LinkButton.findObject("glowbutton.glow.hover");
}

loadForStatus(string statusId) {
	_status = 1;
	str_statusId = statusId;
	if (strlower(str_StatusId) == "play") {
		if (getStatus() == 1) {
			_GlowButton.show();
			l_Overlay.show();
		} else {
			_GlowButton.hide();
			l_Overlay.hide();
		}
	}
	if (strlower(str_StatusId) == "hold") {
		if (getStatus() < 1) {
			_GlowButton.show();
			l_Overlay.show();
		} else {
			_GlowButton.hide();
	    		l_Overlay.hide();
		}
	}
}

System.onResume() {
	if (_status) {
		if (strlower(str_StatusId) == "play") { _GlowButton.show(); l_Overlay.show(); }
		if (strlower(str_StatusId) == "hold") { _GlowButton.hide(); l_Overlay.hide(); }
	}
}

System.onPlay() {
	if (_status) {
		if (strlower(str_StatusId) == "play") { _GlowButton.show(); l_Overlay.show(); }
		if (strlower(str_StatusId) == "hold") { _GlowButton.hide(); l_Overlay.hide(); }
	}
}

System.onPause() {
	if (_status) {
		if (strlower(str_StatusId) == "hold") { _GlowButton.show(); l_Overlay.show(); }
		if (strlower(str_StatusId) == "play") { _GlowButton.hide(); l_Overlay.hide(); }
	}
}

System.onStop() {
	if (_status) {
		if (strlower(str_StatusId) == "hold") { _GlowButton.show(); l_Overlay.show(); }
		if (strlower(str_StatusId) == "play") { _GlowButton.hide(); l_Overlay.hide(); }
	}
}

_GlowButton.onEnterArea() {
	startGlow();
}

startGlow() {
	targetspeedin = getPrivateInt("Deimos/GlowButtons/time", "fadein", 5)/10;
	Int i_glbtn_mode = getPrivateInt("Deimos/GlowButtons/glow", "mode", 2);
	if (i_glbtn_mode == 2 ) {
		l_glowH.setTargetA(255);
		l_glowH.setTargetSpeed(targetspeedin);
		l_glowH.gotoTarget();
	} if (i_glbtn_mode == 1 ) {
		l_glowH.setTargetA(255);
		l_glowH.setTargetSpeed(0);
		l_glowH.gotoTarget();
	}
}

GlowButton.onLeaveArea() {
	stopGlow();
}

stopGlow() {
	targetspeedout = getPrivateInt("Deimos/GlowButtons/time", "fadeout", 15)/10;
	Int i_glbtn_mode = getPrivateInt("Deimos/GlowButtons/glow", "mode", 2);
	if (i_glbtn_mode == 2 ) {
		l_glowH.setTargetA(0);
		l_glowH.setTargetSpeed(targetspeedout);
		l_glowH.gotoTarget();
	} if (i_glbtn_mode == 1 ) {
		l_glowH.setTargetA(0);
		l_glowH.setTargetSpeed(0);
		l_glowH.gotoTarget();
	}
}

_GlowButton.onLeftButtonDown(int x, int y) {
	l_Overlay.setXmlParam("x", "1");
	l_Overlay.setXmlParam("y", "1");
	if (tgifact) {
		guiobject j = XUIGroup.getParent().findObject(XUIGroup.getID() + "_load");
		if (j.isvisible()) {
			j.setXmlParam("x", integerToString(j.getGuiX() + 1));
			j.setXmlParam("y", integerToString(j.getGuiY() + 1));
		}
	}
	if (str_stmsg == "") return;
	layout _main_normal;
	if (str_container == "this") _main_normal = getParentLayout();
	else _main_normal = System.getContainer(getToken(str_container, ";", 0)).getLayout(getToken(str_container, ";", 1));
	if (!_main_normal) return;
	SongTicker = _main_normal.findObject("Songticker");
	textfader.stop();
	str_oldtxt = SongTicker.getText();
	if (b_extstm) {
		int i_CurCfgVal;
		if (nocfgvals) i_CurCfgVal = getActivated();
		else i_CurCfgVal = getCurCfgVal();		
		if (i_CurCfgVal == -1) i_CurCfgVal = 2;
		string str_extstmd = getToken(str_stmsg, ";", i_CurCfgVal);
		SongTicker.setAlternateText(str_extstmd);
	} else SongTicker.setAlternateText(str_stmsg);
	i_count = 0;
	textfader.start();
}

_GlowButton.onLeftButtonUp(int x, int y) {
	l_Overlay.setXmlParam("x", "0");
	l_Overlay.setXmlParam("y", "0");
	if (tgifact) {
		guiobject j = XUIGroup.getParent().findObject(XUIGroup.getID() + "_load");
		if (j.isvisible()) {
			j.setXmlParam("x", integerToString(j.getGuiX() - 1));
			j.setXmlParam("y", integerToString(j.getGuiy() - 1));
		}
	}
}

ca_beat.onDataChanged() {
	if (getData() == "1") {
		beat.start();
	} else {
		beat.stop();
		l_glowH.setAlpha(0);
	}
}

ca_speed.onDataChanged() { beat.setDelay(stringToInteger(ca_speed.getData()) + 1); }

beat.onTimer() {
	int i_vu = (getLeftVuMeter() + getRightVuMeter())/2;
	i_vu /= 50;
	i_vu *= 50;
	l_glowH.setAlpha(i_vu);
}

textfader.onTimer() {
	i_count++;
	if (i_count == 1) {
		SongTicker.setAlternateText("");
/*		str_fade == "hide";
		SongTicker.setTargetA(150);
		SongTicker.setTargetSpeed(0.5);
		SongTicker.gotoTarget();
		textfader.stop();
	}
}

SongTicker.onTargetReached() {
	if (str_fade == "hide") {
		SongTicker.setAlternateText("");
		SongTicker.setTargetA(255);
		SongTicker.setTargetSpeed(0.5);
		str_fade == "x";
		SongTicker.gotoTarget();*/
	}
}
