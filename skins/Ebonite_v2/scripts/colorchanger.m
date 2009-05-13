/*********************************************************************
SLoB for Ebonite 2008
	original idea:- Quadhelix, leechbite
	http://www.skinconsortium.com
	
	Now incorporates Wasabi Maki Colour Theming via Gammagroups - Note:body still uses 3 layer rgb for realtime speed as maki gammagroup setting is not quick enough to do realtime change while dragging rgb picker colours
	
	//get current theme
	string CT = strlower(getPublicString("Color Themes/" + getSkinName(), "error"));

	this script is still wip, a concept if you like, if you use the script or idea please give credit
	
	  ,,,      
	(o o)     
 -ooO--(_)--Ooo-
 
*********************************************************************/

#include <lib/std.mi>
#include <lib/colormgr.mi>
#include "../scripts/attribs/init_rgb.m"


//#define DEBUG
#ifdef DEBUG


Function debug(String debugStr);
debug(String debugStr) {
	system.debugstring("Debug Message:" + debugStr, 0); //debug console
	
	//System.messageBox(debugStr, "Debug Error", 0, "");
}
#endif


// **** global variables *****

global Container cccont, MainPlayer, contEqualizer; //, ContML, ContVid, ContAVS;
global Layout cclay, MainLayout, LayML, LayVid, LayAVS, MiniLayout, StickLayout, VertMiniLayout, CompactLayout, NarrowLayout, EQLayout;

global slider redslider, greenslider, blueslider, textSlider;
global layer colorpalette;
global map mapred, mapgreen, mapblue;
global boolean colormousedown;
global text trv, tgv, tbv;

global Layer BGRed, BGGreen, BGBlue;

global layer MiniBodyRed, MiniBodyGreen, MiniBodyBlue;
global layer CompactBodyRed, CompactBodyGreen, CompactBodyBlue;
global layer VertMiniBodyRed, VertMiniBodyGreen, VertMiniBodyBlue;
global layer StickBodyRed, StickBodyGreen, StickBodyBlue;
global layer VertShadeBodyRed, VertShadeBodyGreen, VertShadeBodyBlue;
global layer NarrowBodyRed, NarrowBodyGreen, NarrowBodyBlue;
global layer EQBGRed, EQBGGreen, EQBGBlue;
global layer ccBlue, ccGreen, ccRed;
global layer ChangerRed, ChangerGreen, ChangerBlue;


//new WA RGB MAKI STUFF
Function adjustrgb(int gr, int gg, int gb);
Function RGBtoGamma();
Function adjust(int newval);

Global GammaSet cur_set;
Global GammaGroup gen_grp;
Global GammaGroup lcdtext_grp, lcd_grp;
Global ColorMgr myColMgr;
Global Boolean mychange;
Global int iGammaRed, iGammaGreen, iGammaBlue;
Global checkbox cbBody, cbOverlay, cbLCD, cbText;
Global int sv_LCDTextRed, sv_LCDTextGreen, sv_LCDTextBlue, sv_LCDRed, sv_LCDGreen, sv_LCDBlue, sv_OverlayRed, sv_OverlayGreen, sv_OverlayBlue;
Global Slider b_adjust;
Global Boolean mychange;


