#include <lib/std.mi>

Function String getMyPath();

Global Group myGroup;
Global Button myButton;
Global ToggleButton myTogButton;
Global Layer myLayer;
Global Boolean isOver, isBut; //, isInv;
Global String myString;

System.onScriptLoaded() {
	myGroup = getScriptGroup();
	myButton = myGroup.getObject(getToken(getParam(),";",0));
	myTogButton = myGroup.getObject(getToken(getParam(),";",0));
	myLayer = myGroup.getObject(getToken(getParam(),";",1));
	
	
	if(myTogButton==null) isBut = true;
	
	if(!isBut){
		myString = getToken(getParam(),";",2);

		//if(myTogButton.getXmlParam("nstates")=="3") isInv = true;
		myTogButton.onToggle(true);
	}
}

myButton.onLeftButtonDown(int x, int y){
	myLayer.cancelTarget();
	myLayer.setAlpha(0);
}
myButton.onLeftButtonUp(int x, int y){
	myLayer.cancelTarget();
	if(myButton.isMouseOverRect()) myLayer.setAlpha(255);
	//debugint(myButton.isMouseOverRect());
}


myButton.onEnterArea(){
	if(!myButton.isVisible()) return;
	//isOver = true;
	myLayer.setTargetA(255);
	myLayer.setTargetSpeed(0.2);
	myLayer.gotoTarget();
	
}
myButton.onLeaveArea(){
	if(!myButton.isVisible()) return;
	myLayer.cancelTarget();
	myLayer.setTargetA(0);
	myLayer.setTargetSpeed(0.6);
	myLayer.gotoTarget();
}

myButton.onSetVisible(boolean onOff){
	//if(onOff && myButton.isMouseOver(0, 0)){
	if(onOff && myButton.isMouseOverRect()){
		myLayer.cancelTarget();
		myLayer.setAlpha(255);
	}
	else{
		myLayer.cancelTarget();
		myLayer.setAlpha(0);
	}
	
}

myTogButton.onToggle(Boolean onoff){
	if(isBut) return;

	int i = myTogButton.getCurCfgVal();
	if(i<0) i=1-i;
	
	//debugint(i);
	
	myLayer.setXmlParam("image", myString+integerToString(i));
}