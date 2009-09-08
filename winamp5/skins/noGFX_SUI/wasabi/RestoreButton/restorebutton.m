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

#define FILENAME "restorebutton.m"
#include "../ripprotection.mi"

Global Button btn;
Global ConfigAttribute attrib;

Global String inputstring;
Global Int numattribs, nomsg = 0;

System.onScriptLoaded() {
	Group XUIGroup = getScriptGroup();

	btn = XUIGroup.findObject("btn");

	ripProtection();
}

System.onSetXuiParam(String stringParam, String stringValue) {
	if (strlower(stringParam) == "setattribs") inputstring = stringValue;
	if (strlower(stringParam) == "numattribs") numattribs = stringToInteger(stringValue);
	if (strlower(stringParam) == "nomsg") nomsg = stringToInteger(stringValue);
}

btn.onLeftClick() {
	if (!nomsg) int i_answer = messageBox("Do you wish to set the values for this page back to the original skin values?" , "Restore standard values", 12, "");

	if (i_answer == 4 || nomsg) {
		for ( int i = 0; i <= numattribs-1; i++ ) {
			string seperated = getToken(inputstring, "|", i);
			string attribsep = getToken(seperated, ":", 0);
			string ci_guid = getToken(attribsep, ";", 0);
			string ca_name = getToken(attribsep, ";", 1);
			string newval = getToken(seperated, ":", 1);
			attrib = Config.getItemByGuid(ci_guid).getAttribute(ca_name);
			attrib.setData(newval);
		}
	}
}