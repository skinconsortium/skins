/*********************************************************************
SLoB for krazyPlayer 2008
	http://www.skinconsortium.com	
	  ,,,      
	(o o)     
 -ooO--(_)--Ooo-
 
 bug in 5.52/3 whereby eqvis is not refreshed on param change, prolly cos no-one really does rgb on the spline ;)
 hopefully its fixed in a future build, if so then need to remove resize for each colour/setting
 
*********************************************************************/
#include <lib/std.mi>
#include "attribs.m"

#define EQRGBDefaultRED 0
#define EQRGBDefaultGREEN 10
#define EQRGBDefaultBLUE 255

function setEqAnim(int eqValue, Layer eqName);

global Container contEqualizer;
Global Layout eqlay;
Global Group grpEQVIS;
Global EqVis EQ_spline_RGB;
Global layer eqpre, eq0, eq1, eq2, eq3, eq4, eq5, eq6, eq7, eq8, eq9, eq10;
Global map EQMap;
Global layer balblue, balRGBRed, balRGBGreen, balRGBBlue;
Global layer eqpreRGBRed, eqpreRGBGreen, eqpreRGBBlue;

Global layer eq0RGBRed, eq1RGBRed, eq2RGBRed, eq3RGBRed, eq4RGBRed, eq5RGBRed, eq6RGBRed, eq7RGBRed, eq8RGBRed, eq9RGBRed;
Global layer eq0RGBGreen, eq1RGBGreen, eq2RGBGreen, eq3RGBGreen, eq4RGBGreen, eq5RGBGreen, eq6RGBGreen, eq7RGBGreen, eq8RGBGreen, eq9RGBGreen;
Global layer eq0RGBBlue, eq1RGBBlue, eq2RGBBlue, eq3RGBBlue, eq4RGBBlue, eq5RGBBlue, eq6RGBBlue, eq7RGBBlue, eq8RGBBlue, eq9RGBBlue;

Global layer pres, presRGBRed, presRGBGreen, presRGBBlue;
Global layer eqonRGBRed, eqonRGBGreen, eqonRGBBlue;
Global button EQON;
Global layer EQAutoRGBRed, EQAutoRGBGreen, EQAutoRGBBlue;

