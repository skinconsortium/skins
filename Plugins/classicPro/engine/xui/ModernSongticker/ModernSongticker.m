#include <lib/std.mi>
#define fadeTime 0.3

Function updateInfo(String showThis);
Function showNews(boolean show);
Function cancelStuff();

Global Layout mainLayout;

Global Group mainGroup;
Global Text info_news;
Global GuiObject info_songticker;
Global Timer fade, goBack;
Global Slider sl_volume, sl_seeker;
Global Button prev, next, open;
Global Boolean isShort, busyWithSeek, cancelNext;
Global Togglebutton shufBut, repBut, muteBut;

System.onScriptLoaded(){
	mainGroup = getScriptGroup();
	info_songticker = mainGroup.findObject("m.st.ticker");
	info_news = mainGroup.findObject("m.st.news");

	fade = new Timer;
	fade.setDelay(300);
	goBack = new Timer;
	busyWithSeek=false;
	cancelNext=false;
}

/*System.onShowLayout(Layout _layout){
	mainLayout = getContainer("main").getLayout("normal");
	if(mainLayout==_layout){
		//mainGroup = getScriptGroup();
		//info_songticker = mainGroup.findObject("m.st.ticker");
		//info_news = mainGroup.findObject("m.st.news");
		
		//sl_volume = mainLayout.findObject("Volume");
		//sl_seeker = mainLayout.findObject("seeker");
		//prev = mainLayout.findObject("previous.track");
		//next = mainLayout.findObject("next.track");
		//open = mainLayout.findObject("open.tracks");
		//shufBut = mainLayout.findObject("shuffle");
		//repBut = mainLayout.findObject("repeat");
		//muteBut = mainLayout.findObject("mute");
	}
}*/

System.onscriptunloading(){
	delete fade;
	delete goBack;
}

System.onSetXuiParam(String param, String value) {
	if(strlower(param) == "id_layout"){
		mainLayout = getContainer(getToken(value, ";", 0)).getLayout(getToken(value, ";", 1));
	}
	else if(strlower(param) == "id_volume"){
		sl_volume = mainLayout.findObject(value);
	}
	else if(strlower(param) == "id_seeker"){
		sl_seeker = mainLayout.findObject(value);
	}
	else if(strlower(param) == "id_prev"){
		prev = mainLayout.findObject(value);
	}
	else if(strlower(param) == "id_next"){
		next = mainLayout.findObject(value);
	}
	else if(strlower(param) == "id_open"){
		open = mainLayout.findObject(value);
	}
	else if(strlower(param) == "id_shuf"){
		shufBut = mainLayout.findObject(value);
	}
	else if(strlower(param) == "id_rep"){
		repBut = mainLayout.findObject(value);
	}
	else if(strlower(param) == "id_mute"){
		muteBut = mainLayout.findObject(value);
	}
	else{
		info_songticker.setXmlParam(param, value);
		info_news.setXmlParam(param, value);
	}
}


shufBut.onToggle(Boolean onOff){
	if(onOff) updateInfo("Shuffle: On");
	else updateInfo("Shuffle: Off");
}

repBut.onToggle(Boolean onOff){
	if(repBut.getCurCfgVal()==0) updateInfo("Repeat: Off");
	else if(repBut.getCurCfgVal()==1) updateInfo("Repeat: Playlist");
	else updateInfo("Repeat: Track");
}

muteBut.onToggle(Boolean onoff){
	//Cancel next volume info tip
	cancelNext=true;
	if(muteBut.getCurCfgVal()==0){
		updateInfo("Mute: Off");
	}
	else{
		updateInfo("Mute: On");
	}
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
		info_news.setAlpha(255);
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
	info_songticker.setTargetA(255);
	info_songticker.setTargetSpeed(fadeTime);
	info_songticker.gotoTarget();
	info_news.hide();
	fade.stop();
}

System.onVolumeChanged(int newvol){
	if(cancelNext){
		cancelNext=false;
	}
	else updateInfo("Volume:" + " "+integerToString(newvol/255*100)+"%");
}

goBack.onTimer(){
	showNews(false);
	goBack.stop();
}

sl_seeker.onSetPosition(int newpos){
	updateInfo("Seek: " + integerToTime(newpos/255*getPlayItemLength()) + "/" + integerToTime(getPlayItemLength()) +" ("+ integerToString(newpos/255*100)+"%)");
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


/*
This will check to see if mouse is still down... aka user busy with seek. If this isnt done, it will start flashing
*/
sl_volume.onLeftButtonUp(int x, int y){
	busyWithSeek=false;
	int newpos = System.getVolume();
	updateInfo("Volume:" + " "+integerToString(newpos/255*100)+"%");
}
sl_volume.onLeftButtonDown(int x, int y){
	busyWithSeek=true;
}

sl_seeker.onLeftButtonUp(int x, int y){
	busyWithSeek=false;
	isShort=true;
	int newpos = sl_seeker.getPosition();
	updateInfo("Seek: " + integerToTime(newpos/255*getPlayItemLength()) + "/" + integerToTime(getPlayItemLength()) +" ("+ integerToString(newpos/255*100)+"%)");
}
sl_seeker.onLeftButtonDown(int x, int y){
	busyWithSeek=true;
}