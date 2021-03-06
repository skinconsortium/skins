//*** scare scripts ***

#include <lib/std.mi>
#include <lib/config.mi>
#include <lib/pldir.mi>

function updateScare();

global layout mainnormal,scarelayout;
global button timer30,timer60,timer90;
global button scarebut1,scarebut2,scarebut3;
global layer scarelayer;

global timer scaretimer, scaretimer2, loadtimer, offtimer;

global string scaremusicpath,scaremusic;

Global ConfigAttribute attrRepeat, attrXfade, attrShfl;
global string lastconfig, lastxfade, lastshuffle;
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
	attrShfl = item.getAttribute("shuffle");
	
	item =  Config.getItemByGUID("{FC3EAF78-C66E-4ED2-A0AA-1494DFCC13FF}");
	attrXfade = item.getAttribute("Enable crossfading");
	
	scaretimer = new timer;
	
	loadtimer = new timer;
	loadtimer.setdelay(500);
	loadtimer.start();
	
	offtimer = new timer;
	offtimer.setdelay(4000);
	
	scaretimer2 = new timer;
	scaretimer2.setdelay(50);
	
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
	delete scaretimer2;
	delete loadtimer;
	delete offtimer;
}

updateScare() {
	int mode = getPrivateInt(getSkinName(),"ScareMode",1);
	
	if (mode == 1) {
		scarelayer.setXMLParam("image","player/scare.jpg");
		scaremusic = scaremusicpath + "\mode1.xml";
	} else if (mode == 2) {
		scarelayer.setXMLParam("image","player/scare2.jpg");
		scaremusic = scaremusicpath + "\mode2.xml";
	} else {
		scarelayer.setXMLParam("image","player/scare3.jpg");
		scaremusic = scaremusicpath + "\mode3.xml";
	} 
}

timer30.onActivate(int on) {
	if (!on) { scaretimer.stop(); scaretimer2.stop(); return; }
	
	System.minimizeApplication();
	timer60.setActivatedNoCallback(0);
	timer90.setActivatedNoCallback(0);
	 
	if(System.isKeyDown(VK_SHIFT)) scaretimer.setDelay(2000); //just for testing
	else scaretimer.setDelay(30000);
	
	scaretimer.start();
	
	updateScare();
	scarelayer.show();
}

timer60.onActivate(int on) {
	if (!on) { scaretimer.stop(); scaretimer2.stop(); return; }
	
	System.minimizeApplication();
	timer30.setActivatedNoCallback(0);
	timer90.setActivatedNoCallback(0);
	
	scaretimer.setDelay(60000);
	scaretimer.start();
	
	updateScare();
	scarelayer.show();
}

timer90.onActivate(int on) {
	if (!on) { scaretimer.stop(); scaretimer2.stop(); return; }
	
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

	
	lastconfig = attrRepeat.getData();
	lastxfade = attrXfade.getData();
	lastshuffle = attrShfl.getData();
	lastvol = getVolume();
	attrRepeat.setData("0");
	attrShfl.setData("0");
	//attrXfade.setData("0");
	
	setVolume(0);
	PlEdit.enqueueFile(scaremusic);				 // adds and plays scare.wav
	//PlEdit.playTrack(PlEdit.getNumTracks()-1);
	System.Stop();

	setVolume(255);

	scaretimer2.start();
}

scaretimer2.onTimer() {
	scaretimer2.stop();
	
	PlEdit.playTrack(PlEdit.getNumTracks()-1);
	scarelayout.show();
	scarelayer.show();

	offtimer.start();
}

System.onKeyDown(string key) {
	if (!scarelayout.isVisible()) return;

	if (key=="esc") {
		offtimer.ontimer();
	}
	
}

/*System.onTitleChange(string newtitle) {
	if (offtimer.isRunning()) stop();
}*/

offtimer.ontimer() {
	stop();
	
	scarelayer.hide();
	scarelayout.hide();
	system.stop();
	PlEdit.removeTrack(PlEdit.getNumTracks()-1); // removes scare.wav
	attrRepeat.setData(lastconfig);
	//attrXfade.setData(lastxfade);
	attrShfl.setData(lastshuffle);
	setVolume(lastvol);
}