/**
 * snapadjust.m
 *
 * Handles snapadjust from a map file.
 *
 * @author	mpdeimos
 * @date	08/11/06
 * @version	1.0
 * @param	bitmapID
 */

#include <lib/std.mi>

Global Layout parent;

System.onScriptLoaded ()
{
	parent = getScriptGroup().getParentLayout();

	Region r = new Region;
	Map m = new Map;
	m.loadMap(getParam());
	r.loadFromBitmap(getParam());

	if (r.getBoundingBoxW() > 0)
	{
		parent.setXmlParam("snapadjustleft", integerToString(r.getBoundingBoxX()));
		parent.setXmlParam("snapadjusttop", integerToString(r.getBoundingBoxY()));
		parent.setXmlParam("snapadjustright", integerToString(m.getWidth() - r.getBoundingBoxW() - r.getBoundingBoxX()));
		parent.setXmlParam("snapadjustbottom", integerToString(m.getHeight() - r.getBoundingBoxH() - r.getBoundingBoxY()));
	}

	delete r;
}
