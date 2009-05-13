//--------------------------------------------------------------------------------------
// ip_mini.m
// Repeat, Shuffle & CrossFade button group
// main play buttons group
// eq, ml, open file group
// by SLoB
//--------------------------------------------------------------------------------------


//#include "attribs.m" //will implement attribs later

//load and unload
Function load_mini();
Function unload_mini();
//function for changing songticker text for info stuff
Function setTempText(string txt);

//global variable declarations
Global Group frameGroup;
Global Text sSongTicker, sSongTickerTimer;
Global Togglebutton btnShuffle, btnRepeat, btnMute;
Global String sRpttype, sShuffleStatus, sXFadeStatus;
Global button btnStop, btnPlay, btnPause, btnNext, btnPrevious, btnPL, btnEQ, btnMenu, btnEject, btnConfig;
Global int iMuted, iVolumeLevel, iRepeatmode, iGetMainStatus, bSeeking, bVolume;
Global Timer tmrSongTickerTimer;
Global Slider Seeker, Volume;

load_mini()
{
//initAttribs(); //will have attribs later on
	frameGroup = getScriptGroup();
    							
	sSongTicker = frameGroup.findObject("songticker");
	
	//btnRepeat = frameGroup.findObject("RPT");
		
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
	
}

unload_mini() 
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
	if (bVolume) 
	{
		int p = (newVol * 100) / 255;	
		setTempText("Vol:" + System.integerToString(p) + "%");
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




