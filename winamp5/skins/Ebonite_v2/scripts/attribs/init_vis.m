
#ifndef included
#error This script can only be compiled as a #include
#endif

#include "gen_pageguids.m"

Function initAttribs_vis();

#define CUSTOM_PAGE_COVER "{0ff91115-b854-4c37-b614-fadb84edac8f}"

Global ConfigAttribute configAttribute_clock_showleadingzero;
Global ConfigAttribute configAttribute_clock_show24hr;
Global ConfigAttribute configAttribute_clock_showwhenstopped;
Global ConfigAttribute configAttribute_repeatType;
Global ConfigAttribute configAttribute_shuffleType;
Global ConfigAttribute configAttribute_crossfadeType;
Global ConfigAttribute configAttribute_configType;

Global ConfigAttribute myattr_SCCoverEnabled;
Global ConfigAttribute myattr_SC90DegVisEnabled;
Global ConfigAttribute myattr_SC90DegVisDirection;
Global ConfigAttribute myattr_SC90DegVisRotation;

Global ConfigAttribute vis_mode_style_attrib;
Global ConfigAttribute vis_mode_Pattern_attrib;
Global ConfigAttribute myattr_SCCubeVisEnabled;

Global ConfigAttribute globalmyattr_SCCubeVisEnabled;
Global ConfigAttribute globalmyattr_SC90DegVisEnabled;
Global ConfigAttribute globalmyattr_SCCoverEnabled;


initAttribs_vis()
{

	initPages();

	myattr_SC90DegVisDirection 			= custom_page_nonexposed.newAttribute("VizDirection", "0");

	ConfigItem custom_page_cover = addConfigSubMenu(optionsmenu_page, "Cover", CUSTOM_PAGE_COVER);

	myattr_SCCoverEnabled = custom_page_cover.newAttribute("Show Cover", "0");
	myattr_SC90DegVisEnabled = custom_page_cover.newAttribute("Show Viz", "0");
	myattr_SCCubeVisEnabled = custom_page_cover.newAttribute("Show Cube Viz", "0");
	myattr_SC90DegVisRotation = custom_page_cover.newAttribute("Rotate Std Viz", "1");
	
	vis_mode_style_attrib = custom_page_nonexposed.newAttribute("Style", "1");
	vis_mode_Pattern_attrib = custom_page_nonexposed.newAttribute("Pattern", "1");
	globalmyattr_SCCubeVisEnabled = custom_page_nonexposed.newAttribute("coverenablecubeviz", "0");
	globalmyattr_SCCoverEnabled = custom_page_nonexposed.newAttribute("coverenablecover", "0");
	globalmyattr_SC90DegVisEnabled = custom_page_nonexposed.newAttribute("coverenable90viz", "0");
}

#ifdef MAIN_ATTRIBS_MGR


myattr_SC90DegVisEnabled.onDataChanged()
{
	if(getData()=="1")
	{
		myattr_SCCoverEnabled.setData("0");
		myattr_SCCubeVisEnabled.setData("0");
		
		globalmyattr_SCCoverEnabled.setData("0");
		globalmyattr_SC90DegVisEnabled.setData("1");
		globalmyattr_SCCubeVisEnabled.setData("0");		
	}
	else if(getData()=="2")
	{
		myattr_SCCoverEnabled.setData("0");
		myattr_SCCubeVisEnabled.setData("0");
		
		globalmyattr_SCCoverEnabled.setData("0");
		globalmyattr_SC90DegVisEnabled.setData("2");
		globalmyattr_SCCubeVisEnabled.setData("0");		
	}
	else
	{
		globalmyattr_SC90DegVisEnabled.setData("0");
	}
}

myattr_SCCubeVisEnabled.onDataChanged()
{
	if(getData()=="1")
	{
		myattr_SCCoverEnabled.setData("0");
		myattr_SC90DegVisEnabled.setData("0");
		
		globalmyattr_SCCoverEnabled.setData("0");
		globalmyattr_SC90DegVisEnabled.setData("0");
		globalmyattr_SCCubeVisEnabled.setData("1");
	}
	else
	{
		globalmyattr_SCCubeVisEnabled.setData("0");
	}
}

#endif
