#include <lib/std.mi>
#define fadeTime 0.3
#define defAlpha 180

Function updateInfo(String showThis);
Function showNews(boolean show);
Function cancelStuff();

Global Group mainGroup;
Global Text info_news;
Global GuiObject info_songticker;
Global Timer fade, goBack;
Global Button sl_volume; //actualy a slider...
Global Button prev, next, open;
Global Boolean isShort, busyWithSeek, cancelNext;
Global Togglebutton shufBut, repBut, muteBut;


System.onScriptLoaded(){
	mainGroup = getScriptGroup();
	info_songticker = mainGroup.findObject("songticker.r");
	info_news = mainGroup.findObject("songticker");
	sl_volume = mainGroup.findObject("vol_slider");
	prev = mainGroup.findObject("prev");
	next = mainGroup.findObject("next");
	open = mainGroup.findObject("open");
	shufBut = mainGroup.findObject("shuffle");
	repBut = mainGroup.findObject("repeat");

	fade = new Timer;
	fade.setDelay(300);
	goBack = new Timer;
	busyWithSeek=false;
	cancelNext=false;
}

System.onscriptunloading(){
	delete fade;
	delete goBack;
}


shufBut.onToggle(Boolean onOff){
	if(onOff) updateInfo("Shuffle: On");
	else updateInfo("Shuffle: Off");
}

repBut.onToggle(Boolean onOff){
	if(stringtointeger(repBut.getXmlParam("cfgval"))==0) updateInfo("Repeat: Off");
	else if(stringtointeger(repBut.getXmlParam("cfgval"))==1) updateInfo("Repeat: Playlist");
	else updateInfo("Repeat: Track");
}

updateInfo(String showThis){
	cancelStuff();

	//do stuff
	info_news.setText(showThis);
	showNews(true);
}

cancelStuff(){
	//cancel stuff
	fade.stop();
	goBack.stop();
	info_songticker.cancelTarget();
	info_news.cancelTarget();
}

showNews(boolean show){
	if(show){
		if(isShort){
			goBack.setDelay(200);
			isShort=false;
		}
		else{
			goBack.setDelay(1000);
		}
		
		if(!busyWithSeek) goBack.start();
		
		info_songticker.setAlpha(0);
		info_songticker.hide();
		info_news.setAlpha(defAlpha);
		info_news.show();
	}
	else{
		info_news.show();
		info_news.setTargetA(0);
		info_news.setTargetSpeed(fadeTime);
		info_news.gotoTarget();
		fade.start();
	}
}

fade.onTimer(){ //fade to songticker
	info_songticker.show();
	info_songticker.setAlpha(0);
	info_songticker.setTargetA(defAlpha);
	info_songticker.setTargetSpeed(fadeTime);
	info_songticker.gotoTarget();
	info_news.hide();
	fade.stop();
}

System.onVolumeChanged(int newvol){
	if(cancelNext){
		cancelNext=false;
	}
	else updateInfo("Vol: "+integerToString(newvol/255*100)+"%");
}

goBack.onTimer(){
	showNews(false);
	goBack.stop();
}

prev.onLeftClick(){
	isShort=true;
	updateInfo("Previous Track");
}
next.onLeftClick(){
	isShort=true;
	updateInfo("Next Track");
}

System.onStop(){
	updateInfo("Playback Stopped");
}
System.onPlay(){
	updateInfo("Playing");
}
System.onPause(){
	updateInfo("Playback Paused");
}
System.onResume(){
	updateInfo("Resuming Playback");
}
open.onLeftClick(){
	updateInfo("Open file(s)");
}


System.onSeek(int newpos)
{
	if (System.getStatus() == 1 || System.getStatus() == -1) 
	{
		updateInfo(integertoTime(newpos) + "/" + integerToTime(getPlayItemLength()+0.001)); //SLoB fixed- is this the div by zero bug?
	}
}

/*
This will check to see if mouse is still down... aka user busy with seek. If this isnt done, it will start flashing
*/
sl_volume.onLeftButtonUp(int x, int y){
	busyWithSeek=false;
	int newpos = System.getVolume();
	updateInfo("Vol: "+integerToString(newpos/255*100)+"%");
}
sl_volume.onLeftButtonDown(int x, int y){
	busyWithSeek=true;
}