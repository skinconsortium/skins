/*---------------------------------------------------
----------------------------------------------------
Filename:	ownmeus.m

Type:		maki/header
Version:	skin version 1.1
Date:		20:01 26.07.2004
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
-----------------------------------------------------
--------------------INCLUDES-------------------------
-Menu scripts for all windows
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
---------------------------------------------------*/

#include "../../../../lib/std.mi"
#include "../../../../lib/config.mi"

Function UpdateMenus(Boolean b_startup);

Global Group ScriptGroup, GBG;

Global ConfigAttribute ca_menu;
Global ConfigItem ci_menu;
Global Boolean b_startup;

Global Group timebg, leftbg, rightbg;
Global Boolean b_ispl = 0;
Global Layout _layout_normal;
Global GuiObject manage;


System.onScriptLoaded() {

	ScriptGroup = getScriptgroup();
	_layout_normal = ScriptGroup.getParentLayout();

	ci_menu = Config.getItemByGuid("{12ED320E-6813-45ac-9F8E-78EE5B2B5F6D}");
	ca_menu = ci_menu.getAttribute("Show Menus in " + getParam());

	if (getParam() == "Playlist Editor") {
		b_ispl = 1;
		timebg = ScriptGroup.findObject("petime");
		leftbg = ScriptGroup.findObject("arsm");
		rightbg = ScriptGroup.findObject("manage");
		GBG = ScriptGroup.findObject("standardframe.playbuttons");
		manage = rightbg.findObject("pl.manage");
	}

	UpdateMenus(1);

}

ca_menu.onDataChanged() {
	UpdateMenus(0);
}

UpdateMenus(Boolean b_startup) {
	group dummy = ScriptGroup.findObject(getParam() + ".mainmenu");
	if (b_startup) dummy.setXmlParam("visible", ca_menu.getData());
	else {
		if (ca_menu.getData() == "1") {
			dummy.setXmlParam("alpha", "0");
			dummy.setXmlParam("visible", "1");
			dummy.setTargetA(255);
			dummy.setTargetSpeed(0.5);
			dummy.gotoTarget();
		}
		if (ca_menu.getData() == "0") {
			dummy.setTargetA(0);
			dummy.setTargetSpeed(0.5);
			dummy.gotoTarget();
		}

	}
}

_layout_normal.onResize(int x, int y, int w, int h) {
	if (!b_ispl) return;
	if (w>538) {
		timebg.show();
		leftbg.setXMLParam("x","-526");
		rightbg.setXMLParam("x","-246");
		timebg.setXMLParam("x","-357");
		rightbg.setXMLParam("image","pl.metal.add.right");
		manage.setXMLParam("x","5");
		GBG.show();
	} else if (w<538 && w>410) {
		timebg.show();
		timebg.setXMLParam("x","-223");
		leftbg.setXMLParam("x","-394");
		rightbg.setXMLParam("x","-115");
		rightbg.setXMLParam("image","pl.metal.add.right2");
		manage.setXMLParam("x","10");
		GBG.hide();
	} else {
		timebg.hide();
		leftbg.setXMLParam("x","-287");
		rightbg.setXMLParam("x","-115");
		rightbg.setXMLParam("image","pl.metal.add.right2");
		manage.setXMLParam("x","10");
		GBG.hide();
	}
}