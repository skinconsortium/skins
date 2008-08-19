#include <lib/std.mi>

Global Group myGroup;
Global Layer myLayer;
Global Timer myTimer;
Global int aniStep;

System.onScriptLoaded() {
	myGroup = getScriptGroup();
	myLayer = myGroup.getObject("startani.fg");
	
	myTimer = new Timer;
}
System.onScriptUnLoading(){
	delete myTimer;
}

myLayer.onSetVisible(boolean onOff){
	if(onOff){
		aniStep=1;
		myTimer.setDelay(333);
		myTimer.start();
	}
	else{
		myLayer.setXmlParam("w", "0");
	}
}

myTimer.onTimer(){
	if(aniStep==1){
		myLayer.setXmlParam("w", "14");
	}
	else if(aniStep==2){
		myLayer.setXmlParam("w", "35");
	}
	else if(aniStep==3){
		myLayer.setXmlParam("w", "54");
	}
	else if(aniStep==4){
		myLayer.setXmlParam("w", "71");
	}
	else if(aniStep==5){
		myLayer.setXmlParam("w", "88");
	}
	else if(aniStep==6){
		myLayer.setXmlParam("w", "106");
	}
	else if(aniStep==7){
		myLayer.setXmlParam("w", "125");
	}
	else if(aniStep==8){
		myLayer.setXmlParam("w", "141");
	}
	else if(aniStep==9){
		myLayer.setXmlParam("w", "158");
	}
	else if(aniStep==10){
		myLayer.setXmlParam("w", "175");
	}
	else if(aniStep==11){
		myLayer.setXmlParam("w", "199");
	}
	else if(aniStep==12){
		myLayer.setTargetA(0);
		myLayer.setTargetSpeed(0.5);
		myLayer.gotoTarget();
		myTimer.setDelay(550);
	}
	else if(aniStep==13){
		myLayer.setTargetA(255);
		myLayer.setTargetSpeed(0.5);
		myLayer.gotoTarget();
	}
	else{
		myTimer.stop();
	}
	aniStep++;
}