Global togglebutton BTNAUTO, ACTUALBTNAUTO;
Global layer eqautomask, eqautomasktxt, eqonmask, eqonmasktxt;

  
System.onScriptLoaded() 
{
	initattribs();

	//EQframeGroup = getScriptGroup();
	
	contEqualizer = getContainer("eqrgb");
	eqlay = contEqualizer.getLayout("eqnormalrgb");
	grpEQVIS = eqlay.findObject("eq.buttons");
	EQ_spline_RGB = grpEQVIS.findObject("eq_spline");
	
	//eq fillbars
	EQMap = new Map;
	EQMap.loadMap("eq.slider.eq.map");
	
	//butons
	pres = eqlay.findObject("eq.button.pres1.blue"); 
	presRGBRed = eqlay.findObject("eq.button.pres1.RGB.Red");
	presRGBGreen = eqlay.findObject("eq.button.pres1.RGB.Green");
	presRGBBlue = eqlay.findObject("eq.button.pres1.RGB.Blue");
	
	eqonRGBRed = eqlay.findObject("eq.button.on1.RGB.Red");
	eqonRGBGreen = eqlay.findObject("eq.button.on1.RGB.Green");
	eqonRGBBlue = eqlay.findObject("eq.button.on1.RGB.Blue");

	EQON = eqlay.findObject("BTNEQ");
	BTNAUTO = eqlay.findObject("BTNAUTO");
	ACTUALBTNAUTO = eqlay.findObject("actualeqauto");
	eqautomask = eqlay.findObject("eqautobuttonmask");
	eqautomasktxt = eqlay.findObject("eqautobuttonmasktxt");
	eqonmask = eqlay.findObject("eqonbuttonmask");
	eqonmasktxt = eqlay.findObject("eqonbuttonmasktxt");
	
	
	EQAutoRGBRed = eqlay.findObject("BTNAUTO.RGB.Red");
	EQAutoRGBGreen = eqlay.findObject("BTNAUTO.RGB.Green");
	EQAutoRGBBlue = eqlay.findObject("BTNAUTO.RGB.Blue");

	
	eqpre = eqlay.findObject("eqpre");
	eqpreRGBRed = eqlay.findObject("eqprered");
	eqpreRGBGreen = eqlay.findObject("eqpregreen");
	eqpreRGBBlue = eqlay.findObject("eqpreblue");
	
	eq0 = eqlay.findObject("eq1");
	eq0RGBRed = eqlay.findObject("eq1r");
	eq0RGBGreen = eqlay.findObject("eq1g");
	eq0RGBBlue = eqlay.findObject("eq1b");
	
	eq1 = eqlay.findObject("eq2");
	eq1RGBRed = eqlay.findObject("eq2r");
	eq1RGBGreen = eqlay.findObject("eq2g");
	eq1RGBBlue = eqlay.findObject("eq2b");
	
	eq2 = eqlay.findObject("eq3");
	eq2RGBRed = eqlay.findObject("eq3r");
	eq2RGBGreen = eqlay.findObject("eq3g");
	eq2RGBBlue = eqlay.findObject("eq3b");
	
	eq3 = eqlay.findObject("eq4");
	eq3RGBRed = eqlay.findObject("eq4r");
	eq3RGBGreen = eqlay.findObject("eq4g");
	eq3RGBBlue = eqlay.findObject("eq4b");
	
	eq4 = eqlay.findObject("eq5");
	eq4RGBRed = eqlay.findObject("eq5r");
	eq4RGBGreen = eqlay.findObject("eq5g");
	eq4RGBBlue = eqlay.findObject("eq5b");
	
	eq5 = eqlay.findObject("eq6");
	eq5RGBRed = eqlay.findObject("eq6r");
	eq5RGBGreen = eqlay.findObject("eq6g");
	eq5RGBBlue = eqlay.findObject("eq6b");
	
	eq6 = eqlay.findObject("eq7");
	eq6RGBRed = eqlay.findObject("eq7r");
	eq6RGBGreen = eqlay.findObject("eq7g");
	eq6RGBBlue = eqlay.findObject("eq7b");
	
	eq7 = eqlay.findObject("eq8");
	eq7RGBRed = eqlay.findObject("eq8r");
	eq7RGBGreen = eqlay.findObject("eq8g");
	eq7RGBBlue = eqlay.findObject("eq8b");
	
	eq8 = eqlay.findObject("eq9");
	eq8RGBRed = eqlay.findObject("eq9r");
	eq8RGBGreen = eqlay.findObject("eq9g");
	eq8RGBBlue = eqlay.findObject("eq9b");
	
	eq9 = eqlay.findObject("eq10");
	eq9RGBRed = eqlay.findObject("eq10r");
	eq9RGBGreen = eqlay.findObject("eq10g");
	eq9RGBBlue = eqlay.findObject("eq10b");
	
	balblue = eqlay.findObject("balblue");
	balRGBRed = eqlay.findObject("balRGBRed");
	balRGBGreen = eqlay.findObject("balRGBGreen");
	balRGBBlue = eqlay.findObject("balRGBBlue");
	
	
	//initialize Band positions
	setEqAnim(128 - System.getEqPreamp(), eqpre);
	setEqAnim(128 - System.getEqPreamp(), eqpreRGBRed);
	setEqAnim(128 - System.getEqPreamp(), eqpreRGBGreen);
	setEqAnim(128 - System.getEqPreamp(), eqpreRGBBlue);
	
	
	setEqAnim(128 - System.getEqBand(0), eq0);
	setEqAnim(128 - System.getEqBand(0), eq0RGBRed);
	setEqAnim(128 - System.getEqBand(0), eq0RGBGreen);
	setEqAnim(128 - System.getEqBand(0), eq0RGBBlue);
	
	setEqAnim(128 - System.getEqBand(1), eq1);
	setEqAnim(128 - System.getEqBand(1), eq1RGBRed);
	setEqAnim(128 - System.getEqBand(1), eq1RGBGreen);
	setEqAnim(128 - System.getEqBand(1), eq1RGBBlue);
	
	setEqAnim(128 - System.getEqBand(2), eq2);
	setEqAnim(128 - System.getEqBand(2), eq2RGBRed);
	setEqAnim(128 - System.getEqBand(2), eq2RGBGreen);
	setEqAnim(128 - System.getEqBand(2), eq2RGBBlue);
	
	setEqAnim(128 - System.getEqBand(3), eq3);
	setEqAnim(128 - System.getEqBand(3), eq3RGBRed);
	setEqAnim(128 - System.getEqBand(3), eq3RGBGreen);
	setEqAnim(128 - System.getEqBand(3), eq3RGBBlue);
	
	setEqAnim(128 - System.getEqBand(4), eq4);
	setEqAnim(128 - System.getEqBand(4), eq4RGBRed);
	setEqAnim(128 - System.getEqBand(4), eq4RGBGreen);
	setEqAnim(128 - System.getEqBand(4), eq4RGBBlue);
	
	setEqAnim(128 - System.getEqBand(5), eq5);
	setEqAnim(128 - System.getEqBand(5), eq5RGBRed);
	setEqAnim(128 - System.getEqBand(5), eq5RGBGreen);
	setEqAnim(128 - System.getEqBand(5), eq5RGBBlue);
	
	setEqAnim(128 - System.getEqBand(6), eq6);
	setEqAnim(128 - System.getEqBand(6), eq6RGBRed);
	setEqAnim(128 - System.getEqBand(6), eq6RGBGreen);
	setEqAnim(128 - System.getEqBand(6), eq6RGBBlue);
	
	setEqAnim(128 - System.getEqBand(7), eq7);
	setEqAnim(128 - System.getEqBand(7), eq7RGBRed);
	setEqAnim(128 - System.getEqBand(7), eq7RGBGreen);
	setEqAnim(128 - System.getEqBand(7), eq7RGBBlue);
	
	setEqAnim(128 - System.getEqBand(8), eq8);
	setEqAnim(128 - System.getEqBand(8), eq8RGBRed);
	setEqAnim(128 - System.getEqBand(8), eq8RGBGreen);
	setEqAnim(128 - System.getEqBand(8), eq8RGBBlue);
	
	setEqAnim(128 - System.getEqBand(9), eq9);
	setEqAnim(128 - System.getEqBand(9), eq9RGBRed);
	setEqAnim(128 - System.getEqBand(9), eq9RGBGreen);
	setEqAnim(128 - System.getEqBand(9), eq9RGBBlue);
	
	//rgb lot now
	
	
	
	
	if(myattrib_RGB_ENABLE.getData()=="0")
	{	
		EQ_spline_RGB.setXMLParam("COLORBOTTOM", integertostring(EQRGBDefaultRED)+","+integertostring(EQRGBDefaultGREEN)+","+integertostring(EQRGBDefaultBLUE));
		EQ_spline_RGB.setXMLParam("COLORMIDDLE", integertostring(EQRGBDefaultRED)+","+integertostring(EQRGBDefaultGREEN)+","+integertostring(EQRGBDefaultBLUE));
		EQ_spline_RGB.setXMLParam("COLORTOP", integertostring(EQRGBDefaultRED)+","+integertostring(EQRGBDefaultGREEN)+","+integertostring(EQRGBDefaultBLUE));
		balblue.setAlpha(255);

		eqpre.setAlpha(255);
		eq0.setAlpha(255);
		eq1.setAlpha(255);
		eq2.setAlpha(255);
		eq3.setAlpha(255);
		eq4.setAlpha(255);
		eq5.setAlpha(255);
		eq6.setAlpha(255);
		eq7.setAlpha(255);
		eq8.setAlpha(255);
		eq9.setAlpha(255);
		
		pres.setAlpha(255);

		presRGBRed.setAlpha(0);
		presRGBGreen.setAlpha(0);
		presRGBBlue.setAlpha(0);
		
		eqonRGBRed.setAlpha(0);
		eqonRGBGreen.setAlpha(0);
		eqonRGBBlue.setAlpha(0);
		
		EQON.setXMLParam("activeImage", "eq.button.on1");
		BTNAUTO.setXMLParam("activeImage", "eq.button.auto1");
		
		EQAutoRGBRed.setAlpha(0);
		EQAutoRGBGreen.setAlpha(0);
		EQAutoRGBBlue.setAlpha(0);

		
	}
	else
	{
		EQ_spline_RGB.setXMLParam("COLORBOTTOM", myattrib_RGB_REDColor.getData()+","+myattrib_RGB_GREENColor.getData()+","+myattrib_RGB_BLUEColor.getData());
		EQ_spline_RGB.setXMLParam("COLORMIDDLE", myattrib_RGB_REDColor.getData()+","+myattrib_RGB_GREENColor.getData()+","+myattrib_RGB_BLUEColor.getData());
		EQ_spline_RGB.setXMLParam("COLORTOP", myattrib_RGB_REDColor.getData()+","+myattrib_RGB_GREENColor.getData()+","+myattrib_RGB_BLUEColor.getData());
		balblue.setAlpha(0);
		balRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		balRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		balRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		//turn off blue
		eqpre.setAlpha(0);
		eq0.setAlpha(0);
		eq1.setAlpha(0);
		eq2.setAlpha(0);
		eq3.setAlpha(0);
		eq4.setAlpha(0);
		eq5.setAlpha(0);
		eq6.setAlpha(0);
		eq7.setAlpha(0);
		eq8.setAlpha(0);
		eq9.setAlpha(0);
		

		eqpreRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eqpreRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eqpreRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq0RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq0RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq0RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq1RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq1RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq1RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq2RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq2RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq2RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq3RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq3RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq3RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq4RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq4RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq4RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq5RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq5RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq5RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq6RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq6RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq6RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq7RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq7RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq7RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq8RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq8RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq8RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq9RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq9RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq9RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		pres.setAlpha(0);

		presRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		presRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		presRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eqonRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eqonRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eqonRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		EQON.setXMLParam("activeImage", "eq.button.on0");
		
		BTNAUTO.setXMLParam("activeImage", "eq.button.auto0");
		
		EQAutoRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		EQAutoRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		EQAutoRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));		

	}
	
	//check if eq is on/off if we decided to enable/disable rgb
	if(System.getEq()==1)
	{		
		if(myattrib_RGB_ENABLE.getData()=="0")
		{
			eqonRGBRed.setAlpha(EQRGBDefaultRED);
			eqonRGBGreen.setAlpha(EQRGBDefaultGREEN);
			eqonRGBBlue.setAlpha(EQRGBDefaultBLUE);
			EQON.setXMLParam("activeImage", "eq.button.on0");
		}
		else
		{
			eqonRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			eqonRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			eqonRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
			EQON.setXMLParam("activeImage", "eq.button.on0");
		}
		eqonmask.setAlpha(0);
		eqonmasktxt.setAlpha(0);
	}
	else
	{
		eqonRGBRed.setAlpha(0);
		eqonRGBGreen.setAlpha(0);
		eqonRGBBlue.setAlpha(0);
		EQON.setXMLParam("activeImage", "eq.button.on1");
		eqonmask.setAlpha(255);
		eqonmasktxt.setAlpha(255);
	}
	
	//System.messageBox(integertostring(ACTUALBTNAUTO.getCurCfgVal()), "Debug Error", 0, "");
	//System.messageBox(EQAuto_enabled_attrib.getData(), "Debug Error", 0, "");
	
	if(EQAuto_enabled_attrib.getData()=="1")
	{
	
		//check if eq is on/off if we decided to enable/disable rgb
	
		if(myattrib_RGB_ENABLE.getData()=="0")
		{
			EQAutoRGBRed.setAlpha(EQRGBDefaultRED);
			EQAutoRGBGreen.setAlpha(EQRGBDefaultGREEN);
			EQAutoRGBBlue.setAlpha(EQRGBDefaultBLUE);

		}
		else
		{
			EQAutoRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			EQAutoRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			EQAutoRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));

		}
		
		eqautomask.setAlpha(255);
		eqautomasktxt.setAlpha(255);
	}	
	else
	{
		EQAutoRGBRed.setAlpha(0);
		EQAutoRGBGreen.setAlpha(0);
		EQAutoRGBBlue.setAlpha(0);
		eqautomask.setAlpha(255);
		eqautomasktxt.setAlpha(255);
	}
	
	
	EQ_spline_RGB.resize(88, 10, 13, 107);
}

