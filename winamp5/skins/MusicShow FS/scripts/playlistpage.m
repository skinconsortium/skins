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
}

System.onScriptUnloading() {
	
}

buttonSwitchToList.onLeftClick() {
	plplus.show();
	covershow.hide();
}

buttonSwitchToCover.onLeftClick() {
	plplus.hide();
	covershow.show();
}