/*
	based on Rotational TimeLine Vizualisation (byframe) by SLoB (inspired by an idea by Eric Moore (HollowEarth) Extended Vis)
	http://www.skinconsortium.com/
	slob@uk2.net
	Copyright 2007
	
idea:		prototype to display rotational timeline, loops round the bars giving a value which is then processed to show specific frame
		to simulate a rotating timeline which pulses in and out in a 3d perspective type effect
		
other ideas: to add a map version, will keep map & frame scripts Vizzes seperate as map version doesnt really lend itself to depth vis altho u could simulate a fairly good 3d depth with a mapped version
		add more bars for a more fluid rotational animation effect
		add more levels to the depth to give more response to lower & overall levels
	
notes:	uses a list to hold vu values with a push/pop stack logic and a do-while loop for speed
		BASS, MID, TREBLE also tested but not responsive enough unless more levels are introduced, therefore not added in initial version
		(8 frames and 8 bars used in this prototype) AnimLength = specific frame count of animations for speed, best to keep all animation frames same length/framecount
		
history:	SLoB 18/05/2007 - initial script

greets:	Hi to the SC guys ;)

closing:	Trippeh Tacca ;)

notes for use/incorporating into skin:
assumes you can incorporate the viz into your skin, its not a simple drop in thing its a concept and needs some input esp for the below:
* make grfx frames to suit your idea/skin, more frames can be added for greater response, amend AnimLength depending on framecount chosen
* probably best not to go below 6 bars otherwise would look too choppy, between 8 and 16 bars, higher giving a more fluid look to the actual rotation and more frames for the 0-255 conversion for smoother response
* adjust script to suit your skin

Feel free to use and modify this in any way you like, provided that you credit me with the original, perhaps also keeping this header for historic/idea/info purposes.
if you use this idea/script in your skin please either post in the SC forum or mail me as to how you incorporated it into your skin and any improvements/other ideas made.
remember this is just a concept, you could create some pretty cool shapes and have this vis effect run through

Disclaimer:	no responsibility taken for hypnotic side effects induced by watching this cool Viz, even if smokin de herb ;) rofl

	  ,,,      
	(o o)     
 -ooO--(_)--Ooo-

 
*/

#include <lib/std.mi>
#include "attribs.m"

#define DEBUG
#ifdef DEBUG
Function debug(String debugStr);
debug(String debugStr) {
	system.debugstring("Debug Message:" + debugStr, 0); //debug console
}
#endif


#define AnimLength 12 

Function DropPoints();
Function ChangeDirection(int whichDirection);
function MakeVizMenu();
Function ProcessVizMenuResult(int a);
Function StopViz();
Function menuoption_Style(string Style);
Function getSpeed();
Function ChangeDepthDirection();

Function menuoption_Pattern(int iPattern);

Global layout LayoutRTLV, LytNorm;
Global Popupmenu VizMenu, VizSubMenu_Pattern;
Global Group VisGroup, grpCubes;
Global Timer ExtendedVisTimer, DropPointsTimer;
Global AnimatedLayer Bar, Bar1, Bar2, Bar3, Bar4, Bar5, Bar6, Bar7, Bar8, Bar9, Bar10, Bar11, Bar12, Bar13, Bar14, Bar15, Bar16;
Global layer temp, mask;
Global int intTemp, i, f, CurVal, LastVal, Drop_Top, Drop_Bottom, Drop_Cur, blah, Drop_Val, Drop_ActualVal, iVuLEDLevel, x, vison;
Global int Dir0, Dir1, Dir2, Dir3, Dir4, Dir5, Dir6, Dir7, Dir8, Dir9, Dir10, Dir11, Dir12, Dir13, Dir14, Dir15, Direction, visSpeed;
Global List Values;
global layer RTLVLCDBLUECOL, RTLVLCDGREENCOL, RTLVLCDREDCOL;
global int Reverse;	
global int VisPattern;
global String sRememberStyle;

