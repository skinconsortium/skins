/*---------------------------------------------------
-----------------------------------------------------
Filename:	init_notifier.m

Type:		maki/attrib definitions
Version:	1.1
Date:		12. Jul. 2006 - 16:15 
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
-----------------------------------------------------
Depending Files:
		wasabi/notifier/notifier.maki
-----------------------------------------------------
---------------------------------------------------*/

#ifndef included
#error This script can only be compiled as a #include
#endif

#include "gen_pageguids.m"


Function initAttribs_notifier();

#define CUSTOM_PAGE_NOTIFIER "{4b100531-6dd6-4b89-8ee2-3392d7feeb79}"
#define CUSTOM_PAGE_NOTIFIER_AA "{e48dda15-84cb-467b-b75d-ccc760e34ef1}"
#define CUSTOM_PAGE_NOTIFIER_LOC "{e308e077-16d9-4704-9cd5-125c06e93e71}"
#define CUSTOM_PAGE_NOTIFIER_FDIN "{45779031-790e-4f71-aa74-5c4744e044ac}"
#define CUSTOM_PAGE_NOTIFIER_FDOUT "{b15651a9-2256-4019-a357-b776d2cc00a1}"
#define CUSTOM_PAGE_NOTIFIER_SHIFTY "{66623378-20fb-11dc-8314-0800200c9a66}"


Global ConfigAttribute notifier_minimized_attrib;
Global ConfigAttribute notifier_always_attrib;
Global ConfigAttribute notifier_never_attrib;
Global ConfigAttribute notifier_fadeintime_attrib;
Global ConfigAttribute notifier_fadeouttime_attrib;
Global ConfigAttribute notifier_holdtime_attrib;
Global ConfigAttribute notifier_showfullscreen_attrib;

Global ConfigAttribute notifier_fdout_alpha;
Global ConfigAttribute notifier_fdout_hslide;
Global ConfigAttribute notifier_fdout_vslide;

Global ConfigAttribute notifier_fdin_alpha;
Global ConfigAttribute notifier_fdin_hslide;
Global ConfigAttribute notifier_fdin_vslide;

Global ConfigAttribute notifier_loc_br_attrib;
Global ConfigAttribute notifier_loc_bl_attrib;
Global ConfigAttribute notifier_loc_tr_attrib;
Global ConfigAttribute notifier_loc_tl_attrib;
Global ConfigAttribute notifier_showcover_attrib;

Global ConfigAttribute notifier_ypos_20_attrib;
Global ConfigAttribute notifier_ypos_40_attrib;
Global ConfigAttribute notifier_ypos_60_attrib;
Global ConfigAttribute notifier_ypos_80_attrib;
Global ConfigAttribute notifier_ypos_100_attrib;


