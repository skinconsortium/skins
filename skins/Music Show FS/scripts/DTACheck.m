/*************************************************************

  DeskTopAlpha (DTA) Check Script

*************************************************************/

#include <lib/std.mi>
#include <lib/config.mi>

System.onScriptLoaded() {

	configAttribute dtaAttrib;
	configItem configGroup = Config.getItemByGuid("{9149C445-3C30-4E04-8433-5A518ED0FDDE}");
	if (configGroup) dtaAttrib = configGroup.getAttribute("Enable desktop alpha");
	
	if (dtaAttrib) {
		if (dtaAttrib.getData()!="1") {
			if (messageBox("Skin requires Desktop Alpha to be ON.\n\nTurn DTA ON?", "Desktop Alpha required", 12, "") == 4) {
				dtaAttrib.setData("1");
			}
		}
	}
}
