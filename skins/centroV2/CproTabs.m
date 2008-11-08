#include <lib/std.mi>

Class Group CProTabButton;

Global Group myGroup, tg, workWithTab;
Global CProTabButton tab123;
Global GuiObject moveIcon;

System.onScriptLoaded() {
	myGroup = getScriptGroup();
	tg = myGroup.findObject("cprotabs.buttons");
	moveIcon = myGroup.findObject("moveicon");

	int createNtabs = 5;
	
	//how to create them
	for(int i=0;i<createNtabs;i++){
		tab123 = System.newGroup("cpro.tab");
		tab123.setXmlParam("tab_id", integerToString(i));
		tab123.setXmlParam("tabtext", "MyTab"+integerToString(i));
		tab123.init(tg);
		tab123.show();
	}
	
	
	//how to work with them
	for(int i=1;i<createNtabs;i++){
		tg.enumObject(i).setXmlParam("x", integerToString(tg.enumObject(i-1).getGuiX() + tg.enumObject(i-1).getWidth()));
	}

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