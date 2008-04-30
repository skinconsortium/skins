#include <lib/std.mi>
#include "attribs.m"

#define sfRGBDefaultRED 7
#define sfRGBDefaultGREEN 106
#define sfRGBDefaultBLUE 218
#define UnreadableTextLimit 80

//is defined as main blue text colour despite lcd being diff 7,106,218 - use this value for now as its brighter and more readable

//SLoB add RGB for title bar and close button to begin with
Global Group frameGroup, content;//, titlebar;
Global String x, y, w, h, rx, ry, rw, rh;
Global string stdFrameRed, stdFrameGreen, stdFrameBlue;
//Global Layer mouselayer;
Global Button Sysmenu;
Global Text titlebar;
Global int iRed, iGreen, iBlue;
Global layer close_RGB_Red, close_RGB_Green, close_RGB_Blue, toggleRGB_Close;
Global layer close_RGB_RedH, close_RGB_GreenH, close_RGB_BlueH, toggleRGB_CloseH;

Global GuiObject closebtn;

Function setNewGroup(String groupid);


System.onScriptLoaded()
{
	initattribs();
	
	frameGroup = getScriptGroup();
	
	titlebar = frameGroup.findObject("titlebar");
	
	close_RGB_Red = frameGroup.findObject("close.RGB_Red");
	close_RGB_Green = frameGroup.findObject("close.RGB_Green");
	close_RGB_Blue = frameGroup.findObject("close.RGB_Blue");
	close_RGB_RedH = frameGroup.findObject("close.RGB_Red.h");
	close_RGB_GreenH = frameGroup.findObject("close.RGB_Green.h");
	close_RGB_BlueH = frameGroup.findObject("close.RGB_Blue.h");

	closebtn = frameGroup.findObject("close.button");
	
	toggleRGB_Close = frameGroup.findObject("RGBToggle_wasabi.frame1.close");
	toggleRGB_CloseH = frameGroup.findObject("RGBToggle_wasabi.frame1.close.h");
	
	String param = getParam();
	x = getToken(param, ",", 0);
	y = getToken(param, ",", 1);
	w = getToken(param, ",", 2);
	h = getToken(param, ",", 3);
	rx = getToken(param, ",", 4);
	ry = getToken(param, ",", 5);
	rw = getToken(param, ",", 6);
	rh = getToken(param, ",", 7);
	sysmenu = frameGroup.findObject("sysmenu");
	
	//rgb is off so default colour
	iRed = stringtointeger(myattrib_RGB_REDColor.getData());
	iGreen = stringtointeger(myattrib_RGB_GREENColor.getData());
	iBlue = stringtointeger(myattrib_RGB_BLUEColor.getData());
	
	if(myattrib_RGB_ENABLE.getData()=="0")
	{
		titlebar.setXMLParam("color",integertostring(sfRGBDefaultRED)+","+integertostring(sfRGBDefaultGREEN)+","+integertostring(sfRGBDefaultBLUE));
		toggleRGB_Close.setAlpha(255);
		toggleRGB_CloseH.setAlpha(255);
		
	}
	else
	{
		toggleRGB_Close.setAlpha(0);
		toggleRGB_CloseH.setAlpha(0);
		close_RGB_Red.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		close_RGB_Green.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		close_RGB_Blue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));

		close_RGB_RedH.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		close_RGB_GreenH.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		close_RGB_BlueH.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));

		titlebar.setXMLParam("color",integertostring(iRed)+","+integertostring(iGreen)+","+integertostring(iBlue));
	}

	if(iRed <= UnreadableTextLimit && iGreen <= UnreadableTextLimit && iBlue <= UnreadableTextLimit)
	{
		titlebar.setXMLParam("color","206,206,206");
		return;
	}
	  
}

myattrib_RGB_ENABLE.onDataChanged()
{
	if(getData()=="0")
	{
		titlebar.setXMLParam("color",integertostring(sfRGBDefaultRED)+","+integertostring(sfRGBDefaultGREEN)+","+integertostring(sfRGBDefaultBLUE));
		toggleRGB_Close.setAlpha(255);
		toggleRGB_CloseH.setAlpha(255);
		
	}
	else
	{
		close_RGB_Red.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		close_RGB_Green.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		close_RGB_Blue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));

		close_RGB_RedH.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		close_RGB_GreenH.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		close_RGB_BlueH.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));

		titlebar.setXMLParam("color",integertostring(iRed)+","+integertostring(iGreen)+","+integertostring(iBlue));
		toggleRGB_Close.setAlpha(0);
		toggleRGB_CloseH.setAlpha(0);
	}
}

