/*--TickerText v1.1----------------------------------
-----------------------------------------------------
Filename:	TickerText.m

Type:		maki/source
Version:	skin version 1.2
Date:		20:30 24.09.2004
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
-----------------------------------------------------
--------------------INCLUDES-------------------------
-Cover Art
-----------------------------------------------------
----------------------NOTE---------------------------
I've written all the script on my own. I was only
inspired by other ones, but I never copied a whole
script or parts of it! 'Cause everyone has to learn
or inspire I implement the source files too.
But if you use parts or the entire script, mail me:
Give me your name, write a little text about your
skin and a skinshot! Then leave my header in the .m
file and implement it in your skin and leave credit
to my name, email and homepage where credit is done!
THX! Deimos
-----------------------------------------------------
---------------------------------------------------*/

#include "../../../../lib/std.mi"
#include "../../../../lib/config.mi"

#define FILENAME "TickerText.m"
#include "../ripprotection.mi"

Global Text _Text;
Global ConfigAttribute ca_scrolling;

System.onScriptLoaded() {
	Group XUIGroup = getScriptGroup();

	_Text = XUIGroup.findObject("tickertext");

	ca_scrolling = Config.getItemByGuid("{7061FDE0-0E12-11D8-BB41-0050DA442EF3}").getAttribute("Enable Songticker scrolling");
	ca_scrolling.onDataChanged();

	ripProtection();

}

_Text.onSetVisible(int v) {
	if (v) ca_scrolling.onDataChanged();
}

ca_scrolling.onDataChanged() {
	_Text.setXMLParam("ticker", getData());
}
