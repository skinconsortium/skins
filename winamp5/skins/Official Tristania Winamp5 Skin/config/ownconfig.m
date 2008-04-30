/*---------------------------------------------------
-----------------------------------------------------
Filename:	own-config.m

Type:		maki/header
Version:	skin version 1.1
Date:		10.July.2004 - 23:19
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@arcor.de
Internet:	www.martin.deimos.de.vu
		home.arcor.de\martin.deimos
-----------------------------------------------------
--------------------INCLUDES-------------------------
-Configuration Tree like Winamp3 Preferences YEH
-Notifier
-Glowbutton Configuration
-Powerline Configuration
-----------------------------------------------------
----------------------NOTE---------------------------
I've written all the scripts on my own. I was only
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

#define MAIN_ATTRIBS_MGR
//#define VIS_ATTRIBS_MGR

#include "../../../lib/std.mi"
#include "../scripts/attribs.m"

#define FILENAME "ownconfig.m"
#include "../../../lib/ripprotection.mi"

Global Container ct_prefs;
Global Button btn_close;
Global Int mychange;

System.onScriptLoaded() {
	initAttribs();

	ct_prefs = System.getContainer("config");

	btn_close = ct_prefs.getLayout("normal").findObject("ConfigGroup").findObject("wasabi.frame.layout").findObject("Close");



	ripProtection("tristania");
}

//---Prefs Window Handling---

prefs_visible_attrib.onDataChanged() {
	if (mychange) return;
	mychange = 1;
	prefs_visible_attrib2.setData(getData());
	if (getData() == "1") ct_prefs.show();
	if (getData() == "0") ct_prefs.close();
	mychange = 0;
}

prefs_visible_attrib2.onDataChanged() {
	if (mychange) return;
	mychange = 1;
	prefs_visible_attrib.setData(getData());
	if (getData() == "1") ct_prefs.show();
	if (getData() == "0") ct_prefs.close();
	mychange = 0;
}


btn_close.onLeftClick() {
	prefs_visible_attrib.setData("0");
	prefs_visible_attrib2.setData("0");
}

System.onKeyDown(String key) {
  if (key == "alt+p") {
    if (prefs_visible_attrib.getData() == "0") {
        prefs_visible_attrib.setData("1");
	prefs_visible_attrib2.setData("1");
    } else {
        prefs_visible_attrib.setData("0");
        prefs_visible_attrib2.setData("0");
    } complete;
  }
  if (key == "alt+g") {
    if (eq_visible_attrib.getData() == "0") {
        eq_visible_attrib.setData("1");
    } else {
        eq_visible_attrib.setData("0"); 
    } complete;
  }
  if (key == "ctrl+f") {
    	navigateUrl(getPath(getPlayItemString()));
	complete;
  }
  if (key == "ctrl+q") {
    	string sdata = playback_shutdown_playlist_attrib.getData();
	if (sdata == "1") {
		playback_shutdown_playlist_attrib.setData("0");
	}
	if (sdata == "0") {
		playback_shutdown_playlist_attrib.setData("1");
	}
	complete;
  }
  if (key == "alt+q") {
    	string sdata = playback_shutdown_playlist_attrib.getData();

	if (sdata == "1") {
		playback_shutdown_track_attrib.setData("0");
	}
	if (sdata == "0") {
		playback_shutdown_track_attrib.setData("1");
	}
	complete;
  }
}
