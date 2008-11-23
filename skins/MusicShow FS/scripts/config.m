/*************************************************************

	config.m
	by leechbite.com
	
	config scripts
*************************************************************/

#include <lib/std.mi>
#include <lib/config.mi>
#include <lib/fileio.mi>

// non exposed attribs page
#define CUSTOM_PAGE_NONEXPOSED "{E9C2D926-53CA-400f-9A4D-85E31755A4CF}"

Global group scriptGroup;

Global configAttribute bkground_image_attrib;

Global checkbox bgdef, bgimage, bgwall, bgtile;

Global edit imagefname;

System.onScriptLoaded() {
  
  
  ConfigItem custom_page_nonexposed = Config.newItem("Hidden", CUSTOM_PAGE_NONEXPOSED);
  bkground_image_attrib = custom_page_nonexposed.newAttribute("Glamour Background Image", "IMAGE:player.main.background.default;1");

  scriptGroup = getScriptGroup();
  
  bgdef = scriptGroup.findObject("config.bg.default");
  bgimage = scriptGroup.findObject("config.bg.image");
  bgwall = scriptGroup.findObject("config.bg.wallpaper");
  bgtile = scriptGroup.findObject("config.bg.tile");

  imagefname = scriptGroup.findObject("filename");
  
  string bkData = strupper(bkground_image_attrib.getData());
  string strtemp = "", bkDataEntry1 = "", bkDataEntry2 = "";
  strtemp = getToken(bkData, ";" ,0);
  if (strtemp!="") bkDataEntry1 = strright(strtemp, strlen(strtemp)-strsearch(strtemp, ":")-1);
  strtemp = getToken(bkData, ";" ,1);
  if (strtemp!="") bkDataEntry2 = strright(strtemp, strlen(strtemp)-strsearch(strtemp, ":")-1);

  if (strLeft(bkData,5)=="IMAGE") {
   	if (bkDataEntry1==strupper("player.main.background.default"))
   	  bgdef.setChecked(1);
   	else if (bkDataEntry1==strupper("player.main.background.wallpaper"))
   	  bgwall.setChecked(1);
   	else {
	  imagefname.setText(bkDataEntry1);
    }
   	  
  }
}

System.onScriptUnloading() {
  return;
}

bgdef.onToggle(int on) {
	if (!on) return;
	
	bkground_image_attrib.setData("IMAGE:player.main.background.default;1");
}

bgimage.onToggle(int on) {
	if (!on) return;
	
	file filecheck = new File;
	
	filecheck.load(imagefname.getText());
	if (filecheck.exists()) {
		bkground_image_attrib.setData("IMAGE:"+imagefname.getText()+";"+integerToString(bgtile.isChecked()));
	}
	
	delete filecheck;
}

imagefname.onEditUpdate() {
	if (bgimage.isChecked()) 
		bgimage.onToggle(1);
	else {
		bgdef.setChecked(0);
		bgimage.setChecked(1);
		bgwall.setChecked(0);
		bgimage.onToggle(1);
	}
}

bgwall.onToggle(int on) {
	if (!on) return;
	
	bkground_image_attrib.setData("IMAGE:player.main.background.wallpaper;"+integerToString(bgtile.isChecked()));
}

bgtile.onToggle(int on) {
	if (bgimage.isChecked()) bgimage.onToggle(1);
	else if (bgwall.isChecked()) bgwall.onToggle(1);
}