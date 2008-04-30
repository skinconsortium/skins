#define FILENAME "mainmenu.m"
/*---------------------------------------------------
Type:		maki/source
Version:	skin version 1.1
Date:		07. Sep. 2005 - 09:58 
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
---------------------------------------------------*/

#include "../../../lib/std.mi"
#include "../../../lib/config.mi"
#include "ripprotection.mi"

Function fade(GuiObject obj, float speed, int alpha);
Function set();

Global GuiObject men, toolb, tools, player;
Global Layout lay;
Global ConfigAttribute a_menu, a_size, a_toolb;
Global int guiH, guiY;
Global boolean size = 0;
Global boolean reverse = 0;

System.onScriptLoaded() {
	men = getScriptGroup().findObject("wasabi.menubar");
	toolb = getScriptGroup().findObject("player.componentbuttons");
	tools = getScriptGroup().findObject("player.componentbuttons.small");
	player = getScriptGroup().findObject("player.group");
	lay = getScriptGroup().getParentLayout();

	a_menu = Config.getItemByGuid("{12ED320E-6813-45ac-9F8E-78EE5B2B5F6D}").getAttribute("Show Menus in Main Window");
	a_size = Config.getItemByGuid("{12ED320E-6813-45ac-9F8E-78EE5B2B5F6D}").getAttribute("Large Toolbar Icons");
	a_toolb = Config.getItemByGuid("{12ED320E-6813-45ac-9F8E-78EE5B2B5F6D}").getAttribute("Show Toolbar");

	guiH = 188;
	guiY = 0;

/*	if (a_size.getData() == "0") {
		if (a_toolb.getData() == "1") return;
		toolb.hide();
		tools.show();
		toolb.setAlpha(0);
		tools.setAlpha(255);
		guiH = guiH - 16;
		guiY = guiY - 16;		
	}*/

	if (a_toolb.getData() == "0") {
		toolb.hide();
		tools.hide();
		toolb.setAlpha(0);
		tools.setAlpha(0);
		guiH = guiH - 40;
		guiY = guiY - 40;
	}

	if (a_menu.getData() == "0") {
		toolb.setXMLParam("y", "0");
		tools.setXMLParam("y", "0");
		men.setAlpha(0);
		guiH = guiH - 20;
		guiY = guiY - 20;
	}
	lay.beforeRedock();
	lay.setXMLParam("h", integerToString(guiH));
	player.setXMLParam("y", integerToString(guiY));
	lay.redock();

	ripProtection();

}
a_menu.onDataChanged() {
	if (size) {
		if (!reverse) {
			reverse = 1;
			if (getData() == "0") setData("1");
			else setData("0");
		} else reverse = 0;
		return;
	}
	size = 1;
	if (getData() == "0") {
		fade(men, 0.5, 0);
	} else set();
}

men.onTargetReached() {
	if (getAlpha() == 0) set();
}

a_toolb.onDataChanged() {
	if (size) {
		if (!reverse) {
			reverse = 1;
			if (getData() == "0") setData("1");
			else setData("0");
		} else reverse = 0;
		return;
	}
	size = 1;
	if (getData() == "0") {
		if (a_size.getData() == "1") fade(toolb, 0.5, 0);
		if (a_size.getData() == "0") fade(tools, 0.5, 0);
	} else set();
}

a_size.onDataChanged() {
	if (size) {
		if (!reverse) {
			reverse = 1;
			if (getData() == "0") setData("1");
			else setData("0");
		} else reverse = 0;
		return;
	}
	size = 1;
	if (a_size.getData() == "0") {
		fade(toolb, 0.5, 0);
	} else {
		fade(tools, 0.5, 0);
	}
}

toolb.onTargetReached() {
	if (getAlpha() == 0) set();
}

tools.onTargetReached() {
	if (getAlpha() == 0) set();
}

set() {
	guiH = 188;
	guiY = 0;

	int tsy;
	int tby;

	if (a_toolb.getData() == "0") {
		toolb.hide();
		tools.hide();
		guiH = guiH - 40;
		guiY = guiY - 40;
	} else {
		if (a_size.getData() == "0") {
			guiH = guiH - 16;
			guiY = guiY - 16;
			toolb.hide();
		} else tools.hide();
	}
	
	if (a_menu.getData() == "0") {
		guiH = guiH - 20;
		guiY = guiY - 20;
//		toolb.setTargetY(0);
//		tools.setTargetY(0);
		tsy = 0;
		tby = 0;
	} else {
//		toolb.setTargetY(20);
//		tools.setTargetY(20);
		tby = 20;
		tsy = 20;
	}

//	lay.setTargetH(guiH);
//	player.setTargetY(guiY);
//	lay.setTargetSpeed(0.5);
//	player.setTargetSpeed(0.5);
//	toolb.setTargetSpeed(0.5);
//	tools.setTargetSpeed(0.5);
//	lay.gotoTarget();
	lay.beforeRedock();
	lay.setXMLParam("h", integerToString(guiH));
	lay.redock();
	player.setXMLParam("y", integerToString(guiY));
	toolb.setXMLParam("y", integerToString(tby));
	tools.setXMLParam("y", integerToString(tsy));
//	player.gotoTarget();
//	toolb.gotoTarget();
//	tools.gotoTarget();
	size = 0;
	if (GuiH == 188) { fade(men, 0.5, 255); toolb.show(); fade(toolb, 0.5, 255); }
	if (GuiH == 168) { toolb.show(); fade(toolb, 0.5, 255);}
	if (GuiH == 172) { fade(men, 0.5, 255); tools.show(); fade(tools, 0.5, 255); }
	if (GuiH == 152) { tools.show(); fade(tools, 0.5, 255); }
}
/*
player.onTargetReached() {
	size = 0;
	if (lay.getGuiH() == 188) { fade(men, 0.5, 255); toolb.show(); fade(toolb, 0.5, 255); }
	if (lay.getGuiH() == 168) { toolb.show(); fade(toolb, 0.5, 255); }
	if (lay.getGuiH() == 172) { fade(men, 0.5, 255); tools.show(); fade(tools, 0.5, 255); }
	if (lay.getGuiH() == 152) { tools.show(); fade(tools, 0.5, 255); }
}*/

fade(GuiObject obj, float speed, int alpha) {
	obj.setTargetSpeed(speed);
	obj.setTargetA(alpha);
	obj.setTargetY(obj.getGuiY()); //need this line, to solve a bug
	obj.gotoTarget();
}