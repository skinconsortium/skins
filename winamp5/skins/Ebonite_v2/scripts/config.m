/*********************************************************************
SLoB for Ebonite 2008
	http://www.skinconsortium.com
	
	config script
	  ,,,      
	(o o)     
 -ooO--(_)--Ooo-
 
*********************************************************************/

#include <lib/std.mi>
//#include <lib/config.mi>
//#include "attribs.m"
//#include "attribs/init_notifier.m"
//#include "attribs/init_songticker.m"
#include "attribs/init_rgb.m"

Function cfgsetSC_RGB_Red(int iRed);
Function cfgsetSC_RGB_Green(int iGreen);
Function cfgsetSC_RGB_Blue(int iBlue);

Global Container contConfig;
Global Layout layConfig;
Global Group grpGeneral, grpNotifier;


Global Layer cfgRed, cfgGreen, cfgBlue, General, Notifier;
Global Int iCfgGrp;
Global Button btnGeneral, btnNotifier;
Global Text txtGeneral, txtNotifier;

Global checkbox optClockShow, optClock24Hour, optLeadingZero, optRotateStdViz;
Global checkbox optShowCover, optShowViz, optShowCubeViz, optTickerScrolling, optTickerClassic;

Global checkbox optNotiShowFullScreen, optNotiShowCover;
Global togglebutton optNotiShowAlways, optNotiShowMin, optNotiShowNever;
Global togglebutton optNotiPosTL, optNotiPosTR, optNotiPosBL, optNotiPosBR;
	

System.onScriptLoaded() 
{
/*	initAttribs();
	//initAttribs_notifier();
	initAttribs_songticker();
*/	
	initAttribs_rgb();
	contConfig = getContainer("configs");
	layConfig = contConfig.getLayout("normalconfigs");
	
	grpGeneral = layConfig.findObject("grpgeneral");
	grpNotifier = layConfig.findObject("grpnotifier");
	
	
	cfgRed = layConfig.findObject("cfg.background.changer.red");
	cfgGreen = layConfig.findObject("cfg.background.changer.green");
	cfgBlue = layConfig.findObject("cfg.background.changer.blue");
	
	btnGeneral = layConfig.findObject("btngrpGeneral");
	btnNotifier = layConfig.findObject("btngrpNotifier");
	txtGeneral = layConfig.findObject("txtgrpGeneral");
	txtNotifier = layConfig.findObject("txtgrpNotifier");
	
	//options options
	optClockShow = layConfig.findObject("checkbox.clockshowclockwhenstopped");
	optClock24Hour = layConfig.findObject("checkbox.clockshow24hourclock");
	optLeadingZero = layConfig.findObject("checkbox.clockshowclockleadingzero");
	
	optShowCover = layConfig.findObject("checkbox.covershowcover");
	optShowViz = layConfig.findObject("checkbox.covershowviz");
	optShowCubeViz = layConfig.findObject("checkbox.covershowcubeviz");
	optRotateStdViz = layConfig.findObject("checkbox.coverrotatestdviz");
	
	optTickerScrolling = layConfig.findObject("checkbox.tickerscrolling");
	optTickerClassic = layConfig.findObject("checkbox.tickerclassicstyle");

	
	optNotiPosTL = layConfig.findObject("checkbox.notilocationtl");
	optNotiPosTR = layConfig.findObject("checkbox.notilocationtr");
	optNotiPosBL = layConfig.findObject("checkbox.notilocationbl");
	optNotiPosBR = layConfig.findObject("checkbox.notilocationbr");
	
	
	iCfgGrp = getPrivateInt(getSkinName(),"cfgGroupShown", 0);
	
	
	if(iCfgGrp == 0)
	{
		grpGeneral.show();
		grpNotifier.hide();
		txtGeneral.setXMLParam("color", "lcdtext");
		txtNotifier.setXMLParam("color", "155,155,155");
	}
	else
	{
		grpGeneral.hide();
		grpNotifier.show();
		txtGeneral.setXMLParam("color", "155,155,155");
		txtNotifier.setXMLParam("color", "lcdtext");
	}
	
	cfgsetSC_RGB_Red(getPrivateInt(getSkinName(),"redbg", 0));
	cfgsetSC_RGB_Green(getPrivateInt(getSkinName(),"greenbg", 0));
	cfgsetSC_RGB_Blue(getPrivateInt(getSkinName(),"bluebg", 0));
	
}

System.onScriptUnloading()
{
	setPrivateInt(getSkinName(),"cfgGroupShown", iCfgGrp);
}

