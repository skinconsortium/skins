//-----------------------------------------------------------------------------
// AutoRepeatVolumeButtons.m
//
// Example of Repeating Buttons
// uses AutoRepeatButtons created by WillFisher
//
// modified by FrisbeeMonkey
//-----------------------------------------------------------------------------


//                         USING THIS SCRIPT:
//*****************************************************************************
//  1.  Define VolUp and VolDown buttons in your XML, something like:
//    <button
//      id="VolUp"
//      x="424" y="39"
//      image="player.IncVolUp"
//      downImage="player.IncVolDown"
//      tooltip="+ Volume +"
//    />
//    <button
//      id="VolDown"
//      x="408" y="45"
//      image="player.DecVolUp"
//      downImage="player.DecVolDown"
//      tooltip="- Volume -"
//    />

//  2.  Make sure their ids are "VolUp" and "VolDown"
//  3.  Make sure your ticker is called "SongTicker" and is in the same group as
//        "VolUp" and "VolDown"  If you don't have a ticker, add one now.
//  4.  Copy this script and autorepeatvolumebuttons.maki to your scripts folder.
//  5.  If you don't have autorepeatvolumebuttons.maki, compile this script
//         (you'll need the AutoRepeatButton.m included in this zip)
//  6.  Add this line to the group that contains your volume buttons:
//        <script id="ARVB" file="scripts/autorepeatvolumebuttons.maki"/>
//  7.  Refresh your skin(F5) and try it out.
//*****************************************************************************

// never forget to include std.mi
#include "../../../lib/std.mi"

//Include the AutoRepeatButton Library
#include "AutoRepeatButton.m"

Global AutoRepeatButton VolumeUp, VolumeDown; //Define our buttons, note the use of AutoRepeatButton as opposed to just Button
Global Text SongTicker;     //Define the status text thing. In a real skin, perhaps use setTempText()
Global Timer SongTickerTimer;
Global GuiObject SongTicker2;

Global float CurrentVolume; //Define a volume var that is floating point, so that we can go in 2.55 (1%) jumps

Global Slider seeker;

System.onScriptLoaded() {
  AutoRepeat_Load();  //This must be done in all scripts using the AutoRepeatButton library

 //gets the group that has the objects we want
  Group ContentGrp = getScriptGroup();

  //now that we have the group, get the buttons in the group
  VolumeUp = ContentGrp.getObject("VolUp");
  VolumeDown = ContentGrp.getObject("VolDown");
  SongTicker = ContentGrp.getObject("InfoText");
  SongTicker2= ContentGrp.getObject("SongTicker");
	seeker = ContentGrp.getObject("seek");
  SongTickerTimer = new Timer;
  SongTickerTimer.setDelay(750);
  AutoRepeat_SetInitalDelay(333);

  CurrentVolume = System.GetVolume(); //start off out Current Volume var
}

System.onScriptUnLoading() {
  AutoRepeat_UnLoad();  //This must be done in all scripts using the AutoRepeatButton library
}

// Clears text area
SongTickerTimer.onTimer() {
  SongTicker.setText("");
	Songticker.hide();
	SongTicker2.show();
  SongTickerTimer.stop();
}


System.onVolumeChanged(int newvol) {             //If we did change the volume update CurrentVolume
  if (System.Integer(CurrentVolume) != newvol) {
    CurrentVolume = Newvol;
  }
}

VolumeUp.onLeftClick() {  //this contains the code for clicks AND NOW autorepeats of VolumeUp
  if (AutoRepeat_ClickType != 0) {  //use this to avoid calls to this that the AutoRepeatLibrary didn't want

    /*Here goes all the code to do when the button is pressed, for now lets just increase the volume by 1% */

    CurrentVolume = CurrentVolume + 2.55; //increase the currentvolume by 2.55 (1%)
    System.SetVolume(system.integer(CurrentVolume)); //set the new volume level
	SongTickerTimer.stop();
	SongTickerTimer.start();
	Songticker.show();
	SongTicker2.hide();
	SongTicker.SetText("Volume: " + System.IntegertoString(CurrentVolume/2.55) + "%"); //update the SongTicker
  }
}

VolumeDown.onLeftClick() {  //this contains the code for clicks AND NOW autorepeats of VolumeDown
  if (AutoRepeat_ClickType != 0) {  //use this to avoid calls to this that the AutoRepeatLibrary didn't want

    /*Here goes all the code to do when the button is pressed, for now lets just decrease the volume by 1% */

    CurrentVolume = CurrentVolume - 2.55; //decrease the currentvolume by 2.55 (1%)
    System.SetVolume(system.integer(CurrentVolume)); //set the new volume level
 	SongTickerTimer.stop();
	SongTickerTimer.start();
	Songticker.show();
	SongTicker2.hide();
   SongTicker.SetText("Volume: " + System.IntegertoString(CurrentVolume/2.55) + "%"); //update the SongTicker
  }
}

seeker.onSetPosition (int newpos)
{
 	SongTickerTimer.stop();
	SongTickerTimer.start();
	Songticker.show();
	SongTicker2.hide();
   SongTicker.SetText("Seek: " + System.integerToTime(newpos/255*getPlayItemLength()) + "/" + integerToTime(getPlayItemLength())); //update the SongTicker
	
}
