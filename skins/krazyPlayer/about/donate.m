/*---------------------------------------------------
-----------------------------------------------------
Filename:	donate.m
Version:	1.0

Type:		maki
Date:		03. Jul. 2006 - 22:40 
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
-----------------------------------------------------
---------------------------------------------------*/

#include <lib/std.mi>

Function String replaceString(string baseString, string toreplace, string replacedby);

Global Button paypal;

System.onScriptLoaded ()
{
	paypal = getScriptGroup().getObject("donate");
}

paypal.onLeftClick ()
{
	string s1 = "https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=donate%40skinconsortium%2ecom&item_name=SkinConsortium%20Donation&item_number=%3e%20for%20skin%3a%20";
	string s2 = getParam();
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(s2, " ") != -1) {
			s2 = replaceString(s2, " ", "%20");
			i = 0;
		} else i = 666;
	}
	string s3 = "&no_shipping=1&no_note=1&cn=Optional%20Message&tax=0&currency_code=EUR&lc=GB&bn=PP%2dDonationsBF&charset=UTF%2d8";
	System.navigateUrl(s1 + s2 + s3);
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