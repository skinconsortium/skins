#include "../../../lib/std.mi"

Global GuiObject guiobjectDropDown;
Global Text textDropDownList;
Global String stringItem = "";
Global String stringSection = "";
Global String stringDefaultValue = "Fofo";

System.onScriptLoaded() {
	guiobjectDropDown = getScriptGroup().getObject("dropdownlist");
	textDropDownList = guiobjectDropDown.findObject("dropdownlist.text");
}

System.onSetXuiParam(String stringParam, String stringValue) {
	if (strlower(stringParam) == "items") guiobjectDropDown.setXmlParam("items", stringValue);
	if (strlower(stringParam) == "defaultlistitem") stringDefaultValue = stringValue;
	if (strlower(stringParam) == "privateintsection") stringSection = stringValue;
	if (strlower(stringParam) == "privateintitem") stringItem = stringValue;
	if (stringItem != "" && stringSection != "" && stringDefaultValue != "Fofo") guiobjectDropDown.setXmlParam("default", System.getPrivateString(stringSection, stringItem, stringDefaultValue));
}

textDropDownList.onTextChanged(String stringNewText) {
	System.setPrivateString(stringSection, stringItem, stringNewText);
}
