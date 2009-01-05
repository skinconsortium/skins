/*************************************************************

  text-to-attrib.m
  by Leechbite

  modified, now displays OFF if attrib is 0.
  
  general purpose script to display a config attrib on a
  Text object.
  
  param = "textID,attribGUID;attribName,prefix,suffix" <--prefix and suffix is optional
    e.g. param = "text.shf,{45F3F7C1-A6F3-4EE6-A15E-125E92FC3F8D};Shuffle" 
    this will displays on text.shf object the current shuffle status, that is 1 or 0.

*************************************************************/

#include <lib/std.mi>
#include <lib/config.mi>

Global group scriptGroup;
Global text textobj;
Global configAttribute attrib;
Global string prefix, suffix;

System.onScriptLoaded() {

	scriptGroup = getScriptGroup();
	string param = getParam();
	
	textobj = scriptGroup.getObject(getToken(param,",",0));
	string param2 = getToken(param,",",1);
	prefix = getToken(param,",",2);
	suffix = getToken(param,",",3);
	
	configItem configGroup = Config.getItemByGuid(getToken(param2,";",0));
	if (configGroup) attrib = configGroup.newAttribute(getToken(param2,";",1),"");
	
	if (attrib) attrib.onDataChanged();
}

attrib.onDataChanged() {
	if (!textobj) return;
	
	if (getData()!="0")
		textobj.setText(prefix+getData()+suffix);
	else
		textobj.setText("OFF");
}