System.onScriptLoaded() 
{
	initAttribs_RGB();
	
	//wargbmaki
	myColMgr = new ColorMgr;
	
	cccont = getContainer("colorchanger");
	contEqualizer = getContainer("equalizer");
	cclay = cccont.getLayout("changer");
	MainPlayer = getContainer("main");
	MainLayout = MainPlayer.getLayout("full");
	
	b_adjust = cclay.findObject("brightness.adjust");
	b_adjust.setPosition(0);
	
	
	//cclay.setRedrawOnResize(1);
	//cclay.resize(cclay.getLeft(), cclay.getTop(), 258, 380);
			
	MiniLayout = MainPlayer.getLayout("mini");
	VertMiniLayout = MainPlayer.getLayout("minivert");
	CompactLayout = MainPlayer.getLayout("compact");
	StickLayout = MainPlayer.getLayout("stick");
	NarrowLayout = MainPlayer.getLayout("narrow");
	EQLayout = contEqualizer.getLayout("normal");
	
/*	
	
	
	//fix crap refresh on top corner of these components
	ContML = getContainer("MLibrary");
	LayML = ContML.getLayout("normal");
	
	ContVid = getContainer("Video");
	LayVid = ContVid.getLayout("normal");

	ContAVS = getContainer("AVS");
	LayAVS = ContAVS.getLayout("normal");
*/

	redslider = cclay.findObject("red.slider");
	greenslider = cclay.findObject("green.slider");
	blueslider = cclay.findObject("blue.slider");
	colorpalette = cclay.findObject("color.palette");


	cbBody = cclay.findObject("checkbox.wargbbody");
	cbOverlay = cclay.findObject("checkbox.wargboverlay");
	cbLCD = cclay.findObject("checkbox.wargblcd");
	cbText = cclay.findObject("checkbox.wargbtext");

	//ccBlue = cclay.findObject("colorchangerblue"); 
	//ccGreen = cclay.findObject("colorchangergreen");
	//ccRed = cclay.findObject("colorchangerred");

	BGRed = MainLayout.findObject("player.background.red");
	BGGreen = MainLayout.findObject("player.background.green");
	BGBlue = MainLayout.findObject("player.background.blue");

	CompactBodyRed = CompactLayout.findObject("player.background.compact.red");
	CompactBodyGreen = CompactLayout.findObject("player.background.compact.green");
	CompactBodyBlue = CompactLayout.findObject("player.background.compact.blue");
	
	MiniBodyRed = MiniLayout.findObject("player.background.mini.red");
	MiniBodyGreen = MiniLayout.findObject("player.background.mini.green");
	MiniBodyBlue = MiniLayout.findObject("player.background.mini.blue");
	
	VertMiniBodyRed = VertMiniLayout.findObject("player.background.mini.vert.red");
	VertMiniBodyGreen = VertMiniLayout.findObject("player.background.mini.vert.green");
	VertMiniBodyBlue = VertMiniLayout.findObject("player.background.mini.vert.blue");
		
	StickBodyRed = StickLayout.findObject("player.background.stick.red");
	StickBodyGreen = StickLayout.findObject("player.background.stick.green");
	StickBodyBlue = StickLayout.findObject("player.background.stick.blue");
	
	
	NarrowBodyRed = NarrowLayout.findObject("player.background.narrow.red");
	NarrowBodyGreen = NarrowLayout.findObject("player.background.narrow.green");
	NarrowBodyBlue = NarrowLayout.findObject("player.background.narrow.blue");
	
	EQBGRed = EQLayout.findObject("player.background.eq.red");
	EQBGGreen = EQLayout.findObject("player.background.eq.green");
	EQBGBlue = EQLayout.findObject("player.background.eq.blue");
	
	trv = cclay.findObject("text.red");
	tgv = cclay.findObject("text.green");
	tbv = cclay.findObject("text.blue");
	
	ChangerRed = cclay.findObject("player.background.changer.red");
	ChangerGreen = cclay.findObject("player.background.changer.green");
	ChangerBlue = cclay.findObject("player.background.changer.blue");

	//set default colour on first startup
	redslider.setPosition(getPrivateInt(getSkinName(),"red", 0));
	greenslider.setPosition(getPrivateInt(getSkinName(),"green", 0));
	blueslider.setPosition(getPrivateInt(getSkinName(),"blue", 0));
	b_adjust.setPosition(getPrivateInt(getSkinName(),"brightness", 0));
	
	//re-enable checkboxes state
	int icheckbody = getPrivateInt(getSkinName(),"chkBody", stringtointeger(myattrib_stdfrmBGEnabled.getData()));
	int icheckoverlay = getPrivateInt(getSkinName(),"chkOverlay", stringtointeger(myattrib_stdfrmBGOverlayEnabled.getData()));
	int ichecklcd = getPrivateInt(getSkinName(),"chkLCD", stringtointeger(myattrib_stdfrmBGLCDEnabled.getData()));
	int ichecktext = getPrivateInt(getSkinName(),"chkText", stringtointeger(myattrib_stdfrmBGLCDTextEnabled.getData()));
	
	if(ichecktext == 1) cbText.setChecked(1);
	if(ichecklcd == 1) cbLCD.setChecked(1);
	if(icheckoverlay == 1) cbOverlay.setChecked(1);
	if(icheckbody == 1) cbBody.setChecked(1);
	
	colormousedown = 0;
	
	//set all the colours for the various sections based on saved colours, wow wot a list :)
	//BG
	BGRed.setAlpha(getPrivateInt(getSkinName(),"redbg", 0));
	BGGreen.setAlpha(getPrivateInt(getSkinName(),"greenbg", 0));
	BGBlue.setAlpha(getPrivateInt(getSkinName(),"bluebg", 0));
	
	CompactBodyRed.setAlpha(getPrivateInt(getSkinName(),"redbg", 0));
	CompactBodyGreen.setAlpha(getPrivateInt(getSkinName(),"greenbg", 0));
	CompactBodyBlue.setAlpha(getPrivateInt(getSkinName(),"bluebg", 0));
	
	MiniBodyRed.setAlpha(getPrivateInt(getSkinName(),"redbg", 0));
	MiniBodyGreen.setAlpha(getPrivateInt(getSkinName(),"greenbg", 0));
	MiniBodyBlue.setAlpha(getPrivateInt(getSkinName(),"bluebg", 0));

	VertMiniBodyRed.setAlpha(getPrivateInt(getSkinName(),"redbg", 0));
	VertMiniBodyGreen.setAlpha(getPrivateInt(getSkinName(),"greenbg", 0));
	VertMiniBodyBlue.setAlpha(getPrivateInt(getSkinName(),"bluebg", 0));

	StickBodyRed.setAlpha(getPrivateInt(getSkinName(),"redbg", 0));
	StickBodyGreen.setAlpha(getPrivateInt(getSkinName(),"greenbg", 0));
	StickBodyBlue.setAlpha(getPrivateInt(getSkinName(),"bluebg", 0));		

	NarrowBodyRed.setAlpha(getPrivateInt(getSkinName(),"redbg", 0));
	NarrowBodyGreen.setAlpha(getPrivateInt(getSkinName(),"greenbg", 0));
	NarrowBodyBlue.setAlpha(getPrivateInt(getSkinName(),"bluebg", 0));
	
	EQBGRed.setAlpha(getPrivateInt(getSkinName(),"redbg", 0));
	EQBGGreen.setAlpha(getPrivateInt(getSkinName(),"greenbg", 0));
	EQBGBlue.setAlpha(getPrivateInt(getSkinName(),"bluebg", 0));

	ChangerRed.setAlpha(getPrivateInt(getSkinName(),"redbg", 0));
	ChangerGreen.setAlpha(getPrivateInt(getSkinName(),"greenbg", 0));
	ChangerBlue.setAlpha(getPrivateInt(getSkinName(),"bluebg", 0));


	sv_OverlayRed = getPrivateInt(getSkinName(),"rgbOverlay_red", 0);
	sv_OverlayGreen = getPrivateInt(getSkinName(),"rgbOverlay_green", 0);
	sv_OverlayBlue = getPrivateInt(getSkinName(),"rgbOverlay_blue", 0);
	
	sv_LCDRed = getPrivateInt(getSkinName(),"rgbLCD_red", 0);
	sv_LCDGreen = getPrivateInt(getSkinName(),"rgbLCD_green", 0);
	sv_LCDBlue = getPrivateInt(getSkinName(),"rgbLCD_blue", 0);
	
	sv_LCDTextRed = getPrivateInt(getSkinName(),"rgbLCDText_red", 0);
	sv_LCDTextGreen = getPrivateInt(getSkinName(),"rgbLCDText_green", 0);
	sv_LCDTextBlue = getPrivateInt(getSkinName(),"rgbLCDText_blue", 0);
	
}

