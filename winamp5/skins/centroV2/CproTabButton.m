#include <lib/std.mi>

Function buttonState(int mode);  //1=activated , 2=normal , 3=hover

Global Group myGroup, myParent;
Global ToggleButton myButton;
Global Text myText;
Global GuiObject myGrid;
Global int downX, tab_id;
Global boolean tabMouseDown, wasActive, tabMoveSend;

System.onScriptLoaded() {
	myGroup = getScriptGroup();
	myParent = myGroup.getParent();
	myButton = myGroup.findObject("cpro.tab.button");
	myGrid = myGroup.findObject("cpro.tab.grid");
	myText = myGroup.findObject("cpro.tab.text");
	tabMoveSend=false;
}

System.onSetXuiParam(String param, String value) {
	if(strlower(param) == "tabtext"){
		myText.setText(value);
		myGroup.setXmlParam("w", integerToString(myText.getAutoWidth()+14));
	}
	else if(strlower(param) == "tab_id"){
		tab_id = stringToInteger(value);
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
		//myParent.sendAction("move_tab", "", tab_id, 0, 0, 0);
		//debug(integertostring(downX) + " "+integertostring(System.getMousePosX()));
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
	tabMoveSend=false;
	wasActive=myButton.getActivated();
	downX=System.getMousePosX();
}
myButton.onLeftButtonUp(int x, int y){
	if(tabMouseDown){
		tabMouseDown=false;
		if(tabMoveSend){
			myParent.sendAction("move_tab_now", "", tab_id, 0, 0, 0);
		}
	}
}
myButton.onMouseMove(int x, int y){
	if(tabMouseDown && !tabMoveSend){
		int x = System.getMousePosX();
		if(downX >= x+4 || downX <= x-4){
			tabMoveSend=true;
			myParent.sendAction("move_tab", "", tab_id, 0, 0, 0);
		}
	}

}