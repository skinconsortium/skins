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

Global togglebutton bgdef, bgimage, bgwall;

Global edit imagefname;
Global button browseButton;

class layer currbgClass;
Global currbgClass currbg1, currbg2, currbg3, currbg4;

Global int noaddcurrbg;

System.onScriptLoaded() {
  
  
  ConfigItem custom_page_nonexposed = Config.newItem("Hidden", CUSTOM_PAGE_NONEXPOSED);
  bkground_image_attrib = custom_page_nonexposed.newAttribute("Glamour Background Image", "IMAGE:player.main.background.default;1");

  scriptGroup = getScriptGroup();
  
  bgdef = scriptGroup.findObject("config.button.default");
  bgimage = scriptGroup.findObject("config.button.choose");
  bgwall = scriptGroup.findObject("config.button.desktop");

  imagefname = scriptGroup.findObject("filename");
  browseButton = scriptGroup.findObject("select");
  
  currbg1 = scriptGroup.findObject("config.currbg1");
  currbg2 = scriptGroup.findObject("config.currbg2");
  currbg3 = scriptGroup.findObject("config.currbg3");
  currbg4 = scriptGroup.findObject("config.currbg4");
  
  string bkData = strupper(bkground_image_attrib.getData());
  string strtemp = "", bkDataEntry1 = "", bkDataEntry2 = "";
  strtemp = getToken(bkData, ";" ,0);
  if (strtemp!="") bkDataEntry1 = strright(strtemp, strlen(strtemp)-strsearch(strtemp, ":")-1);
  strtemp = getToken(bkData, ";" ,1);
  if (strtemp!="") bkDataEntry2 = strright(strtemp, strlen(strtemp)-strsearch(strtemp, ":")-1);

  if (strLeft(bkData,5)=="IMAGE") {
   	if (bkDataEntry1==strupper("player.main.background.default"))
   	  bgdef.setActivated(1);
   	else if (bkDataEntry1==strupper("player.main.background.wallpaper"))
   	  bgwall.setActivated(1);
   	else {
	  noaddcurrbg = 1;
	  bgimage.setActivated(1);
	  imagefname.setText(bkDataEntry1);
	  noaddcurrbg = 0;
    }
   	  
  }
  
  currbg1.setXMLParam("image",getPrivateString("MusicShow","currbg1",""));
  currbg2.setXMLParam("image",getPrivateString("MusicShow","currbg2",""));
  currbg3.setXMLParam("image",getPrivateString("MusicShow","currbg3",""));
  currbg4.setXMLParam("image",getPrivateString("MusicShow","currbg4",""));
}

System.onScriptUnloading() {
  return;
}

bgdef.onToggle(int on) {
	if (!on) {
		bgdef.setActivatedNoCallback(1);
	}
	
	bkground_image_attrib.setData("IMAGE:player.main.background.default;1");
	
	bgimage.setActivatedNoCallback(0);
	bgwall.setActivatedNoCallback(0);
}

bgimage.onToggle(int on) {

	bgimage.setActivatedNoCallback(0);

	
	browseButton.leftClick();

}

imagefname.onEditUpdate() {
	
	file filecheck = new File;
	
	filecheck.load(imagefname.getText());
	if (filecheck.exists()) {
		bgwall.setActivatedNoCallback(0);
		bgimage.setActivatedNoCallback(1);
		bgdef.setActivatedNoCallback(0);
		
		bkground_image_attrib.setData("IMAGE:"+imagefname.getText()+";0");
		if (!noaddcurrbg) {
			string bg1 = getPrivateString("MusicShow","currbg1","");
			string bg2 = getPrivateString("MusicShow","currbg2","");
			string bg3 = getPrivateString("MusicShow","currbg3","");
			
			setPrivateString("MusicShow","currbg4",bg3);
			setPrivateString("MusicShow","currbg3",bg2);
			setPrivateString("MusicShow","currbg2",bg1);
			setPrivateString("MusicShow","currbg1",imagefname.getText());
			
			currbg1.setXMLParam("image",getPrivateString("MusicShow","currbg1",""));
			currbg2.setXMLParam("image",getPrivateString("MusicShow","currbg2",""));
			currbg3.setXMLParam("image",getPrivateString("MusicShow","currbg3",""));
			currbg4.setXMLParam("image",getPrivateString("MusicShow","currbg4",""));
		}
	}
	
	delete filecheck;
}

currbgClass.onLeftButtonDown(int x, int y) {
	string img = getXMLParam("image");
	if (img=="") return;
	
	bkground_image_attrib.setData("IMAGE:"+img+";0");
	
	bgwall.setActivatedNoCallback(0);
	bgimage.setActivatedNoCallback(1);
	bgdef.setActivatedNoCallback(0);
}

bgwall.onToggle(int on) {
	if (!on) {
		bgwall.setActivatedNoCallback(1);
	}
	
	bkground_image_attrib.setData("IMAGE:player.main.background.wallpaper;0");
	
	bgimage.setActivatedNoCallback(0);
	bgdef.setActivatedNoCallback(0);
}