System.onScriptLoaded()
{
	initAttribs();
	
	VisGroup = getScriptGroup();
	LayoutRTLV = getContainer("main").getLayout("full");
	
	grpCubes = LayoutRTLV.findObject("cubes");
	
	//dont forgettaboutme ;)
	
	Bar1 = LayoutRTLV.findObject("cube1");
	Bar2 = LayoutRTLV.findObject("cube2");
	Bar3 = LayoutRTLV.findObject("cube3");
	Bar4 = LayoutRTLV.findObject("cube4");
	Bar5 = LayoutRTLV.findObject("cube5");
	Bar6 = LayoutRTLV.findObject("cube6");
	Bar7 = LayoutRTLV.findObject("cube7");
	Bar8 = LayoutRTLV.findObject("cube8");	
	Bar9 = LayoutRTLV.findObject("cube9");
	Bar10 = LayoutRTLV.findObject("cube10");
	Bar11 = LayoutRTLV.findObject("cube11");
	Bar12 = LayoutRTLV.findObject("cube12");
	Bar13 = LayoutRTLV.findObject("cube13");
	Bar14 = LayoutRTLV.findObject("cube14");
	Bar15 = LayoutRTLV.findObject("cube15");
	Bar16 = LayoutRTLV.findObject("cube16");
	
	
	//mask = LayoutRTLV.findObject("vismask");
	
	Bar1.setSpeed(1);
	Bar2.setSpeed(1);
	Bar3.setSpeed(1);
	Bar4.setSpeed(1);
	Bar5.setSpeed(1);
	Bar6.setSpeed(1);
	Bar7.setSpeed(1);
	Bar8.setSpeed(1);
	
	Bar9.setSpeed(1);
	Bar10.setSpeed(1);
	Bar11.setSpeed(1);
	Bar12.setSpeed(1);
	Bar13.setSpeed(1);
	Bar14.setSpeed(1);
	Bar15.setSpeed(1);
	Bar16.setSpeed(1);
	

	vison = System.getPrivateInt("EboniteRTLV","VisMode",0);
	grpCubes.hide();
	
	i=1;
	Drop_Top = 255;
	Drop_Bottom = 0;
	Drop_Cur = 10;
	blah = 255;
	Drop_Val=0;
	Drop_ActualVal=0;
	
	VisPattern = System.getPrivateInt("EboniteRTLV","Pattern",1); 
	menuoption_Pattern(VisPattern);
		
	//set style
	sRememberStyle = system.getPrivateString("Ebonite","cubevisstyle", "1");
	menuoption_Style(sRememberStyle);

	//if(LayoutRTLV.isVisible())
	//{
		//default direction anticlockwise
		//Direction = System.getPrivateInt("RTLV","Direction",1);
		//vis_mode_direction_attrib.setData(integertostring(Direction));
		
		//default direction anticlockwise
		Direction = System.getPrivateInt("RTLV","Direction",1);
		//ChangeDirection(Direction);
		

		

		/*
		//downwards
		Dir0=0;
		Dir1=4;
		Dir2=8;
		Dir3=12;
		
		Dir4=1;
		Dir5=5;
		Dir6=9;
		Dir7=13;
		
		Dir8=2;
		Dir9=6;
		Dir10=10;
		Dir11=14;

		Dir12=3;
		Dir13=7;
		Dir14=11;
		Dir15=15;
		
*/
		
		//vis_mode_direction_attrib.setData(integertostring(Direction));
		
		Values = new List;
		
		getSpeed();	
		if(visSpeed<10)
		{
			visSpeed = System.getPrivateInt("RTLV","Speed",30);
		}
		ExtendedVisTimer = new Timer;
		ExtendedVisTimer.setDelay(visSpeed);
		ExtendedVisTimer.stop();
		DropPointsTimer = new Timer;
		DropPointsTimer.setDelay(1);
		DropPointsTimer.stop();
		
		
		//create initial points
		for(int i = 0; i <= 15; i++)
		{
			Values.addItem(i);
		}
		
			#ifdef DEBUG
				debug("vison=" + integertostring(vison));
			#endif
			
		//if(LayoutRTLV.isVisible())
		//{
			//LayoutRTLV.resize(LayoutRTLV.getLeft(), LayoutRTLV.getTop(), LayoutRTLV.getWidth(), LayoutRTLV.getHeight());
			
		
		
			if(vison==1 || globalmyattr_SCCubeVisEnabled.getData()=="1")
			{
				if(globalmyattr_SC90DegVisEnabled.getData()=="0" && globalmyattr_SCCoverEnabled.getData()=="0")
				{
					grpCubes.show();
					ExtendedVisTimer.start();		
				}				
			}
		//}
	//}
}

