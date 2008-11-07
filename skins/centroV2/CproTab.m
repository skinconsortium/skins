#include <lib/std.mi>

Global Group myGroup, tab123;

System.onScriptLoaded() {
	myGroup = getScriptGroup();
	
	tab123 = System.newGroup("cpro.tab");
	tab123.setXmlParam("y", "50");
	tab123.setXmlParam("tabtext", "VideoHaha");
	tab123.init(myGroup);
}