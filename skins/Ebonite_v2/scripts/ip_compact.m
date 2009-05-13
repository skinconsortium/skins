//--------------------------------------------------------------------------------------
// ip_compact.m
// Repeat, Shuffle & CrossFade button group
// main play buttons group
// eq, ml, open file group
// by SLoB
//--------------------------------------------------------------------------------------


#include "attribs/init_misc.m"

//load and unload
Function load_compact();
Function unload_compact();
//function for changing songticker text for info stuff
Function setTempText(string txt);
Function DoButtonStatus();

//global variable declarations
Global Container Main;
Global Layout LayoutCompact;

Global Group frameGroup;
Global Text sSongTicker, sSongTickerTimer;
Global Togglebutton btnShuffle, btnRepeat, btnMute, btnCrossfade, btnConfig;
Global String sRpttype, sShuffleStatus, sXFadeStatus;
Global button btnStop, btnPlay, btnPause, btnNext, btnPrevious, btnPL, btnEQ, btnMenu, btnEject;
Global int iMuted, iVolumeLevel, iRepeatmode, iGetMainStatus, bSeeking, bVolume;
Global Timer tmrSongTickerTimer;
Global Slider Seeker, Volume;

load_compact()
{
	//load global attribs
	initAttribs_misc();
	
	Main = getContainer("main"); 
    LayoutCompact = Main.getLayout("compact");
		
	frameGroup = getScriptGroup();
    							
	sSongTicker = frameGroup.findObject("songticker");
	
	btnRepeat = frameGroup.findObject("RPT");
	btnShuffle = frameGroup.findObject("SHUF");
	btnCrossfade = frameGroup.findObject("CFD");
	btnConfig = frameGroup.findObject("CNFG");
	
	// Initialize our timer
	tmrSongTickerTimer= new Timer;
	tmrSongTickerTimer.setDelay(1000);
	tmrSongTickerTimer.stop();

	btnPause = frameGroup.findObject("Pause");
	btnPlay = frameGroup.findObject("Play");
	btnStop = frameGroup.findObject("Stop");
	btnNext = frameGroup.findObject("Next");
	btnPrevious = frameGroup.findObject("Prev");
	
	Seeker = frameGroup.findObject("prog.slider.ghost");
	Volume = frameGroup.findObject("vol.slider");
	
	//set
	iRepeatmode = getPrivateInt("Ebonite", "Repeatmode", 1);
	iMuted = 0;

	// Hides both buttons until playing status is determined
  	btnPause.hide();
  	btnPlay.hide();
	
    //determines whether Winamp is playing or stopped
	iGetMainStatus = System.getStatus();
	//either paused or stopped
	if (iGetMainStatus==STATUS_PAUSED || iGetMainStatus==STATUS_STOPPED) 
	{
		btnPause.hide();		
    	btnPlay.show();		
  	}
    else 
	{
		//must be playing
		btnPlay.hide();
    	btnPause.show();		
  	}
	
	if (iRepeatmode == 0) {		
		btnRepeat.setXMLPARAM("tooltip", "Repeat OFF");		
	}
    else if (iRepeatmode == 1) 
	{
		btnRepeat.setXMLPARAM("tooltip", "Repeat ALL");
	}
    else if (iRepeatmode == 2) 
	{
		btnRepeat.setXMLPARAM("tooltip", "Repeat Track");
	}
	
	DoButtonStatus();
	
}


System.onShowLayout(Layout LayoutCompact)
{
	DoButtonStatus();	
}

DoButtonStatus()
{
	//shuffle
	if(configAttribute_shuffleType.getdata()=="1")
	{
		btnShuffle.setActivated(1);
	}
	else
	{
		btnShuffle.setActivated(0);
	}
	
	//cf
	if(configAttribute_crossfadeType.getdata()=="1")
	{
		btnCrossfade.setActivated(1);
	}
	else
	{
		btnCrossfade.setActivated(0);
	}
	
	//cfg
	if(configAttribute_configType.getdata()=="1")
	{
		btnConfig.setActivated(1);
	}
	else
	{
		btnConfig.setActivated(0);
	}
	
	//etc
	
}

unload_compact() 
{
	tmrSongTickerTimer.stop();
	delete tmrSongTickerTimer;
	frameGroup = NULL; // clears all events
}


setTempText(string txt) 
{
  sSongTicker.setText(txt);
}


// Clears text area
tmrSongTickerTimer.onTimer() 
{
	tmrSongTickerTimer.stop();
	sSongTicker.setText("");	
}


//seek text info

Seeker.onSetPosition(int p) 
{
	if (bSeeking) 
	{
		Float f;
		f = p;
		f = f / 255 * 100;
		Float len = getPlayItemLength();
		if (len != 0) 
		{
			int np = len * f / 100;
			setTempText(integerToTime(np) + "/" + integerToTime(len) + " " + integerToString(f) + "% ");			
		}
	}
}


Seeker.onLeftButtonDown(int x, int y) 
{
	bSeeking = 1;
}

Seeker.onLeftButtonUp(int x, int y) 
{
	bSeeking = 0;
	tmrSongTickerTimer.start();
}

Seeker.onSetFinalPosition(int p) 
{
	tmrSongTickerTimer.start();
}

