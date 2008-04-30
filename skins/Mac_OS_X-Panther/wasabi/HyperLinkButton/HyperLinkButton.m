/*---------------------------------------------------
-----------------------------------------------------
Filename:	HyperLinkButton.m

Type:		maki/source
Version:	skin version 1.2
Date:		10:11 30.08.2004
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
-----------------------------------------------------
--------------------INCLUDES-------------------------
-SliderText
-----------------------------------------------------
----------------------NOTE---------------------------
I've written all the script on my own. I was only
inspired by other ones, but I never copied a whole
script or parts of it! 'Cause everyone has to learn
or inspire I implement the source files too.
But if you use parts or the entire script, mail me:
Give me your name, write a little text about your
skin and a skinshot! Then leave my header in the .m
file and implement it in your skin and leave credit
to my name, email and homepage where credit is done!
THX! Deimos
-----------------------------------------------------
---------------------------------------------------*/

#include "../../../../lib/std.mi"

#define FILENAME "restorebutton.m"
#include "../ripprotection.mi"

Global Button btn;

Global String strurl;

System.onScriptLoaded() {
	Group XUIGroup = getScriptGroup();

	btn = XUIGroup.findObject("btn");

	ripProtection();
}

System.onSetXuiParam(String stringParam, String stringValue) {
	if (strlower(stringParam) == "url") strurl = stringValue;
}

btn.onleftclick() { System.navigateUrl(strurl); }