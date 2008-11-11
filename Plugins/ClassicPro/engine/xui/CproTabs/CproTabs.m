#include <lib/std.mi>

#define INTERNALTABNAMES "Media Library;Playlist;Video;Visualization;Browser;@ALL@"

Class Group CProTabGroup;
Class Button CProTabButton;

Function refresh_X();
Function refresh_W();
Function int getTabsW();
Function setMaxTabW(); //
Function int tabID_to_groupNo(int tabId);
Function int getTabX(int tabNo);

Global Group myGroup, tg, workWithTab;
Global CProTabGroup tab123;
Global CProTabButton but123;
Global GuiObject moveIcon, CproSUI;
Global int numOfTabs, maxW, activeTab, downX;
Global boolean maxW_Set, allTabsMaxView, tabMouseDown, tabMoveSend; //set this disabled when you add a new tab
Global String widgetTabNames, tabOrder;

Global Button test;

System.onScriptLoaded() {
	myGroup = getScriptGroup();
	tg = myGroup.findObject("cprotabs.buttons");
	moveIcon = myGroup.findObject("moveicon");
	CproSUI = myGroup.getParent().getParent().getParent().getParent();

	maxW_Set=false;
	allTabsMaxView=false;
	activeTab = -1;


	numOfTabs = 6+2; //5internal + 2widgets // @martin: add the number of widgets found here (replace the +2 ;)
	widgetTabNames = "CoverFlow;BrowserPro"; // @martin: read the names in here

	tabOrder = "0;1;2;3;4;5;100;101";	//read this in via publicString later
	/*
	ToDo - Check to see if there changes in no of widgets...
	Then fix the "tabOrder"
	*/

	//how to create them
	for(int i=0;i<numOfTabs;i++){
		int tabId = stringToInteger(getToken(tabOrder,";", i));
		String output_TabName = "error";
		
		tab123 = System.newGroup("cpro.tab");
			
		tab123.setXmlParam("tab_id", integerToString(tabId));
		
		if(tabId<6){ //InternalTabs
			output_TabName = getToken(INTERNALTABNAMES,";", tabId);
		}
		else if(tabId>=100){
			output_TabName = getToken(widgetTabNames,";", tabId-100);
		}
		
		tab123.setXmlParam("tabtext", output_TabName);
		tab123.init(tg);
		tab123.show();
		
		but123 = tg.enumObject(i).findObject("cpro.tab.button");
		//but123.setXmlParam("text","x");
	}
	
	
	//how to work with them
	/*for(int i=1;i<numOfTabs;i++){
		tg.enumObject(i).setXmlParam("x", integerToString(tg.enumObject(i-1).getGuiX() + tg.enumObject(i-1).getWidth()));
	}*/
	refresh_X();

}

CProTabGroup.onresize(int x, int y, int w, int h){
	//debug("xyz");
}

CProTabButton.onLeftButtonDown(int x, int y){
	downX=x;
	tabMouseDown=true;
	tabMoveSend=false;
}
CProTabButton.onLeftButtonUp(int x, int y){
	if(tabMouseDown){
		tabMouseDown=false;
		if(tabMoveSend){
			moveIcon.hide();
			//myParent.sendAction("move_tab_now", "", tab_id, 0, 0, 0);
		}
	}
}
CProTabButton.onMouseMove(int x, int y){
	if(tabMouseDown){
		//int x = System.getMousePosX();
		if((downX  >= x+4 || downX <= x-4) && !tabMoveSend){
			tabMoveSend=true;
			moveIcon.show();
		}
		
		if(tabMoveSend){
			moveIcon.setXmlParam("x",integerToString(x));
		}
	}

}

tg.onAction(String action, String param, int x, int y, int p1, int p2, GuiObject source){
	if(strlower(action) == "open_tab"){
		/*for(int i=1;i<numOfTabs;i++){
			//tg.enumObject(i).setXmlParam("x", integerToString(tg.enumObject(i-1).getGuiX() + tg.enumObject(i-1).getWidth()));
		}*/
		if(activeTab>-1 && activeTab!=x) tg.enumObject(tabID_to_groupNo(activeTab)).setXmlParam("activate", "0");
		activeTab = x;
		//*** pass action on to sui engine here!!!!!
		CproSUI.sendAction ("show_tab", "", x, 0, 0, 0);
	}
	else if(strlower(action) == "move_tab"){
		//debug("This tab wants to move: " + integerToString(x));
		moveIcon.show();
		//test = tg.enumObject(tabID_to_groupNo(activeTab)).findObject("cpro.tab.button");
	}
	else if(strlower(action) == "move_tab_now"){
		moveIcon.hide();
		//debug("This tab wants to move to position of the indicator now: " + integerToString(x));
	}
}

myGroup.onAction(String action, String param, int x, int y, int p1, int p2, GuiObject source){
	if(strlower(action) == "select_tab"){
		if(activeTab!=x){
			if(activeTab>-1) tg.enumObject(tabID_to_groupNo(activeTab)).setXmlParam("activate", "0");
			tg.enumObject(tabID_to_groupNo(x)).setXmlParam("activate", "1");
		}
		activeTab = x;
	}
}


refresh_X(){
	for(int i=1;i<numOfTabs;i++){
		tg.enumObject(i).setXmlParam("x", integerToString(tg.enumObject(i-1).getGuiX() + tg.enumObject(i-1).getWidth()));
	}

}

refresh_W(){
	int w = tg.getWidth();
	
	if(maxW_Set && maxW<w && allTabsMaxView) return;	// Dont do calculations if theres enough space

	for(int i=0;i<numOfTabs;i++){
		tg.enumObject(i).setXmlParam("viewmode", "0");
		allTabsMaxView=true;
	}
	
	/*
	Set the maxW of the tabs so that we dont do all these calculations when there is enough space 
	We know the max space now because the above for loop changed all the tabs to their longest view mode
	*/
	if(!maxW_Set){
		maxW = getTabsW();
		maxW_Set=true;
	}
	
	boolean width_Okay = false;
	
	for(int a=1; a<3; a++){
		for(int b=numOfTabs-1; b>=0; b--){
			if(getTabsW()>w){
				tg.enumObject(b).setXmlParam("viewmode", integerToString(a));
				allTabsMaxView=false;
			}
			else{
				width_Okay = true;
				break;
			}
		}
		if(width_Okay) break;
	}
	refresh_X();
}
tg.onResize(int x, int y, int w, int h){
	refresh_W();
}

int getTabsW(){
	int w = 0;
	for(int i=0;i<numOfTabs;i++){
		w += tg.enumObject(i).getWidth();
	}
	return w;
}

int tabID_to_groupNo(int tabId){
	String searchFor = integerToString(tabId);
	
	for(int i=0;i<numOfTabs;i++){
		if(getToken(tabOrder,";", i)==searchFor) return i;
		
	}
	debug("Error: 101");
	return 999; //should not happen!
}

getTabX(int tabNo){
}