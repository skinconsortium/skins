/*---------------------------------------------------
-----------------------------------------------------
Filename:	albumart.m
Version:	1.0

Type:		maki
Date:		20. Sep. 2007 - 16:54 
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
-----------------------------------------------------
---------------------------------------------------*/

#include <lib/std.mi>

Global layer AlbumArt;

System.onScriptLoaded ()
{
	AlbumArt = getScriptGroup().findObject("aanarrow");
}

AlbumArt.onRightButtonDown (int x, int y)
{
	popupmenu p = new popupmenu;
	p.addCommand("Album Art", -1, 0, 1);
	p.addCommand("Get Album Art", 1, 0, 0);
	p.addCommand("Refresh Album Art", 2, 0, 0);
	p.addCommand("Open Folder", 3, 0, 0);

	int result = p.popatmouse();
	delete p;

	if (result == 1)
	{
		if (system.getAlbumArt(system.getPlayItemString()) > 0)
		{
			AlbumArt.setXmlParam("notfoundimage", getXmlParam("notfoundimage")); // a nesty refresh - isn't it?
		}
	}
	else if (result == 2)
	{
		AlbumArt.setXmlParam("notfoundimage", getXmlParam("notfoundimage")); // a nesty refresh - isn't it?
	}
	else if (result == 3)
	{
		System.navigateUrl(system.getPath(system.getPlayItemString()));
	}

}

AlbumArt.onLeftButtonDblClk (int x, int y)
{
	System.navigateUrl(system.getPath(system.getPlayItemString()));
}