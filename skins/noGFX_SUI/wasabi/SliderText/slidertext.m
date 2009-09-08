/*---------------------------------------------------
-----------------------------------------------------
Filename:	cover.m

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
#include "../../../../lib/config.mi"

#define FILENAME "slidertext.m"
#include "../ripprotection.mi"

Function setTxt();

Global Text txt;
Global ConfigAttribute attrib;

Global String after, before, attribname, attribguid;
Global Boolean isdiv = 0, isinv = 0;
Global float m;
Global Int ndigits, add = 0;

System.onScriptLoaded() {
	Group XUIGroup = getScriptGroup();

	txt = XUIGroup.findObject("txt");

	ripProtection();
}

System.onSetXuiParam(String stringParam, String stringValue) {
	if (strlower(stringParam) == "textbefore") before = stringValue;
	if (strlower(stringParam) == "textafter") after = stringValue;
	if (strlower(stringParam) == "attribname") attribname = stringValue;
	if (strlower(stringParam) == "attribguid") attribguid = stringValue;
	if (strlower(stringParam) == "multiplier") m = stringToFloat(stringValue);
	if (strlower(stringParam) == "division") isdiv = stringToInteger(stringValue);
	if (strlower(stringParam) == "inverted") isinv = stringToInteger(stringValue);
	if (strlower(stringParam) == "ndigits") ndigits = stringToInteger(stringValue);
	if (strlower(stringParam) == "add") add = stringToInteger(stringValue);
	if (attribname != "" && attribguid != "" ) {
		attrib = Config.getItemByGuid(attribguid).getAttribute(attribname);
		setTxt();
	}
}

attrib.onDataChanged() { setTxt(); }

setTxt() {
	float f = stringToFloat(attrib.getData()) + add;
	if (isinv) {
		if (isdiv) f = m / f;
		else f = f * m;
	} else {
		if (isdiv) f = f / m;
		else f = f * m;
	}
	txt.setText(before + floatToString(f, ndigits) + after);
}