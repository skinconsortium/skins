/*************************************************************

  pagescroll.m
  
  -script to control the page scrolling
  

*************************************************************/

#include <lib/std.mi>

global layout scriptGroup;
global button buttonScrollLeft, buttonScrollRight;
global string pageList;
global int currPage, maxPage;

global group currGroup, nextGroup;

System.onScriptLoaded() {
	scriptGroup = getScriptGroup();
	
	buttonScrollLeft = scriptGroup.findObject("player.button.page.left");
	buttonScrollRight = scriptGroup.findObject("player.button.page.right");
	
	pageList = getParam();
	currPage = 0;
	
	string p="";
	maxPage = 0;
	do {
		p = getToken(pageList, ",", maxPage);
		if (p!="") maxPage++;		
	} while (p!="");
	maxPage--;
}

System.onScriptUnloading() {
	
}

buttonScrollLeft.onLeftClick() {
	nextGroup = NULL;
	currGroup = scriptGroup.getObject(getToken(pageList, ",", currPage));
	currPage--;
	if (currPage < 0) currPage = maxPage;
	
	string nextGroupID = getToken(pageList, ",", currPage);
	
	nextGroup = scriptGroup.getObject(nextGroupID);
	if (!nextGroup) return;
	
	nextGroup.setXMLParam("x","-100");
	nextGroup.show();
	
	currGroup.setTargetX(100);
	currGroup.setTargetSpeed(1);
	nextGroup.setTargetX(0);
	nextGroup.setTargetSpeed(1);
	
	currGroup.gotoTarget();
	nextGroup.gotoTarget();
}

buttonScrollRight.onLeftClick() {
	nextGroup = NULL;
	currGroup = scriptGroup.getObject(getToken(pageList, ",", currPage));
	currPage++;
	string nextGroupID = getToken(pageList, ",", currPage);
	
	if (nextGroupID == "") {
		currPage = 0;
		nextGroupID = getToken(pageList, ",", currPage);
	}
	nextGroup = scriptGroup.getObject(nextGroupID);
	if (!nextGroup) return;
	
	nextGroup.setXMLParam("x","100");
	nextGroup.show();
	
	currGroup.setTargetX(-100);
	currGroup.setTargetSpeed(1);
	nextGroup.setTargetX(0);
	nextGroup.setTargetSpeed(1);
	
	currGroup.gotoTarget();
	nextGroup.gotoTarget();
}

currGroup.onTargetReached() {
	currGroup.hide();
}

