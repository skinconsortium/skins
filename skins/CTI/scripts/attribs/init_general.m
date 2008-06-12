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

Function initAttribs_general();

#define CUSTOM_PAGE_GENERAL "{F1239F09-8CC6-4081-8519-C2AE99FCB14C}"


Global ConfigAttribute crossfade_time_attrib;


initAttribs_general()
{

	initPages();

	ConfigItem custom_page_general = config.getItemByGuid(CUSTOM_PAGE_GENERAL);

	crossfade_time_attrib = custom_page_general.getAttribute("Crossfade time");

}