System.onScriptUnloading() {
	delete mapred;
	delete mapgreen;
	delete mapblue;

	setPrivateInt(getSkinName(),"chkBody", stringtointeger(myattrib_stdfrmBGEnabled.getData()));
	setPrivateInt(getSkinName(),"chkOverlay", stringtointeger(myattrib_stdfrmBGOverlayEnabled.getData()));
	setPrivateInt(getSkinName(),"chkLCD", stringtointeger(myattrib_stdfrmBGLCDEnabled.getData()));
	setPrivateInt(getSkinName(),"chkText", stringtointeger(myattrib_stdfrmBGLCDTextEnabled.getData()));
	
	setPrivateInt(getSkinName(),"rgbOverlay_red", sv_OverlayRed);
	setPrivateInt(getSkinName(),"rgbOverlay_green", sv_OverlayGreen);
	setPrivateInt(getSkinName(),"rgbOverlay_blue", sv_OverlayBlue);
	
	setPrivateInt(getSkinName(),"rgbLCD_red", sv_LCDRed);
	setPrivateInt(getSkinName(),"rgbLCD_green", sv_LCDGreen);
	setPrivateInt(getSkinName(),"rgbLCD_blue", sv_LCDBlue);
	
	setPrivateInt(getSkinName(),"rgbLCDText_red", sv_LCDTextRed);
	setPrivateInt(getSkinName(),"rgbLCDText_green", sv_LCDTextGreen);
	setPrivateInt(getSkinName(),"rgbLCDText_blue", sv_LCDTextBlue);

	setPrivateInt(getSkinName(),"brightness", b_adjust.getPosition());

}