System.onScriptUnloading()
{
	delete EQMap;
}


System.onEqChanged(int newstatus)
{

	if(newstatus==1)
	{	
		if(myattrib_RGB_ENABLE.getData()=="0")
		{
			eqonRGBRed.setAlpha(EQRGBDefaultRED);
			eqonRGBGreen.setAlpha(EQRGBDefaultGREEN);
			eqonRGBBlue.setAlpha(EQRGBDefaultBLUE);
			EQON.setXMLParam("activeImage", "eq.button.on0");
		}
		else
		{
			eqonRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			eqonRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			eqonRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
			EQON.setXMLParam("activeImage", "eq.button.on0");
		}
		eqonmask.setAlpha(0);
		eqonmasktxt.setAlpha(0);
	}
	else
	{
		eqonRGBRed.setAlpha(0);
		eqonRGBGreen.setAlpha(0);
		eqonRGBBlue.setAlpha(0);
		EQON.setXMLParam("activeImage", "eq.button.on1");
		eqonmask.setAlpha(255);
		eqonmasktxt.setAlpha(255);
	}
}


ACTUALBTNAUTO.onToggle(Boolean onoff)
{
	if(onoff)
	{
		EQAuto_enabled_attrib.setData("1");
	}
	else
	{
		EQAuto_enabled_attrib.setData("0");
	}
	
	//if (EQAuto_enabled_attrib.getData() == "0") EQAuto_enabled_attrib.setData("1");
	//else EQAuto_enabled_attrib.setData("0");
}

