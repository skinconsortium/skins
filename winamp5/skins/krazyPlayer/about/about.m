/*********************************************************************
SLoB for krazyPlayer 2008
	http://www.skinconsortium.com	
	  ,,,      
	(o o)     
 -ooO--(_)--Ooo-
 
*********************************************************************/

#include <lib/std.mi>
#define bvsensitivity 1.2
Global Container contAbout;
Global Layout layAbout;
Global Group aboutGroup;
Global Layer lyrbeatvis;

Global timer animTimer;
Global int bvlastBeatLeft;


System.onScriptLoaded() {

	
	contAbout = getContainer("about.skin");
	layAbout = contAbout.getLayout("normal");
	
	lyrbeatvis = layAbout.findObject("about.beatvis");

  	animTimer = new Timer;
  	animTimer.setDelay(30);

}

system.onScriptUnloading()
{
  	delete animTimer;	
  	aboutGroup = NULL; // clears all instances  	
}

layAbout.onSetVisible(boolean on)
{
  	if (on)
	{   		
    	animTimer.start();
  	}
	else
	{	
    	animTimer.stop();
	}
}


animTimer.onTimer()
{
	//reverted back to old version minus the suppression - need to still use as much of the spectrum as possible
	int aboutbeatvis = ((System.getLeftVuMeter()+System.getRightVuMeter())/2)*bvsensitivity;
	
	if(aboutbeatvis > 255) aboutbeatvis =255;

	int bvframeLeft=aboutbeatvis;
	
	if (bvframeLeft<bvlastBeatLeft)
	{
		aboutbeatvis=bvlastBeatLeft-25.5;
		if (aboutbeatvis<0) aboutbeatvis=0;
	}

	lyrbeatvis.setAlpha(bvframeLeft);
	
	bvlastBeatLeft=bvframeLeft;	
	
	return;
  	
}