System.OnScriptUnloading()
{

	delete Values;
	delete ExtendedVisTimer;
	delete DropPointsTimer;
	
	System.setPrivateInt("EboniteRTLV","VisMode",vison);
	//System.setPrivateInt("RTLV","Direction", stringtointeger(vis_mode_direction_attrib.getData()));		
	//System.setPrivateInt("RTLV","Speed",visSpeed);
	
	System.setPrivateInt("EboniteRTLV","Pattern", VisPattern);
	system.setPrivateString("Ebonite","cubevisstyle", sRememberStyle);
}


vis_mode_style_attrib.onDataChanged()
{	
	menuoption_Style(vis_mode_style_attrib.getdata());
	
	sRememberStyle = vis_mode_style_attrib.getData();
	
}

menuoption_Style(string Style)
{
	int iStyle = stringtointeger(Style);
	string sStyle = "cubevis" + Style;
	
	if(iStyle >=1 && iStyle<=3)
	{
		Bar1.setXMLParam("image", sStyle);
		Bar2.setXMLParam("image", sStyle);
		Bar3.setXMLParam("image", sStyle);
		Bar4.setXMLParam("image", sStyle);
		Bar5.setXMLParam("image", sStyle);
		Bar6.setXMLParam("image", sStyle);
		Bar7.setXMLParam("image", sStyle);
		Bar8.setXMLParam("image", sStyle);
		Bar9.setXMLParam("image", sStyle);
		Bar10.setXMLParam("image", sStyle);
		Bar11.setXMLParam("image", sStyle);
		Bar12.setXMLParam("image", sStyle);
		Bar13.setXMLParam("image", sStyle);
		Bar14.setXMLParam("image", sStyle);
		Bar15.setXMLParam("image", sStyle);
		Bar16.setXMLParam("image", sStyle);
		
	}
	else
	{
		sStyle = "cubevis1";
		
		Bar1.setXMLParam("image", sStyle);
		Bar2.setXMLParam("image", sStyle);
		Bar3.setXMLParam("image", sStyle);
		Bar4.setXMLParam("image", sStyle);
		Bar5.setXMLParam("image", sStyle);
		Bar6.setXMLParam("image", sStyle);
		Bar7.setXMLParam("image", sStyle);
		Bar8.setXMLParam("image", sStyle);
		Bar9.setXMLParam("image", sStyle);
		Bar10.setXMLParam("image", sStyle);
		Bar11.setXMLParam("image", sStyle);
		Bar12.setXMLParam("image", sStyle);
		Bar13.setXMLParam("image", sStyle);
		Bar14.setXMLParam("image", sStyle);
		Bar15.setXMLParam("image", sStyle);
		Bar16.setXMLParam("image", sStyle);
		
	}
	
}


globalmyattr_SCCubeVisEnabled.onDataChanged()
{	
	if (getdata()=="1")
	{
		vison=1;
		grpCubes.show();
		DropPointsTimer.stop();
		ExtendedVisTimer.start();
		
	}
	else
	{
		vison=0;
		ExtendedVisTimer.stop();
		grpCubes.hide();
		//DropPoints();

	}
}