EQAuto_enabled_attrib.onDataChanged()
{
	if(getData()=="1")
	{
	
		//check if eq is on/off if we decided to enable/disable rgb
		
		if(myattrib_RGB_ENABLE.getData()=="0")
		{
			EQAutoRGBRed.setAlpha(EQRGBDefaultRED);
			EQAutoRGBGreen.setAlpha(EQRGBDefaultGREEN);
			EQAutoRGBBlue.setAlpha(EQRGBDefaultBLUE);

			
		}
		else
		{
			EQAutoRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			EQAutoRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			EQAutoRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));

		}
		
		eqautomask.setAlpha(0);
		eqautomasktxt.setAlpha(0);
	}	
	else
	{
		EQAutoRGBRed.setAlpha(0);
		EQAutoRGBGreen.setAlpha(0);
		EQAutoRGBBlue.setAlpha(0);
		eqautomask.setAlpha(255);
		eqautomasktxt.setAlpha(255);
	}
}





setEqAnim(int eqValue, Layer eqName)
{
	Region r = new Region;
	r.loadFromMap(EQMap, eqValue, 0);
	eqName.setRegion(r);
	delete r;
}

System.onEqPreampChanged(int newValue) {
	setEqAnim(128 - newValue, eqpre);
	setEqAnim(128 - newValue, eqpreRGBRed);
	setEqAnim(128 - newValue, eqpreRGBGreen);
	setEqAnim(128 - newValue, eqpreRGBBlue);
}