System.onShowLayout(Layout layConfig)
{
	iCfgGrp = getPrivateInt(getSkinName(),"cfgGroupShown", 0);
	
	if(iCfgGrp == 0)
	{
		grpGeneral.show();
		grpNotifier.hide();
		txtGeneral.setXMLParam("color", "lcdtext");
		txtNotifier.setXMLParam("color", "155,155,155");
	}
	else
	{
		grpGeneral.hide();
		grpNotifier.show();
		txtGeneral.setXMLParam("color", "155,155,155");
		txtNotifier.setXMLParam("color", "lcdtext");
	}
	
	cfgsetSC_RGB_Red(getPrivateInt(getSkinName(),"redbg", 0));
	cfgsetSC_RGB_Green(getPrivateInt(getSkinName(),"greenbg", 0));
	cfgsetSC_RGB_Blue(getPrivateInt(getSkinName(),"bluebg", 0));
#ifdef 0	
	//set defaults
	if(configAttribute_clock_showwhenstopped.getData()=="1")
	{
		optClockShow.setChecked(1);
	}
	else
	{
		optClockShow.setChecked(0);
	}
	
	if(globalmyattr_SCCoverEnabled.getData()=="1")
	{
		optShowCover.setChecked(1);		
	}
	else
	{
		optShowCover.setChecked(0);
	}
#endif
}	

btnNotifier.onEnterArea()
{
		txtNotifier.setXMLParam("color", "lcdtext");
}

btnGeneral.onEnterArea()
{
		txtGeneral.setXMLParam("color", "lcdtext");
}		

btnNotifier.onLeaveArea()
{
	if(iCfgGrp == 0)
	{
		txtNotifier.setXMLParam("color", "155,155,155");
	}
}

btnGeneral.onLeaveArea()
{
	if(iCfgGrp == 1)
	{
		txtGeneral.setXMLParam("color", "155,155,155");
	}
}


btnGeneral.onLeftButtonDown(int x, int y)
{

	txtGeneral.setXMLParam("color", "lcdtext");
	txtNotifier.setXMLParam("color", "155,155,155");

	grpGeneral.show();
	grpNotifier.hide();
	iCfgGrp = 0;
	
	setPrivateInt(getSkinName(),"cfgGroupShown", iCfgGrp);
}
	

btnNotifier.onLeftButtonDown(int x, int y)
{
	txtGeneral.setXMLParam("color", "155,155,155");
	txtNotifier.setXMLParam("color", "lcdtext");

	grpGeneral.hide();
	grpNotifier.show();
	iCfgGrp = 1;
	
	setPrivateInt(getSkinName(),"cfgGroupShown", iCfgGrp);
}


myattrib_stdfrmBGREDColor.onDataChanged()
{
	if(myattrib_stdfrmBGEnabled.getData()=="1")
	{
		cfgsetSC_RGB_Red(stringtointeger(myattrib_stdfrmBGREDColor.getData()));
	}
}

myattrib_stdfrmBGGREENColor.onDataChanged()
{
	if(myattrib_stdfrmBGEnabled.getData()=="1")
	{
		cfgsetSC_RGB_Green(stringtointeger(myattrib_stdfrmBGGREENColor.getData()));
	}
}

myattrib_stdfrmBGBLUEColor.onDataChanged()
{
	if(myattrib_stdfrmBGEnabled.getData()=="1")
	{
		cfgsetSC_RGB_Blue(stringtointeger(myattrib_stdfrmBGBLUEColor.getData()));
	}
}

cfgsetSC_RGB_Red(int iRed)
{
	cfgRed.setAlpha(iRed);	
}

cfgsetSC_RGB_Green(int iGreen)
{
	cfgGreen.setAlpha(iGreen);	
}
cfgsetSC_RGB_Blue(int iBlue)
{
	cfgBlue.setAlpha(iBlue);
}

#ifdef 0

//option changes now, lets sort em out

//clock first
optClockShow.onToggle(int newstate)
{
	if(newstate== 1)
	{
		configAttribute_clock_showwhenstopped.setData("1");		
	}
	else
	{
		configAttribute_clock_showwhenstopped.setData("0");
	}	
}

//update cfg window if changed
configAttribute_clock_showwhenstopped.onDataChanged()
{
	if(getData()=="1")
	{
		optClockShow.setChecked(1);
	}
	else
	{
		optClockShow.setChecked(0);
	}
}



optClock24Hour.onToggle(int newstate)
{
	if(newstate== 1)
	{
		configAttribute_clock_show24hr.setData("1");		
	}
	else
	{
		configAttribute_clock_show24hr.setData("0");
	}	
}

