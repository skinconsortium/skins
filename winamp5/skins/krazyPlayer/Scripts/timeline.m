#include <lib/std.mi>

Global Group frameGroup;

Global AnimatedLayer t01, t02, t03, t04, t05, t06, t07, t08, t09, t10, t11, t12, t13, t14, t15, t16, t17, t18, t19, t20, t21, t22, t23, t24, t25;
Global Timer myTimer;
Global int fadeout;
Global boolean goingToStop; 

System.onScriptLoaded (){

	frameGroup = getScriptGroup ();
  
	t01 = frameGroup.findObject("timeline.vis.1");
	t02 = frameGroup.findObject("timeline.vis.2");
	t03 = frameGroup.findObject("timeline.vis.3");
	t04 = frameGroup.findObject("timeline.vis.4");
	t05 = frameGroup.findObject("timeline.vis.5");
	t06 = frameGroup.findObject("timeline.vis.6");
	t07 = frameGroup.findObject("timeline.vis.7");
	t08 = frameGroup.findObject("timeline.vis.8");
	t09 = frameGroup.findObject("timeline.vis.9");
	t10 = frameGroup.findObject("timeline.vis.10");
	t11 = frameGroup.findObject("timeline.vis.11");
	t12 = frameGroup.findObject("timeline.vis.12");
	t13 = frameGroup.findObject("timeline.vis.13");
	t14 = frameGroup.findObject("timeline.vis.14");
	t15 = frameGroup.findObject("timeline.vis.15");
	t16 = frameGroup.findObject("timeline.vis.16");
	t17 = frameGroup.findObject("timeline.vis.17");
	t18 = frameGroup.findObject("timeline.vis.18");
	t19 = frameGroup.findObject("timeline.vis.19");
	t20 = frameGroup.findObject("timeline.vis.20");
 	t21 = frameGroup.findObject("timeline.vis.21");
	t22 = frameGroup.findObject("timeline.vis.22");
	t23 = frameGroup.findObject("timeline.vis.23");
	t24 = frameGroup.findObject("timeline.vis.24");
	t25 = frameGroup.findObject("timeline.vis.25");
 
	myTimer = new Timer;
	myTimer.setDelay(30);
}

System.onscriptunloading(){
	delete myTimer;
}

myTimer.onTimer(){
	
	t25.gotoFrame(t24.getCurFrame());
	t24.gotoFrame(t23.getCurFrame());
	t23.gotoFrame(t22.getCurFrame());
	t22.gotoFrame(t21.getCurFrame());
	t21.gotoFrame(t20.getCurFrame());
	t20.gotoFrame(t19.getCurFrame());
	t19.gotoFrame(t18.getCurFrame());
	t18.gotoFrame(t17.getCurFrame());
	t17.gotoFrame(t16.getCurFrame());
	t16.gotoFrame(t15.getCurFrame());
	t15.gotoFrame(t14.getCurFrame());
	t14.gotoFrame(t13.getCurFrame());
	t13.gotoFrame(t12.getCurFrame());
	t12.gotoFrame(t11.getCurFrame());
	t11.gotoFrame(t10.getCurFrame());
	t10.gotoFrame(t09.getCurFrame());
	t09.gotoFrame(t08.getCurFrame());
	t08.gotoFrame(t07.getCurFrame());
	t07.gotoFrame(t06.getCurFrame());
	t06.gotoFrame(t05.getCurFrame());
	t05.gotoFrame(t04.getCurFrame());
	t04.gotoFrame(t03.getCurFrame());
	t03.gotoFrame(t02.getCurFrame());
	t02.gotoFrame(t01.getCurFrame());
	t01.gotoFrame((getLeftVuMeter()+getRightVuMeter())*51/510);
	
	if(goingToStop){
		if(fadeout>25){
			myTimer.stop();
			goingToStop = false;
		}
		fadeout++;
	}
}

System.onStop(){
	goingToStop = true;
	fadeout = 0;
}

System.onPlay(){
	if(frameGroup.isVisible()){
		myTimer.start();
	}
}
System.onPause(){
	myTimer.stop();
}

System.onResume(){
	if(frameGroup.isVisible()){
		myTimer.start();
	}
}

frameGroup.onSetVisible(Boolean onoff){
	if(onoff && System.getStatus() == STATUS_PLAYING)
	{
		myTimer.start();
		goingToStop=false;	//remeber this little sob ;P
	}
	else{
		myTimer.stop();
	}
}