System.onEqBandChanged(int band, int newValue) {
	if (band == 0) {
		setEqAnim(128 - newValue, eq0);
		setEqAnim(128 - newValue, eq0RGBRed);
		setEqAnim(128 - newValue, eq0RGBGreen);
		setEqAnim(128 - newValue, eq0RGBBlue);
	} else if (band == 1) {
		setEqAnim(128 - newValue, eq1);
		setEqAnim(128 - newValue, eq1RGBRed);
		setEqAnim(128 - newValue, eq1RGBGreen);
		setEqAnim(128 - newValue, eq1RGBBlue);
	} else if (band == 2) {
		setEqAnim(128 - newValue, eq2);
		setEqAnim(128 - newValue, eq2RGBRed);
		setEqAnim(128 - newValue, eq2RGBGreen);
		setEqAnim(128 - newValue, eq2RGBBlue);
	} else if (band == 3) {
		setEqAnim(128 - newValue, eq3);
		setEqAnim(128 - newValue, eq3RGBRed);
		setEqAnim(128 - newValue, eq3RGBGreen);
		setEqAnim(128 - newValue, eq3RGBBlue);
	} else if (band == 4) {
		setEqAnim(128 - newValue, eq4);
		setEqAnim(128 - newValue, eq4RGBRed);
		setEqAnim(128 - newValue, eq4RGBGreen);
		setEqAnim(128 - newValue, eq4RGBBlue);
	} else if (band == 5) {
		setEqAnim(128 - newValue, eq5);
		setEqAnim(128 - newValue, eq5RGBRed);
		setEqAnim(128 - newValue, eq5RGBGreen);
		setEqAnim(128 - newValue, eq5RGBBlue);
	} else if (band == 6) {
		setEqAnim(128 - newValue, eq6);
		setEqAnim(128 - newValue, eq6RGBRed);
		setEqAnim(128 - newValue, eq6RGBGreen);
		setEqAnim(128 - newValue, eq6RGBBlue);
	} else if (band == 7) {
		setEqAnim(128 - newValue, eq7);
		setEqAnim(128 - newValue, eq7RGBRed);
		setEqAnim(128 - newValue, eq7RGBGreen);
		setEqAnim(128 - newValue, eq7RGBBlue);
	} else if (band == 8) {
		setEqAnim(128 - newValue, eq8);
		setEqAnim(128 - newValue, eq8RGBRed);
		setEqAnim(128 - newValue, eq8RGBGreen);
		setEqAnim(128 - newValue, eq8RGBBlue);
	} else if (band == 9) {
		setEqAnim(128 - newValue, eq9);
		setEqAnim(128 - newValue, eq9RGBRed);
		setEqAnim(128 - newValue, eq9RGBGreen);
		setEqAnim(128 - newValue, eq9RGBBlue);
	}
}


