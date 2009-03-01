/*************************************************************

  pagescroll.m
  
  -script to control the page scrolling
  

*************************************************************/

#include <lib/std.mi>

global group scriptGroup;
global button buttonSwitchToCover, buttonSwitchToList;
global group covershow, plplus;

global group currGroup, nextGroup;

System.onScriptLoaded() {
	scriptGroup = getScriptGroup();
	
	buttonSwitchToList = scriptGroup.findObject("SwitchToList.button");
	buttonSwitchToCover = scriptGroup.findObject("SwitchToCover.button");

	covershow = scriptGroup.getObject("player.main.pl.coverflow");
	plplus = scriptGroup.getObject("player.main.pl.list");
	
	if (getPrivateInt(getSkinName(), "CoverShow", 1) == 0) {
		plplus.show();
		covershow.hide();
	}
}

System.onScriptUnloading() {
	
}

buttonSwitchToList.onLeftClick() {
	plplus.show();
	covershow.hide();
	
	setPrivateInt(getSkinName(), "CoverShow", 0);
}

buttonSwitchToCover.onLeftClick() {
	plplus.hide();
	covershow.show();
	
	setPrivateInt(getSkinName(), "CoverShow", 1);
}