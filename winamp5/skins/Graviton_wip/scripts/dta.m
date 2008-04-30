#include </lib/std.mi>
#include </lib/config.mi>

Global Layer dtaLyr;
Class ConfigAttribute ToggleConfigAttribute;
Global ToggleConfigAttribute attr_desktopalpha;

System.onScriptLoaded() {

	Layout MainNormal = System.getContainer("Main").getLayout("Normal");
	dtaLyr = MainNormal.findObject("main.outer.mask.dta");
	ConfigItem item = Config.getItem("Skins and UI Tweaks");
	if (item != NULL) 
	{
		attr_desktopalpha = item.getAttribute("Enable desktop alpha");
	}


	//check if dta on/off show/hide dta button workaround
	if (attr_desktopalpha.getData() == "1") 
	{
		dtaLyr.hide();
	}

	if (attr_desktopalpha.getData() == "0") 
	{
		dtaLyr.show();
	}


}


attr_desktopalpha.onDataChanged()
{
	if (getData() == "1") 
	{
		dtaLyr.hide();
	}

	if (getData() == "0") 
	{
		dtaLyr.show();
	}
}