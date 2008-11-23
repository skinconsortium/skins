/*************************************************************

  hoverglow.m
  by Leechbite

  all-purpose script for glow effect on hover.
  
  takes two parameters: (eq. param="obj1,obj2");
  obj1 = id of trigger object;
  obj2 = id of glow object;
  

*************************************************************/

#include <lib/std.mi>

Global guiObject triggerObject, glowObject;

System.onScriptLoaded() {
	group scriptGroup = getScriptGroup();
	string param = getParam();

	triggerObject = scriptGroup.getObject(getToken(param,",",0));
	glowObject = scriptGroup.getObject(getToken(param,",",1));

	if (glowObject) { 
		glowObject.setAlpha(0);
		glowObject.setTargetSpeed(0.5);
	}
}

System.onScriptUnloading() {
  return;
}

triggerObject.onEnterArea() {
	if (glowObject) { 
		glowObject.cancelTarget();
		glowObject.setAlpha(255);
	}
}

triggerObject.onLeaveArea() {
	if (glowObject) { 
		glowObject.cancelTarget();
		glowObject.setTargetA(0);
		glowObject.gotoTarget();
	}
}



