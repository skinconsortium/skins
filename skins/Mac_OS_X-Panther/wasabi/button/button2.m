/*---------------------------------------------------
-----------------------------------------------------
Filename:	button.m

Type:		maki/source
Version:	skin version 1.2
Date:		10:11 30.08.2004
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
-----------------------------------------------------
--------------------INCLUDES-------------------------
-Handling for buttons
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

#define FILENAME "button.m"
#include "../../../../lib/ripprotection.mi"

Function loadForStatus(string statusId);

Global GuiObject XUIGroup;
Global ToggleButton _Button;
Global Layer l_overlay;

Global Boolean _status = 0;
Global String str_statusId = "";
Global String str_stmsg = "_ERROR_";

Global Text SongTicker;
Global Int i_count = 0;
Global String str_fade, str_oldtxt;
Global String str_layout = "normal";
Global Boolean b_extstm = 0;
Global Timer textfader;

System.onScriptLoaded() {

	XUIGroup = getScriptGroup();

	_Button = XUIGroup.findObject("button");

	l_overlay = XUIGroup.findObject("button.overlay");

	textfader = new Timer;
	textfader.setDelay(1000);

	ripProtection("panther");
}

System.onSetXuiParam(String stringParam, String stringValue) {
	if (strlower(stringParam) == "showonstatus") loadForStatus(stringValue);
	if (strlower(stringParam) == "songtickermessage") str_stmsg = stringValue;
	if (strlower(stringParam) == "extendedsongtickermessage") if (stringValue != "") { b_extstm = 1; str_stmsg = stringValue; }
	if (strlower(stringParam) == "overlay") l_Overlay.setXmlParam("image", stringValue);
}

_Button.onLeftButtonDown(int x, int y) {
	l_Overlay.setXmlParam("x", "1");
	l_Overlay.setXmlParam("y", "1");
	if (str_stmsg == "") return;
	Layout _main_normal = getParentLayout();
	SongTicker = _main_normal.findObject("infoline");
	textfader.stop();
	str_oldtxt = SongTicker.getText();
	if (b_extstm) {
		int i_CurCfgVal = getCurCfgVal();
		if (i_CurCfgVal == -1) i_CurCfgVal = 2;
		string str_extstmd = getToken(str_stmsg, ";", i_CurCfgVal);
		SongTicker.setAlternateText(str_extstmd);
	} else SongTicker.setAlternateText(str_stmsg);
	i_count = 0;
	textfader.start();
}

_Button.onLeftButtonUp(int x, int y) {
	l_Overlay.setXmlParam("x", "0");
	l_Overlay.setXmlParam("y", "0");
}



loadForStatus(string statusId) {
	_status = 1;
	str_statusId = statusId;
	if (strlower(str_StatusId) == "play") {
		if (getStatus() == 1) {
			XUIGroup.show();
			l_Overlay.show();
		} else {
			XUIGroup.hide();
			l_Overlay.hide();
		}
	}
	if (strlower(str_StatusId) == "hold") {
		if (getStatus() < 1) {
			XUIGroup.show();
			l_Overlay.show();
		} else {
			XUIGroup.hide();
	    		l_Overlay.hide();
		}
	}
}

System.onResume() {
	if (_status) {
		if (strlower(str_StatusId) == "play") { XUIGroup.show(); l_Overlay.show(); }
		if (strlower(str_StatusId) == "hold") { XUIGroup.hide(); l_Overlay.hide(); }
	}
}

System.onPlay() {
	if (_status) {
		if (strlower(str_StatusId) == "play") { XUIGroup.show(); l_Overlay.show(); }
		if (strlower(str_StatusId) == "hold") { XUIGroup.hide(); l_Overlay.hide(); }
	}
}

System.onPause() {
	if (_status) {
		if (strlower(str_StatusId) == "hold") { XUIGroup.show(); l_Overlay.show(); }
		if (strlower(str_StatusId) == "play") { XUIGroup.hide(); l_Overlay.hide(); }
	}
}

System.onStop() {
	if (_status) {
		if (strlower(str_StatusId) == "hold") { XUIGroup.show(); l_Overlay.show(); }
		if (strlower(str_StatusId) == "play") { XUIGroup.hide(); l_Overlay.hide(); }
	}
}

textfader.onTimer() {
	i_count++;
	if (i_count == 1) {
		SongTicker.setAlternateText("");
	}
}