myattrib_RGB_ENABLE.onDataChanged()
{
	if(myattrib_RGB_ENABLE.getData()=="0")
	{	
		EQ_spline_RGB.setXMLParam("COLORBOTTOM", integertostring(EQRGBDefaultRED)+","+integertostring(EQRGBDefaultGREEN)+","+integertostring(EQRGBDefaultBLUE));
		EQ_spline_RGB.setXMLParam("COLORMIDDLE", integertostring(EQRGBDefaultRED)+","+integertostring(EQRGBDefaultGREEN)+","+integertostring(EQRGBDefaultBLUE));
		EQ_spline_RGB.setXMLParam("COLORTOP", integertostring(EQRGBDefaultRED)+","+integertostring(EQRGBDefaultGREEN)+","+integertostring(EQRGBDefaultBLUE));
		balblue.setAlpha(255);
		
		eqpre.setAlpha(255);
		eq0.setAlpha(255);
		eq1.setAlpha(255);
		eq2.setAlpha(255);
		eq3.setAlpha(255);
		eq4.setAlpha(255);
		eq5.setAlpha(255);
		eq6.setAlpha(255);
		eq7.setAlpha(255);
		eq8.setAlpha(255);
		eq9.setAlpha(255);
		
		pres.setAlpha(255);
		
		presRGBRed.setAlpha(0);
		presRGBGreen.setAlpha(0);
		presRGBBlue.setAlpha(0);
		
		eqonRGBRed.setAlpha(0);
		eqonRGBGreen.setAlpha(0);
		eqonRGBBlue.setAlpha(0);
		EQON.setXMLParam("activeImage", "eq.button.on1");
		BTNAUTO.setXMLParam("activeImage", "eq.button.auto1");
		
		EQAutoRGBRed.setAlpha(0);
		EQAutoRGBGreen.setAlpha(0);
		EQAutoRGBBlue.setAlpha(0);


	}
	else
	{
		EQ_spline_RGB.setXMLParam("COLORBOTTOM", myattrib_RGB_REDColor.getData()+","+myattrib_RGB_GREENColor.getData()+","+myattrib_RGB_BLUEColor.getData());
		EQ_spline_RGB.setXMLParam("COLORMIDDLE", myattrib_RGB_REDColor.getData()+","+myattrib_RGB_GREENColor.getData()+","+myattrib_RGB_BLUEColor.getData());
		EQ_spline_RGB.setXMLParam("COLORTOP", myattrib_RGB_REDColor.getData()+","+myattrib_RGB_GREENColor.getData()+","+myattrib_RGB_BLUEColor.getData());
		balblue.setAlpha(0);
		
		//turn off blue
		eqpre.setAlpha(0);
		eq0.setAlpha(0);
		eq1.setAlpha(0);
		eq2.setAlpha(0);
		eq3.setAlpha(0);
		eq4.setAlpha(0);
		eq5.setAlpha(0);
		eq6.setAlpha(0);
		eq7.setAlpha(0);
		eq8.setAlpha(0);
		eq9.setAlpha(0);
		
		balRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		balRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		balRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eqpreRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eqpreRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eqpreRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq0RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq0RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq0RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq1RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq1RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq1RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq2RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq2RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq2RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq3RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq3RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq3RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq4RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq4RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq4RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq5RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq5RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq5RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq6RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq6RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq6RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq7RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq7RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq7RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq8RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq8RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq8RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eq9RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eq9RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eq9RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		pres.setAlpha(0);
		presRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		presRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		presRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		
		eqonRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		eqonRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		eqonRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		EQON.setXMLParam("activeImage", "eq.button.on0");
		
		BTNAUTO.setXMLParam("activeImage", "eq.button.auto0");
		EQAutoRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		EQAutoRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		EQAutoRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));		


	}
	
	
		//check if eq is on/off if we decided to enable/disable rgb
		if(System.getEq()==1)
		{		
			if(myattrib_RGB_ENABLE.getData()=="0")
			{
				eqonRGBRed.setAlpha(EQRGBDefaultRED);
				eqonRGBGreen.setAlpha(EQRGBDefaultGREEN);
				eqonRGBBlue.setAlpha(EQRGBDefaultBLUE);
				EQON.setXMLParam("activeImage", "eq.button.on0");
			}
			else
			{
				eqonRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
				eqonRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
				eqonRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
				EQON.setXMLParam("activeImage", "eq.button.on0");
			}
			eqonmask.setAlpha(0);
			eqonmasktxt.setAlpha(0);
		}
		else
		{
			eqonRGBRed.setAlpha(0);
			eqonRGBGreen.setAlpha(0);
			eqonRGBBlue.setAlpha(0);
			EQON.setXMLParam("activeImage", "eq.button.on1");
			eqonmask.setAlpha(255);
			eqonmasktxt.setAlpha(255);
		}
		
		if(EQAuto_enabled_attrib.getData()=="1")
		{
		
			//check if eq is on/off if we decided to enable/disable rgb
			
			if(myattrib_RGB_ENABLE.getData()=="0")
			{
				EQAutoRGBRed.setAlpha(EQRGBDefaultRED);
				EQAutoRGBGreen.setAlpha(EQRGBDefaultGREEN);
				EQAutoRGBBlue.setAlpha(EQRGBDefaultBLUE);
			}
			else
			{
				EQAutoRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
				EQAutoRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
				EQAutoRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));

			}
			
			eqautomask.setAlpha(0);
			eqautomasktxt.setAlpha(0);
		}	
		else
		{
			EQAutoRGBRed.setAlpha(0);
			EQAutoRGBGreen.setAlpha(0);
			EQAutoRGBBlue.setAlpha(0);
			eqautomask.setAlpha(255);
			eqautomasktxt.setAlpha(255);
		}

	//have to force a refresh as ther is a refresh bug on param change in 5.52
	EQ_spline_RGB.resize(88, 10, 13, 107);
}


