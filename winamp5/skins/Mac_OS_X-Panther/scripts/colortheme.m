/*---------------------------------------------------
-----------------------------------------------------
Filename:	colortheme.m

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
Global Button min, close, shade;
Global ConfigAttribute attrib;

#define CUSTOM_PAGE_NONEXPOSED "{E9C2D926-53CA-400f-9A4D-85E31755A4CF}"

System.onScriptLoaded() {
	min = getScriptGroup().findObject("else");
	close = getScriptGroup().findObject("Close.comp");
	shade = getScriptGroup().findObject("menu");


	attrib = Config.getItemByGuid(CUSTOM_PAGE_NONEXPOSED).getAttribute("colortheme_"+getSkinName());

	attrib.onDataChanged();
}

attrib.onDataChanged() {
	if (getData() == "*Panther (Defualt)") {
		min.setXMLParam("image", "standardframe.botton.minimize.n");
		min.setXMLParam("downimage", "standardframe.botton.minimize.d");
		min.setXMLParam("hoverimage", "standardframe.botton.minimize.h");

		close.setXMLParam("image", "standardframe.botton.close.n");
		close.setXMLParam("downimage", "standardframe.botton.close.d");
		close.setXMLParam("hoverimage", "standardframe.botton.close.h");

		shade.setXMLParam("image", "standardframe.botton.shade.n");
		shade.setXMLParam("downimage", "standardframe.botton.shade.d");
		shade.setXMLParam("hoverimage", "standardframe.botton.shade.h");
	} else {
		min.setXMLParam("image", "standardframe.botton.minimize.n.blue");
		min.setXMLParam("downimage", "standardframe.botton.minimize.d.blue");
		min.setXMLParam("hoverimage", "standardframe.botton.minimize.h.blue");

		close.setXMLParam("image", "standardframe.botton.close.n.blue");
		close.setXMLParam("downimage", "standardframe.botton.close.d.blue");
		close.setXMLParam("hoverimage", "standardframe.botton.close.h.blue");

		shade.setXMLParam("image", "standardframe.botton.shade.n.blue");
		shade.setXMLParam("downimage", "standardframe.botton.shade.d.blue");
		shade.setXMLParam("hoverimage", "standardframe.botton.shade.h.blue");
	}
}