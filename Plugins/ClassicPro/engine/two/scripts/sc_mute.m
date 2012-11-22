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
Global Boolean direction, createdTooltip;
Global Timer myTimer;


System.onScriptLoaded() {
	mainGroup = getScriptGroup();
	/*
	vol_slider = mainGroup.findObject("two.playback.volslider");
	mute_but = mainGroup.findObject("two.player.mute");
	muteWarning = mainGroup.findObject("two.player.mute.overlay");
	*/
	vol_slider = mainGroup.findObject(getToken(getParam(),";",0));
	mute_but = mainGroup.findObject(getToken(getParam(),";",1));
	muteWarning = mainGroup.findObject(getToken(getParam(),";",2));
	myTimer = new Timer;
	myTimer.setDelay(700);
}

mainGroup.onSetVisible(boolean onOff){
	if(onOff){
		if(mute_but.getCurCfgVal() != getPrivateInt(getSkinName(), "muted", 0) || !createdTooltip){
			createdTooltip = true;
			mute_but.setActivated(getPrivateInt(getSkinName(), "muted", 0));
			mute_but.onToggle(getPrivateInt(getSkinName(), "muted", 0));
		}
	}
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
		if(getVolume()==0) setVolume(getPrivateInt(getSkinName(), "saveVol", 100));
		mute_but.setXmlParam("tooltip", "Mute Volume");
		stopFade();
	}
	else{
		if(getVolume()!=0) setPrivateInt(getSkinName(), "saveVol", getVolume());
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