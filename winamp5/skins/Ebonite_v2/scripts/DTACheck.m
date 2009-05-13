/*************************************************************


  DeskTopAlpha (DTA) Check Script


*************************************************************/


#include <lib/std.mi>
#include <lib/config.mi>

Global ConfigAttribute dtaAttrib;

System.onScriptLoaded() {
	configItem configGroup = Config.getItemByGuid("{9149C445-3C30-4E04-8433-5A518ED0FDDE}");
	if (configGroup) dtaAttrib = configGroup.getAttribute("Enable desktop alpha");
	
	if (dtaAttrib) {
		if (dtaAttrib.getData()!="1") {
			//We dont check anymore... Winamp isnt supported anymore on Win98 so all of the systems support it.. so we dont take no for an answer :P
			dtaAttrib.setData("1");
		}
	}
}

dtaAttrib.onDataChanged(){
		if (dtaAttrib.getData()!="1") {
			dtaAttrib.setData("1");
		}
}