/*---------------------------------------------------
-----------------------------------------------------
Filename:	loadattribs.m
Version:	1.1

Type:		maki/attrib loader
Date:		03. Jul. 2006 - 22:40 
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
-----------------------------------------------------
---------------------------------------------------*/

#define MAIN_ATTRIBS_MGR
#define MAIN_ATTRIBS_LOADER

#include <lib/std.mi>

//#include "attribs/init_windowpage.m"
#include "attribs/init_songticker.m"
//#include "attribs/init_updateSystem.m"
//#include "attribs/init_visualizer.m"
#include "attribs/init_general.m"
#include "attribs/init_notifier.m"
#include "attribs/init_rgb.m"
#include "attribs/init_misc.m"
#include "attribs/init_vis.m"
#include "attribs/init_clock.m"
/*
include "attribs/init_glowbuttons.m"
include "attribs/init_windowmenus.m"

include "attribs/init_display.m"
include "attribs/init_playback.m"
include "attribs/init_colorthemes.m"
include "attribs/init_coversearch.m"


include "attribs/init_dashboard.m"
*/

System.onScriptLoaded()
{
/*	initAttribs_dashboard();
	initAttribs_display();

	initAttribs_coversearch();
	initAttribs_glowbuttons();*/
	initAttribs_notifier();
	initAttribs_songTicker();
	initAttribs_misc();
	initAttribs_vis();
	initAttribs_clock();
/*	
	initAttribs_windowmenus();
	initAttribs_playback();
	initAttribs_colorthemes();*/
	//initAttribs_updateSystem();

	//initAttribs_windowpage();

	initAttribs_general();
	initAttribs_RGB();
}