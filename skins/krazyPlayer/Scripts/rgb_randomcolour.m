/*********************************************************************
SLoB for krazyPlayer 2008
	Random Colour changer to create colours on the fly and morph to it
	http://www.skinconsortium.com
	
	this script is still wip, a concept if you like, if you use the script or idea please give credit
	
	  ,,,      
	(o o)     
 -ooO--(_)--Ooo-
 
*********************************************************************/

#include <lib/std.mi>
#include "attribs.m"

function RGB_ChangeColour();
function nextColour();


Global int r, g, b, nextr, nextg, nextb;
Global timer tmrRGB;

System.onScriptLoaded() 
{
	initattribs();
	
	tmrRGB = new timer;
	tmrRGB.setdelay(60);
	
	if(myattrib_RGB_ENABLE.getData()=="1")
	{
		RGB_ChangeColour();
	}
}

System.onScriptUnloading()
{
	delete tmrRGB;

}


RGB_ChangeColour()
{

	if(myattrib_RGB_ENABLE.getData()=="1")
	{
		r = System.random(255);
		b = System.random(100);
		g = System.random(255);
		nextr = System.random(255);
		nextb = System.random(100);
		nextg = System.random(255);
		
		myattrib_RGB_REDColor.setData(integertostring(r));
		myattrib_RGB_GREENColor.setData(integertostring(g));
		myattrib_RGB_BLUEColor.setData(integertostring(b));
		
		tmrRGB.start();
	}
	else
	{
		tmrRGB.stop();
	}
}

nextColour()
{
	if (r>nextr) {r=r-1;}
	if (r<nextr) {r++;}	
	if (b>nextb) {b=b-1;}
	if (b<nextb) {b++;}		
	if (g>nextg) {g=g-1;}
	if (g<nextg) {g++;}
	if (r==nextr)
	{
		if (g==nextg)
		{
			if (b==nextb)
			{
				nextr = System.random(255);
				nextb = System.random(255);
				nextg = System.random(255);
			}
		}
	}

	myattrib_RGB_REDColor.setData(integertostring(r));
	myattrib_RGB_GREENColor.setData(integertostring(g));
	myattrib_RGB_BLUEColor.setData(integertostring(b));

}

tmrRGB.onTimer()
{
	nextColour();
}