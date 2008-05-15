/*************************************************************

  KameleonDUI - hideshow-attrib.m
  by Leechbite

  all-purpose script for hiding and showing guiObjects depending
  on config attrib values.
  
  takes 3 parameters: (eq. param="objID,hide,attribGUID;attribNAME=value";
  objID = id of object to show and hide.
  hide = 1 to hide, 0 to show
  attribGUID;attribNAME = config attrib to use
  value = config attrib value to hide or show object
  
*************************************************************/

#include <lib/std.mi>
#include <lib/config.mi>

Global group parentGroup;
Global guiObject obj;
Global int hidemode;
Global configAttribute attrib;
Global string value;

System.onScriptLoaded() {
	parentGroup = getScriptGroup();
	string param = getParam();

	obj = parentGroup.findObject(getToken(param,",",0));
	hidemode = stringToInteger(getToken(param,",",1));
	string param2 = getToken(param,",",2);
	value = strlower(getToken(param2,"=",1));
	
	string param3 = getToken(param2,"=",0);
	configItem configGroup = Config.getItemByGuid(getToken(param3,";",0));
	if (configGroup) attrib = configGroup.newAttribute(getToken(param3,";",1),value);
	
	if (attrib) attrib.onDataChanged();
}

System.onScriptUnloading() {
	attrib = NULL;
}

attrib.onDataChanged() {
	if (strlower(getData()) == value) {
		if (hidemode == 1) obj.hide(); else obj.show();
	} else {
		if (hidemode == 1) obj.show(); else obj.hide();
	}
}