/*************************************************************

	customBG.xml
	by leechbite.com
	
	lifted off KameleonDUI for custom background XUI

*************************************************************/

#include <lib/std.mi>
#include <lib/config.mi>

// non exposed attribs page
#define CUSTOM_PAGE_NONEXPOSED "{E9C2D926-53CA-400f-9A4D-85E31755A4CF}"

Global group scriptGroup;
Global layer bgImage;
Global guiObject bgColor, bgGroup;

Global configAttribute bkground_image_attrib;

System.onScriptLoaded() {
  
  
  ConfigItem custom_page_nonexposed = Config.newItem("Hidden", CUSTOM_PAGE_NONEXPOSED);
  bkground_image_attrib = custom_page_nonexposed.newAttribute("Glamour Background Image", "IMAGE:player.main.background.default;0");

  scriptGroup = getScriptGroup();
  bgImage = scriptGroup.getObject("bgImage");
  bgColor = scriptGroup.getObject("bgColor");
  bgGroup = scriptGroup.getObject("bgGroup");

  /*bgColor.setXMLParam("color", getPrivateString(getSkinName(),"Config slider.red","0")+","+
  		getPrivateString(getSkinName(),"Config slider.green","0")+","+
  		getPrivateString(getSkinName(),"Config slider.blue","0"));*/
  
  bkground_image_attrib.onDataChanged();
  //bkground_image_attrib.setData("GROUP:bkground.group.redflame");
}

System.onScriptUnloading() {
  return;
}

bkground_image_attrib.onDataChanged() {
  string bkData = strupper(getData());

  string strtemp = "", bkDataEntry1 = "", bkDataEntry2 = "";
  strtemp = getToken(bkData, ";" ,0);
  if (strtemp!="") bkDataEntry1 = strright(strtemp, strlen(strtemp)-strsearch(strtemp, ":")-1);
  strtemp = getToken(bkData, ";" ,1);
  if (strtemp!="") bkDataEntry2 = strright(strtemp, strlen(strtemp)-strsearch(strtemp, ":")-1);

  if (strLeft(bkData,5)=="IMAGE") {
    bgColor.hide();
    bgGroup.hide();    bgGroup.setXMLParam("groupid", "");
    bgImage.show();    bgImage.setXMLParam("image", bkDataEntry1);
    if (bkDataEntry2=="") bkDataEntry2="0";
    bgImage.setXMLParam("tile", bkDataEntry2);
  } else if (strLeft(bkData,3)=="RGB") {
    bgColor.show();
    bgGroup.hide();    bgGroup.setXMLParam("groupid", "");
    bgImage.hide();
    bgColor.setXMLParam("color", bkDataEntry1);
  } else if (strLeft(bkData,5)=="GROUP") {
    bgColor.hide();
    bgImage.hide();
    bgGroup.show();
    bgGroup.setXMLParam("groupid", bkDataEntry1);
  }
}