initAttribs_notifier() {

	initPages();
	
	ConfigItem custom_page_notifier = addConfigSubMenu(optionsmenu_page, "Notifications", CUSTOM_PAGE_NOTIFIER);
	
	notifier_always_attrib = custom_page_notifier.newAttribute("Show always", "1");
	notifier_minimized_attrib = custom_page_notifier.newAttribute("Show only when minimized", "0");
	notifier_never_attrib = custom_page_notifier.newAttribute("Never show", "0");
	notifier_showfullscreen_attrib = custom_page_notifier.newAttribute("Show in fullscreen", "0");
	//addMenuSeparator(custom_page_notifier);	
	notifier_showcover_attrib = custom_page_notifier.newAttribute("Enable Cover", "0");
	//addMenuSeparator(custom_page_notifier);
	
	
	ConfigItem custom_page_notifier_loc = addConfigSubMenu(custom_page_notifier, "Location", CUSTOM_PAGE_NOTIFIER_LOC);

	ConfigItem custom_page_notifier_fdin = addConfigSubMenu(custom_page_notifier, "Fade In Effect", CUSTOM_PAGE_NOTIFIER_FDIN);

	ConfigItem custom_page_notifier_fdout = addConfigSubMenu(custom_page_notifier, "Fade Out Effect", CUSTOM_PAGE_NOTIFIER_FDOUT);
	
	ConfigItem custom_page_notifier_ypos = addConfigSubMenu(custom_page_notifier, "Y Offset", CUSTOM_PAGE_NOTIFIER_SHIFTY);
	



	notifier_fadeintime_attrib = custom_page_nonexposed.newAttribute("Notifications fade in time", "1000");
	notifier_fadeouttime_attrib = custom_page_nonexposed.newAttribute("Notifications fade out time", "5000");
	notifier_holdtime_attrib = custom_page_nonexposed.newAttribute("Notifications display time", "2000");


// Notifications > Location
	notifier_loc_br_attrib = custom_page_notifier_loc.newAttribute("Bottom Right", "1");
	notifier_loc_bl_attrib = custom_page_notifier_loc.newAttribute("Bottom Left", "0");
	notifier_loc_tr_attrib = custom_page_notifier_loc.newAttribute("Top Right", "0");
	notifier_loc_tl_attrib = custom_page_notifier_loc.newAttribute("Top Left", "0");
	
	notifier_ypos_20_attrib = custom_page_notifier_ypos.newAttribute("20 Pixels", "1");
	notifier_ypos_40_attrib = custom_page_notifier_ypos.newAttribute("40 Pixels", "0");
	notifier_ypos_60_attrib = custom_page_notifier_ypos.newAttribute("60 Pixels", "0");
	notifier_ypos_80_attrib = custom_page_notifier_ypos.newAttribute("80 Pixels", "0");
	notifier_ypos_100_attrib = custom_page_notifier_ypos.newAttribute("100 Pixels", "0");
	

// Notifications > Fade...
	notifier_fdout_alpha = custom_page_notifier_fdout.newAttribute("Alpha Fade ", "1");
	notifier_fdout_vslide = custom_page_notifier_fdout.newAttribute("Vertical Slide ", "0");
	notifier_fdout_hslide = custom_page_notifier_fdout.newAttribute("Horizontal Slide ", "0");

	notifier_fdin_alpha = custom_page_notifier_fdin.newAttribute("Alpha Fade", "1");
	notifier_fdin_vslide = custom_page_notifier_fdin.newAttribute("Vertical Slide", "0");
	notifier_fdin_hslide = custom_page_notifier_fdin.newAttribute("Horizontal Slide", "0");

}

#ifdef MAIN_ATTRIBS_MGR

notifier_always_attrib.onDataChanged() {
  if (attribs_mychange) return;
  NOOFF
  attribs_mychange = 1;
  notifier_never_attrib.setData("0");
  notifier_minimized_attrib.setData("0");
  attribs_mychange = 0;
}

notifier_never_attrib.onDataChanged() {
  if (attribs_mychange) return;
  NOOFF
  attribs_mychange = 1;
  notifier_always_attrib.setData("0");
  notifier_minimized_attrib.setData("0");
  attribs_mychange = 0;
}

notifier_minimized_attrib.onDataChanged() {
  if (attribs_mychange) return;
  NOOFF
  attribs_mychange = 1;
  notifier_never_attrib.setData("0");
  notifier_always_attrib.setData("0");
  attribs_mychange = 0;
}

notifier_fdout_alpha.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_fdout_hslide.setData("0");
	notifier_fdout_vslide.setData("0");
	attribs_mychange = 0;
}
notifier_fdout_hslide.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_fdout_alpha.setData("0");
	notifier_fdout_vslide.setData("0");
	attribs_mychange = 0;
}
notifier_fdout_vslide.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_fdout_hslide.setData("0");
	notifier_fdout_alpha.setData("0");
	attribs_mychange = 0;
}

notifier_fdin_alpha.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_fdin_hslide.setData("0");
	notifier_fdin_vslide.setData("0");
	attribs_mychange = 0;
}
notifier_fdin_hslide.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_fdin_alpha.setData("0");
	notifier_fdin_vslide.setData("0");
	attribs_mychange = 0;
}
notifier_fdin_vslide.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_fdin_hslide.setData("0");
	notifier_fdin_alpha.setData("0");
	attribs_mychange = 0;
}

notifier_loc_br_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_loc_bl_attrib.setData("0");
	notifier_loc_tr_attrib.setData("0");
	notifier_loc_tl_attrib.setData("0");
	attribs_mychange = 0;
}
notifier_loc_bl_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_loc_br_attrib.setData("0");
	notifier_loc_tr_attrib.setData("0");
	notifier_loc_tl_attrib.setData("0");
	attribs_mychange = 0;
}
notifier_loc_tl_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_loc_bl_attrib.setData("0");
	notifier_loc_tr_attrib.setData("0");
	notifier_loc_br_attrib.setData("0");
	attribs_mychange = 0;
}
notifier_loc_tr_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_loc_bl_attrib.setData("0");
	notifier_loc_br_attrib.setData("0");
	notifier_loc_tl_attrib.setData("0");
	attribs_mychange = 0;
}

#endif