vis_mode_Pattern_attrib.onDataChanged()
{	
	VisPattern = stringtointeger(vis_mode_Pattern_attrib.getdata());
	menuoption_Pattern(VisPattern);		
}

menuoption_Pattern(int iPattern)
{
	//zero is handled in cube m file to turn off cube vis
	//we also want to disable the other vis or cover if the cube vis is on
	if(iPattern==0)
	{
		//do something here
	}
	
	
	/*
		pattern
		00010203
		04050607
		08091011
		12131415

	
	*/
	
	if(iPattern >= 1 && iPattern <= 6)
	{
		//zig-zag Horizontal
		if(iPattern==1)
		{		
			Dir0=12;
			Dir1=13;
			Dir2=14;
			Dir3=15;
			Dir4=11;
			Dir5=10;
			Dir6=9;
			Dir7=8;			
			Dir8=4;
			Dir9=5;
			Dir10=6;
			Dir11=7;
			Dir12=3;
			Dir13=2;
			Dir14=1;
			Dir15=0;
		}
		
		//zig-zag Vertical
		if(iPattern==2)
		{
			Dir0=12;
			Dir1=8;
			Dir2=4;
			Dir3=0;
			Dir4=1;
			Dir5=5;
			Dir6=9;
			Dir7=13;			
			Dir8=14;
			Dir9=10;
			Dir10=6;
			Dir11=2;
			Dir12=3;
			Dir13=7;
			Dir14=11;
			Dir15=15;
		}
		
		//Striped Horizontal
		if(iPattern==3)
		{		
			Dir0=0;
			Dir1=1;
			Dir2=2;
			Dir3=3;
			Dir4=4;
			Dir5=5;
			Dir6=6;
			Dir7=7;			
			Dir8=8;
			Dir9=9;
			Dir10=10;
			Dir11=11;
			Dir12=12;
			Dir13=13;
			Dir14=14;
			Dir15=15;
		}

		//Striped Vertical
		if(iPattern==4)
		{
			Dir0=12;
			Dir1=8;
			Dir2=4;
			Dir3=0;
			Dir4=13;
			Dir5=9;
			Dir6=5;
			Dir7=1;			
			Dir8=14;
			Dir9=10;
			Dir10=6;
			Dir11=2;
			Dir12=15;
			Dir13=11;
			Dir14=7;
			Dir15=3;
		}
		
		//Spiral IN		
		if(iPattern==5)
		{
		
			Dir15=0;
			Dir4=1;
			Dir13=2;
			Dir12=3;
			Dir11=7;
			Dir10=11;
			Dir9=15;
			Dir8=14;			
			Dir7=13;
			Dir6=12;
			Dir5=8;
			Dir4=4;
			Dir3=5;
			Dir2=6;
			Dir1=10;
			Dir0=9;
		}
		
		
		//Spiral OUT		
		if(iPattern==6)
		{
			Dir0=5;
			Dir1=6;
			Dir2=10;
			Dir3=9;
			Dir4=8;
			Dir5=4;
			Dir6=0;
			Dir7=1;			
			Dir8=2;
			Dir9=3;
			Dir10=7;
			Dir11=11;
			Dir12=15;
			Dir13=14;
			Dir14=13;
			Dir15=12;
		}
		
		//Diagonal		
		if(iPattern==7)
		{
			Dir0=0;
			Dir1=4;
			Dir2=1;
			Dir3=8;
			Dir4=5;
			Dir5=2;
			Dir6=12;
			Dir7=9;			
			Dir8=6;
			Dir9=3;
			Dir10=13;
			Dir11=10;
			Dir12=7;
			Dir13=14;
			Dir14=11;
			Dir15=15;
		}
		
	}

}


