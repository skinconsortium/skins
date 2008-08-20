#include <lib/std.mi>

#define SENSITIVITY 1.4

Global Group myGroup;
Global Layer myLayer, myLayer2;
Global Timer myTimer;
Global int myInt;

System.onScriptLoaded (){
	myGroup = getScriptGroup();
	myLayer = myGroup.findObject("beatvis");
	myLayer2 = myGroup.findObject("beatvis2");
	
	myTimer = new Timer;
	myTimer.setDelay(10);
}

System.onscriptunloading(){
	delete myTimer;
}


myTimer.onTimer(){
	myInt = (System.getLeftVuMeter() * SENSITIVITY + System.getRightVuMeter() * SENSITIVITY)/2;
	if (myInt > 255) myInt = 255;
	
	myLayer.setAlpha(myInt);

	myInt *= 1.3;
	if (myInt > 255) myInt = 255;
	myLayer2.setAlpha(myInt);
}

System.onStop(){
	myTimer.stop();
	myLayer.setAlpha(0);
	myLayer2.setAlpha(255);
}

System.onPlay(){
	if(myGroup.isVisible()){
		myTimer.start();
	}
}
System.onPause(){
	if(myGroup.isVisible()){
		myTimer.stop();
	}
}

System.onResume(){
	if(myGroup.isVisible()){
		myTimer.start();
	}
}

myGroup.onSetVisible(Boolean onoff){
	if(onoff == STATUS_PLAYING){
		myTimer.start();
	}
	else{
		myTimer.stop();
	}
}