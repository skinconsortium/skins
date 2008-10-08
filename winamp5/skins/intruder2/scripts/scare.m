//*** scare scripts ***

#include <lib/std.mi>
#include <lib/config.mi>
#include <lib/pldir.mi>

global layout mainnormal,scarelayout;
global button timer30,timer60,timer90;
global layer scarelayer;

global timer scaretimer, loadtimer, offtimer;

global string scaremusic;

Global ConfigAttribute attrRepeat, attrXfade;
global string lastconfig, lastxfade;

System.onScriptLoaded() {
	scaremusic = getParam();
	
	mainnormal = getContainer("main").getLayout("normalc");
	
	scarelayout = getContainer("scare").getLayout("normal");
	scarelayer = scarelayout.findobject("scare.layer");
	scarelayer.hide();
	scarelayout.hide();
	scarelayout.resize(0,0,getMonitorWidth(),getMonitorHeight());
	
	timer30 = mainnormal.findObject("30sec");
	timer60 = mainnormal.findObject("60sec");
	timer90 = mainnormal.findObject("90sec");
	
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

timer30.onActivate(int on) {
	if (!on) { scaretimer.stop(); return; }
	
	System.minimizeApplication();
	timer60.setActivatedNoCallback(0);
	timer90.setActivatedNoCallback(0);
	
	scaretimer.setDelay(30000);
	scaretimer.start();
	
	scarelayer.show();
}

timer60.onActivate(int on) {
	if (!on) { scaretimer.stop(); return; }
	
	System.minimizeApplication();
	timer30.setActivatedNoCallback(0);
	timer90.setActivatedNoCallback(0);
	
	scaretimer.setDelay(60000);
	scaretimer.start();
	
	scarelayer.show();
}

timer90.onActivate(int on) {
	if (!on) { scaretimer.stop(); return; }
	
	System.minimizeApplication();
	timer60.setActivatedNoCallback(0);
	timer30.setActivatedNoCallback(0);
	
	scaretimer.setDelay(90000);
	scaretimer.start();
	
	scarelayer.show();
}

scaretimer.onTimer() {
	stop();
	
	timer30.setActivatedNoCallback(0);
	timer60.setActivatedNoCallback(0);
	timer90.setActivatedNoCallback(0);
	
	scarelayout.resize(0,0,getMonitorWidth(),getMonitorHeight());
	scarelayout.show();
	scarelayer.show();
	
	lastconfig = attrRepeat.getData();
	lastxfade = attrXfade.getData();
	attrRepeat.setData("0");
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
}