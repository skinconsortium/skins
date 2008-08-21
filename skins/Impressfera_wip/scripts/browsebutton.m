/*	----------------------------------
	Browser Url Button script
	by pjn123 (www.skinconsortium.com)
	----------------------------------
*/

#include <lib/std.mi>

Global Group myGroup;
Global GuiObject browserxui, myButton;
Global Layout myLayout;

System.onScriptLoaded() {
	myGroup = getScriptGroup();
	myButton = myGroup.getObject(getToken(getParam(), ";", 0));
	
	myLayout = getContainer("winampbrowser").getLayout("normal");
	browserxui = myLayout.findObject("browser.winamp.xui");
}

myButton.onLeftButtonUp(int x, int y){
	myLayout.show();
	browserxui.sendAction ("openurl", getToken(getParam(), ";", 1), 0, 0, 0, 0);
}