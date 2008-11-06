/********************************************************\
**  Filename:	vis.m					**
**  Version:	1.0					**
**  Date:	25. Feb. 2008 - 13:54			**
**********************************************************
**  Type:	winamp.wasabi/maki			**
**  Project:	krazyPlayer				**
**********************************************************
**  Author:	Martin Poehlmann aka Deimos		**
**  E-Mail:	martin@skinconsortium.com		**
**  Internet:	http://www.skinconsortium.com		**
**		http://home.cs.tum.edu/~poehlman	**
\*******************************************************

SLoB 18/03/2008 - fix guru error
*/


#include <lib/std.mi>

Function switchTo(int n);

Global Container visGrpMain;
Global Layout visGrpLay;
Global Vis myVis, myVis2;
Global Group visGrp, timeline;
Global GuiObject Mousetrap, AlbumArt;
Global int stat;

System.onScriptLoaded ()
{

	visGrpMain = getContainer("main");
	visGrpLay = visGrpMain.getLayout("normal");

	visGrp = visGrpLay.findObject("main_vis_grp");
	myVis = visGrpLay.findObject("main.vis");
	myVis2 = visGrpLay.findObject("main.vis2");
	Mousetrap = visGrpLay.findObject("mousetrap.vis");
	AlbumArt = visGrpLay.findObject("albumart");
	timeline = visGrpLay.findObject("main.timelineVis");

	stat = getPrivateInt(getSkinName(), "vis.aa", 0);
	switchTo(stat);
}

switchTo(int n)
{
	n = n % 5;
	stat = n;
	setPrivateInt(getSkinName(), "vis.aa", n);

	if (n == 0)
	{
		timeline.hide();
		albumart.show();
		visGrp.hide();
	}
	else if (n == 1)
	{
		albumart.hide();
		myvis.setMode(1);
		myVis2.hide();
		visGrp.show();
	}
	else if (n == 2)
	{
		albumart.hide();
		myvis.setMode(2);
		myVis2.hide();
		visGrp.show();	
	}
	else if (n == 3)
	{
		albumart.hide();
		myvis.setMode(2);
		myVis2.show();
		visGrp.show();		
	}
	else
	{
		albumart.hide();
		visGrp.hide();
		timeline.show();	
	}	
}

mouseTrap.onLeftButtonUp (int x, int y)
{
	stat++;
	switchTo(stat);
}

mouseTrap.onRightButtonDown (int x, int y)
{
	PopupMenu pop = new PopupMenu;
	pop.addCommand("Album Art", 10, stat == 0, false);
	pop.addCommand("Spectrum Analyzer", 11, stat == 1, false);
	pop.addCommand("Oscilloscope", 12, stat == 2, false);
	pop.addCommand("Double Oscilloscope", 13, stat == 3, false);
	pop.addCommand("Timeline Analyzer", 14, stat == 4, false);
	pop.addSeparator();
	pop.addCommand("Get Album Art", 101, 0, 0);
	pop.addCommand("Refresh Album Art", 102, 0, 0);
	pop.addSeparator();
	pop.addCommand("Open Folder", 103, 0, 0);
	
	int res = pop.popAtMouse();
	
	delete pop;
	
	if (res >= 0)
	{
		if (res < 100)
		{
			switchTo(res-10);
		}
		else
		{
			if (res == 101)
			{
				if (system.getAlbumArt(system.getPlayItemString()) > 0)
				{
					//AlbumArt.setXmlParam("notfoundimage", getXmlParam("notfoundimage")); // a nesty refresh - isn't it?
					AlbumArt.setXmlParam("notfoundimage", "m_lcd_Logo2");
				}
			}
			else if (res == 102)
			{
				//AlbumArt.setXmlParam("notfoundimage", getXmlParam("notfoundimage")); // a nesty refresh - isn't it?
				AlbumArt.setXmlParam("notfoundimage", "m_lcd_Logo2");
			}
			else if (res == 103)
			{
				System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
			}			
		}
	}
}

mouseTrap.onRightButtonUp (int x, int y)
{	
	complete;
}