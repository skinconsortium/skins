//*********************************************
//*********************************************
//*********************************************
//********                             ********
//******  This script was made/modified  ******
//*****  for side-amp, by Michael McBriar *****
//*****   If you use any of this script   *****
//*****       please contact me and       *****
//*****     reference me in your skin.    *****
//******             Thanx.              ******
//********                             ********
//*********************************************
//*********************************************
//*********************************************
//**** Continued by Plague (Linus Brolin) *****
//*********************************************

#include <lib/std.mi>
//#include <lib/core.mi>

Global Button popout, clock, timerb, stopwatch, scare, hour, min, sec, strt, stop;
Global group botdrawer;
Global text mode, digits;
Global timer counttimer, flash, scaretmr;
Global int hr, mn, sc, countdown;
Global Layout scarepic;
//Global core coreTwo;

System.onScriptUnloading() {
//	CoreAdmin.freeCore(CoreTwo);
//	delete CoreTwo;
	delete counttimer;
	delete flash;
	delete scaretmr;
}

System.onScriptLoaded() {
	scarepic = getContainer("scarepic").getLayout("normal");
	botdrawer = getScriptGroup().findobject("player.bot.drawer");
	popout = botdrawer.findObject("botdrawer.popout");
	clock = botdrawer.findObject("botdrawer.clock");
	timerb = botdrawer.findObject("botdrawer.timer");
	stopwatch = botdrawer.findObject("botdrawer.stopwatch");
	scare = botdrawer.findObject("botdrawer.scare");
	hour = botdrawer.findObject("botdrawer.hr");
	min = botdrawer.findObject("botdrawer.min");
	sec = botdrawer.findObject("botdrawer.sec");
	strt = botdrawer.findObject("botdrawer.start");
	stop = botdrawer.findObject("botdrawer.stop");
	mode = botdrawer.findObject("botdrawer.mode");
	digits = botdrawer.findObject("DIGITS");

	counttimer = New Timer;
	counttimer.setDelay(1000);
	counttimer.start();

	flash = New Timer;
	flash.setDelay(200);

	scaretmr = New Timer;
	scaretmr.setDelay(3000);

//	CoreTwo = CoreAdmin.newNamedCore("core2");
//	CoreTwo = New core;
}

popout.onleftbuttonup(int x, int y) {
  if(getprivateint("sideamp","botdrawer.popout",1)) {
	setprivateint("sideamp","botdrawer.popout",0);
	botdrawer.setTargetX(280);
	botdrawer.setTargetSpeed(1.7);
	botdrawer.gotoTarget();
  } else {
	setprivateint("sideamp","botdrawer.popout",1);
	botdrawer.setTargetX(47);
	botdrawer.setTargetSpeed(1.7);
	botdrawer.gotoTarget();
  }
}


// CLOCK
clock.onLeftButtonDown(int x, int y) {
	mode.setText("clock");
	counttimer.start();
	digits.setText(integerToLongTime(getTimeOfDay()));
}


// TIMER
timerb.onLeftButtonDown(int x, int y) {
  if(mode.getText() != "timer") {
	counttimer.stop();
	mode.setText("timer");
	digits.setText("0:00:00");
	hr = 0;
	mn = 0;
	sc = 0;
	countdown = 0;
  }
}
// SCARE
scare.onLeftButtonDown(int x, int y) {
  if(mode.getText() != "scare") {
	counttimer.stop();
	mode.setText("scare");
	digits.setText("0:00:00");
	hr = 0;
	mn = 0;
	sc = 0;
	countdown = 0;
  }
}
hour.onLeftButtonDown(int x, int y) {
 if(!counttimer.isRunning()) { if(!flash.isRunning()) {
  if(mode.getText() == "timer" || mode.getText() == "scare") {
    if(hr >= 356400000) {
	hr = 0;
    } else {
	hr = hr + 3600000;
    }
	countdown = hr + mn + sc;
	digits.setText(integertolongtime(countdown));
  }
 }}
}
min.onLeftButtonDown(int x, int y) {
 if(!counttimer.isRunning()) { if(!flash.isRunning()) {
  if(mode.getText() == "timer" || mode.getText() == "scare") {
    if(mn >= 3540000) {
	mn = 0;
    } else {
	mn = mn + 60000;
    }
	countdown = hr + mn + sc;
	digits.setText(integertolongtime(countdown));
  }
 }}
}
sec.onLeftButtonDown(int x, int y) {
 if(!counttimer.isRunning()) { if(!flash.isRunning()) {
  if(mode.getText() == "timer" || mode.getText() == "scare") {
    if(sc >= 59000) {
	sc = 0;
    } else {
	sc = sc + 1000;
    }
	countdown = hr + mn + sc;
	digits.setText(integertolongtime(countdown));
  }
 }}
}


// STOPWATCH
stopwatch.onLeftButtonDown(int x, int y) {
  if(mode.getText() != "stopwatch") {
	counttimer.stop();
	mode.setText("stopwatch");
	digits.setText("0:00:00");
  }
}


// BLARG
strt.onLeftButtonDown(int x, int y) {
  if(mode.getText() == "timer" || mode.getText() == "scare" || mode.getText() == "stopwatch") {
    if (counttimer.isRunning()) {
	counttimer.stop();
	flash.start();
    } else {
	counttimer.stop();
	counttimer.start();
	digits.show();
	flash.stop();
    }
  }
}
stop.onLeftButtonDown(int x, int y) {
 if(!flash.isRunning()) {
	counttimer.stop();
	countdown = hr + mn + sc;
	digits.setText(integertolongtime(countdown));
 }
}

counttimer.ontimer() {
  if(mode.getText() == "clock") {
	digits.setText(integerToLongTime(getTimeOfDay()));
  } else if(mode.getText() == "timer") {
	countdown = countdown - 1000;
	digits.setText(integerToLongTime(countdown));
	if(countdown == 0){
	  playFile("skins/" + getSkinName() + "/bleep14.mp3");
	  counttimer.stop();
	  hr = 0;
	  mn = 0;
	  sc = 0;
	}
  } else if(mode.getText() == "stopwatch") {
	countdown = countdown + 1000;
	digits.setText(integerToLongTime(countdown));
  } else if(mode.getText() == "scare") {
	countdown = countdown - 1000;
	digits.setText(integerToLongTime(countdown));
	if(countdown == 0){
	  playFile("skins/" + getSkinName() + "/scream9.wav");
	  scarepic.resize((getViewportWidth()/2)-(scarepic.getWidth()/2), (getViewportHeight()/2)-(scarepic.getHeight()/2), scarepic.getWidth(), scarepic.getHeight());
	  scarepic.show();
	  scaretmr.start();
	  counttimer.stop();
	  hr = 0;
	  mn = 0;
	  sc = 0;
	}
  } else {
	counttimer.stop();
	digits.setText("0:00:00");
  }
}

flash.ontimer() {
  if(digits.isVisible()) {
	digits.hide();
  } else {
	digits.show();
  }
}

scaretmr.ontimer() {
  scarepic.hide();
  scaretmr.stop();
}
