#include </lib/std.mi>
#include </lib/config.mi>
#include </lib/fileio.mi>

#define WINDOW_ITEMS "{6559CA61-7EB2-4415-A8A9-A2AEEF762B7F}"
#define OPTIONS_MENU "{1828D28F-78DD-4647-8532-EBA504B8FC04}"
#define MY_OPT_MENU "{3448EFC7-D134-4F2B-BFA6-B8FC5AB48089}"

// songticker config page
#define CUSTOM_PAGE_SONGTICKER "{7061FDE0-0E12-11D8-BB41-0050DA442EF3}"

// LCD content page.
#define CUSTOM_PAGE_LCD_CONTENT_TRANSLATED "{349A0016-0950-11DE-856A-729855D89593}"

/********************************************************************************************
Globals, the variables, that are used in several independent functions and can't be forwarded 
or store objects, that trigger functions
********************************************************************************************/

// MyChange is used by several functions to indicate, the changes are by the script
Global int MyChange;

//Declare vis animated layers
Global AnimatedLayer lyrVis1;
Global AnimatedLayer lyrVis2;
Global AnimatedLayer lyrVis3;
Global AnimatedLayer lyrVis4;
Global AnimatedLayer lyrVis5;
Global AnimatedLayer lyrVis6;
Global AnimatedLayer lyrVis7;
Global AnimatedLayer lyrVis8;
Global AnimatedLayer lyrVis9;
Global AnimatedLayer lyrVis10;
Global AnimatedLayer lyrVis11;
Global AnimatedLayer lyrVis12;
Global AnimatedLayer lyrVis13;
Global AnimatedLayer lyrVis14;
Global AnimatedLayer lyrVis15;
Global AnimatedLayer lyrVis16;
Global AnimatedLayer lyrVis17;
Global AnimatedLayer lyrVis18;
Global AnimatedLayer lyrVis19;
Global AnimatedLayer lyrVis20;
Global AnimatedLayer lyrVis21;

// Advanced Visualization Main Mode
// Type 1
Global Layer lyrAdvVis1_1, lyrAdvVis1_2, lyrAdvVis1_3, lyrAdvVis1_4, lyrAdvVis1_5, lyrAdvVis1_6;

Global GuiObject Ticker;

Global List LCDattrNames;

Global List SpectrumList;
Global List WaveFormList;

Global BitList WorkingVis; //This parameter shows vis, that works at the moment

Global Group grpCover;
Global Group grpEq;
Global Group grpLCD;
Global Group grpMNLCD1;
Global Group grpMNLCD2;

Global Layer btnCoverButton;
Global Button btnCoverStar1, btnCoverStar2, btnCoverStar3, btnCoverStar4, btnCoverStar5;

Global Layer lyrEQButton;

Global Button btnMNCrossfade, btnMNShuffle, btnMNRepeat;

Global Button btnMNcontent1, btnMNcontent2, btnMNcontent3; // Buttons to Switch contents of Main Normal LCD

Global Layer PNBackground;
Global Layer LCDCrossfade;
Global Layer LCDShuffle;
Global Layer LCDRepeat;
Global Layer LCDMute;
Global Layer CoverMap;

Global Text Bitrate;

Global Button btnMNPlay;
Global Layer lyrMNPlayDown, lyrMNPlayLight;

Global Slider sldEqBass;
Global Slider sldEqMiddle;
Global Slider sldEqTremble;

Global Timer tmrVis;

Global Timer tmrPlay2Pause;

// Should be loaded first
#include "languageParser.m"
// Initialize attributes
#include "initAttribs.m"

#include "play2pause.m"
#include "songinfo.m"
#include "coverdrawer.m"
#include "keyboard.m"
#include "eqdrawer.m"
// Swithcing between contents
#include "LCDcontent.m"
#include "custom_vis.m"

