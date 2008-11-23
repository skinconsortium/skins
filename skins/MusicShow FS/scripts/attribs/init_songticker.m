/*---------------------------------------------------
-----------------------------------------------------
Filename:	init_songticker.m
Version:	2.1

Type:		maki/attrib definitions
Date:		08. Jul. 2006 - 16:44 
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
-----------------------------------------------------
Depending Files:
		wasabi/OneDirectionText/oneDirectionText.maki
-----------------------------------------------------
---------------------------------------------------*/

#ifndef included
#error This script can only be compiled as a #include
#endif

#include "gen_pageguids.m"

Function initAttribs_songTicker();

#define CUSTOM_PAGE_SONGTICKER "{7061FDE0-0E12-11D8-BB41-0050DA442EF3}"


Global ConfigAttribute songticker_scrolling_enabled_attrib;
Global ConfigAttribute songticker_scrolling_disabled_attrib;


initAttribs_songTicker()
{

	initPages();

	ConfigItem custom_page_songticker = addConfigSubMenu(optionsmenu_page, "Songticker", CUSTOM_PAGE_SONGTICKER);

	songticker_scrolling_enabled_attrib = custom_page_songticker.newAttribute("Enable Songticker scrolling", "1");
	songticker_scrolling_disabled_attrib = custom_page_songticker.newAttribute("Disable Songticker scrolling", "0");


}

#ifdef MAIN_ATTRIBS_MGR

songticker_scrolling_enabled_attrib.onDataChanged()
{
  if (attribs_mychange) return;
  attribs_mychange = 1;
  if (getData() == "1") songticker_scrolling_disabled_attrib.setData("0");
  if (getData() == "0") songticker_scrolling_disabled_attrib.setData("1");
  attribs_mychange = 0;
}
songticker_scrolling_disabled_attrib.onDataChanged()
{
  if (attribs_mychange) return;
  attribs_mychange = 1;
  if (getData() == "1") songticker_scrolling_enabled_attrib.setData("0");
  if (getData() == "0") songticker_scrolling_enabled_attrib.setData("1");
  attribs_mychange = 0;
}


#endif