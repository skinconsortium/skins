
#ifndef included
#error This script can only be compiled as a #include
#endif

#include "gen_pageguids.m"

Function initAttribs_misc();

Global ConfigAttribute configAttribute_clock_showleadingzero;
Global ConfigAttribute configAttribute_clock_show24hr;
Global ConfigAttribute configAttribute_clock_showwhenstopped;
Global ConfigAttribute configAttribute_repeatType;
Global ConfigAttribute configAttribute_shuffleType;
Global ConfigAttribute configAttribute_crossfadeType;
Global ConfigAttribute configAttribute_configType;

Global ConfigAttribute desktopalpha_enabled_attrib;

initAttribs_misc()
{
	initPages();

	configAttribute_repeatType 		= custom_page_nonexposed.newAttribute("Repeat", "1");
	configAttribute_configType 		= custom_page_nonexposed.newAttribute("Config", "1");
	configAttribute_shuffleType 		= custom_page_nonexposed.newAttribute("shuffle", "1");
	configAttribute_crossfadeType 		= custom_page_nonexposed.newAttribute("crossfade", "0");

	desktopalpha_enabled_attrib = Config.getItemByGuid("{9149C445-3C30-4E04-8433-5A518ED0FDDE}").getAttribute("Enable desktop alpha");

	ConfigItem cfgItems;
	
	cfgItems = Config.getItem("Playlist editor");
	if (cfgItems != NULL)
	{
		configAttribute_repeatType = cfgItems.getAttribute("repeat");
	}
}