LayoutRTLV.onSetVisible(Boolean on)
{
	if(on)
	{
	
		if (globalmyattr_SCCubeVisEnabled.getdata()=="1")
		{
			vison=1;
			grpCubes.show();
			DropPointsTimer.stop();
			ExtendedVisTimer.start();
			
		}
		else
		{
			vison=0;
			ExtendedVisTimer.stop();
			grpCubes.hide();
			//DropPoints();

		}
		
	
	}
	else
	{
		ExtendedVisTimer.stop();
	}
	
	
}



/*
LayoutRTLV.onSetVisible(Boolean on)
{
	if(on)
	{
		#ifdef DEBUG
			debug("getCurCfgVal=1");
		#endif
		
		//LayoutRTLV.resize(LayoutRTLV.getLeft(), LayoutRTLV.getTop(), LayoutRTLV.getWidth(), LayoutRTLV.getHeight());

		blah=255;
		Drop_Val=0;
		Drop_ActualVal=0;
		
		//test
			
					//default direction anticlockwise
			Direction = System.getPrivateInt("RTLV","Direction",1);
			//vis_mode_direction_attrib.setData(integertostring(Direction));
			
			
			Values = new List;
			
			getSpeed();	
			if(visSpeed<10)
			{
				visSpeed = System.getPrivateInt("RTLV","Speed",30);
			}
			ExtendedVisTimer = new Timer;
			ExtendedVisTimer.setDelay(visSpeed);
			ExtendedVisTimer.stop();
			
			DropPointsTimer = new Timer;
			DropPointsTimer.setDelay(1);
			DropPointsTimer.stop();
			
			//create initial points
			for(int i = 0; i <= 15; i++)
			{
				Values.addItem(i);
			}
			
				#ifdef DEBUG
					debug("vison=" + integertostring(vison));
				#endif
				
			if(LayoutRTLV.isVisible())
			{
				//LayoutRTLV.resize(LayoutRTLV.getLeft(), LayoutRTLV.getTop(), LayoutRTLV.getWidth(), LayoutRTLV.getHeight());
					
				if(vison==1)
				{
					ExtendedVisTimer.start();		
				}
			}
				
		
		//end test
		
		if(vison==1)
		{
			DropPointsTimer.stop();
			ExtendedVisTimer.start();
		}
		
		
		
	}
	else
	{
		#ifdef DEBUG
			debug("getCurCfgVal=0");
		#endif
		System.setPrivateInt("RTLV","Direction",Direction);
		DropPointsTimer.stop();
		ExtendedVisTimer.stop();
		delete Values;
		delete ExtendedVisTimer;
		delete DropPointsTimer;
		
	}
}

*/


ExtendedVisTimer.onTimer()
{	

	CurVal = (getLeftVuMeter() + getRightVuMeter()) / 2;		
	
	//rotational levels
		Values.addItem(CurVal);
		Values.removeItem(0);
		
		i = 0;
		do {	
			intTemp = values.enumItem(i);		
			f = integer((intTemp * AnimLength) / 255);
			
			//#ifdef DEBUG
			//	debug("i=" + integertostring(i) + " f=" + integertostring(f));
			//#endif
			
			if(i==Dir0) 		Bar1.gotoFrame(f+1);
			else if(i==Dir1) 	Bar2.gotoFrame(f+1);
			else if(i==Dir2) 	Bar3.gotoFrame(f+1);
			else if(i==Dir3) 	Bar4.gotoFrame(f+1);
			else if(i==Dir4) 	Bar5.gotoFrame(f+1);
			else if(i==Dir5) 	Bar6.gotoFrame(f+1);
			else if(i==Dir6) 	Bar7.gotoFrame(f+1);
			else if(i==Dir7) 	Bar8.gotoFrame(f+1);			
			else if(i==Dir8) 	Bar9.gotoFrame(f+1);
			else if(i==Dir9) 	Bar10.gotoFrame(f+1);
			else if(i==Dir10) 	Bar11.gotoFrame(f+1);
			else if(i==Dir11) 	Bar12.gotoFrame(f+1);
			else if(i==Dir12) 	Bar13.gotoFrame(f+1);
			else if(i==Dir13) 	Bar14.gotoFrame(f+1);
			else if(i==Dir14) 	Bar15.gotoFrame(f+1);
			else if(i==Dir15) 	Bar16.gotoFrame(f+1);
			
			i++;
		} while(i<=15);
	
}

