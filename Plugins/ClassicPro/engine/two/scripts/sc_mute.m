#include <lib/std.mi>

Global Group mainGroup;
Global Container main;
Global Slider vol_slider;
Global Layer muteWarning;

//MuteButton
Global Togglebutton mute_but;
Global Timer reCheck;

// Mute warning
Function doFade();
Function stopFade();
Function startFade();
Global Boolean direction;
Global Timer myTimer;


System.onScriptLoaded() {
	mainGroup = getScriptGroup();
	vol_slider = mainGroup.findObject("two.playback.volslider");
	mute_but = mainGroup.findObject("two.player.mute");
	muteWarning = mainGroup.findObject("two.player.mute.overlay");
	myTimer = new Timer;
	myTimer.setDelay(700);
}


vol_slider.onSetPosition(int newpos){
	if(mute_but.getCurCfgVal()==1 && newpos>0){
		mute_but.setActivated(false);
		setPrivateInt(getSkinName(), "muted", 0);
		stopFade();
	}
}
vol_slider.onPostedPosition(int newpos){
	if(mute_but.getCurCfgVal()==1 && newpos>0){
		mute_but.setActivated(false);
		setPrivateInt(getSkinName(), "muted", 0);
		stopFade();
	}
}

mute_but.onToggle(Boolean onoff){
	if(mute_but.getCurCfgVal()==0){
		setVolume(getPrivateInt(getSkinName(), "saveVol", 100));
		mute_but.setXmlParam("tooltip", "Mute Volume");
		stopFade();
	}
	else{
		setPrivateInt(getSkinName(), "saveVol", getVolume());
		setVolume(0);
		mute_but.setXmlParam("tooltip", "Turn Volume On");
		startFade();
	}
	setPrivateInt(getSkinName(), "muted", mute_but.getCurCfgVal());
}



//Mute warning
myTimer.onTimer(){
	doFade();
}
doFade(){
	if(direction){
		muteWarning.setTargetA(0);
	}
	else{
		muteWarning.setTargetA(253);
	}
	muteWarning.setTargetSpeed(0.6);
	muteWarning.gotoTarget();
	direction=!direction;
}
startFade(){
	direction=false;
	doFade();
	myTimer.start();
	muteWarning.show();
}
stopFade(){
	myTimer.stop();
	muteWarning.cancelTarget();
	muteWarning.setAlpha(0);
	muteWarning.hide();
}