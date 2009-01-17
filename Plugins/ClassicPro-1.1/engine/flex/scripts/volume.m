/**
 * volume.m
 *
 * Manages custom volume fillbar and related volume stuff like muting.
 *
 * @package	com.skinconsortium.cpro.flex
 * @author	mpdeimos
 * @date	11/10/01
 * @param	layerID;mapBitmapID(;muteButtonID)
 */

#include <lib/std.mi>
#include <lib/com/fillbar.m>
#include dispatch_codes.m

Function updateVolume();

Global FillBar volumeBar;

Global Boolean muted, bypassCallback;
Global int volumeLevel;

Global ToggleButton mute;

System.onScriptLoaded ()
{
	initDispatcher();
	Layer tmp = getScriptGroup().findObject(getToken(getParam(), ";", 0));
	volumeBar = FillBar_construct(tmp, getToken(getParam(), ";", 1));
	volumeBar.dragable = TRUE;

	FillBar_setPosition(volumeBar, System.getVolume());

	String muteID = getToken(getParam(), ";", 2);

	if (muteID != "")
	{
		mute = getScriptGroup().findObject(muteID);

		muted = getPrivateInt("winamp5", "muted", 0);
		volumeLevel = getPrivateInt("winamp5", "old_volume", 0);

		if (muted)
		{
			mute.setActivated(1);
		}
	}
}

System.onScriptUnloading ()
{
	setPrivateInt("winamp5", "muted", muted);
	setPrivateInt("winamp5", "old_volume", volumeLevel);
	FillBar_destruct(volumeBar);
}

System.onVolumeChanged (int newvol)
{
	FillBar_setPosition(volumeBar, newvol);

	if (bypassCallback)
	{
		bypassCallback = false;
		return;
	}

	if (muted)
	{
		muted = false;
		mute.leftClick();
		
	}

	SendMessageS(SHOW_SYSINFO, getString("winamp.playback", 15) + ": " + integerToString(newvol/255*100) + "%");
}

/*
 * Dragging Callbacks
 */

boolean FillBar_onDrag(Fillbar fb, int pos)
{
	System.setVolume(pos);
	return TRUE; 
}

boolean FillBar_onEndDrag(Fillbar fb, int pos)
{
	System.setVolume(pos);
	return TRUE; 
}

/*
 * Muting
 */

mute.onToggle (Boolean on)
{
	bypassCallback = true;

	if (muted = on)
	{
		volumeLevel = System.getVolume();
		System.setVolume(0);
	}
	else
	{
		System.setVolume(VolumeLevel);		
	}
}

mute.onLeftButtonDown (int x, int y)
{
	if (!mute.getCurCfgVal())
	{
		SendMessageS(SHOW_SYSINFO, getString("winamp.playback", 13));
	}
	else
	{
		SendMessageS(SHOW_SYSINFO, getString("winamp.playback", 14));
	}
}

mute.onLeftButtonUp (int x, int y)
{
	if (!mute.getCurCfgVal())
	{
		SendMessageS(SHOW_SYSINFO, getString("winamp.playback", 13));
	}
	else
	{
		SendMessageS(SHOW_SYSINFO, getString("winamp.playback", 14));
	}
}