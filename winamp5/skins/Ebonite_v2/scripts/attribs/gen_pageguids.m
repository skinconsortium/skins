/*---------------------------------------------------
-----------------------------------------------------
Filename:	gen_pageguids.m

Type:		maki/page guid definitions
Version:	1.0
Date:		03. Jul. 2006 - 18:29 
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
-----------------------------------------------------
---------------------------------------------------*/

#ifndef included
#error This script can only be compiled as a #include
#endif

#ifndef __GEN_PAGEGUIDS_M
#define __GEN_PAGEGUIDS_M

#include <lib/config.mi>

Function initPages();

/*--NON CHANGEABLE GUIDS:--------------------------*/

// this is the page that maps its items to the options menu, you can add attribs or more pages (submenus)
#define CUSTOM_OPTIONSMENU_ITEMS "{1828D28F-78DD-4647-8532-EBA504B8FC04}"
Global ConfigItem optionsmenu_page;

// this is the page that maps its items to the windows menu (aka View), you can add attribs or more pages (submenus)
#define CUSTOM_WINDOWSMENU_ITEMS "{6559CA61-7EB2-4415-A8A9-A2AEEF762B7F}"
Global ConfigItem custom_windows_page;

// non exposed attribs page
//#define CUSTOM_PAGE_NONEXPOSED "{E9C2D926-53CA-400f-9A4D-85E31755A4CF}"
#define CUSTOM_PAGE_NONEXPOSED "{0b804f46-fd44-49e6-ba2d-410844a4b190}"
Global ConfigItem custom_page_nonexposed;


/*--DECLARE PAGES HERE:----------------------------*/

initPages()
{

#ifndef __PAGES
#define __PAGES

	custom_page_nonexposed = Config.newItem("Hidden", CUSTOM_PAGE_NONEXPOSED);

	// load up the cfgpage in which we'll insert our custom page
	optionsmenu_page = Config.getItem(CUSTOM_OPTIONSMENU_ITEMS);

	custom_windows_page = Config.getItem(CUSTOM_WINDOWSMENU_ITEMS);

#endif

}

/*--GLOBAL DEFINITIONS:----------------------------*/

#define NOOFF if (getData()=="0") { setData("1"); return; }
Global Int attribs_mychange;

Global ConfigAttribute sep;
Global Int sep_count = 0;

Function addMenuSeparator(ConfigItem cfgmenupage);

addMenuSeparator(ConfigItem cfgmenupage)
{
#ifdef MAIN_ATTRIBS_LOADER

	sep_count = sep_count + 1;
	sep = cfgmenupage.newAttribute(getSkinName() + "seperator" + integerToString(sep_count), "");
	sep.setData("-");

#endif
}

Function ConfigItem addConfigSubMenu(configitem parent, string name, string guid);

ConfigItem addConfigSubMenu(configitem parent, string name, string guid)
{
	ConfigItem __ret = Config.newItem(name, guid);
	ConfigAttribute __dret = parent.newAttribute(name, "");
	__dret.setData(guid);
	return __ret;
}

#endif