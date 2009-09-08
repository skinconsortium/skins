/*---------------------------------------------------
-----------------------------------------------------
Filename:	configtree.m

Type:		maki/source
Version:	skin version 1.2
Date:		23:12 17.05.2005
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
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

#define FILENAME "configtree.m"
#include "../ripprotection.mi"

Function stackProtection(int i);

Global Group XUIGroup;
Global GuiTree _Tree;
Global TreeItem ti_root, ti_lastsel;
Global Group _ConfigGroup, _impGroup;
Global Boolean startup;

System.onScriptLoaded() {
	XUIGroup = getScriptGroup();

	_ConfigGroup = XUIGroup.getParent().getParent();
	startup = 1;

	_Tree = XUIGroup.findObject("tree");
	_Tree.setSorted(0);
	ti_Root = new TreeItem;
	ti_Root = _Tree.enumRootItem(1);

	ripProtection();
}

System.onScriptUnloading() {
//.STACKPROT
	stackProtection(_Tree.getNumVisibleItems());
}

stackProtection(int i) {
	i--;
	_tree.moveTreeItem(_tree.enumAllItems(i), ti_Root);
	if (i > 0) stackProtection(i);
}	

_Tree.onAction(String action, String param, Int x, int y, int p1, int p2, GuiObject source) {
	if (action == "createItem") {
		TreeItem _t  = new TreeItem;
		_t.setLabel(param);
		_Tree.addTreeItem(_t, ti_Root, 0, 0);
		_Tree.selectItem(_Tree.enumAllItems(0));
	}
	if (action == "createSubItem") {
		TreeItem _t = new TreeItem;
		TreeItem _s = _Tree.getByLabel(ti_Root, getToken(param, ";", 0));
		_t.setLabel(getToken(param, ";", 1));
		_Tree.addTreeItem(_t, _s, 0, 0);
		_s.expand();
	}
	if (action == "switchToItem") {
		TreeItem _t = _Tree.getByLabel(ti_Root, param);
		if (param) _Tree.selectItem(_t);
	}
}

_Tree.onItemSelected(TreeItem _item) {
	if (!ti_lastsel) {
		ti_lastsel = _item;
		return;
	}
	GuiObject gui = _impGroup.findObject(ti_lastsel.getLabel());
	gui.hide();
	ti_lastsel = _item;
	GuiObject gui = _impGroup.findObject(ti_lastsel.getLabel());
	gui.show();
}

_ConfigGroup.onsetVisible(int v) {
	if (startup) {
		startup = 0;
		_impGroup = _ConfigGroup.findObject("config.imp");
	}
}