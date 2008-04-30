/*---------------------------------------------------
-----------------------------------------------------
Filename:	configpage.m

Type:		maki/source
Version:	skin version 1.2
Date:		22:39 17.05.2005
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
-----------------------------------------------------
--------------------INCLUDES-------------------------
-Cover Art
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
#include "../../scripts/attribs.m"

#define FILENAME "updateSystem.m"
#include "../../../../lib/ripprotection.mi"

Global Browser brw;

Global String str_version;
Global String url;

System.onScriptLoaded() {
	Group XUIGroup = getScriptGroup();

	str_version = "1.0";

//	url = "http://home.arcor.de/martin.deimos/updates/panther_check.htm?Panther";
	url = "H:\Eigene Dateien\Meine Websites\Deimos\updates\panther_check.htm?Panther";

	brw = XUIGroup.findObject("brw");
	if (autoupdate_attrib.getData() == "1") {
		brw.navigateURL("about:blank");
		brw.navigateURL(url + "|" + str_version);
//		brw.navigateURL("http://home.arcor.de/martin.deimos/updates/panther_check.htm?Panther|" + str_version);

	}
	ripprotection("panther");
}

brw.onDocumentComplete(String url) {
	if (strsearch(url, "|Aviable") != -1) {
		int i_upd = messageBox("A new Version of this is aviable! Do you like to download it?" , "New Version Aviable", 12, "");
		if (i_upd == 4 ) brw.navigateUrl(url+ "," + str_version + "|Down");
	}
	if (strsearch(url, "|newSkin") != -1) {
		int i_upd = messageBox("A new Skin by Deimos is aviable! Do you like to download it?" , "New Skin Aviable", 12, "");
		if (i_upd == 4 ) brw.navigateUrl(url+ "," + str_version + "|getSkin");
	}
}