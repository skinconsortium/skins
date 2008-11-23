//-----------------------------------------------------------------------------
// seekbyregion.m
//
// Example of an Animated Seekbar using Regions
// (Improved, no longer requires HiddenSeek)
//
// written by FrisbeeMonkey
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
//        and
//        <bitmap id="player.map.seek2" file="player/player-map-seek2.png"/>
//      If you need help creating a map file, check:
//        http://www.stefanweb.com/wa3/tutorials.html#UsingMaps
//  3.  Make sure your ticker is called "SongTicker" and is in the same group as
//      "SeekAnim".  If you don't have a ticker, add one now.
//  4.  Copy this script (and seekbyregion.maki) to your scripts folder.
//  5.  If you don't have seekbyregion.maki, compile this script.
//  6.  Add this line to the group that contains your layer and SongTicker
//        <script id="seek" file="scripts/seekbyregion.maki"/>
//  7.  Refresh your skin(F5) and try it out.
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

// Declare global variables for use in script
Global Layer Seek;
Global Map SeekMap, SeekMap2;
Global Text SongTicker;
Global Timer SongTickerTimer, SongPlayingTimer;
Global Boolean SeekChanging;

// When the script/skin is loaded, do this
System.onScriptLoaded() {
	Group ScriptGrp = getScriptGroup();

	// Get Seek Layer and SongTicker
	Seek = ScriptGrp.findObject("SeekAnim");
	SongTicker = ScriptGrp.findObject("SongTicker");

	// Initialize our timers
	SongTickerTimer = new Timer;
	SongTickerTimer.setDelay(750);
	SongPlayingTimer = new Timer;
	SongPlayingTimer.setDelay(1000);

	// Initialize Maps
	SeekMap = new Map;
	SeekMap.loadMap("player.map.seek");
	SeekMap2 = new Map;
	SeekMap2.loadMap("player.map.seek2");

	// Start SongPlayingTimer if Media is Playing
	if (getplayitemstring() != "") {
		SongPlayingTimer.start();
		setSeekAnim(255 * System.getPosition() / System.getPlayItemLength());
	} else {
		setSeekAnim(0);
	}
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
	setSeekAnim(255 * System.getPosition() / System.getPlayItemLength());
}

// Clears Text Area
SongTickerTimer.onTimer() {
	SongTicker.setText("");
	SongTickertimer.stop();
}

// Sets the Animation to Correct Region
setSeekAnim(int Value) {
	Region r = new Region;
	r.loadFromMap(SeekMap2, Value, 1);
	Seek.setRegion(r);
	delete r;
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
	int newValue = SeekMap.getValue(x - Seek.getLeft(), y - Seek.getTop());
	if (System.getPlayItemLength() >= 0) {
		int p = (newValue * 100) / 255;
		int s = (newValue * System.getPlayItemLength()) / 255;
		Songtickertimer.stop();
		Songtickertimer.start();
		Songticker.setAlternateText(System.integerToTime(s) + "/" + System.integerToTime(System.getPlayItemLength()) + " (" + System.integerToString(p) + "%)");
		if (!SeekChanging) {
			System.seekTo(s);
		}
		setSeekAnim(255 * s / System.getPlayItemLength());
	}
}

// When Script/Skin Unloads, Delete Maps.
System.onScriptUnloading() {
	delete SongPlayingTimer;
	delete SongTickerTimer;
	delete SeekMap;
	delete SeekMap2;
}