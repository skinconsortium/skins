/**
 * classicvis.m
 *
 * Positions vis object and handles styles
 *
 * @package	com.skinconsortium.cpro.flex
 * @author	mpdeimos
 * @date	08/11/06
 * @param	objectID;regionID
 */


#include <lib/std.mi>

Global guiObject myVis;
Global Boolean active;

System.onScriptLoaded ()
{
	myVis = getScriptGroup().findObject(getToken(getParam(), ";", 0));

	Region r = new Region;
	r.loadFromBitmap(getToken(getParam(), ";", 1));

	active = (r.getBoundingBoxW() > 0);
	if (active)
	{
		myVis.setXmlParam("x", integerToString(r.getBoundingBoxX()));
		myVis.setXmlParam("y", integerToString(r.getBoundingBoxY()));
		myVis.setXmlParam("h", integerToString(r.getBoundingBoxH()));
		myVis.setXmlParam("w", integerToString(r.getBoundingBoxW()));
		myVis.show();
		r.offset(-r.getBoundingBoxX(), -r.getBoundingBoxY());
		//myVis.setRegion(r);
	}

	delete r;
}