//update cfg window if changed
configAttribute_clock_show24hr.onDataChanged()
{
	if(getData()=="1")
	{
		optClock24Hour.setChecked(1);
	}
	else
	{
		optClock24Hour.setChecked(0);
	}
}

optLeadingZero.onToggle(int newstate)
{
	if(newstate== 1)
	{
		configAttribute_clock_showleadingzero.setData("1");		
	}
	else
	{
		configAttribute_clock_showleadingzero.setData("0");
	}	
}
//update cfg window if changed
configAttribute_clock_showleadingzero.onDataChanged()
{
	if(getData()=="1")
	{
		optLeadingZero.setChecked(1);
	}
	else
	{
		optLeadingZero.setChecked(0);
	}
}

//now cover
optRotateStdViz.onToggle(int newstate)
{
	if(newstate== 1)
	{
		myattr_SC90DegVisRotation.setData("1");		
	}
	else
	{
		myattr_SC90DegVisRotation.setData("0");
	}	
}
//update cfg window if changed
myattr_SC90DegVisRotation.onDataChanged()
{
	if(getData()=="1")
	{
		optRotateStdViz.setChecked(1);		
	}
	else
	{
		optRotateStdViz.setChecked(0);
	}
}

//radio

optShowCover.onToggle(int newstate)
{
	if(newstate==1)
	{
		globalmyattr_SCCoverEnabled.setData("1");		
	}
	else
	{
		globalmyattr_SCCoverEnabled.setData("0");
	}
}

globalmyattr_SCCoverEnabled.onDataChanged()
{
	if(getData()=="1")
	{
		optShowCover.setChecked(1);
		globalmyattr_SC90DegVisEnabled.setData("0");
		globalmyattr_SCCubeVisEnabled.setData("0");
		optShowViz.setChecked(0);
		optShowCubeViz.setChecked(0);		
	}
	else
	{
		optShowCover.setChecked(0);
	}
}

optShowViz.onToggle(int newstate)
{
	if(newstate==1)
	{
		globalmyattr_SC90DegVisEnabled.setData("1");
		globalmyattr_SCCoverEnabled.setData("0");
		globalmyattr_SCCubeVisEnabled.setData("0");
		optShowCover.setChecked(0);
		optShowCubeViz.setChecked(0);
	}
	else
	{
		globalmyattr_SC90DegVisEnabled.setData("0");
	}
}

optShowCubeViz.onToggle(int newstate)
{
	if(newstate==1)
	{
		globalmyattr_SCCubeVisEnabled.setData("1");
		globalmyattr_SCCoverEnabled.setData("0");
		globalmyattr_SC90DegVisEnabled.setData("0");
		optShowViz.setChecked(0);
		optShowCover.setChecked(0);
	}
	else
	{
		globalmyattr_SCCubeVisEnabled.setData("0");
	}
}

//songticker options
optTickerScrolling.onToggle(int newstate)
{
	if(newstate==1)
	{
		//songticker_scrolling_enabled_attrib.setData("1");
	}
	else
	{
		//songticker_scrolling_enabled_attrib.setData("0");
	}
}

songticker_scrolling_enabled_attrib.onDataChanged()
{
	if(getData()=="1")
	{
		//optTickerScrolling.setChecked(1);
	}
	else
	{
		//optTickerScrolling.setChecked(0);	
	}
}


optTickerClassic.onToggle(int newstate)
{
	if(newstate==1)
	{
		//songticker_style_old_attrib.setData("1");		
	}
	else
	{
		//songticker_style_old_attrib.setData("0");
	}
}


//NOTIFIER OPTIONS
/*
if(yOffset==20)	notifier_ypos_20_attrib.setData("1");
	if(yOffset==40)	notifier_ypos_40_attrib.setData("1");
	if(yOffset==60)	notifier_ypos_60_attrib.setData("1");
	if(yOffset==80)	notifier_ypos_80_attrib.setData("1");
	if(yOffset==100) notifier_ypos_100_attrib.setData("1");
	*/
	
//Location/Position
/*
optNotiPosTL.onToggle(int newstate)
{
	if(newstate==1)
	{
		notifier_loc_tl_attrib.setData("1");
		notifier_loc_tr_attrib.setData("0");
		notifier_loc_bl_attrib.setData("0");
		notifier_loc_br_attrib.setData("0");
		
		optNotiPosTR.setChecked(0);
		optNotiPosBL.setChecked(0);
		optNotiPosBR.setChecked(0);
		
	}
	else
	{
		notifier_loc_tl_attrib.setData("0");
	}
}
*/

#endif
