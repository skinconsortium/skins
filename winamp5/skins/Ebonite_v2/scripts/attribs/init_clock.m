#ifndef included
#error This script can only be compiled as a #include
#endif

#include "gen_pageguids.m"

Function initAttribs_clock();

#define CUSTOM_PAGE_CLOCK "{F260193E-3598-4086-82B2-651110BA2900}"

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