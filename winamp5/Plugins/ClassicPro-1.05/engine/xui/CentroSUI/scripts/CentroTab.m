#include <lib/std.mi>

Function updateState(int activated);

Global Group XUIGroup, but_on, but_off;
Global ToggleButton tabToggle;
Global Text tabText1, tabText2, tabText3;
Global GuiObject unselected;

System.onScriptLoaded() {
	XUIGroup = getScriptGroup();
	but_on = XUIGroup.findObject("centro.tabsheet.button.selected.group");
	but_off = XUIGroup.findObject("centro.tabsheet.button.unselected.group");
	tabToggle = XUIGroup.findObject("centro.tabtoggle");
	unselected = XUIGroup.findObject("centro.unselected.grid");

	updateState(tabToggle.getActivated());
}

System.onSetXuiParam(String param, String value) {
	if(strlower(param) == "tabtext"){
		tabText1 = XUIGroup.findObject("centro.text.act");
		tabText2 = XUIGroup.findObject("centro.text.inact");
		tabText3 = XUIGroup.findObject("centro.text.inact.hover");

		tabText1.setText(value);
		tabText2.setText(value);
		tabText3.setText(value);

		XUIGroup.setXmlParam("w", integerToString(tabText1.getAutoWidth()+14));
		
		//XUIGroup.setXmlParam("w", integerToString(tabText1.getTextWidth()+14));
	}
	if(strlower(param) == "tabtip"){
		tabToggle.setXmlParam("tooltip", value);
	}
}

tabText1.onTextChanged(String newtxt){
		XUIGroup.setXmlParam("w", integerToString(tabText1.getAutoWidth()+14));
}

updateState(int activated){
	if(activated==1){
		but_off.hide();
		but_on.show();
	}
	else{
		but_on.hide();
		but_off.show();
	}
}

tabToggle.onActivate(int activated){
	updateState(activated);
	tabText2.setXmlParam("color", "Tab.Text.Off");
}

tabToggle.onEnterArea(){
	unselected.setXmlParam("topleft", "wasabi.tabsheet.button.left.3");
	unselected.setXmlParam("top", "wasabi.tabsheet.button.center.3");
	unselected.setXmlParam("topright", "wasabi.tabsheet.button.right.3");
	
	tabText2.hide();
	tabText3.show();
}
tabToggle.onLeaveArea(){
	unselected.setXmlParam("topleft", "wasabi.tabsheet.button.left.2");
	unselected.setXmlParam("top", "wasabi.tabsheet.button.center.2");
	unselected.setXmlParam("topright", "wasabi.tabsheet.button.right.2");

	tabText2.show();
	tabText3.hide();
}