System.onSetXuiParam(String param, String value) {
  if (param == "content") {
    setNewGroup(value);
//    titlebar = frameGroup.findObject("titlebar");
    //mouselayer = titlebar.findObject("mousetrap");

	iRed = stringtointeger(myattrib_RGB_REDColor.getData());
	iGreen = stringtointeger(myattrib_RGB_GREENColor.getData());
	iBlue = stringtointeger(myattrib_RGB_BLUEColor.getData());
	
	if(myattrib_RGB_ENABLE.getData()=="0")
	{
		titlebar.setXMLParam("color",integertostring(sfRGBDefaultRED)+","+integertostring(sfRGBDefaultGREEN)+","+integertostring(sfRGBDefaultBLUE));
		toggleRGB_Close.setAlpha(255);
		toggleRGB_CloseH.setAlpha(255);

	}
	else
	{
		toggleRGB_Close.setAlpha(0);
		toggleRGB_CloseH.setAlpha(0);

		close_RGB_Red.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		close_RGB_Green.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		close_RGB_Blue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));

		close_RGB_RedH.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		close_RGB_GreenH.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		close_RGB_BlueH.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));

		titlebar.setXMLParam("color",integertostring(iRed)+","+integertostring(iGreen)+","+integertostring(iBlue));
	}
	
   	if(iRed <= UnreadableTextLimit && iGreen <= UnreadableTextLimit && iBlue <= UnreadableTextLimit)
	{
		titlebar.setXMLParam("color","206,206,206");
		return;
	}

}
  /*if (param == "padtitleright" || param == "padtitleleft") {
    if (titlebar != NULL) titlebar.setXmlParam(param, value); 
  }
  if (param == "shade") {
    if (mouselayer != NULL) mouselayer.setXmlParam("dblclickaction", "switch;"+value);
    else messagebox("Cannot set shade parameter for StandardFrame object, no mousetrap found", "Skin Error", 0, "");
  }*/
  
  
}

// backward compatibility for prerelease notify trick
frameGroup.onNotify(String cmd, String param, int a, int b) {
  String _command = getToken(cmd, ",", 0);
  String _param = getToken(cmd, ",", 1);
  if (_command == "content" || _command == "padtitleright" || _command == "padtitleleft" || _command == "shade") {
    onSetXuiParam(_command, _param);
  }
  
	iRed = stringtointeger(myattrib_RGB_REDColor.getData());
	iGreen = stringtointeger(myattrib_RGB_GREENColor.getData());
	iBlue = stringtointeger(myattrib_RGB_BLUEColor.getData());
	
	if(myattrib_RGB_ENABLE.getData()=="0")
	{
		titlebar.setXMLParam("color",integertostring(sfRGBDefaultRED)+","+integertostring(sfRGBDefaultGREEN)+","+integertostring(sfRGBDefaultBLUE));
		toggleRGB_Close.setAlpha(255);
		toggleRGB_CloseH.setAlpha(255);

	}
	else
	{
		toggleRGB_Close.setAlpha(0);
		toggleRGB_CloseH.setAlpha(0);
		close_RGB_Red.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		close_RGB_Green.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		close_RGB_Blue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));

		close_RGB_RedH.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		close_RGB_GreenH.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		close_RGB_BlueH.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));

		titlebar.setXMLParam("color",integertostring(iRed)+","+integertostring(iGreen)+","+integertostring(iBlue));
	}

   	if(iRed <= UnreadableTextLimit && iGreen <=UnreadableTextLimit && iBlue <= UnreadableTextLimit)
	{
		titlebar.setXMLParam("color","206,206,206");
		return;
	}
	
}

