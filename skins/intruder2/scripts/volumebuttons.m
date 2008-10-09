#include <lib/std.mi>

Global Group myGroup;
Global Button volDown, volUp;
Global Timer myTimer;
Global Boolean mouseDown0, mouseDown100;
Global int timerDelay, volOutput;

System.onScriptLoaded() {
	myGroup = getScriptGroup();
	volDown = myGroup.getObject("vol.less");
	volUp = myGroup.getObject("vol.more");
	
	myTimer = new Timer;
}
System.onScriptUnLoading(){
	delete myTimer;
}

myTimer.onTimer(){
	timerDelay*=0.94;
	if(timerDelay<33) timerDelay=33;
	myTimer.setDelay(timerDelay);

	if(mouseDown0){
		volOutput = System.getVolume();
		volOutput-=5;
		if(volOutput<0) volOutput=0;
		System.setVolume(volOutput);
	}
	else if(mouseDown100){
		volOutput = System.getVolume();
		volOutput+=5;
		if(volOutput>255) volOutput=255;
		System.setVolume(volOutput);
	}
	else{
		myTimer.stop();
	}
}

volDown.onLeftButtonDown(int x, int y){
	volOutput = System.getVolume();
	volOutput-=5;
	if(volOutput<0) volOutput=0;
	System.setVolume(volOutput);

	mouseDown0=true;
	timerDelay = 200;
	myTimer.setDelay(timerDelay);
	myTimer.start();
}
volDown.onLeftButtonUp(int x, int y){
	mouseDown0=false;
	myTimer.stop();
}

volUp.onLeftButtonDown(int x, int y){
	volOutput = System.getVolume();
	volOutput+=5;
	if(volOutput>255) volOutput=255;
	System.setVolume(volOutput);

	mouseDown100=true;
	timerDelay = 200;
	myTimer.setDelay(timerDelay);
	myTimer.start();
}
volUp.onLeftButtonUp(int x, int y){
	mouseDown100=false;
	myTimer.stop();
}