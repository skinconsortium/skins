/*---------------------------------------------------
-----------------------------------------------------
Filename:	configpage.m

Type:		maki/source
Version:	skin version 1.2
Date:		22:39 17.05.2005
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
-----------------------------------------------------
--------------------INCLUDES-------------------------
-Cover Art
-----------------------------------------------------
----------------------NOTE---------------------------
I've written all the script on my own. I was only
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

#define FILENAME "configpage.m"
#include "../ripprotection.mi"

Global Group XUIGroup;
Global Layout l;

System.onScriptLoaded() {
	ripprotection();
}

System.onSetXuiParam(String param, String value) {
	XUIGroup = getScriptGroup();
	l = XUIGroup.getParentLayout();
	if (param == "createItem" || param == "createSubItem") {
		GuiTree _tree = l.findObject("wasabi.preferences.group").findObject("wasabi.preferences.tree.embedded").findObject("mylist").findObject("tree");
		_tree.sendAction(param, value, 0, 0, 0, 0);
	}
}