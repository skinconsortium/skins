#include "../../../../lib/std.mi" 
#include "../../../../lib/config.mi" 
//script modified for Titan by Martin P. alias Deimos (//!)

Global DropDownlist guiobjectDropDown; //!
Global Text textDropDownList;
Global String stringItem = "";
Global String stringSection = "";
Global String stringDefaultValue = "Fofo";
Global ConfigAttribute attrib;
Global String itemguid = "";
Global int h = 50;

System.onScriptLoaded() {
	guiobjectDropDown = getScriptGroup().getObject("dropdownlist");
	textDropDownList = guiobjectDropDown.findObject("dropdownlist.text");
	guiobjectDropDown.setListHeight(h);
}

System.onSetXuiParam(String stringParam, String stringValue) {
	if (strlower(stringParam) == "items") guiobjectDropDown.setXmlParam("items", stringValue);
	if (strlower(stringParam) == "defaultlistitem") stringDefaultValue = stringValue;
	if (strlower(stringParam) == "privateintsection") stringSection = stringValue;
	if (strlower(stringParam) == "privateintitem") stringItem = stringValue;
	if (strlower(stringParam) == "itemguid") itemguid = stringValue;
	if (strlower(stringParam) == "lh") { h = stringToInteger(stringValue); guiobjectDropDown.setListHeight(h); }
	if (stringItem != "" && stringSection != "" && stringDefaultValue != "Fofo") guiobjectDropDown.setXmlParam("default", System.getPrivateString(stringSection, stringItem, stringDefaultValue));
//	if (stringDefaultValue != "Fofo") guiobjectDropDown.setXmlParam("default", stringDefaultValue);
}

textDropDownList.onTextChanged(String stringNewText) {
	if (itemguid != "" ) {
		attrib = Config.getItemByGuid(itemguid).getAttribute(stringNewText);
		attrib.setData("1");
	}
}
