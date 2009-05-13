/*********************************************************************
SLoB for Walpha 2007
	original idea:- Quadhelix, leechbite
	http://www.skinconsortium.com
	
	//get current theme
	string CT = strlower(getPublicString("Color Themes/" + getSkinName(), "error"));

	this script is still wip, a concept if you like, if you use the script or idea please give credit
	
	  ,,,      
	(o o)     
 -ooO--(_)--Ooo-
 
*********************************************************************/

#include <lib/std.mi>
#include "attribs.m"

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

System.onScriptLoaded() 
{
	initattribs();
	
	cccont = getContainer("colorchanger");
	contEqualizer = getContainer("equalizer");
	cclay = cccont.getLayout("changer");
	MainPlayer = getContainer("main");
	MainLayout = MainPlayer.getLayout("full");
	
	
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
	
	
/*
	mapred = new map;
	mapred.loadMap("color.map.red");

	mapgreen = new map;
	mapgreen.loadMap("color.map.green");

	mapblue = new map;
	mapblue.loadMap("color.map.blue");
*/

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


}

System.onScriptUnloading() {
  delete mapred;
  delete mapgreen;
  delete mapblue;
}
/*
cclay.onEndMove()
{
	int w = cclay.getWidth();
	int h = cclay.getHeight();
	
	if(w < 258 || w > 258 || h < 380 || h > 380)
	{
		cclay.setTargetW(258);
		cclay.setTargetH(380);
		cclay.setTargetSpeed(0);
		cclay.gotoTarget();
		//cclay.resize(cclay.getLeft(), cclay.getTop(), 258, 380);
	}
}
*/

//cclay.onUserResize(int x, int y, int w, int h)
//{	
//resize stuff seems borked in 1.3 with dta workaround
//	if(w < 258 || w > 258 || h < 380 || h > 380)
//	{
		/*cclay.setTargetW(258);
		cclay.setTargetH(380);
		cclay.setTargetSpeed(0);
		cclay.gotoTarget();*/
//		cclay.resize(cclay.getLeft(), cclay.getTop(), 258, 380);
//	}
//}


/*
LayML.onSetVisible(Boolean on)
{
	if(on)
	{		
		LayML.resize(LayML.getLeft(), LayML.getTop(), LayML.getWidth(), LayML.getHeight());		
	}
}

LayVid.onSetVisible(Boolean on)
{
	if(on)
	{		
		LayVid.resize(LayVid.getLeft(), LayVid.getTop(), LayVid.getWidth(), LayVid.getHeight());		
	}
}

LayAVS.onSetVisible(Boolean on)
{
	if(on)
	{		
		LayAVS.resize(LayAVS.getLeft(), LayAVS.getTop(), LayAVS.getWidth(), LayAVS.getHeight());		
	}
}
*/

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


colorpalette.onLeftButtonDown(int x, int y) {
  colormousedown = 1;
}

colorpalette.onLeftButtonUp(int x, int y) {
  colormousedown = 0;
}

colorpalette.onMouseMove(int x, int y) {
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

	//ccRed.setAlpha(newpos);
	
	BGRed.setAlpha(newpos);
	CompactBodyRed.setAlpha(newpos);
	MiniBodyRed.setAlpha(newpos);
	VertMiniBodyRed.setAlpha(newpos);
	StickBodyRed.setAlpha(newpos);
	NarrowBodyRed.setAlpha(newpos);
	EQBGRed.setAlpha(newpos);
	ChangerRed.setAlpha(newpos);
	
	//stdfrm
	myattrib_stdfrmBGREDColor.setData(integertostring(newpos));
	
	setPrivateInt(getSkinName(),"redbg", redslider.getPosition());

	trv.setText(integertostring(newpos));
	setPrivateInt(getSkinName(),"red", redslider.getPosition());
}

greenslider.onSetPosition(int newpos) 
{
	//ccGreen.setAlpha(newpos);
	BGGreen.setAlpha(newpos);
	CompactBodyGreen.setAlpha(newpos);
	MiniBodyGreen.setAlpha(newpos);
	VertMiniBodyGreen.setAlpha(newpos);
	StickBodyGreen.setAlpha(newpos);
	NarrowBodyGreen.setAlpha(newpos);
	EQBGGreen.setAlpha(newpos);
	ChangerGreen.setAlpha(newpos);

	//stdfrm
	myattrib_stdfrmBGGREENColor.setData(integertostring(newpos));
	
	setPrivateInt(getSkinName(),"greenbg", greenslider.getPosition());
	
	tgv.setText(integertostring(newpos));	
	setPrivateInt(getSkinName(),"green", greenslider.getPosition());
}

blueslider.onSetPosition(int newpos) 
{
	//ccBlue.setAlpha(newpos);
	
	BGBlue.setAlpha(newpos);
	CompactBodyBlue.setAlpha(newpos);
	MiniBodyBlue.setAlpha(newpos);
	VertMiniBodyBlue.setAlpha(newpos);
	StickBodyBlue.setAlpha(newpos);
	NarrowBodyBlue.setAlpha(newpos);
	EQBGBlue.setAlpha(newpos);
	ChangerBlue.setAlpha(newpos);

	//stdfrm
	myattrib_stdfrmBGBLUEColor.setData(integertostring(newpos));
	
	setPrivateInt(getSkinName(),"bluebg", blueslider.getPosition());

	tbv.setText(integertostring(newpos));
	setPrivateInt(getSkinName(),"blue", blueslider.getPosition());
}
