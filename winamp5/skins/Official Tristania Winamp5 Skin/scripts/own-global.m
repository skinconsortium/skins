/*---------------------------------------------------
-----------------------------------------------------
Filename:	own-global.m

Type:		maki/source
Version:	skin version 1.1
Date:		16.Apr.2004 - 23:19
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.tk
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

Global Layout _main_normal;
Global Group PlayerDisplay;
Global Text Songticker;
Global Group PlayerButtons;
Global Container eq;
Global Boolean mychange;
Global Button btn_close;
Global Togglebutton tgdummy;

load_global() {
#ifdef __OWNKILLERSYSTEM_M
	_main_normal = System.getContainer("main").getLayout("normal");
	PlayerDisplay = _main_normal.getObject("player.display");
	PlayerButtons = _main_normal.getObject("player.buttons");
	eq = System.getContainer("eq");

	btn_close = eq.getLayout("normal").findObject("Close");

	tgdummy = _main_normal.findObject("eqtoggle");

	tgdummy.onToggle(tgdummy.getCurCfgVal());

#endif
	Songticker = PlayerDisplay.findObject("Songticker");

}

tgdummy.onToggle(int v) {
	eq_visible_attrib.setData(integerToString(v));
}

eq_visible_attrib.onDataChanged() {
	if (mychange) return;
	mychange = 1;
	if (getData() == "1") eq.show();
	if (getData() == "0") eq.close();
	mychange = 0;
}

btn_close.onLeftClick() {
	eq_visible_attrib.setData("0");
}