#include <lib/std.mi>

Class Group CProTabButton;

Global Group myGroup, workWithTab;
Global CProTabButton tab123;

System.onScriptLoaded() {
	myGroup = getScriptGroup();

	int createNtabs = 5;
	
	//how to create them
	for(int i=0;i<createNtabs;i++){
		tab123 = System.newGroup("cpro.tab");
		tab123.setXmlParam("tabtext", "MyTab"+integerToString(i));
		tab123.init(myGroup);
		tab123.show();
	}
	
	
	//how to work with them
	for(int i=1;i<createNtabs;i++){
		myGroup.enumObject(i).setXmlParam("x", integerToString(myGroup.enumObject(i-1).getGuiX() + myGroup.enumObject(i-1).getWidth()));
	}

}

CProTabButton.onresize(int x, int y, int w, int h){
	//debug("xyz");
}