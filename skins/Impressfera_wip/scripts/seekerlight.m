#include <lib/std.mi>

Global Group mainGroup;
Global Layer light, seeker;

System.onScriptLoaded() {
	mainGroup = getScriptGroup();
	light = mainGroup.findObject("seeker.light");
	seeker = mainGroup.findObject("seeker.bg.1");
}

seeker.onEnterArea(){
	light.cancelTarget();
	light.setTargetA(30);
	light.setTargetSpeed(0.3);
	light.gotoTarget();
}
seeker.onLeaveArea(){
	light.cancelTarget();
	light.setTargetA(0);
	light.setTargetSpeed(0.6);
	light.gotoTarget();
}