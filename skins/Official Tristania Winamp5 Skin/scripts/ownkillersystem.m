/*---------------------------------------------------
Filename:	ownkillersystem.m

Type:		maki/header
Version:	skin version 1.1
Date:		13.Apr.2004 - 18:47
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.tk
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
---------------------------------------------------*/

// Libraries:

#include "../../../lib/std.mi"
#include "../../../lib/exd.mi"
#include "../../../lib/config.mi"

#include "attribs.m"

#ifndef __OWNKILLERSYSTEM_M
#define __OWNKILLERSYSTEM_M
#endif

// Ripprotection:

#define FILENAME "ownkilersystem.m"
#include "../../../lib/ripprotection.mi"

// Load/UnLoad-Functions:

Function load_seek();
Function load_status();
Function load_volume();
Function load_global();

Function unload_seek();
Function unload_status();
Function unload_volume();

// MAKI-sourcefiles:

#include "own-global.m" 
#include "own-volume.m"
#include "own-seek.m" 		// Seek
#include "own-status.m" 	// PauseAnim, Play/Pause Button

System.onScriptLoaded() {

	initAttribs();
	
	load_global();
	load_volume();
	load_seek();
	load_status();

	ripProtection("tristania");

}

System.onScriptUnloading() {
	unload_volume();
	unload_seek();
	unload_status();
}
