//*** scare scripts ***

#include <lib/std.mi>

global layout mainnormal;
global button timer30,timer60,timer90;

global timer scaretimer;

System.onScriptLoaded() {
	mainnormal = getContainer("main").getLayout("normalc");
	
	timer30 = mainnormal.findObject("30sec");
	timer60 = mainnormal.findObject("60sec");
	timer90 = mainnormal.findObject("90sec");
	
	scaretimer = new timer;
}

system.onScriptUnloading() {
	delete scaretimer;
}

timer30.onActivate(int on) {
	if (!on) { scaretimer.stop(); return; }
	
	timer60.setActivatedNoCallback(0);
	timer90.setActivatedNoCallback(0);
	
	scaretimer.setDelay(30000);
	scaretimer.start();
}

timer60.onActivate(int on) {
	if (!on) { scaretimer.stop(); return; }
	
	timer30.setActivatedNoCallback(0);
	timer90.setActivatedNoCallback(0);
	
	scaretimer.setDelay(60000);
	scaretimer.start();
}

timer90.onActivate(int on) {
	if (!on) { scaretimer.stop(); return; }
	
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
	
	System.minimizeApplication();

}
