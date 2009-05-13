#ifndef included
#error This script can only be compiled as a #include
#endif

#include "gen_pageguids.m"

Function initAttribs_clock();

#define CUSTOM_PAGE_CLOCK "{EFF7B9C8-57D3-442f-B9D2-43F9C1AEF75F}"

Global ConfigAttribute configAttribute_clock_showleadingzero;
Global ConfigAttribute configAttribute_clock_show24hr;
Global ConfigAttribute configAttribute_clock_showwhenstopped;

initAttribs_clock()
{

	initPages();

	ConfigItem custom_page_clock = addConfigSubMenu(optionsmenu_page, "Clock", CUSTOM_PAGE_CLOCK);

	configAttribute_clock_showwhenstopped 		= custom_page_clock.newAttribute("ShowClockwhenStopped", "1");
	configAttribute_clock_show24hr 			= custom_page_clock.newAttribute("Show24HourClock", "1");
	configAttribute_clock_showleadingzero 		= custom_page_clock.newAttribute("ShowClockLeadingZero", "1");

}

#ifdef MAIN_ATTRIBS_MGR

#endif