eqlay.onSetVisible(Boolean on)
{
	//if(on)
	//{	
		if(myattrib_RGB_ENABLE.getData()=="0")
		{	
			EQ_spline_RGB.setXMLParam("COLORBOTTOM", integertostring(EQRGBDefaultRED)+","+integertostring(EQRGBDefaultGREEN)+","+integertostring(EQRGBDefaultBLUE));
			EQ_spline_RGB.setXMLParam("COLORMIDDLE", integertostring(EQRGBDefaultRED)+","+integertostring(EQRGBDefaultGREEN)+","+integertostring(EQRGBDefaultBLUE));
			EQ_spline_RGB.setXMLParam("COLORTOP", integertostring(EQRGBDefaultRED)+","+integertostring(EQRGBDefaultGREEN)+","+integertostring(EQRGBDefaultBLUE));
			balblue.setAlpha(255);
			
			eqpre.setAlpha(255);
			eq0.setAlpha(255);
			eq1.setAlpha(255);
			eq2.setAlpha(255);
			eq3.setAlpha(255);
			eq4.setAlpha(255);
			eq5.setAlpha(255);
			eq6.setAlpha(255);
			eq7.setAlpha(255);
			eq8.setAlpha(255);
			eq9.setAlpha(255);
			
			pres.setAlpha(255);
			presRGBRed.setAlpha(0);
			presRGBGreen.setAlpha(0);
			presRGBBlue.setAlpha(0);
			
			eqonRGBRed.setAlpha(0);
			eqonRGBGreen.setAlpha(0);
			eqonRGBBlue.setAlpha(0);
			EQON.setXMLParam("activeImage", "eq.button.on1");
			BTNAUTO.setXMLParam("activeImage", "eq.button.auto1");
			
			EQAutoRGBRed.setAlpha(0);
			EQAutoRGBGreen.setAlpha(0);
			EQAutoRGBBlue.setAlpha(0);


		}
		else
		{
			EQ_spline_RGB.setXMLParam("COLORBOTTOM", myattrib_RGB_REDColor.getData()+","+myattrib_RGB_GREENColor.getData()+","+myattrib_RGB_BLUEColor.getData());
			EQ_spline_RGB.setXMLParam("COLORMIDDLE", myattrib_RGB_REDColor.getData()+","+myattrib_RGB_GREENColor.getData()+","+myattrib_RGB_BLUEColor.getData());
			EQ_spline_RGB.setXMLParam("COLORTOP", myattrib_RGB_REDColor.getData()+","+myattrib_RGB_GREENColor.getData()+","+myattrib_RGB_BLUEColor.getData());
			balblue.setAlpha(0);
			
			//turn off blue
			eqpre.setAlpha(0);
			eq0.setAlpha(0);
			eq1.setAlpha(0);
			eq2.setAlpha(0);
			eq3.setAlpha(0);
			eq4.setAlpha(0);
			eq5.setAlpha(0);
			eq6.setAlpha(0);
			eq7.setAlpha(0);
			eq8.setAlpha(0);
			eq9.setAlpha(0);
			
			balRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			balRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			balRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
			
			
			eqpreRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			eqpreRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			eqpreRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
			
			eq0RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			eq0RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			eq0RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
			
			eq1RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			eq1RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			eq1RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
			
			eq2RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			eq2RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			eq2RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
			
			eq3RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			eq3RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			eq3RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
			
			eq4RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			eq4RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			eq4RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
			
			eq5RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			eq5RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			eq5RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
			
			eq6RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			eq6RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			eq6RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
			
			eq7RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			eq7RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			eq7RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
			
			eq8RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			eq8RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			eq8RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
			
			eq9RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			eq9RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			eq9RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
			
			pres.setAlpha(0);
			presRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			presRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			presRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
			
			eqonRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			eqonRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			eqonRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
			EQON.setXMLParam("activeImage", "eq.button.on0");
			
			BTNAUTO.setXMLParam("activeImage", "eq.button.auto0");

			EQAutoRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
			EQAutoRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			EQAutoRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));		
			
			
		}

		//check if eq is on/off if we decided to enable/disable rgb
		if(System.getEq()==1)
		{		
			if(myattrib_RGB_ENABLE.getData()=="0")
			{
				eqonRGBRed.setAlpha(EQRGBDefaultRED);
				eqonRGBGreen.setAlpha(EQRGBDefaultGREEN);
				eqonRGBBlue.setAlpha(EQRGBDefaultBLUE);
				EQON.setXMLParam("activeImage", "eq.button.on0");
			}
			else
			{
				eqonRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
				eqonRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
				eqonRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
				EQON.setXMLParam("activeImage", "eq.button.on0");
			}
			eqonmask.setAlpha(0);
			eqonmasktxt.setAlpha(0);
		}
		else
		{
			eqonRGBRed.setAlpha(0);
			eqonRGBGreen.setAlpha(0);
			eqonRGBBlue.setAlpha(0);
			EQON.setXMLParam("activeImage", "eq.button.on1");
			eqonmask.setAlpha(255);
			eqonmasktxt.setAlpha(255);
		}
		
		if(EQAuto_enabled_attrib.getData()=="1")
		{
		
			//check if eq is on/off if we decided to enable/disable rgb
			
				if(myattrib_RGB_ENABLE.getData()=="0")
				{
					EQAutoRGBRed.setAlpha(EQRGBDefaultRED);
					EQAutoRGBGreen.setAlpha(EQRGBDefaultGREEN);
					EQAutoRGBBlue.setAlpha(EQRGBDefaultBLUE);
					
				}
				else
				{
					EQAutoRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
					EQAutoRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
					EQAutoRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
					
				}
				
				eqautomask.setAlpha(0);
				eqautomasktxt.setAlpha(0);
		}	
		else
		{
			EQAutoRGBRed.setAlpha(0);
			EQAutoRGBGreen.setAlpha(0);
			EQAutoRGBBlue.setAlpha(0);
			eqautomask.setAlpha(255);
			eqautomasktxt.setAlpha(255);
		}
		

	//have to force a refresh as ther is a refresh bug on param change in 5.52
	EQ_spline_RGB.resize(88, 10, 13, 107);
}


