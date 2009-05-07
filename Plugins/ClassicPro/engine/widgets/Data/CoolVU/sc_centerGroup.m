/*---------------------------------------------------
-----------------------------------------------------
Filename:	sc_centerGroup.m

Type:		maki/source
Version:	skin version 1.2
Date:		22:03 24.06.2007
Author:		Pieter Nieuwoudt aka pjn123
E-Mail:		sylvester@skinconsortium.com
Internet:	-
-----------------------------------------------------
-----------------------------------------------------

How to use it:

<group id="main.enhancement.eq" fitparent="1" wantfocus="1" visible="0"/>
<script file="scripts/sc_centerGroup.maki" param="main.enhancement.eq;1;1;1"/>

The param:
	0=false;
	1=true;
	(centerInWidth? , centerInHeight?, limitToSide?)

	centerInWidth:
		Do you want the object to be centered on the x axis?

	centerInHeight:
		Do you want the object to be centered on the y axis?

	limitToSide:
		If the containing group/layout size gets smaller than the target object the object will have a x=0 and/or a y=0 thus not be centered anymore.
*/


#include <lib/std.mi>

Function doMyAction();

Global Group frameGroup;
Global GuiObject centerThis;
Global boolean boolW, boolH, boolLimit;

System.onScriptLoaded() {
	frameGroup = getScriptGroup();
	centerThis = frameGroup.findObject(System.getToken(System.getParam(), ";", 0));
	boolW = stringToInteger(System.getToken(System.getParam(), ";", 1));
	boolH = stringToInteger(System.getToken(System.getParam(), ";", 2));
	boolLimit = stringToInteger(System.getToken(System.getParam(), ";", 3));
	doMyAction();
}

frameGroup.onResize(int x, int y, int w, int h){
	doMyAction();
}

doMyAction(){
	if(boolW){
		if(centerThis.getWidth()>frameGroup.getWidth() && boolLimit){
			centerThis.setXmlParam("x", "0");
		}
		else{
			centerThis.setXmlParam("x", integerToString(frameGroup.getWidth()/2-centerThis.getWidth()/2));
		}
	}

	if(boolH){
		if(centerThis.getHeight()>frameGroup.getHeight() && boolLimit){
			centerThis.setXmlParam("y", "0");
		}
		else{
			centerThis.setXmlParam("y", integerToString(frameGroup.getHeight()/2-centerThis.getHeight()/2));
		}
	}
}