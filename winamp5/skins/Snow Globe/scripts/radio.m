//-----------------------------------------------------------------------------
// customvis.m
//
// Plays internet radio station on button press
//
// To Use this script:
//
// 1) Put the customvis.maki file in your scripts folder
// 2) Put <script id="customvis" file="scripts/customvis.maki"/> in the same group
//       as your animated layer
// 3) Done!
//
// by iPlayTheSpoons
//
//-----------------------------------------------------------------------------

#include "../../../lib/std.mi"

Global Button Rock;

System.onScriptLoaded() { 

	Group ButtonGroup = getScriptGroup();
	
	rock = ButtonGroup.getObject("radio_rock");
	

}


Rock.onLeftClick(){
	System.playFile("http://209.164.178.26:8256");
}


