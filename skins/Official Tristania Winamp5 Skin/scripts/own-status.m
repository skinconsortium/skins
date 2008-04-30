/*---------------------------------------------------
-----------------------------------------------------
Filename:	own-status.m

Type:		maki/source
Version:	skin version 1.1
Date:		12.Apr.2004 - 23:19
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.tk
-----------------------------------------------------
Includes: 
---------
-Play/Pause ComboButton
-sexy Pause Animation
-disc animation (very buggy uses lot of resources
	never had that problem jet)
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
#ifndef included
#error This script can only be compiled as a #include
#endif

Function PauseAnim(int state);
/*-
Global String str_titanversion;
-*/
Global Int swob_state, a1;
Global Timer PlayTimer;
/*-Global AnimatedLayer al_disc;
Global Browser brw;-*/

unload_status() {
	delete PlayTimer;
}

load_status() {
/*-
	al_disc = PlayerDisplay.findObject("player.normal.display.disc.anim");
	al_disc.setSpeed(fpsToMsc(1+stringToInteger(display_discanim_speed_attrib.getData())));
-*/
	PlayTimer = new Timer;
	PlayTimer.setDelay(1000);

	Int PlayerStatus = getStatus();
//-	al_disc.stop();
/*
 	STATUS_PAUSED -1
	STATUS_STOPPED 0
	STATUS_PLAYING 1
*/
	if ( PlayerStatus == 1 ) {
		PlayTimer.start();
//-		if (display_discanim_attrib.getData() == "1") al_disc.play();
//-		onStatusEvent("play");
	}
	if ( PlayerStatus == 0 ) {
//-		al_disc.stop();
//-		onStatusEvent("stop");
		setSeekAnim(0);
	}
	if ( PlayerStatus == -1 ) {
//-		al_disc.stop();
//-		onStatusEvent("pause");
//-		PauseAnim(1);
	}
/*-
	str_titanversion = "1.01";

	brw = _main_normal.findObject("brw");
	if (autoupdate_attrib.getData() == "1") {
		brw.navigateURL("about:blank");
//		brw.navigateURL("http://localhost/deimos/updates/titan_ckeck.htm?Titan|" + str_titanversion);
		brw.navigateURL("http://home.arcor.de/martin.deimos/updates/titan_ckeck.htm?Titan|" + str_titanversion);

	}-*/


}

System.onResume() {
	PlayTimer.start();
	PauseAnim(0);
//-	if (display_discanim_attrib.getData() == "1") al_disc.play();
//-	onStatusEvent("resume");
}

System.onPlay() {
	PlayTimer.start();
	PauseAnim(0);
//-	if (display_discanim_attrib.getData() == "1") al_disc.play();
//-	onStatusEvent("play");
}

System.onPause() {
	PlayTimer.stop();
//-	PauseAnim(1);
//-	if (display_discanim_attrib.getData() == "1") al_disc.pause();
//-	onStatusEvent("pause");
}

System.onStop() {
	PlayTimer.stop();
//-	al_disc.gotoFrame(al_disc.getStartFrame());
//-	if (display_discanim_attrib.getData() == "1") al_disc.stop();
//-	onStatusEvent("stop");
	setSeekAnim(0);
}

PlayTimer.onTimer() {
	int curpo = 255 * getPosition() / getPlayItemLength();
	setSeekAnim(curpo);
	setPublicInt("Deimos/Playback/_Position", getPosition());
}

System.onTitleChange(String newtitle) {
//-	onStatusEvent("newtrack");
}

PauseAnim(int state) {
	float f_speed = 0.5;
	swob_state = state;
	if (state==1) {
		l_pauseanim.setTargetA(255);
		l_pauseanim.setXMLParam("alpha", "0");
		l_pauseanim.show();
		l_pauseanim.setTargetSpeed(f_speed);
		l_pauseanim.gotoTarget();
		sa_pnn.hide();
		swob_state = 2;
	} if (state==2) {
		l_pauseanim.setTargetA(0);
		l_pauseanim.setTargetSpeed(f_speed);
		l_pauseanim.gotoTarget();
		swob_state = 3;
	} if (state==3) {
		l_pauseanim.setTargetA(255);
		l_pauseanim.setTargetSpeed(f_speed);
		l_pauseanim.gotoTarget();
		swob_state = 2;
	} if (state==0) {
		l_pauseanim.setXMLParam("alpha", "0");
		l_pauseanim.hide();
		sa_pnn.show();
	}
}

l_pauseanim.onTargetReached() { 
	PauseAnim(swob_state);
}
/*-
display_discanim_speed_attrib.onDataChanged() {
	al_disc.setSpeed(fpsToMsc(1+stringToInteger(getData())));
}

display_discanim_attrib.onDataChanged() {
	if (getData() == "1" && getStatus() == 1) al_disc.play();
	if (getData() == "0") al_disc.stop();
}

brw.onDocumentComplete(String url) {
	if (strsearch(url, "|Aviable") != -1) {
		int i_upd = messageBox("A new Version of Titan is aviable! Do you like to download it?" , "New Version Aviable", 12, "");
		if (i_upd == 4 ) brw.navigateUrl("http://home.arcor.de/martin.deimos/updates/titan_ckeck.htm?Titan," + str_titanversion + "|Down");
	}
	if (strsearch(url, "|newSkin") != -1) {
		int i_upd = messageBox("A new Skin by Deimos is aviable! Do you like to download it?" , "New Skin Aviable", 12, "");
		if (i_upd == 4 ) brw.navigateUrl("http://home.arcor.de/martin.deimos/updates/titan_ckeck.htm?Titan," + str_titanversion + "|getSkin");
	}
}-*/