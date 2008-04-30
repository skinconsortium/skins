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

#include "../../../lib/std.mi"
#include "../scripts/attribs.m"
#include "../../../lib/exd.mi"

#define FILENAME "updateSystem.m"
#include "../../../lib/ripprotection.mi"

Global Browser brw;

Global String str_version;
Global String url;
Global Boolean ready = 0;

System.onScriptLoaded() {
	initAttribs();
	Group XUIGroup = getScriptgroup();

	str_version = getParam();

	url = "http://home.arcor.de/martin.deimos/updates/panther_dsu.htm?Panther";
//	url = "file://J:\siemens2\_mac os x - panther\panther_dsu.htm?Panther";

	brw = XUIGroup.findObject("brw");
	if (autoupdate_attrib.getData() == "1") {
//		brw.navigateURL("about:blank");
		brw.navigateURL(url + "+" + str_version);
//		system.navigateURL("http://home.arcor.de/martin.deimos/updates/panther_check.htm?Panther," + str_version);

	}
	//messageBox("" , "New Version Available", 12, "");
	ripprotection("panther");
}

brw.onDocumentComplete(String url) {
	if (strsearch(url, "|Available") != -1 && !ready) {
		string msg = getToken(url, ";", 1);
		for ( int i = 0; i < 666; i++ ) {	
			if (strsearch(msg, "%20") != -1) {
				msg = replaceString(msg, "%20", " ");
				i = 0;
			} else i = 666;
		}
		for ( int i = 0; i < 666; i++ ) {	
			if (strsearch(msg, "%40") != -1) {
				msg = replaceString(msg, "%40", "\n");
				i = 0;
			} else i = 666;
		}
		int i_upd = messageBox("A new version of this skin is available!\n\n" + msg + "\n\nDo you like to download this version?" , "New Version Available", 12, "");
		ready = 1;
		if (i_upd == 4 ) brw.navigateUrl(url+ "," + str_version + "+Down");
	}
}