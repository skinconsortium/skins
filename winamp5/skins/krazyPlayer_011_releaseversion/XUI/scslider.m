/*
Script by TEM 2007

XUI Animated Slider

Uses 2 objects: layer and a (fake) button 

Works for: Volume, (Seeker)

Word of caution: The map param MUST be listed before the action, otherwise winamp will crash
		 because it must upload the map on loading the action.
*/

#include <lib/std.mi>

Function setAnim(int Value);

Global Layer aniSlider;
Global Boolean changing, mouseDown;
Global Int nval, val;
Global Boolean mousedown,mouseout;
Global Button fakeButton;
Global String action;
Global Map slidermap;
Global Timer SongTimer;

//#define DEBUG

#ifdef DEBUG
Function debug(String debugStr);
debug(String debugStr) {
	system.debugstring(debugStr,0);
}
#endif

System.onScriptLoaded() 
{
	Group ScriptGrp = getScriptGroup();

	aniSlider = ScriptGrp.findObject("aniSlider");
	fakeButton = ScriptGrp.findObject("fakeButton");

	SongTimer = new Timer;
	SongTimer.setDelay(1000);
}

System.onSetXuiParam(string param, string value) 
{
	param = system.strlower(param);
	
	if(param == "image")
	{
		fakeButton.setXMLParam("image",value);
		aniSlider.setXMLParam("image",value);
	}
	
	if(param == "alpha")
	{
		aniSlider.setXMLParam("alpha",value);
	}


	if(param == "tooltip") 
	{
		aniSlider.setXMLParam("tooltip", value);
		fakeButton.setXMLParam("tooltip", value);
	}

	if(param == "action")
	{
		action = value;

		if (action == "volume")
		{
			setAnim(system.getVolume());
		}
		if (action == "seek")
		{
			if (getplayitemstring() != "") 
			{
				SongTimer.start();
				setAnim(255 * System.getPosition() / System.getPlayItemLength()+0.001);
			}
			else
			{
				setAnim(1);
			}
		}

	}

	if(param == "map")
	{
		slidermap = new map;
		slidermap.loadMap(value);
	}	

}

//SLoB - thanks Pieter :) - have also added .001 as potential divbyzero can occurr with getPlayItemLength - avoid deathbyzero ;)
System.onSeek(int newPos)
{
    if (action == "seek") setAnim(255 * System.getPosition() / (System.getPlayItemLength()+0.001));
}


System.onPlay() 
{
	if (action == "seek")
	{
		SongTimer.start();
	}
}

System.onStop() 
{
	if (action == "seek")
	{
		SongTimer.stop();
		setAnim(1);
	}
}

SongTimer.onTimer() 
{
	if (action == "seek")
	{
		if (!mouseDown)
		setAnim(255 * System.getPosition() / System.getPlayItemLength()+0.001);
	}
}

System.onVolumeChanged(int newVal) 
{
	if(action == "volume")
	{	
		setAnim(newVal);
	}

}

setAnim(int Value) 
{
	Region r = new Region;
	r.loadFromMap(slidermap,Value,1);
	aniSlider.setRegion(r);
	delete r;
}

System.onScriptUnloading() 
{
	delete slidermap;
	delete SongTimer;
}

fakeButton.onEnterArea() 
{
	if (mouseout == 1) 
	{
		mousedown = 1;
		mouseout = 0;
	}
		
}

fakeButton.onLeaveArea() 
{
	if (mousedown == 1) 
	{
		mouseout = 1;
		mousedown = 0;
	} 
	else 
	{
		mousedown = 0;
		mouseout = 0;
	}
}
	
fakeButton.onMouseMove(int x, int y) 
{	
	if (mousedown == 1) 
	{
		nval = slidermap.getValue(x-fakeButton.getLeft(),y-fakeButton.getTop());
		if (action == "volume")
		{
			system.setVolume(nval);
		}
		if (action == "seek")
		{
			system.seekTo(nval * System.getPlayItemLength() / 255);
		}
	}	
}

system.onVolumeChanged(int newval) 
{
	val = newval/2.55;
	setAnim(val);
}

fakeButton.OnLeftButtonDown(int x, int y)
{
		mousedown = 1;
		mouseout = 0;
}

fakeButton.OnLeftButtonUp(int x, int y)
{
	if (mousedown == 1) 
	{
		nval = slidermap.getValue(x-fakeButton.getLeft(),y-fakeButton.getTop());
		if (action == "volume")
		{
			system.setVolume(nval);
		}
		if (action == "seek")
		{
			system.seekTo(nval * System.getPlayItemLength() / 255);
		}
		mousedown = 0;
		mouseout = 0;
	} 
	else 
	{
		mousedown = 0;
		mouseout = 0;
	}
}
