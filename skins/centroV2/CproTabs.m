#include <lib/std.mi>

Class Group CProTabButton;

Function refresh_X();
Function refresh_W();
Function int getTabsW();
Function setMaxTabW(); //

Global Group myGroup, tg, workWithTab;
Global CProTabButton tab123;
Global GuiObject moveIcon;
Global int createNtabs, maxW;
Global boolean maxW_Set, allTabsMaxView; //set this disabled when you add a new tab

System.onScriptLoaded() {
	myGroup = getScriptGroup();
	tg = myGroup.findObject("cprotabs.buttons");
	moveIcon = myGroup.findObject("moveicon");

	createNtabs = 5;
	maxW_Set=false;
	allTabsMaxView=false;

	//how to create them
	for(int i=0;i<createNtabs;i++){
		tab123 = System.newGroup("cpro.tab");
		tab123.setXmlParam("tab_id", integerToString(i));
		tab123.setXmlParam("tabtext", "MyTab"+integerToString(i));
		tab123.init(tg);
		tab123.show();
	}
	
	
	//how to work with them
	/*for(int i=1;i<createNtabs;i++){
		tg.enumObject(i).setXmlParam("x", integerToString(tg.enumObject(i-1).getGuiX() + tg.enumObject(i-1).getWidth()));
	}*/
	refresh_X();

}

CProTabButton.onresize(int x, int y, int w, int h){
	//debug("xyz");
}


tg.onAction(String action, String param, int x, int y, int p1, int p2, GuiObject source){
	if(strlower(action) == "move_tab"){
		//debug("This tab wants to move: " + integerToString(x));
		moveIcon.show();
	}
	else if(strlower(action) == "move_tab_now"){
		moveIcon.hide();
		//debug("This tab wants to move to position of the indicator now: " + integerToString(x));
	}
}

refresh_X(){
	for(int i=1;i<createNtabs;i++){
		tg.enumObject(i).setXmlParam("x", integerToString(tg.enumObject(i-1).getGuiX() + tg.enumObject(i-1).getWidth()));
	}

}

refresh_W(){
	int w = tg.getWidth();
	
	if(maxW_Set && maxW<w && allTabsMaxView) return;	// Dont do calculations if theres enough space

	for(int i=0;i<createNtabs;i++){
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
		for(int b=createNtabs-1; b>=0; b--){
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



int getTabsW(){
	int w = 0;
	for(int i=0;i<createNtabs;i++){
		w += tg.enumObject(i).getWidth();
	}
	return w;
}

tg.onResize(int x, int y, int w, int h){
	refresh_W();
}