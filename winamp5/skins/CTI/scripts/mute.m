/*---------------------------------------------------
-----------------------------------------------------
Filename:	mute.m
Version:	1.0

Type:		maki
Date:		18. Nov. 2006 - 18:07 
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu

Note:		This script is based on mute.m
		from Winamp Modern
-----------------------------------------------------
---------------------------------------------------*/

#include <lib/std.mi>

Global Group frameGroup;
Global Togglebutton MuteBtn;
Global Text SongTicker;
Global Float VolumeLevel;
Global Boolean Muted, BtnPressed;


System.onScriptLoaded()
{ 
	Muted = getPrivateInt(getSkinNAme(), "muted", 0);
	VolumeLevel = getPrivateInt(getSkinNAme(), "old_volume", 0);
	frameGroup = getScriptGroup();

	MuteBtn = frameGroup.findObject("vol.mute");
	MuteBtn.setActivated(Muted);

	SongTicker = frameGroup.getParentLayout().findObject("songticker");

	if (Muted)
	{
		string sm = getPrivateString(getSkinNAme(), "Mute.method", "Mute");
		SongTicker.sendAction("showinfo", sm +": On", 0, 0, 0, 0);
	}
	BtnPressed = 0;
}


System.onScriptUnloading()
{
	setPrivateInt(getSkinNAme(), "muted", Muted);
	setPrivateInt(getSkinNAme(), "old_volume", VolumeLevel);
}

MuteBtn.onLeftClick()
{
	BtnPressed = 1;
	if (!Muted)
	{
		VolumeLevel = System.getVolume();
		string sm = getPrivateString(getSkinNAme(), "Mute.method", "Mute");
		if (sm == "Attenuate") System.setVolume(getVolume() / 10);
		else System.setVolume(0);
		Muted = 1;
		setPrivateInt(getSkinNAme(), "muted", Muted);
		SongTicker.sendAction("showinfo", sm +": On", 0, 0, 0, 0);
	}
	else
	{
		System.setVolume(VolumeLevel);
		Muted = 0;
		setPrivateInt(getSkinNAme(), "muted", Muted);
		SongTicker.sendAction("showinfo", "Mute: Off", 0, 0, 0, 0);
	}
}

System.onvolumechanged(int newvol)
{
	if (!BtnPressed)
	{
		if (Muted)
		{
			MuteBtn.setActivated(0);
			Muted = 0;
			setPrivateInt(getSkinNAme(), "muted", Muted);
		}
	}
	BtnPressed = 0;
}