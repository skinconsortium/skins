/**
 * text.m
 *
 * Positions a text based of a region
 *
 * @package	com.skinconsortium.cpro.flex
 * @author	mpdeimos
 * @date	18/10/01
 * @param	textID,regionID
 */

#include <lib/std.mi>

Global GuiObject myText;

System.onScriptLoaded ()
{
	myText = getScriptGroup().findObject(getToken(getParam(), ",", 0));
	Region r = new Region;
	r.loadFromBitmap(getToken(getParam(), ",", 1));
	myText.setXmlParam("x", integerToString(r.getBoundingBoxX()));
	myText.setXmlParam("y", integerToString(r.getBoundingBoxY()));
	myText.setXmlParam("h", integerToString(r.getBoundingBoxH()));
	myText.setXmlParam("w", integerToString(r.getBoundingBoxW()));
	delete r;
}
