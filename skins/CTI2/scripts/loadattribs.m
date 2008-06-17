/*---------------------------------------------------
-----------------------------------------------------
Filename:	loadattribs.m
Version:	1.2

Type:		maki/attrib loader
Date:		29. Aug. 2006 - 23:43 
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
-----------------------------------------------------
---------------------------------------------------*/

#define MAIN_ATTRIBS_MGR
#define MAIN_ATTRIBS_LOADER

#include <lib/std.mi>

#include attribs/init_songticker.m
#include attribs/init_general.m

System.onScriptLoaded()
{
	initAttribs_songTicker();

	// without optionsmenu entry:
	initAttribs_general();
}