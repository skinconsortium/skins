/*---------------------------------------------------
-----------------------------------------------------
Filename:	updateSystem.m

Type:		maki/source
Version:	skin version 1.2
Date:		22:39 17.05.2005
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
-----------------------------------------------------
---------------------------------------------------*/

#include "../../../../lib/std.mi"
#include "../../scripts/attribs/init_updateSystem.m"

Function String replaceString(string baseString, string toreplace, string replacedby);

Global Browser brw;

Global String str_version;
Global String url;
Global Boolean ready = 0;
Global int count = 0;
Global Timer tmr, timeout;
Global Layout l;

System.onSetXuiParam(String stringParam, String stringValue) {
	if (strlower(stringParam) == "remotefile") { url = stringValue; count++; }
	if (strlower(stringParam) == "skinversion") { str_version = stringValue;  count++; }
	if (count == 2) {
		initAttribs_updateSystem();

		Group XUIGroup = getScriptgroup();

		l = XUIGroup.getParentLayout();

		brw = XUIGroup.findObject("brw");
		if (autoupdate_attrib.getData() == "1") {
			tmr = new Timer;
			tmr.setDelay(5000);
			tmr.start();
			timeout = new Timer;
			timeout.setDelay(30000);
			timeout.start();
		}
	}	
}

System.onScriptUnloading ()
{
	l.hide();
}


tmr.onTimer ()
{
	Stop();
	l.show();
}

timeout.onTimer ()
{
	Stop();
	l.hide();
}

l.onSetVisible (Boolean onoff)
{
	if (onoff)
	{
		brw.navigateURL(url + "?skinupdate+" + str_version);
	}
}

brw.onDocumentComplete(String url) {
//	debug(url);
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
		brw.navigateUrl("about:blank");
		timeout.stop();
		timeout.setDelay(10000);
		timeout.start();
	}
}

String replaceString(string baseString, string toreplace, string replacedby) {
	if (toreplace == "") return baseString;
	string sf1 = strupper(baseString);
	string sf2 = strupper(toreplace);
	int i = strsearch(sf1, sf2);
	if (i == -1) return baseString;
	string left = "", right = "";
	if (i != 0) left = strleft(baseString, i);

	if (strlen(basestring) - i - strlen(toreplace) != 0) {
		right = strright(basestring, strlen(basestring) - i - strlen(toreplace));
	}
	return left + replacedby + right;
}