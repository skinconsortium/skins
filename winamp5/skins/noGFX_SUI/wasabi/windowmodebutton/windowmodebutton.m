/*---------------------------------------------------
-----------------------------------------------------
Filename:	windowmodebutton.m

Version:	1.0
Date:		17. Feb. 2006 - 15:49 
Author:		Martin Poehlmann alias Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
-----------------------------------------------------
-----------------------------------------------------
Usage:		See windowmodebutton.xml
-----------------------------------------------------
---------------------------------------------------*/

#include "../../../../lib/std.mi"

Function ProcessMenuResult(int a);
Function Int countSubString(string str, string substr);

//#define DEBUG

#ifdef DEBUG
Function debug(String debugStr);
debug(String debugStr) {
	messageBox(debugStr, getSkinName() +" :Debug Message", 0, "");
}
#endif

Global Button btn;

Global String _container = "this";
Global PopupMenu menu_Layouts;
Global int nLayouts = 0;
Global String layoutstring;
Global String rclick = "null";
Global String lclick = "null";

System.onScriptLoaded() {
	Group XUIGroup = getScriptGroup();

	btn = XUIGroup.findObject("btn");

	menu_Layouts = new PopupMenu;
	menu_Layouts.addCommand("Window Modes", 0, 0, 1);
	menu_Layouts.addSeparator();

}

System.onScriptUnloading() {
	delete menu_Layouts;
}

System.onSetXuiParam(String stringParam, String stringValue) {
	if (strlower(stringParam) == "switch") _container = stringValue;
	if (strlower(stringParam) == "layoutids") { 
		layoutstring = stringValue;
		nLayouts = countSubString(layoutstring, ";");
	}
	if (strlower(stringParam) == "rclick") rclick = stringValue;
	if (strlower(stringParam) == "lclick") lclick = stringValue;
	if (strlower(stringParam) == "menuentry") {
		for ( int i = 0; i <= nLayouts; i++ ) {
			string s = getToken(stringValue, ";", i);
			menu_Layouts.addCommand(s, i + 1, 0, 0);
		}
	}
}

btn.onLeftButtonUp(int x, int y) {
	if (strsearch(strlower(lclick), "switchto:") >= 0) {
		container c;
		if (_container == "this") c = btn.getParentLayout().getContainer();
		else c = System.getContainer(_container);
		if (c) c.switchToLayout(getToken(lclick, ":", 1));
		
	} else if (strlower(rclick) != "menu") {
		return;
	} else {
		ProcessMenuResult(menu_Layouts.popAtMouse());
		complete;
	}

}

btn.onRightButtonUp(int x, int y) {
	if (strsearch(strlower(rclick), "switchto:") >= 0) {
		container c;
		if (_container == "this") c = btn.getParentLayout().getContainer();
		else c = System.getContainer(_container);
		if (c) c.switchToLayout(getToken(lclick, ":", 1));
		
	} else if (strlower(rclick) != "menu") {
		return;
	} else {
		ProcessMenuResult(menu_Layouts.popAtMouse());
		complete;
	}

}

ProcessMenuResult(int a) {
	if(a > 0) {
		container c;
		if (_container == "this") c = btn.getParentLayout().getContainer();
		else c = System.getContainer(_container);
		if (c) c.switchToLayout(getToken(layoutstring, ";", a-1));
	}
}

int countSubString(string str, string substr) {
	int n = 0;
	for ( int i = 0; i < 1000; i++ ) {
		int r = strSearch(str, substr);
#ifdef DEBUG
		debug(integerToString(r));
#endif
		if (r == -1) i = 1000;
		else {
			str = strright(str, strlen(str) - (r + 1));
			n++;
		}
	}
	return n;
}
	