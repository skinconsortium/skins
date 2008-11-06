/*---------------------------------------------------
-----------------------------------------------------
Filename:	HyperLinkButton.m

Type:		maki
Version:	1.1
Date:		19. Jul. 2006 - 22:32 
Author:		Martin Poehlmann aka Deimos
SLoB:		added/changed for krazyPlayer
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
-----------------------------------------------------
---------------------------------------------------*/

#include <lib/std.mi>

Global Button btn;

Global String strurl;

System.onScriptLoaded() {
	Group XUIGroup = getScriptGroup();

	btn = XUIGroup.findObject("btn");
}

System.onSetXuiParam(String stringParam, String stringValue) {
	if (strlower(stringParam) == "url") strurl = stringValue;
}

btn.onleftclick() { System.navigateUrl(strurl); }