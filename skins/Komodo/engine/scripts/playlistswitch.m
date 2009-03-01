/*************************************************************

  playlistswitch.m
  
  -script to create the playlistswitch buttons.
  

*************************************************************/

#include <lib/std.mi>
#include <lib/pldir.mi>

global layout main;
global group scriptGroup;

System.onScriptLoaded() {
	main = getContainer("main").getLayout("normal");
	scriptGroup = getScriptGroup();
	
	scriptGroup.onResize(0,0, scriptGroup.getWidth(), scriptGroup.getHeight());
}

scriptGroup.onSetVisible(int on) {
	if (on) scriptGroup.onResize(0,0, scriptGroup.getWidth(), scriptGroup.getHeight());
}

scriptGroup.onResize(int x, int y, int w, int h) {
	if (!isVisible()) return;
	
	int numPL= PlDir.getNumItems();
	int maxButtons = w / 100;
	int numButtons;
	group t;
	
	if (numPL < maxButtons) 
		numButtons = numPL;
	else
		numButtons = maxButtons;
	
	int offx = (w - numButtons*100 - 5)/2;
	//main.sendAction("INDTEXT", "test"+integerToString(offx), 0,0,0,0);
				
	int c = 0;

	for (c=0; c<=maxButtons; c++) {
		t = NULL;
		t = getObject("mlplaylist."+integerTostring(c));
		if (!t) {

			if (c < numPL) {
				t = newGroup("xui.custom.button");
				
				t.setXMLParam("id","mlplaylist."+integerTostring(c));

				t.setXMLParam("y","0");
				t.setXMLParam("action","PLAYPL");
				t.setXMLParam("action_target",scriptGroup.getID());
				t.setXMLParam("param",integerTostring(c));

				t.init(scriptGroup);
			}
		}
		if (t) {
			if (c >= numPL || c == maxButtons) 
				t.hide();
			else {
				t.show();
				t.setXMLParam("x",integerToString(offx+c*100));
				t.setXMLParam("label",PlDir.getItemName(c));
			}
		}
	}
}

scriptGroup.onAction(String action, String param, Int x, int y, int clicked, int lines, GuiObject source) {
	action = strupper(action);
	
	if (action == "PLAYPL") {
		PlDir.playItem(stringToInteger(param));
		return 1;
	}
	return 0;
}
