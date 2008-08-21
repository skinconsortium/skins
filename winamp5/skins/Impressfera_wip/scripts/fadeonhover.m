#include <lib/std.mi>

Global Group mainGroup;
Global GuiObject light, seeker;

System.onScriptLoaded() {
	mainGroup = getScriptGroup();
	light = mainGroup.findObject(getToken(getParam(), ";", 0));
	seeker = mainGroup.findObject(getToken(getParam(), ";", 1));
}

seeker.onEnterArea(){
	light.cancelTarget();
	light.setTargetA(stringToInteger(getToken(getParam(), ";", 2)));
	light.setTargetSpeed(0.2);
	light.gotoTarget();
}
seeker.onLeaveArea(){
	light.cancelTarget();
	light.setTargetA(0);
	light.setTargetSpeed(0.6);
	light.gotoTarget();
}