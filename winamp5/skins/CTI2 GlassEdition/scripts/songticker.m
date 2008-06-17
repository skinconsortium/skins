/*---------------------------------------------------
-----------------------------------------------------
Filename:	songticker.m
Version:	1.0

Type:		maki
Date:		18. Nov. 2006 - 16:08 
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
-----------------------------------------------------
---------------------------------------------------*/

#include <lib/std.mi>
#include attribs/init_songticker.m

Global Timer SongTickerTimer;
Global Text SongTicker;

System.onScriptLoaded ()
{
	initAttribs_songTicker();

	group sg = getScriptGroup();

	SongTicker = sg.findObject("songticker");
	SongTickerTimer = new Timer;
	SongTickerTimer.setDelay(1000);

	SongTicker.setXMLParam("ticker", songticker_scrolling_enabled_attrib.getData());
}

System.onScriptUnloading ()
{
	SongTickerTimer.stop();
	delete SongTickerTimer;
}

SongTicker.onAction (String action, String param, Int x, int y, int p1, int p2, GuiObject source)
{
	if (strlower(action) == "showinfo")
	{
		SongTicker.cancelTarget();
		SongTicker.setAlpha(255);
		SongTickerTimer.start();
		SongTicker.setText(param);
	}
	else if (strlower(action) == "cancelinfo")
	{
		SongTickerTimer.onTimer ();
	}
}

SongTickerTimer.onTimer ()
{
	SongTickerTimer.stop();
	Songticker.setTargetA(0);
	Songticker.setTargetSpeed(0.3);
	Songticker.gotoTarget();
}

Songticker.onTargetReached ()
{
	if (getAlpha() == 0)
	{
		SongTicker.setText("");
		Songticker.setTargetA(255);
		Songticker.setTargetSpeed(0.3);
		Songticker.gotoTarget();		
	}
}

/* Changing TickerScrolling via Config Attrib */

songticker_scrolling_enabled_attrib.onDataChanged ()
{
	SongTicker.setXMLParam("ticker", songticker_scrolling_enabled_attrib.getData());
}
