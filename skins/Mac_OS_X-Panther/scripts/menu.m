/*---------------------------------------------------
-----------------------------------------------------
Filename:	menu.m

Type:		maki/source
Version:	skin version 1.1
Date:		07. Sep. 2005 - 09:58 
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
---------------------------------------------------*/

#include "../../../lib/std.mi"
#include "../../../lib/config.mi"

Function fade(GuiObject obj, float speed, int alpha);
Global GuiObject comp, men;
Global ConfigAttribute attrib;

System.onScriptLoaded() {
	comp = getScriptGroup().findObject(getToken(getParam(),"|",0));
	if (strsearch(getToken(getParam(),"|",0), ".pl") != -1) {
		men = getScriptGroup().findObject("wasabi.menubar.pl");
	}
	if (strsearch(getToken(getParam(),"|",0), ".ml") != -1) {
		men = getScriptGroup().findObject("wasabi.menubar.ml");
	}
	string attribsep = getToken(getParam(), "|", 1);
	string ci_guid = getToken(attribsep, ";", 0);
	string ca_name = getToken(attribsep, ";", 1);
	attrib = Config.getItemByGuid(ci_guid).getAttribute(ca_name);

	if (attrib.getData() == "0") {
		comp.setXMLParam("y", "0");
		comp.setXMLParam("h", "0");
		men.setAlpha(0);
	}
	

}

attrib.onDataChanged() {
	if (attrib.getData() == "0") {
		fade(men, 0.5, 0);
	} else {
		comp.setTargetH(-20);
		comp.setTargetY(20);
		comp.setTargetSpeed(0.5);
		comp.gotoTarget();
	}
}

men.onTargetReached() {
	if (getAlpha() == 0) {
		comp.setTargetH(0);
		comp.setTargetY(0);
		comp.setTargetSpeed(0.5);
		comp.gotoTarget();
	}
}

comp.onTargetReached() {
	if (getGuiY() == 20) fade(men, 0.5, 255);
}

fade(GuiObject obj, float speed, int alpha) {
	obj.setTargetSpeed(speed);
	obj.setTargetA(alpha);
	obj.gotoTarget();
}