/*---------------------------------------------------
-----------------------------------------------------
Filename:	seek.m
Version:	1.0

Type:		maki
Date:		18. Nov. 2006 - 18:07 
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu

Note:		This script is based on seek.m
		from Winamp Modern
-----------------------------------------------------
---------------------------------------------------*/

#include <lib/std.mi>

Global Group frameGroup;
Global Slider Seeker;
Global Int Seeking;
Global Text SongTicker;

System.onScriptLoaded()
{
	frameGroup = getScriptGroup();
	Seeker = frameGroup.findObject("Seeker.Ghost");
	SongTicker = frameGroup.getParentLayout().findObject("songticker");
}

Seeker.onSetPosition(int p) {
	if (seeking) {
		Float f;
		f = p;
		f = f / 255 * 100;
		Float len = getPlayItemLength();
		if (len != 0) {
			int np = len * f / 100;
			SongTicker.sendAction
			(
				"showinfo",
				"SEEK: " + integerToTime(np) + "/" + integerToTime(len) + " (" + integerToString(f) + "%) ",
				0, 0, 0, 0
			);
		}
	}
}


Seeker.onLeftButtonDown(int x, int y) {
	seeking = 1;
}

Seeker.onLeftButtonUp(int x, int y) {
	seeking = 0;
	SongTicker.sendAction("cancelinfo", "", 0, 0, 0, 0);
}

Seeker.onSetFinalPosition(int p) {
	SongTicker.sendAction("cancelinfo", "", 0, 0, 0, 0);
}