myColMgr.onLoaded()
{		
	
	cur_set = ColorMgr.getGammaSet("default");
	//overlay_grp = cur_set.enumGammaGroup(1); //getGammaGroup("overlay");
	lcdtext_grp = cur_set.enumGammaGroup(3); //getGammaGroup("lcdstuff");
	lcd_grp = cur_set.enumGammaGroup(2); //getGammaGroup("lcd");
	
	gen_grp = cur_set.enumGammaGroup(-1);
	
	//SET COLOURS ON LOAD
	//body already saved with prior work
	
	//overlay_grp.setBlue(sv_OverlayBlue);
	//overlay_grp.setRed(sv_OverlayRed);
	//overlay_grp.setGreen(sv_OverlayGreen);
	
	lcd_grp.setBlue(sv_LCDBlue);
	lcd_grp.setRed(sv_LCDRed);
	lcd_grp.setGreen(sv_LCDGreen);

	lcdtext_grp.setBlue(sv_LCDtextBlue);
	lcdtext_grp.setRed(sv_LCDTextRed);
	lcdtext_grp.setGreen(sv_LCDTextGreen);
	
	cur_set.apply();

	adjust(b_adjust.getPosition());
	
}


adjust(int newval)
{
	if (gen_grp!=NULL && cur_set!=NULL)
	{	
		gen_grp.setBlue(newval);
		gen_grp.setRed(newval);
		gen_grp.setGreen(newval);
		cur_set.apply();
	}
}

b_adjust.onSetFinalPosition(int pos)
{
	adjust(pos);
}

//************************************************
//* rgbtogamma
//************************************************
			
RGBtoGamma()
{				
	iGammaRed = ((stringtointeger(myattrib_stdfrmBGREDColor.getData()) - 128) * 32);
	iGammaGreen = ((stringtointeger(myattrib_stdfrmBGGREENColor.getData()) - 128) * 32);
	iGammaBlue = ((stringtointeger(myattrib_stdfrmBGBLUEColor.getData()) - 128) * 32);
				
	adjustrgb(iGammaRed, iGammaGreen, iGammaBlue);	
}

cbBody.onToggle(int newstate)
{
	if(newstate== 1)	
	{
		myattrib_stdfrmBGEnabled.setData("1");
	}
	else
	{
		myattrib_stdfrmBGEnabled.setData("0");
	}
}

cbOverlay.onToggle(int newstate)
{
	if(newstate== 1)	
	{
		myattrib_stdfrmBGOverlayEnabled.setData("1");
	}
	else
	{
		myattrib_stdfrmBGOverlayEnabled.setData("0");
	}
}

cbLCD.onToggle(int newstate)
{
	if(newstate== 1)	
	{
		myattrib_stdfrmBGLCDEnabled.setData("1");
	}
	else
	{
		myattrib_stdfrmBGLCDEnabled.setData("0");
	}
}

cbText.onToggle(int newstate)
{
	if(newstate== 1)	
	{
		myattrib_stdfrmBGLCDTextEnabled.setData("1");
	}
	else
	{
		myattrib_stdfrmBGLCDTextEnabled.setData("0");
	}
}

adjustrgb(int gr, int gg, int gb)
{
		
		//for when overlays are implemented
		if(cbOverlay.isChecked() == 1)
		{
		/*
			overlay_grp.setBlue(gb);
			overlay_grp.setRed(gr);
			overlay_grp.setGreen(gg);
			cur_set.apply();
			*/
			setPrivateInt(getSkinName(),"rgbOverlay_red", gr);
			setPrivateInt(getSkinName(),"rgbOverlay_green", gg);
			setPrivateInt(getSkinName(),"rgbOverlay_blue", gb);
			sv_OverlayRed = gr;
			sv_OverlayGreen = gg;
			sv_OverlayBlue = gb;			
		}
		
		if(cbText.isChecked() == 1)
		{
			lcdtext_grp.setBlue(gb);
			lcdtext_grp.setRed(gr);
			lcdtext_grp.setGreen(gg);
			cur_set.apply();
			
			setPrivateInt(getSkinName(),"rgbLCDText_red", gr);
			setPrivateInt(getSkinName(),"rgbLCDText_green", gg);
			setPrivateInt(getSkinName(),"rgbLCDText_blue", gb);
			sv_LCDTextRed = gr;
			sv_LCDTextGreen = gg;
			sv_LCDTextBlue = gb;
			
		}
		
		if(cbLCD.isChecked() == 1)
		{
			lcd_grp.setBlue(gb);
			lcd_grp.setRed(gr);
			lcd_grp.setGreen(gg);
			cur_set.apply();
			
			setPrivateInt(getSkinName(),"rgbLCD_red", gr);
			setPrivateInt(getSkinName(),"rgbLCD_green", gg);
			setPrivateInt(getSkinName(),"rgbLCD_blue", gb);
			sv_LCDRed = gr;
			sv_LCDGreen = gg;
			sv_LCDBlue = gb;
		}
}


