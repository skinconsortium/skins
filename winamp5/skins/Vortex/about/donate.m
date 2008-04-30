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

Global Button paypal;

System.onScriptLoaded ()
{
	paypal = getScriptGroup().getObject("donate");
}

paypal.onLeftClick ()
{
	System.navigateUrl("https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=donate%40skinconsortium%2ecom&item_name=SkinConsortium%20Donation&item_number=%3e%20for%20skin%3a%20Vortex&no_shipping=1&no_note=1&cn=Optional%20Message&tax=0&currency_code=EUR&lc=GB&bn=PP%2dDonationsBF&charset=UTF%2d8");
}