setNewGroup(String groupid)
{
	content = newGroup(groupid);
	if (content == NULL) {
	messagebox("group \"" + groupid + "\" not found", "ButtonGroup", 0, "");
	return;
	}

	content.setXmlParam("x", x);
	content.setXmlParam("y", y);
	content.setXmlParam("w", w);
	content.setXmlParam("h", h);
	content.setXmlParam("relatx", rx);
	content.setXmlParam("relaty", ry);
	content.setXmlParam("relatw", rw);
	content.setXmlParam("relath", rh);
	content.init(frameGroup);
	
	iRed = stringtointeger(myattrib_RGB_REDColor.getData());
	iGreen = stringtointeger(myattrib_RGB_GREENColor.getData());
	iBlue = stringtointeger(myattrib_RGB_BLUEColor.getData());
	
	if(myattrib_RGB_ENABLE.getData()=="0")
	{
		titlebar.setXMLParam("color",integertostring(sfRGBDefaultRED)+","+integertostring(sfRGBDefaultGREEN)+","+integertostring(sfRGBDefaultBLUE));
		toggleRGB_Close.setAlpha(255);
		toggleRGB_CloseH.setAlpha(255);
	}
	else
	{
		toggleRGB_Close.setAlpha(0);
		toggleRGB_CloseH.setAlpha(0);
		close_RGB_Red.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		close_RGB_Green.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		close_RGB_Blue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));

		close_RGB_RedH.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		close_RGB_GreenH.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		close_RGB_BlueH.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));

		titlebar.setXMLParam("color",integertostring(iRed)+","+integertostring(iGreen)+","+integertostring(iBlue));
	}
		
	if(iRed <= UnreadableTextLimit && iGreen <= UnreadableTextLimit && iBlue <= UnreadableTextLimit)
	{
		titlebar.setXMLParam("color","206,206,206");
		return;
	}
	
}

Sysmenu.onLeftClick() {
  LayoutStatus _status = frameGroup.findObject("sysmenu.status");
  _status.callme("{system}");
}

//SLoB RGB

myattrib_RGB_REDColor.onDataChanged()
{
	stdFrameRed = getData();
	iRed = stringtointeger(stdFrameRed);
	
	close_RGB_Red.setAlpha(iRed);
	close_RGB_RedH.setAlpha(iRed);
	
	//prevent title from being unreadable	
	if(iRed <= UnreadableTextLimit && iGreen <= UnreadableTextLimit && iBlue <= UnreadableTextLimit)
	{
		//System.messageBox("here red", "Debug Error", 0, "");
		titlebar.setXMLParam("color","206,206,206");
		return;
	}
	
	titlebar.setXMLParam("color",integertostring(iRed)+","+integertostring(iGreen)+","+integertostring(iBlue));
}

myattrib_RGB_GREENColor.onDataChanged()
{
	stdFrameGreen = getData();
	iGreen = stringtointeger(stdFrameGreen);
	
	close_RGB_Green.setAlpha(iGreen);
	close_RGB_GreenH.setAlpha(iGreen);
	
	//prevent title from being unreadable	
	if(iRed <= UnreadableTextLimit && iGreen <= UnreadableTextLimit && iBlue <= UnreadableTextLimit)
	{
		//System.messageBox("here green", "Debug Error", 0, "");
		titlebar.setXMLParam("color","206,206,206");
		return;
	}
	
	titlebar.setXMLParam("color",integertostring(iRed)+","+integertostring(iGreen)+","+integertostring(iBlue));
}

myattrib_RGB_BLUEColor.onDataChanged()
{
	stdFrameBlue = getData();	
	iBlue = stringtointeger(stdFrameBlue);
	
	close_RGB_Blue.setAlpha(iBlue);
	close_RGB_BlueH.setAlpha(iBlue);
	
	//prevent title from being unreadable	
	if(iRed <= UnreadableTextLimit && iGreen <= UnreadableTextLimit && iBlue <= UnreadableTextLimit)
	{
		//System.messageBox("here blue", "Debug Error", 0, "");
		titlebar.setXMLParam("color","206,206,206");
		return;
	}
	
	titlebar.setXMLParam("color",integertostring(iRed)+","+integertostring(iGreen)+","+integertostring(iBlue));
}

closebtn.onEnterArea ()
{
	close_RGB_RedH.show();
	close_RGB_GreenH.show();
	close_RGB_BlueH.show();
	toggleRGB_CloseH.show();
}

closebtn.onLeaveArea ()
{
	close_RGB_RedH.hide();
	close_RGB_GreenH.hide();
	close_RGB_BlueH.hide();
	toggleRGB_CloseH.hide();
}