System.onScriptLoaded() {
	
	string LangPath = system.getParam() + "Lang";

	/* Should be loaded first to use languages
	 as this script requires nothing, but can be used everywhere
	 even in declarations */
	languageParserOnLoaded(LangPath);

	Container cntMain = System.getContainer("main");
	Layout lytMainNormal = cntMain.GetLayout("normal");
	Group grpPlayerNormal = lytMainNormal.GetObject("player.normal.group");
	grpLCD = grpPlayerNormal.GetObject("player.normal.LCD");
	
	// Contents of main LCD
	grpMNLCD1 = grpLCD.GetObject("player.normal.LCD.content.1");
	grpMNLCD2 = grpLCD.GetObject("player.normal.LCD.content.2");

	// Advanced Visualization types
	Group grpMNLCD2_1 = grpMNLCD2.getObject("player.normal.LCD.content.2.vis.1");

	btnMNcontent1 = grpPlayerNormal.getObject("toggle1");
	btnMNcontent2 = grpPlayerNormal.getObject("toggle2");
	btnMNcontent3 = grpPlayerNormal.getObject("toggle3");

	grpCover = lytMainNormal.GetObject("player.normal.drawer.cover"); // Cover art drawer
	grpEq = lytMainNormal.GetObject("player.normal.drawer.eq"); // Equalizer drawer
	PNBackground = lytMainNormal.getObject("background");
	
	// Getting vis layers
	lyrVis1 = grpMNLCD1.getObject("vis1");
	lyrVis2 = grpMNLCD1.getObject("vis2");
	lyrVis3 = grpMNLCD1.getObject("vis3");
	lyrVis4 = grpMNLCD1.getObject("vis4");
	lyrVis5 = grpMNLCD1.getObject("vis5");
	lyrVis6 = grpMNLCD1.getObject("vis6");
	lyrVis7 = grpMNLCD1.getObject("vis7");
	lyrVis8 = grpMNLCD1.getObject("vis8");
	lyrVis9 = grpMNLCD1.getObject("vis9");
	lyrVis10 = grpMNLCD1.getObject("vis10");
	lyrVis11 = grpMNLCD1.getObject("vis11");
	lyrVis12 = grpMNLCD1.getObject("vis12");
	lyrVis13 = grpMNLCD1.getObject("vis13");
	lyrVis14 = grpMNLCD1.getObject("vis14");
	lyrVis15 = grpMNLCD1.getObject("vis15");
	lyrVis16 = grpMNLCD1.getObject("vis16");
	lyrVis17 = grpMNLCD1.getObject("vis17");
	lyrVis18 = grpMNLCD1.getObject("vis18");
	lyrVis19 = grpMNLCD1.getObject("vis19");
	lyrVis20 = grpMNLCD1.getObject("vis20");
	lyrVis21 = grpMNLCD1.getObject("vis21");

	// Getting advanced visualization of main mode (type 1)
	lyrAdvVis1_1 = grpMNLCD2_1.getObject("circle1");
	lyrAdvVis1_2 = grpMNLCD2_1.getObject("circle2");
	lyrAdvVis1_3 = grpMNLCD2_1.getObject("circle3");
	lyrAdvVis1_4 = grpMNLCD2_1.getObject("circle4");
	lyrAdvVis1_5 = grpMNLCD2_1.getObject("circle5");
	lyrAdvVis1_6 = grpMNLCD2_1.getObject("circle6");

	Ticker = grpMNLCD1.getObject("ticker");

	btnMNPlay = grpPlayerNormal.getObject("play2pause");
	lyrMNPlayDown = grpPlayerNormal.getObject("play2pause.pressed");
	lyrMNPlayLight = grpPlayerNormal.getObject("play2pause.light");
	tmrPlay2Pause = new Timer;
	
	tmrVis = new Timer;

	btnMNCrossfade = grpPlayerNormal.getObject("crossfade");
	btnMNShuffle = grpPlayerNormal.getObject("shuffle");
	btnMNRepeat = grpPlayerNormal.getObject("repeat");

	LCDCrossfade = grpMNLCD1.getObject("status.crossfade");
	LCDShuffle = grpMNLCD1.getObject("status.shuffle");
	LCDRepeat = grpMNLCD1.getObject("status.repeat");

	Bitrate = grpMNLCD1.getObject("bitrate");

	CoverMap = grpCover.getObject("noalpha.map");
	btnCoverButton = grpCover.getObject("button");

	//rating stars
	btnCoverStar1 = grpCover.getObject("star.1");
	btnCoverStar2 = grpCover.getObject("star.2");
	btnCoverStar3 = grpCover.getObject("star.3");
	btnCoverStar4 = grpCover.getObject("star.4");
	btnCoverStar5 = grpCover.getObject("star.5");

	// Eq declarations
	lyrEQButton = grpEq.getObject("button"); // Open/Close Button (It is really a layer)

	sldEqBass = grpEq.getObject("bit.bass");
	sldEqMiddle = grpEq.getObject("bit.mids");
	sldEqTremble =grpEq.getObject("bit.high");

	//LCD attribs names
	LCDattrNames = new List;
	LCDattrNames.addItem("Normal");
	LCDattrNames.addItem(MyTranslate(1));
	LCDattrNames.addItem("Options");

	// Vis values list
	SpectrumList = new List;
	WaveFormList = new List;
	WorkingVis = new BitList;
	WorkingVis.setSize(2); // VisWorking on/off, Fisrst/Second content

	//First initializing attribs as it's data can be used
	initAttribsonLoaded();

	if (cattrDA.getData() == "1")
	{
		PNBackground.setXMLparam("image","player.normal.background.bitmap");
		CoverMap.Hide();
		btnCoverButton.setXMLparam("image","player.normal.cover.button");
		lyrEQButton.setXMLparam("image","player.normal.eq.button");
	}
	
// All included scripts have something to load when skin is loading, so included scripts have @Name@OnLoaded() functions, called below
	play2pauseOnLoaded();
	songinfoOnLoaded();
	coverdrawerOnLoaded();
	eqdrawerOnLoaded();
	keyboardOnLoaded();
	LCDcontentOnLoaded();
	custom_visOnLoaded();
}

cattrDA.OnDataChanged()
{
	if (cattrDA.getData() == "0")
	{
		PNBackground.setXMLparam("image","player.normal.background.noalpha.bitmap");
		CoverMap.Show();
		btnCoverButton.setXMLparam("image","player.normal.cover.button.noalpha");
		lyrEQButton.setXMLparam("image","player.normal.eq.button.noalpha");
	}
	if (cattrDA.getData() == "1")
	{
		PNBackground.setXMLparam("image","player.normal.background.bitmap");
		CoverMap.Hide();
		btnCoverButton.setXMLparam("image","player.normal.cover.button");
		lyrEQButton.setXMLparam("image","player.normal.eq.button");
	}
}

System.onTitleChange(String newtitle)
{
	coverDrawerOnTitleChange(newtitle);
}

System.onScriptUnLoading() {
	
// Functions of included scripts, used when Skin is Unloading 	
	custom_visOnUnloading();
	play2pauseOnUnLoading();
	initAttribsonUnLoading();

	delete LCDattrNames;
	delete tmrPlay2Pause;
	delete tmrVis;
}