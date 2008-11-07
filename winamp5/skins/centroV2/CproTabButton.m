#include <lib/std.mi>

Function buttonState(int mode);  //1=activated , 2=normal , 3=hover

Global Group myGroup;
Global ToggleButton myButton;
Global Text myText;
Global GuiObject myGrid;
Global int downX;
Global boolean tabMouseDown, wasActive;

System.onScriptLoaded() {
	myGroup = getScriptGroup();
	myButton = myGroup.findObject("cpro.tab.button");
	myGrid = myGroup.findObject("cpro.tab.grid");
	myText = myGroup.findObject("cpro.tab.text");
}

System.onSetXuiParam(String param, String value) {
	if(strlower(param) == "tabtext"){
		myText.setText(value);
		myGroup.setXmlParam("w", integerToString(myText.getAutoWidth()+14));
	}
}


buttonState(int mode){
	myGrid.setXmlParam("topleft", "wasabi.tabsheet.button.left."+integerToString(mode));
	myGrid.setXmlParam("top", "wasabi.tabsheet.button.center."+integerToString(mode));
	myGrid.setXmlParam("topright", "wasabi.tabsheet.button.right."+integerToString(mode));

	if(mode==1){
		myText.setXmlParam("y", "6");
		myText.setXmlParam("color", "Tab.Text.On");
	}
	else if(mode==2){
		myText.setXmlParam("y", "7");
		myText.setXmlParam("color", "Tab.Text.Off");
	}
	else{
		myText.setXmlParam("y", "7");
		myText.setXmlParam("color", "Tab.Text.Hover");
	}
}

myButton.onActivate(boolean onOff){
	if(onOff){
		buttonState(1);
	}
	else{
		buttonState(2);
	}
}
myButton.onLeftClick(){
	int x = System.getMousePosX();
	if(downX < x+4 && downX > x-4) myButton.setActivated(true);
	else{
		myButton.setActivated(wasActive);
		debug(integertostring(downX) + " "+integertostring(System.getMousePosX()));
	}
}

/*testing*/
myButton.onRightClick(){
	myButton.setActivated(false);
}
/*testing*/

myButton.onEnterArea(){
	if(!myButton.getActivated()) buttonState(3);
}
myButton.onLeaveArea(){
	if(!myButton.getActivated()) buttonState(2);
}

myButton.onLeftButtonDown(int x, int y){
	tabMouseDown=true;
	wasActive=myButton.getActivated();
	downX=System.getMousePosX();
}
myButton.onLeftButtonUp(int x, int y){
	if(tabMouseDown){
		tabMouseDown=false;
	}
}