myattrib_RGB_REDColor.onDataChanged()
{
	EQ_spline_RGB.setXMLParam("COLORBOTTOM", getData()+","+myattrib_RGB_GREENColor.getData()+","+myattrib_RGB_BLUEColor.getData());
	EQ_spline_RGB.setXMLParam("COLORMIDDLE", getData()+","+myattrib_RGB_GREENColor.getData()+","+myattrib_RGB_BLUEColor.getData());
	EQ_spline_RGB.setXMLParam("COLORTOP", getData()+","+myattrib_RGB_GREENColor.getData()+","+myattrib_RGB_BLUEColor.getData());
	
	eqpreRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		
	balRGBRed.setAlpha(stringtointeger(getData()));
	eq0RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
	eq1RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
	eq2RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
	eq3RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
	eq4RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
	eq5RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
	eq6RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
	eq7RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
	eq8RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
	eq9RGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
	
	presRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
	eqonRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
	EQAutoRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));


		
	//have to force a refresh as ther is a refresh bug on param change in 5.52
	EQ_spline_RGB.resize(88, 10, 13, 107);
}

myattrib_RGB_GREENColor.onDataChanged()
{
	EQ_spline_RGB.setXMLParam("COLORBOTTOM", myattrib_RGB_REDColor.getData()+","+getData()+","+myattrib_RGB_BLUEColor.getData());
	EQ_spline_RGB.setXMLParam("COLORMIDDLE", myattrib_RGB_REDColor.getData()+","+getData()+","+myattrib_RGB_BLUEColor.getData());
	EQ_spline_RGB.setXMLParam("COLORTOP", myattrib_RGB_REDColor.getData()+","+getData()+","+myattrib_RGB_BLUEColor.getData());

	
	eqpreRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
			
	balRGBGreen.setAlpha(stringtointeger(getData()));
	eq0RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
	eq1RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
	eq2RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
	eq3RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
	eq4RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
	eq5RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
	eq6RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
	eq7RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
	eq8RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
	eq9RGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		
	presRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
	eqonRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
	EQAutoRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));


	
	//have to force a refresh as ther is a refresh bug on param change in 5.52
	EQ_spline_RGB.resize(88, 10, 13, 107);
}

myattrib_RGB_BLUEColor.onDataChanged()
{
	EQ_spline_RGB.setXMLParam("COLORBOTTOM", myattrib_RGB_REDColor.getData()+","+myattrib_RGB_GREENColor.getData()+","+getData());
	EQ_spline_RGB.setXMLParam("COLORMIDDLE", myattrib_RGB_REDColor.getData()+","+myattrib_RGB_GREENColor.getData()+","+getData());
	EQ_spline_RGB.setXMLParam("COLORTOP", myattrib_RGB_REDColor.getData()+","+myattrib_RGB_GREENColor.getData()+","+getData());

	eqpreRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
	
	balRGBBlue.setAlpha(stringtointeger(getData()));
	eq0RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
	eq1RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
	eq2RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
	eq3RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
	eq4RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
	eq5RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
	eq6RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
	eq7RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
	eq8RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
	eq9RGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
	
	presRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
	eqonRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
	EQAutoRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));		


	
	//have to force a refresh as ther is a refresh bug on param change in 5.52
	EQ_spline_RGB.resize(88, 10, 13, 107);
}
