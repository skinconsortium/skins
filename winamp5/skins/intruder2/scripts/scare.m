//*** scare scripts ***

#include <lib/std.mi>

function string pathToURL(string path);

global layout mainnormal,scarelayout;
global button timer30,timer60,timer90;

global timer scaretimer, loadtimer;

global string scaremusic;

System.onScriptLoaded() {
	scaremusic = pathToURL(getParam());
	
	mainnormal = getContainer("main").getLayout("normalc");
	
	scarelayout = getContainer("scare").getLayout("normal");
	scarelayout.hide();
	scarelayout.resize(0,0,getMonitorWidth(),getMonitorHeight());
	
	timer30 = mainnormal.findObject("30sec");
	timer60 = mainnormal.findObject("60sec");
	timer90 = mainnormal.findObject("90sec");
	
	scaretimer = new timer;
	
	loadtimer = new timer;
	loadtimer.setdelay(100);
	loadtimer.start();
}

loadtimer.onTimer() {
	stop();
	
	scarelayout.hide();
}

system.onScriptUnloading() {
	delete scaretimer;
	delete loadtimer;
}

string pathToURL(string path) {
	int c, len = strlen(path);
	string ret = "", char;

	
	c=0;
	while (c < len) {
		char = strmid(path,c,1);
		if (char==chr(92)) {
			ret = ret + chr(47);
			c ++;
		} else if (char==":") { //for ":/"
			ret = ret + ":";
			c ++;
			
			char = strmid(path,c,1);
			if (char==chr(92)) {
				ret = ret + chr(47) + chr(47);
				c ++;
			}
		} else {
			ret = ret + char;
			c++;
		}
	}
	
	return ret;
}

timer30.onActivate(int on) {
	if (!on) { scaretimer.stop(); return; }
	
	System.minimizeApplication();
	timer60.setActivatedNoCallback(0);
	timer90.setActivatedNoCallback(0);
	
	scaretimer.setDelay(30000);
	scaretimer.start();
}

timer60.onActivate(int on) {
	if (!on) { scaretimer.stop(); return; }
	
	System.minimizeApplication();
	timer30.setActivatedNoCallback(0);
	timer90.setActivatedNoCallback(0);
	
	scaretimer.setDelay(60000);
	scaretimer.start();
}

timer90.onActivate(int on) {
	if (!on) { scaretimer.stop(); return; }
	
	System.minimizeApplication();
	timer60.setActivatedNoCallback(0);
	timer30.setActivatedNoCallback(0);
	
	scaretimer.setDelay(90000);
	scaretimer.start();
}

scaretimer.onTimer() {
	stop();
	
	timer30.setActivatedNoCallback(0);
	timer60.setActivatedNoCallback(0);
	timer90.setActivatedNoCallback(0);
	
	scarelayout.resize(0,0,getMonitorWidth(),getMonitorHeight());
	scarelayout.show();
	
	playfile(scaremusic);
}

System.onKeyDown(string key) {
	if (!scarelayout.isVisible()) return;

	if (key=="esc") {
		scarelayout.hide();
		stop();
	}
	
}