/*---------------------------------------------------
-----------------------------------------------------
Filename:	songinfo.m
Version:	1.0

Type:		maki
Date:		20. Nov. 2006 - 22:47 
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
-----------------------------------------------------
---------------------------------------------------*/

#include <lib/std.mi>

Function int getChannels (); // returning 1 for mono, 2 for stereo, more for multichannel (e.g. 6), -1 for no info available
Function string getBitrate();
Function string getFrequency();
Function String getChannelsText();

Global timer delayload, songInfoTimer;

Global Text Bitrate, Monster;

System.onScriptLoaded()
{
	
	group PlayerDisplay = getScriptgroup();

	monster = PlayerDisplay.findObject("monster");

	Bitrate = PlayerDisplay.findObject("Bitrate");

	delayload = new Timer;
	delayload.setDelay(100);

	songInfoTimer = new Timer;
	songInfoTimer.setDelay(1000);

//	Bitrate.onTextChanged ("yay!");

	Int PlayerStatus = System.getStatus();

	if ( PlayerStatus != 0 )
	{
		delayload.start();
		bitrate.setText(getBitrate());
		Monster.setText(getChannelsText());
		if (PlayerStatus == 1)
		{
			songInfoTimer.start();
		}
		
	}
}

system.onScriptUnloading ()
{
	songinfotimer.stop();
	delete songinfotimer;
	delayload.stop();
	delete delayload;
}


System.onResume()
{
	delayload.start();
	songInfoTimer.start();
}

System.onPlay()
{
	delayload.start();
	songInfoTimer.start();
}

System.onStop ()
{
	monster.setText("");
	songInfoTimer.stop();
}

system.onPause ()
{
	songInfoTimer.stop();
}


System.onTitleChange(String newtitle)
{
	delayload.start();
	bitrate.setText(getBitrate());
}

delayload.onTimer ()
{
	delayload.stop();
	//ensure to display bitrate & frequency
	bitrate.setText(getBitrate());
	monster.setText(getChannelsText());
}


Int getChannels ()
{
	if (strsearch(getSongInfoText(), "tereo") != -1)
	{
		return 2;
	}
	else if (strsearch(getSongInfoText(), "ono") != -1)
	{
		return 1;
	}
	else if (strsearch(getSongInfoText(), "annels") != -1)
	{
		int pos = strsearch(getSongInfoText(), "annels");
		return stringToInteger(strmid(getSongInfoText(), pos - 4, 1));
	}
	else
	{
		return -1;
	}
}

String getChannelsText ()
{
	int c = getChannels();
	if (c == -1) return "";
	else if (c == 1) return "Mono";
	else if (c == 2 || c == 3) return "Stereo";
	else return "Surround";
}

songInfoTimer.onTimer ()
{
	bitrate.setText(getBitrate());
}


string getBitrate ()
{
	string sit = strlower(getSongInfoText());
	if (sit != "")
	{
		string rtn;
		int searchresult;
		for (int i = 0; i < 5; i++) {
			rtn = getToken(sit, " ", i);
			searchResult = strsearch(rtn, "kbps");
			if (searchResult>0) return StrMid(rtn, 0, searchResult);
		}
		return "";
	}
	else
	{
		return "";
	}
}

string getFrequency ()
{
	string sit = strlower(getSongInfoText());
	if (sit != "")
	{
		string rtn;
		int searchresult;
		for (int i = 0; i < 5; i++) {
			rtn = getToken(sit, " ", i);
			searchResult = strsearch(strlower(rtn), "khz");
			if (searchResult>0) 
			{
				rtn = StrMid(rtn, 0, searchResult);
				searchResult = strsearch(strlower(rtn), ".");
				if (searchResult>0)
				{
					rtn = getToken(rtn, ".", 0);
				}
				return rtn;
			}
		}
		return "";
	}
	else
	{
		return "";
	}
}