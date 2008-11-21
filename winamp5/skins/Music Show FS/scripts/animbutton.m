//-----------------------------------------------------------------------------
// Animbutton.m
//
// Makes an animation play when you hover your mouse over it.
// Click a button hidden by the script when the animatedlayer
// is clicked (uses the action).
//
// created by Hammerhead aka Kabir Chanrai
//-----------------------------------------------------------------------------
//                            USING THIS SCRIPT:
//*****************************************************************************
//  1.  Define the following in your XML (or at least something similar):
//		  <Animatedlayer
//			id="Animbutton"
//			speed="30"
//			x="?" y="?"
//			w="?" h="?"
//			autoreplay="1"
//		  />
//      Change the position(x,y) and size(w,h) of "Animbutton" to suit your
//		needs.
//
//  2.  Define the following in your XML (or at least something similar):
//
//		  <button
//			id="FakeAction"
//			speed="30"
//			x="8" y="8"
//			w="29" h="29"
//			action="?"
//		  />
//
//		Note: the action should be there but is not a must.
//
//  3.  Make sure your button is called "FakeAction" and is in the same group as
//      "Animbutton"  If you don't have this button, add it now. The co-ordinates
//      do not matter, as this button will be clicked by the system when you click
//      the animated layer.
//  4.  Copy this script (and animbutton.maki) to your scripts folder.
//  5.  If you don't have animbutton.maki, compile this script.
//  6.  Add this line to the group that contains your slider & songticker
//
//        <script id="animbutton" file="scripts/animbutton.maki"/>
//
//  7.  Refresh your skin(F5) and try it out.
//*****************************************************************************

#include "../../../lib/std.mi"  //Always include this in makis

Global Animatedlayer Animbutton;
Global Button FakeAction;
//define elements

System.onScriptLoaded(){  //What happens when the skin is loaded?

group pGroup = getScriptGroup();  //Define a group and get it from the script location

Animbutton = pGroup.getObject("Animbutton");  //What is animbutton's id? Where do we get it from?
FakeAction = pGroup.getObject("FakeAction");  //What is FakeAction's id? Where do we get it from?

Animbutton.stop();  //If the animation 'Animbutton' is playing, stop it

FakeAction.hide();  //Hide Animbutton

}

Animbutton.onEnterArea(){  //What happens when your mouse enters the rect area of 'animbutton'?

Animbutton.play();  //Play the animation.

}

Animbutton.OnLeaveArea(){  //What happens when your mouse leaves the rect area of 'animbutton'?

Animbutton.gotoFrame(1);  //animation goes to frame 1
Animbutton.stop();  //animation stops

}

Animbutton.onLeftButtonUp(int y, int x){  //What happens when you click on animbutton?

FakeAction.leftClick();  //Make the system click Fakeaction.

}