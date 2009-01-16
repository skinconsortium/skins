/*---------------------------------------------------
-----------------------------------------------------
Filename:	init_general.m
Version:	1.0

Type:		maki/attrib definitions
29. Jul. 2006 - 16:50 
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
-----------------------------------------------------
---------------------------------------------------*/

#ifndef included
#error This script can only be compiled as a #include
#endif

#include "gen_pageguids.m"

Function initAttribs_general();

Global ConfigAttribute desktopalpha_enabled_attrib;



initAttribs_general() {

	initPages();

	desktopalpha_enabled_attrib = Config.getItemByGuid("{9149C445-3C30-4E04-8433-5A518ED0FDDE}").getAttribute("Enable desktop alpha");


}

