#ifndef included
#error This script can only be compiled as a #include
#endif

#ifndef __ATTRIBS_M
#define __ATTRIBS_M


#include <lib/config.mi>

// -----------------------------------------------------------------------------------------------------------------


// this is the page that maps its items to the options menu, you can add attribs or more pages (submenus)
#define CUSTOM_OPTIONSMENU_ITEMS "{1828D28F-78DD-4647-8532-EBA504B8FC04}"

// this is the page that maps its items to the windows menu (aka View), you can add attribs or more pages (submenus)
#define CUSTOM_WINDOWSMENU_ITEMS "{6559CA61-7EB2-4415-A8A9-A2AEEF762B7F}"


// non exposed attribs page
#define CUSTOM_PAGE_NONEXPOSED "{E9C2D926-53CA-400f-9A4D-85E31755A4CF}"

// custom options submenu item page, you can add more, just use guidgen and Config.newItem()
#define CUSTOM_PAGE "{9924D4DF-B776-48b4-8BC9-DC26D8BD13E4}"

// -----------------------------------------------------------------------------------------------------------------

Function initAttribs();

// -----------------------------------------------------------------------------------------------------------------



Global ConfigAttribute myattr_cdcovertype;


// -----------------------------------------------------------------------------------------------------------------

initAttribs() {

	// create the custom cfgpage for this session (if it does exist, it just returns it)
	ConfigItem custom_page = Config.newItem("Graviton Skin", CUSTOM_PAGE);

	ConfigItem custom_page_nonexposed = Config.newItem("Hidden", CUSTOM_PAGE_NONEXPOSED);

	// load up the cfgpage in which we'll insert our custom page
	ConfigItem custom_options_page = Config.getItem(CUSTOM_OPTIONSMENU_ITEMS);

	// this creates a submenu for this attribute
	ConfigAttribute submenuattrib = custom_options_page.newAttribute("Graviton Skin", "");
	submenuattrib.setData(CUSTOM_PAGE); // discard any default value and point at our custom cfgpage


	myattr_cdcovertype = custom_page_nonexposed.newAttribute("CD Cover Type", "net");

}

// -----------------------------------------------------------------------------------------------------------------

#endif
