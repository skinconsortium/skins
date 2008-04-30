/*---------------------------------------------------
-----------------------------------------------------
Filename:	own-volume.m

Type:		maki/source
Version:	skin version 1.1
Date:		16.Apr.2004 - 23:19
Author:		Martin P. alias Deimos
E-Mail:		hippies4ever@web.de
Internet:	www.deimos.tk
-----------------------------------------------------
--------------------INCLUDES-------------------------
-Autorepeating Volume Button
-Mute Function: You can set the volume to 0 and set
      it back to the old level.
-Remembering Volume Level: It saves the volume level
      in studio.xnf and can call it back on Winamp3-
      start.
-Remembering Mute Level: It saves the mute level (1/0)
      in studio.xnf and can call it back even when
      an other skin was loaded between or Winamp3 was
      closed! (great, isn't it!)
-sexy wobbling mute-anim!!
-Volume Map
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
#ifndef included
#error This script can only be compiled as a #include
#endif

Global Layer volOver;



//-Function Mute(boolean onoff);
Function setVolumeAnim(int newvol);
Function updateVolumeAnim(int x, int y);
Function MuteAnim(int state);

//-Global Button VolumeMute;

Global Map VolMap;
//-Global Layer l_muteanim;

Global Int CurrVol, ARrate, VARVol, oldsetvol;
Global Boolean b_Mute, Voling;
Global String imageid;
Global Int wob_state;
Global AnimatedLayer volanim, volanim2;


unload_volume() {
	delete VolMap;
}

load_volume() {

	volOver = PlayerDisplay.findObject("volume.overlay");
//-	l_muteanim = PlayerDisplay.findObject("player.normal.display.volume.mute");

	VolMap = new Map;
	VolMap.loadMap("player.normal.volume.map");

//-	imageid = "player.normal.button.volume.mute";

	CurrVol = System.GetVolume();

        VARVol = getPrivateInt("deimos.global.Mute", "VARVolume", CurrVol);
        b_Mute = getPrivateInt("deimos.global.Mute", "VARMute", 0);

/*-	if (b_Mute) {
		Mute(1);
		VolumeMute.setXMLParam("image", imageid + ".normal" + ".enabled");
		VolumeMute.setXMLParam("downImage", imageid + ".pressed" + ".enabled");
		VolumeMute.setXMLParam("hoverImage", imageid + ".hover" + ".enabled");
	} else {
		VARVol = getPrivateInt("deimos.global.Mute", "VARVolume", 255);
		VolumeMute.setXMLParam("image", imageid + ".normal" + ".disabled");
		VolumeMute.setXMLParam("downImage", imageid + ".pressed" + ".disabled");
		VolumeMute.setXMLParam("hoverImage", imageid + ".hover" + ".disabled");
	}-*/
//	_VKnobInit(PlayerButtons, "volume.knob");
//	_VBgInit(PlayerButtons, "volume.bg");
	volanim = PlayerDisplay.findObject("volume.anim");
	volanim2 = PlayerDisplay.findObject("volume.knobanim");

	setVolumeAnim(CurrVol);

}

System.onVolumeChanged(int newvol) {
	int relvol = newvol / 2.55;
	Songticker.sendAction("setText", "Volume: " + System.integerToString(relvol)+ "%", 0, 0, 0, 0);
//-	b_Mute = getPrivateInt("deimos.global.Mute", "VARMute", 0);
//-	if (b_Mute == 1) setVolume(0);
	setVolumeAnim(newvol);
	oldsetvol = newvol;
}
/*-#ifdef __OWNKILLERSYSTEM_M

Mute(boolean onoff) {
	setPrivateInt("deimos.global.Mute", "VARMute", onoff);
	if (onoff) {
		VolumeMute.setXMLParam("image", imageid + ".normal" + ".enabled");
		VolumeMute.setXMLParam("downImage", imageid + ".pressed" + ".enabled");
		VolumeMute.setXMLParam("hoverImage", imageid + ".hover" + ".enabled");
		VARVol = getVolume();
		setPrivateInt("deimos.global.Mute", "VARVolume", VARVol);
		setVolume(0);
	} else {
		VolumeMute.setXMLParam("image", imageid + ".normal" + ".disabled");
		VolumeMute.setXMLParam("downImage", imageid + ".pressed" + ".disabled");
		VolumeMute.setXMLParam("hoverImage", imageid + ".hover" + ".disabled");
		VARVol = getPrivateInt("deimos.global.Mute", "VARVolume", 255);
		setVolume(VARVol);
	}
}-*/
//-#endif
/*-MuteAnim(int state) {
	float f_speed = 0.5;
	wob_state = state;
	if (state==1) {
		l_muteanim.setTargetA(255);
		l_muteanim.setXMLParam("alpha", "0");
		l_muteanim.show();
		l_muteanim.setTargetSpeed(f_speed);
		l_muteanim.gotoTarget();
		wob_state = 2;
	} if (state==2) {
		l_muteanim.setTargetA(0);
		l_muteanim.setTargetSpeed(f_speed);
		l_muteanim.gotoTarget();
		wob_state = 3;
	} if (state==3) {
		l_muteanim.setTargetA(255);
		l_muteanim.setTargetSpeed(f_speed);
		l_muteanim.gotoTarget();
		wob_state = 2;
	} if (state==0) {
		l_muteanim.setXMLParam("alpha", "0");
		l_muteanim.hide();
	}
}
l_muteanim.onTargetReached() { 
	MuteAnim(wob_state);
}-*/
/*-#ifdef __OWNKILLERSYSTEM_M
VolumeMute.onLeftClick() {
	b_Mute = getPrivateInt("deimos.global.Mute", "VARMute", 0);
	if (b_Mute == 1) {
		Mute(0);
		MuteAnim(0);
	}
	if (b_Mute == 0) {
		Mute(1);
		MuteAnim(1);
	}
}-*/
//-#endif
setVolumeAnim(int newvol) {
	volanim.gotoFrame(newvol/10.625);
	volanim2.gotoFrame(newvol/10.625);
}

volOver.onLeftButtonDown(int x, int y) {
	Voling = 1;
	updateVolumeAnim(x, y);
}

volOver.onMouseMove(int x, int y) {
	if (Voling && volOver.isMouseOverRect() ) {
		oldsetvol = getVolume();
		updateVolumeAnim(x, y);
	}
}

volOver.onLeftButtonUp(int x, int y) {
	if ( Voling && volOver.isMouseOverRect() ) {
		Voling = 0;
		updateVolumeAnim(x, y);
	}
	if ( Voling && !volOver.isMouseOverRect() ) {
		Voling = 0;
		setVolume(oldsetvol);
	}
}

updateVolumeAnim(int x, int y) {
	int newVal = VolMap.getValue(x - volOver.getLeft(), y - volOver.getTop());
	int deltaVolume = oldsetvol - newVal;
	if (deltaVolume > 150 || deltaVolume < -150) return;
	setVolume(newVal);
}