//volume text info
System.onVolumeChanged(int newVol) 
{
	//if (bVolume) 
	//{
		int p = (newVol * 100) / 255;	
		setTempText("Vol:" + System.integerToString(p) + "%");
		if (!bVolume) 
		{
			tmrSongTickerTimer.start();
		}	
}

Volume.onLeftButtonDown(int x, int y) 
{
	bVolume = 1;
}

Volume.onLeftButtonUp(int x, int y) 
{
	bVolume = 0;
	tmrSongTickerTimer.start();
}

Volume.onSetFinalPosition(int p) 
{
	tmrSongTickerTimer.start();
}


//play 2 pause and main buttons
// If winamp is playing, hides the play button and shows pause
System.onPlay()
{
	btnPlay.hide();
  	btnPause.show();
}

// If winamp is paused, hides pause and shows play
System.onPause()
{
	btnPause.hide();
 	btnPlay.show();	
}

// If winamp is stopped, shows play and hides pause
System.onStop()
{
	btnPause.hide();
  	btnPlay.show();	  	
}


// After paused and button is again pressed starting play, will show pause and hide play
System.onresume()
{
	btnPlay.hide();
  	btnPause.show();	
}


//attrib stuff

btnRepeat.onRightButtonDown(int x, int y) {

  	popUpMenu repeatmenu = new popUpMenu;

  	int x;
  	Int iRepeatmode = stringtointeger(btnRepeat.getXmlParam("cfgval")); //getCurCfgVal() still doesnt exist? wtf? 

  	repeatmenu.addCommand("Repeat", -1, 0, 1);
  	repeatmenu.addSeparator();
  	repeatmenu.addCommand("Repeat Off", 0, (iRepeatmode == 0), 0);
  	repeatmenu.addCommand("Repeat All", 1, (iRepeatmode == 1), 0);
  	repeatmenu.addCommand("Repeat Track", 2, (iRepeatmode == -1), 0);
	
  	int iRep = repeatmenu.popAtMouse();
  
  	if (iRep < 0) return;
  	if (iRep == 2) iRep = -1;
	
	//adjust menu
	if (iRep == 0) 
	{
		//off		
		repeatmenu.checkCommand(0, 1);
		repeatmenu.checkCommand(1, 0);
		repeatmenu.checkCommand(2, 0);
		btnRepeat.setXmlParam("cfgval", "0;1;-1");
	}
    else if (iRep == 1) 
	{
		//all		
		repeatmenu.checkCommand(0, 0);
		repeatmenu.checkCommand(1, 1);
		repeatmenu.checkCommand(2, 0);
		btnRepeat.setXmlParam("cfgval", "1;-1;0");
	}
    else if (iRep == 2 || iRep == -1) 
	{
		//track
		repeatmenu.checkCommand(0, 0);
		repeatmenu.checkCommand(1, 0);
		repeatmenu.checkCommand(2, 1);
		btnRepeat.setXmlParam("cfgval", "-1;0;1");
	}
				
	delete repeatmenu;
				
  	btnRepeat.onToggle(iRep!=0);
}

btnRepeat.onRightButtonUp(int x, int y) 
{
	complete;
}
btnRepeat.onToggle(boolean on) {
	
	Int iRpt = stringtointeger(btnRepeat.getXmlParam("cfgval")); //getCurCfgVal() doesnt exist? wtf? 

	if (iRpt == 0) 
	{
		//off		
		setPrivateInt("Ebonite", "Repeatmode", iRpt);
		btnRepeat.setXMLPARAM("tooltip", "Repeat OFF");
	}
    else if (iRpt == 1) 
	{
		//all		
		setPrivateInt("Ebonite", "Repeatmode", iRpt);
		btnRepeat.setXMLPARAM("tooltip", "Repeat ALL");
	}
    else if (iRpt == 2 || iRpt == -1) 
	{
		//track
		if (iRpt == -1) iRpt = 2;
		setPrivateInt("Ebonite", "Repeatmode", iRpt);
		btnRepeat.setXMLPARAM("tooltip", "Repeat Track");
	}

	if (iRpt < 0) return;
  	if (iRpt == 2) iRpt = -1;
	
	configAttribute_repeatType.setData(integerToString(iRpt));	
	
}


btnShuffle.onToggle(boolean on) 
{
	if(on)
	{
		configAttribute_shuffleType.setData("1");
	}
	else
	{
		configAttribute_shuffleType.setData("0");
	}
}


		
configAttribute_shuffleType.onDataChanged() 
{
	if(getData()=="1")
	{
		btnShuffle.setActivated(1);
	}
	else
	{
		btnShuffle.setActivated(0);
	}

}

btnCrossfade.onToggle(boolean on) 
{
	if(on)
	{
		configAttribute_crossfadeType.setData("1");
	}
	else
	{
		configAttribute_crossfadeType.setData("0");
	}
}
		
configAttribute_crossfadeType.onDataChanged() 
{
	if(getData()=="1")
	{
		btnCrossfade.setActivated(1);
	}
	else
	{
		btnCrossfade.setActivated(0);
	}

}

btnConfig.onToggle(boolean on) 
{
	if(on)
	{
		configAttribute_configType.setData("1");
	}
	else
	{
		configAttribute_configType.setData("0");
	}
}
		
configAttribute_configType.onDataChanged() 
{
	if(getData()=="1")
	{
		btnConfig.setActivated(1);
	}
	else
	{
		btnConfig.setActivated(0);
	}

}