/**
 * albumart.m
 *
 * Positions albumart object and handles menu entries
 *
 * @package	com.skinconsortium.cpro.flex
 * @author	mpdeimos
 * @date	08/11/05
 * @param	objectID;regionID
 */


#include <lib/std.mi>

Global AlbumArtLayer AlbumArt;

System.onScriptLoaded ()
{
	AlbumArt = getScriptGroup().findObject(getToken(getParam(), ";", 0));

	Region r = new Region;
	r.loadFromBitmap(getToken(getParam(), ";", 1));

	if (r.getBoundingBoxW() > 0)
	{
		AlbumArt.setXmlParam("x", integerToString(r.getBoundingBoxX()));
		AlbumArt.setXmlParam("y", integerToString(r.getBoundingBoxY()));
		AlbumArt.setXmlParam("h", integerToString(r.getBoundingBoxH()));
		AlbumArt.setXmlParam("w", integerToString(r.getBoundingBoxW()));
		AlbumArt.show();
		r.offset(-r.getBoundingBoxX(), -r.getBoundingBoxY());
		AlbumArt.setRegion(r);
	}

	delete r;
}

AlbumArt.onRightButtonDown (int x, int y)
{
	popupmenu p = new popupmenu;

	// TODO move to stringtable!
	p.addCommand("Get Album Art", 1, 0, 0);
	p.addCommand("Refresh Album Art", 2, 0, 0);
	p.addCommand("Open Folder", 3, 0, 0);

	int result = p.popatmouse();
	delete p;

	if (result == 1)
	{
		if (system.getAlbumArt(system.getPlayItemString()) > 0)
		{
			AlbumArt.refresh();
		}
	}
	else if (result == 2)
	{
		AlbumArt.refresh();
	}
	else if (result == 3)
	{
		System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
	}
}

AlbumArt.onLeftButtonDblClk (int x, int y)
{
	System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
}