//reduce mem, only use as necessary
cclay.onSetVisible(Boolean on)
{
	if(on)
	{		
		//cclay.resize(cclay.getLeft(), cclay.getTop(), 258, 380);
		mapred = new map;
		mapred.loadMap("color.map.red");

		mapgreen = new map;
		mapgreen.loadMap("color.map.green");

		mapblue = new map;
		mapblue.loadMap("color.map.blue");	
	}
	else
	{
		delete mapred;
		delete mapgreen;
		delete mapblue;		
	}
	
}


colorpalette.onLeftButtonDown(int x, int y)
{
	colormousedown = 1;
}

colorpalette.onLeftButtonUp(int x, int y)
{
	colormousedown = 0;
	
	//catch if RGB PICKER only used, this is not triggered or triggers anything else
	RGBtoGamma();
}

colorpalette.onMouseMove(int x, int y)
{
	if (!colormousedown) return;

	int rx = x - getLeft();
	int ry = y - getTop();

	if ((rx<0) || (ry<0)) return;
	if ( (rx > getWidth()) || (ry > getHeight())) return;

	redslider.setPosition(mapred.getValue(rx, ry));
	greenslider.setPosition(mapgreen.getValue(rx, ry));
	blueslider.setPosition(mapblue.getValue(rx, ry));
}

//debug(integertostring(newpos));

redslider.onSetPosition(int newpos) {

	
	if(cbBody.isChecked() == 1)
	{
		BGRed.setAlpha(newpos);
		CompactBodyRed.setAlpha(newpos);
		MiniBodyRed.setAlpha(newpos);
		VertMiniBodyRed.setAlpha(newpos);
		StickBodyRed.setAlpha(newpos);
		NarrowBodyRed.setAlpha(newpos);
		EQBGRed.setAlpha(newpos);
		ChangerRed.setAlpha(newpos);
		
	}
	
	//stdfrm
	myattrib_stdfrmBGREDColor.setData(integertostring(newpos));
		
	setPrivateInt(getSkinName(),"redbg", redslider.getPosition());

	trv.setText(integertostring(newpos));
	
	setPrivateInt(getSkinName(),"red", redslider.getPosition());	
}

redslider.onSetFinalPosition(int pos)
{
	//catch if slider only used, this is not triggered by anything else other than sliding the slider
	RGBtoGamma();
}

greenslider.onSetPosition(int newpos) 
{
	
	if(cbBody.isChecked() == 1)
	{
		BGGreen.setAlpha(newpos);
		CompactBodyGreen.setAlpha(newpos);
		MiniBodyGreen.setAlpha(newpos);
		VertMiniBodyGreen.setAlpha(newpos);
		StickBodyGreen.setAlpha(newpos);
		NarrowBodyGreen.setAlpha(newpos);
		EQBGGreen.setAlpha(newpos);
		ChangerGreen.setAlpha(newpos);
		
	}
	
	//stdfrm
	myattrib_stdfrmBGGREENColor.setData(integertostring(newpos));
		
	setPrivateInt(getSkinName(),"greenbg", greenslider.getPosition());
	
	tgv.setText(integertostring(newpos));

	setPrivateInt(getSkinName(),"green", greenslider.getPosition());
}

greenslider.onSetFinalPosition(int pos)
{
	//catch if slider only used, this is not triggered by anything else other than sliding the slider
	RGBtoGamma();
}


blueslider.onSetPosition(int newpos) 
{
	
	if(cbBody.isChecked() == 1)
	{
		BGBlue.setAlpha(newpos);
		CompactBodyBlue.setAlpha(newpos);
		MiniBodyBlue.setAlpha(newpos);
		VertMiniBodyBlue.setAlpha(newpos);
		StickBodyBlue.setAlpha(newpos);
		NarrowBodyBlue.setAlpha(newpos);
		EQBGBlue.setAlpha(newpos);
		ChangerBlue.setAlpha(newpos);
	}
	
	//stdfrm
	myattrib_stdfrmBGBLUEColor.setData(integertostring(newpos));
		
	setPrivateInt(getSkinName(),"bluebg", blueslider.getPosition());

	tbv.setText(integertostring(newpos));
	
	setPrivateInt(getSkinName(),"blue", blueslider.getPosition());	
}

blueslider.onSetFinalPosition(int pos)
{
	//catch if slider only used, this is not triggered by anything else other than sliding the slider
	RGBtoGamma();
}