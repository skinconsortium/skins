/*---------------------------------------------------
-----------------------------------------------------
Filename:	cfg.m
Version:	2.0

Type:		maki
Date:		18. Jul. 2006 - 23:12 
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
-----------------------------------------------------
---------------------------------------------------*/

#include "../../../../lib/std.mi"
#include "../../scripts/attribs.m"

Function fillList();
Function saveList();
Function ProcessMenuResult(int a);

Global Button b, b_save, b_add, b_edit, b_cancel, b_up, b_down, b_del;
Global edit e;

Global GuiList _list;

Global Popupmenu pop;


System.onScriptLoaded() {
	initAttribs();

	Group XUIGroup = getScriptGroup();

	b = XUIGroup.findObject("btn");
	e = XUIGroup.findObject("editbox");

	_list = XUIGroup.findObject("presetlist");
/*	_list.setAutoSort(0);
	_list.setPreventMultipleSelection(1);*/

	b_edit = XUIGroup.findObject("edit");
	b_cancel = XUIGroup.findObject("cancel");
	b_save = XUIGroup.findObject("save");
	b_add = XUIGroup.findObject("add");
	b_up = XUIGroup.findObject("up");
	b_down = XUIGroup.findObject("down");
	b_del = XUIGroup.findObject("del");


	fillList();
}

b.onLeftClick() {
	messageBox("Available Params:\n%artist%, %album%, %title%, %year%, %genre%,\n%tracknumber%, %bitrate%, %frequency%, %channels%, %extension%\n%path%, %songticker%, %songinfo%, %length%, %comment%\n"+"\n$upper(x)$, $lower(x)$ converts x into upper/lower case; e.g. $upper(%Artist%)$", "Syntax reference", 0, "");
}

fillList() {
	int i_numberOfpresets = getPrivateInt(getSkinName() + "/ATF/", "NumberOfPresets", 1);
	if (i_numberOfpresets < 1) {
		i_numberOfpresets = 1;
		setPublicInt(getSkinName() + "/ATF/_NumberOfPresets", 1);
	}
	for ( int i = 1; i <= i_numberOfpresets; i++ ) {
		string str_name = getPrivateString(getSkinName() + "/ATF/ATFPresets/", integerToString(i), "%songticker%");
		_list.insertItem(i-1, str_name);
	}
}

b_edit.onLeftClick() {
	int i = _list.getFirstItemSelected();
	if (i > -1) {
		b_edit.hide();
		b_add.hide();
		_list.setXMLParam("noleftclick", "1");
		_list.setXMLParam("norightclick", "1");
		_list.setAlpha(180);
		e.setText(_list.getItemLabel(i, 0));
	} else {
		messageBox("You have to select an item!", "Error", 0, "");
	}
	saveList();
}

e.onEnter() {
	if(b_add.isVisible()) b_add.leftClick();
	else b_save.leftClick();
}

b_cancel.onLeftClick() {
	_list.setXMLParam("noleftclick", "0");
	_list.setXMLParam("norightclick", "0");
	b_edit.show();
	b_add.show();
	saveList();
}

b_save.onLeftClick() {
	int i = _list.getFirstItemSelected();
	_list.setItemLabel(i, e.getText());
	b_cancel.onLeftClick();
	saveList();
}

b_add.onLeftClick() {
	int i = _list.getFirstItemSelected();
	if(e.getText() == "") return;
	_list.addItem(e.getText());
	saveList();
}

b_up.onLeftClick() {
	int i = _list.getFirstItemSelected();
	if (i <= 0) return;
	_list.moveItem(i-1, i+1);
	_list.deselectAll();
	_list.setItemFocused(i-1);
	_list.setSelected(i-1, 1);
	saveList();
}

b_down.onLeftClick() {
	int i = _list.getFirstItemSelected();
	if (i+1 >= _list.getNumItems()) return;
	_list.moveItem(i, i+2);
	_list.deselectAll();
	_list.setItemFocused(i+1);
	_list.setSelected(i+1, 1);
	saveList();
}

b_del.onLeftClick() {
	if (_list.getNumItems() == 1) {
		messageBox("You cannot delete the last preset!", "ERROR", 0, "");
		return;
	}
	
	int i = _list.getFirstItemSelected();
	_list.deleteByPos(i);
	_list.setItemFocused(i);
	_list.setSelected(i, 1);
	saveList();
}

_list.onRightClick(Int itemnum) {

	pop = new PopUpMenu;

	int i = 1;

	pop.addCommand(" Edit", i++, 0, 0);
	pop.addCommand(" Delete", i++, 0, 0);
	pop.addCommand(" Move up", i++, 0, 0);
	pop.addCommand(" Move down", i++, 0, 0);

	ProcessMenuResult(pop.popAtMouse());
}

ProcessMenuResult(int a) {
	if(a < 0) return;
	if (a == 1) b_edit.leftclick();
	else if (a == 2) b_del.leftclick();
	else if (a == 3) b_up.leftclick();
	else if (a == 4) b_down.leftclick();	
}


saveList() {
	int i_numberOfpresets = _list.getNumItems();
	setPublicInt(getSkinName() + "/ATF/_NumberOfPresets", _list.getNumItems());
	for ( int i = 1; i <= i_numberOfpresets; i++ ) {
		setPublicString(getSkinName() + "/ATF/ATFPresets/_" + integerToString(i), _list.getItemLabel(i-1, 0));
	}
	atfset_toggle_attrib.setData(integerToString((stringToInteger(atfset_toggle_attrib.getData())-1)*(-1)));
}

atfset_toggle_attrib.onDataChanged() {
	if (getData() == "-1") {
		_list.deleteAllItems();
		_list.addItem("%songticker%");
		saveList();
		atfset_toggle_attrib.setData("0");
	}
}
	


 