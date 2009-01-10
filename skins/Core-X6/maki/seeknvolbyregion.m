//-----------------------------------------------------------------------------
// seekbyregion.m
//
// Example of an Animated Seekbar using Regions
// (Improved, no longer requires HiddenSeek)
//
// written by FrisbeeMonkey
//
//updated by NickMikh for Core-X6
//-----------------------------------------------------------------------------

//                            USING THIS SCRIPT:
//*****************************************************************************
//  1.  Define the following in your XML:
//    <layer id="SeekAnim" image="?.?.Seek" x="?" y="?" move="0" tooltip="Seek"/>
//
//      Change the position(x,y) and image of "SeekAnim" to the specifics
//      of your layer.
//  2.  Define your gradient maps with your other elements using:
//        <bitmap id="player.map.seek" file="player/player-map-seek.png"/>
//      If you need help creating a map file, check:
//        http://www.stefanweb.com/wa3/tutorials.html#UsingMaps
//  3.  Copy this script (and seekbyregion.maki) to your scripts folder.
//  4.  If you don't have seekbyregion.maki, compile this script.
//  5.  Add this line to the group that contains your layer and SongTicker
//        <script id="seek" file="scripts/seekbyregion.maki"/>
//  6.  Refresh your skin(F5) and try it out.
//
//  NOTE: The second gradient map should be identical to the first except you
//        should change the pure black RGB(0,0,0) to RGB(1,1,1).  This makes
//        sure that none of the seek bar is showing while off.
//*****************************************************************************

// Never forget to include std.mi
#include </lib/std.mi>

// Declare local functions for use in script
Function setSeekAnim(int posValue);
Function updateSeek(int x, int y);
Function updateVolume(int x, int y);

// Declare global variables for use in script
Global Layer Seek;
Global Map SeekMap;
Global Layer Volume;
Global Map VolMap;
Global Timer SongPlayingTimer;
Global Boolean SeekChanging;
Global Boolean VolChanging;

// When the script/skin is loaded, do this
System.onScriptLoaded() {
	Group ScriptGrp = getScriptGroup();

	// Get Seekand Volume Layers
	Seek = ScriptGrp.getObject("seek.progress");
	Volume = ScriptGrp.getObject("volume.progress");

	// Initialize our timer
	SongPlayingTimer = new Timer;
	SongPlayingTimer.setDelay(1000);

	// Initialize Map
	SeekMap = new Map;
	SeekMap.loadMap("player.normal.LCD.seek.map.bitmap");
	VolMap = new Map;
	VolMap.loadMap("player.normal.LCD.volume.map.bitmap");

	// Start SongPlayingTimer if Media is Playing
	if (getplayitemstring() != "") {
		SongPlayingTimer.start();
		setSeekAnim(255 * System.getPosition() / System.getPlayItemLength());
	} else {
		setSeekAnim(0);
	}

	// Setting Volume progress
	Volume.setRegionFromMap(VolMap, System.GetVolume(),1);
}

// Starting to change Volume
Volume.onLeftButtonDown(int x, int y) {
	VolChanging = 1;
	updateVolume(x, y);
}
// Stop changing Volume
Volume.onLeftButtonUp(int x, int y) {
	if (VolChanging) {
		VolChanging = 0;
		updateVolume(x, y);
	}
}
// Changing Volume
Volume.onMouseMove(int x, int y) {
	if (VolChanging) {
		updateVolume(x, y);
	}
}

// Changing Volume progress if Volume changes
System.onVolumeChanged(int Value) {
	Volume.setRegionFromMap(VolMap, Value,1);
}



updateVolume(int x, int y) {
	int newValue = VolMap.getValue(x - Volume.getLeft(), 0); // be carefull here bacause y-dependence has been removed
	
// Checking for mouse out of boundaries
	If (Volume.GetLeft() >= x) newValue = 0;
	If (Volume.GetLeft() + Volume.GetWidth() <= x) newValue = 255;
	
	System.SetVolume(newValue);
}

// When Media is Played, Start Updates.
System.onPlay() {
	SongPlayingTimer.start();
}

// When Media is Stopped, Discontinue Updates, Set Seek to 0.
System.onStop() {
	SongPlayingTimer.stop();
	setSeekAnim(0);
}

// Updates Seek as Media Advances
SongPlayingTimer.onTimer() {
	if (System.getPlayItemLength() > 0 && System.getPlayItemLength() > System.getPosition())
	{
		
		setSeekAnim(255 * System.getPosition() / System.getPlayItemLength());
	}
	else
	{
		setSeekAnim(255);
	}
}

// Sets the Animation to Correct Region
setSeekAnim(int Value) {
	Seek.setRegionFromMap(SeekMap, Value,1);
}

// Starting to Seek
Seek.onLeftButtonDown(int x, int y) {
	SongPlayingTimer.stop();
	SeekChanging = 1;
	updateSeek(x, y);
}
// Stop Seeking
Seek.onLeftButtonUp(int x, int y) {
	SongPlayingTimer.start();
	if (SeekChanging) {
		SeekChanging = 0;
		updateSeek(x, y);
	}
}
// Seeking
Seek.onMouseMove(int x, int y) {
	if (SeekChanging) {
		updateSeek(x, y);
	}
}


// Updates Seek Image and System Position
updateSeek(int x, int y) {
	int newValue = SeekMap.getValue(x - Seek.getLeft(), 0); // be carefull here bacause y-dependence has been removed
// Checking for mouse out of boundaries
	If (Seek.GetLeft() >= x) newValue = 0;
	If (Seek.GetLeft() + Seek.getWidth() <= x) newValue = 255;

	if (System.getPlayItemLength() >= 0) {
		int p = (newValue * 100) / 255;
		int s = (newValue * System.getPlayItemLength()) / 255;
		if (!SeekChanging) {
			System.seekTo(s);
		}
		setSeekAnim(255 * s / System.getPlayItemLength());
	}
}

// When Script/Skin Unloads, Delete Map.
System.onScriptUnloading() {
	delete SongPlayingTimer;
	delete SeekMap;
}