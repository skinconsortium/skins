//*** scare scripts ***

#include <lib/std.mi>
#include <lib/config.mi>
#include <lib/pldir.mi>

function updateScare();

global layout mainnormal,scarelayout;
global button timer30,timer60,timer90;
global button scarebut1,scarebut2,scarebut3;
global layer scarelayer;

global timer scaretimer, loadtimer, offtimer;

global string scaremusicpath,scaremusic;

Global ConfigAttribute attrRepeat, attrXfade;
global string lastconfig, lastxfade;
global int lastvol;

System.onScriptLoaded() {
	scaremusicpath = getParam();
	
	mainnormal = getContainer("main").getLayout("normalc");
	
	scarelayout = getContainer("scare").getLayout("normal");
	scarelayer = scarelayout.findobject("scare.layer");
	scarelayer.hide();
	scarelayout.hide();
	scarelayout.resize(0,0,getMonitorWidth(),getMonitorHeight());
	
	timer30 = mainnormal.findObject("30sec");
	timer60 = mainnormal.findObject("60sec");
	timer90 = mainnormal.findObject("90sec");
	
	scarebut1 = mainnormal.findObject("button.scare1");
	scarebut2 = mainnormal.findObject("button.scare2");
	scarebut3 = mainnormal.findObject("button.scare3");
	
	configItem item = Config.getItem("Playlist editor");
	attrRepeat = item.getAttribute("repeat");
	
	item =  Config.getItemByGUID("{FC3EAF78-C66E-4ED2-A0AA-1494DFCC13FF}");
	attrXfade = item.getAttribute("Enable crossfading");
	
	scaretimer = new timer;
	
	loadtimer = new timer;
	loadtimer.setdelay(500);
	loadtimer.start();
	
	offtimer = new timer;
	offtimer.setdelay(4000);
	
	int mode = getPrivateInt(getSkinName(),"ScareMode",1);
	if (mode == 1) 
		scarebut1.setActivatedNoCallback(1);
	else if (mode == 2)
		scarebut2.setActivatedNoCallback(1);
	else
		scarebut3.setActivatedNoCallback(1);
		
	updateScare();
}

loadtimer.onTimer() {
	stop();
	
	scarelayout.hide();
}

system.onScriptUnloading() {
	delete scaretimer;
	delete loadtimer;
	delete offtimer;
}

updateScare() {
	int mode = getPrivateInt(getSkinName(),"ScareMode",1);
	
	if (mode == 1) {
		scarelayer.setXMLParam("image","player/scare.jpg");
		scaremusic = scaremusicpath + "\scream9.wav";
	} else if (mode == 2) {
		scarelayer.setXMLParam("image","player/scare2.jpg");
		scaremusic = scaremusicpath + "\Evil Laugh.wav";
	} else {
		scarelayer.setXMLParam("image","player/scare3.jpg");
		scaremusic = scaremusicpath + "\Psycho 02.wav";
	} 
}

timer30.onActivate(int on) {
	if (!on) { scaretimer.stop(); return; }
	
	System.minimizeApplication();
	timer60.setActivatedNoCallback(0);
	timer90.setActivatedNoCallback(0);
	
	scaretimer.setDelay(30000);
	scaretimer.start();
	
	updateScare();
	scarelayer.show();
}

timer60.onActivate(int on) {
	if (!on) { scaretimer.stop(); return; }
	
	System.minimizeApplication();
	timer30.setActivatedNoCallback(0);
	timer90.setActivatedNoCallback(0);
	
	scaretimer.setDelay(60000);
	scaretimer.start();
	
	updateScare();
	scarelayer.show();
}

timer90.onActivate(int on) {
	if (!on) { scaretimer.stop(); return; }
	
	System.minimizeApplication();
	timer60.setActivatedNoCallback(0);
	timer30.setActivatedNoCallback(0);
	
	scaretimer.setDelay(90000);
	scaretimer.start();
	
	updateScare();
	scarelayer.show();
}

scarebut1.onActivate(int on) {
	setPrivateInt(getSkinName(),"ScareMode",1);
	if (!on) { scarebut1.setActivatedNoCallback(1); return; }
	
	scarebut2.setActivatedNoCallback(0);
	scarebut3.setActivatedNoCallback(0);
}

scarebut2.onActivate(int on) {
	setPrivateInt(getSkinName(),"ScareMode",2);
	if (!on) { scarebut2.setActivatedNoCallback(1); return; }
	
	scarebut3.setActivatedNoCallback(0);
	scarebut1.setActivatedNoCallback(0);
}

scarebut3.onActivate(int on) {
	setPrivateInt(getSkinName(),"ScareMode",3);
	if (!on) { scarebut3.setActivatedNoCallback(1); return; }
	
	scarebut2.setActivatedNoCallback(0);
	scarebut1.setActivatedNoCallback(0);
	
}

scaretimer.onTimer() {
	stop();
	
	timer30.setActivatedNoCallback(0);
	timer60.setActivatedNoCallback(0);
	timer90.setActivatedNoCallback(0);
	
	updateScare();
	
	scarelayout.resize(0,0,getMonitorWidth(),getMonitorHeight());
	scarelayout.show();
	scarelayer.show();
	
	lastconfig = attrRepeat.getData();
	lastxfade = attrXfade.getData();
	lastvol = getVolume();
	attrRepeat.setData("0");
	//attrXfade.setData("0");
	setVolume(255);
	PlEdit.enqueueFile(scaremusic);				 // adds and plays scare.wav
	PlEdit.playTrack(PlEdit.getNumTracks()-1);
	
	offtimer.start();
}

System.onKeyDown(string key) {
	if (!scarelayout.isVisible()) return;

	if (key=="esc") {
		offtimer.ontimer();
	}
	
}

System.onTitleChange(string newtitle) {
	if (offtimer.isRunning()) stop();
}

offtimer.ontimer() {
	stop();
	
	scarelayer.hide();
	scarelayout.hide();
	system.stop();
	PlEdit.removeTrack(PlEdit.getNumTracks()-1); // removes scare.wav
	attrRepeat.setData(lastconfig);
	attrXfade.setData(lastxfade);
	setVolume(lastvol);
}