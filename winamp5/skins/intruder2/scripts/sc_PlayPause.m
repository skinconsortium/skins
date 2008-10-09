/*---------------------------------------------------
-----------------------------------------------------
Filename:	sc_PlayPause.m

Type:		maki/source
Version:	skin version 1.2
Date:		14:00 14.01.2007
Author:		Pieter Nieuwoudt aka pjn123
E-Mail:		sylvester@skinconsortium.com
Internet:	-
-----------------------------------------------------
-----------------------------------------------------
*/


#include <lib/std.mi>

Global Group frameGroup;
Global GuiObject playBut, pauseBut;


System.onScriptLoaded() {
	frameGroup = getScriptGroup();
	playBut = frameGroup.findObject(System.getToken(System.getParam(), ";", 0));
	pauseBut = frameGroup.findObject(System.getToken(System.getParam(), ";", 1));

	if (System.getStatus() == STATUS_STOPPED){
		pauseBut.hide();
	}
	else if (System.getStatus() == STATUS_PLAYING){
		playBut.hide();
	}
	else if (System.getStatus() == STATUS_PAUSED){
		pauseBut.hide();
	}
}

System.onStop(){
	playBut.show();
	pauseBut.hide();
}

System.onPlay(){
	playBut.hide();
	pauseBut.show();
}
System.onPause(){
	playBut.show();
	pauseBut.hide();
}

System.onResume(){
	playBut.hide();
	pauseBut.show();
}