System.onPlay()
{
	if((vison==1 || globalmyattr_SCCubeVisEnabled.getData()=="1") && LayoutRTLV.isVisible())
	{
		DropPointsTimer.stop();
		ExtendedVisTimer.start();
	}	
}

System.onResume()
{
	if((vison==1 || globalmyattr_SCCubeVisEnabled.getData()=="1") && LayoutRTLV.isVisible())
	{
		DropPointsTimer.stop();
		ExtendedVisTimer.start();
	}
}

System.OnStop()
{
	if((vison==1 || globalmyattr_SCCubeVisEnabled.getData()=="1") && LayoutRTLV.isVisible())
	{
		ExtendedVisTimer.stop();
		//DropPoints();
	}
}

System.OnPause()
{
	if((vison==1 || globalmyattr_SCCubeVisEnabled.getData()=="1") && LayoutRTLV.isVisible())
	{
		ExtendedVisTimer.stop();
		//DropPoints();
	}
}
/*
StopViz()
{
	if(myattr_SCCubeVisEnabled.getData()=="1") 
	{
		myattr_SCCubeVisEnabled.setData("0");
		vison=0;
		ExtendedVisTimer.stop();
		DropPoints();
	}
	else if(myattr_SCCubeVisEnabled.getData()=="0")
	{	
		vison=1;
		myattr_SCCubeVisEnabled.setData("0");		
		DropPointsTimer.stop();
		ExtendedVisTimer.start();
	}
}
*/

DropPointsTimer.onTimer()
{


	//first raise all points to 255, then loop round in increments to drop to zero
	Drop_Val = Drop_Val + Drop_Cur;
	Drop_ActualVal = blah-Drop_Val;
	
	Values.addItem(Drop_ActualVal);
	Values.removeItem(0);
	
	i = 0;
	do {	
		intTemp = values.enumItem(i);		
		f = integer((intTemp * AnimLength) / 255);
		
		if(i==Dir0) 		Bar1.gotoFrame(f+1);
		else if(i==Dir1) 	Bar2.gotoFrame(f+1);
		else if(i==Dir2) 	Bar3.gotoFrame(f+1);
		else if(i==Dir3) 	Bar4.gotoFrame(f+1);
		else if(i==Dir4) 	Bar5.gotoFrame(f+1);
		else if(i==Dir5) 	Bar6.gotoFrame(f+1);
		else if(i==Dir6) 	Bar7.gotoFrame(f+1);
		else if(i==Dir7) 	Bar8.gotoFrame(f+1);
		
		else if(i==Dir8) 	Bar9.gotoFrame(f+1);
		else if(i==Dir9) 	Bar10.gotoFrame(f+1);
		else if(i==Dir10) 	Bar11.gotoFrame(f+1);
		else if(i==Dir11) 	Bar12.gotoFrame(f+1);
		else if(i==Dir12) 	Bar13.gotoFrame(f+1);
		else if(i==Dir13) 	Bar14.gotoFrame(f+1);
		else if(i==Dir14) 	Bar15.gotoFrame(f+1);
		else if(i==Dir15) 	Bar16.gotoFrame(f+1);
		
		i++;
	} while(i<=15);
	
			
	if(Drop_ActualVal<= (-250))
	{
		Drop_ActualVal=0;
		DropPointsTimer.stop();
		//Values.removeAll();
	}
	
}

DropPoints()
{
	blah=255;
	Drop_Val=0;
	Drop_ActualVal=0;
	DropPointsTimer.start();
}


getSpeed()
{	
	visSpeed = 10;

}






