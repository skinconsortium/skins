/********************************************************\
**  Filename:	xtramenu.m				**
**  Version:	1.0					**
**  Date:	03. Mrz. 2008 - 08:13 			**
**********************************************************
**  Type:	winamp.wasabi/maki			**
**  Project:	krazyPlayer				**
**********************************************************
**  Author:	Martin Poehlmann aka Deimos		**
**  quick fix: SLoB					**
**  E-Mail:	martin@skinconsortium.com		**
**  Internet:	http://www.skinconsortium.com		**
**		http://home.cs.tum.edu/~poehlman	**
\********************************************************/


#include <lib/std.mi>
#include <lib/config.mi>

#include "attribs/init_notifier.m"
#include "attribs.m"

#define IS0 getData()=="0"
#define IS1 getData()=="1"
#define ISm1 getData()=="-1"

Function toggle (ConfigAttribute ca);

Global ConfigAttribute ca_shuffle, ca_repeat, ca_xfade, ca_xfadet, ca_prefsPage;
Global Button trigger;
Global Layout cclay, about;

//SLoB - get guru error in this script if accessing about page, throw vis in here
Global Layer lyrbeatvis;
Global timer animTimer;

System.onScriptLoaded ()
{
	initAttribs();
	initAttribs_notifier();
	ConfigItem ci1 = config.getItemByGuid("{45F3F7C1-A6F3-4EE6-A15E-125E92FC3F8D}");
	ca_shuffle = ci1.getAttribute("Shuffle");
	ca_repeat = ci1.getAttribute("Repeat");

	ca_xfade = config.getItemByGuid("{FC3EAF78-C66E-4ED2-A0AA-1494DFCC13FF}").getAttribute("Enable crossfading");
	ca_xfadet = config.getItemByGuid("{F1239F09-8CC6-4081-8519-C2AE99FCB14C}").getAttribute("Crossfade time");

	trigger = getScriptGroup().findObject(getParam());
	
  	animTimer = new Timer;
  	animTimer.setDelay(30);
	
}

system.onScriptUnloading()
{
  	delete animTimer;	

}

trigger.onLeftClick ()
{
	//ConfigItem ci = Config.getItem("Winamp5");//ByGuid("{68A2EFD7-0FBB-4ef9-9D3A-590F943C2A73}");
	
	//ca_prefsPage = ci.getAttribute("Last Page");

	if (!cclay) cclay = getContainer("sc.colorchanger").getLayout("changer");
	if (!about) about = getContainer("about.skin").getLayout("normal");
	if (!lyrbeatvis) lyrbeatvis = about.findObject("about.beatvis");

	PopupMenu p = new popupMenu;
	p.addCommand("KrazyPlayer - Config Menu", -1, 0, 1);
	p.addSeparator();
	PopupMenu ps = new popupMenu;
	ps.addcommand("Off", 10, ca_shuffle.IS0, 0);
	ps.addcommand("On", 11, ca_shuffle.IS1, 0);
	p.addSubMenu(ps, "Playlist Shuffling");
	PopupMenu pr = new popupMenu;
	pr.addcommand("Off", 20, ca_repeat.IS0, 0);
	pr.addcommand("All", 21, ca_repeat.IS1, 0);
	pr.addcommand("Track", 19, ca_repeat.ISm1, 0);
	p.addSubMenu(pr, "Playlist Repeat");
	PopupMenu pc = new popupMenu;
	//pc.addcommand("Enable Crossfading", 30, ca_repeat.IS0, 0); SLoB - eh? its not repeat | Martin> eh, yep, damn copy'n'paste
	pc.addcommand("Enable Crossfading", 30, ca_xfade.IS1, 0);
	pc.addSeparator();
	for ( int i = 1; i <= 20; i++ )
	{
		pc.addcommand(integerToString(i)+" sec", 40 + i, ca_xfadet.getData() == integerToString(i), 0);
	}
	p.addSubMenu(pc, "Song Crossfading");
	p.addSeparator();
	
	PopupMenu pn = new popupMenu;

	pn.addcommand("Show always", 100, notifier_always_attrib.IS1, 0);
	pn.addcommand("Show only when minimized", 102, notifier_minimized_attrib.IS1, 0);
	pn.addcommand("Never show", 103, notifier_never_attrib.IS1, 0);
	pn.addSeparator();
	
	PopupMenu pnl = new popupMenu;
	PopupMenu pni = new popupMenu;
	PopupMenu pno = new popupMenu;

// Notifications > Location
	pnl.addcommand("Bottom Left", 110, notifier_loc_bl_attrib.IS1, 0);
	pnl.addcommand("Bottom Center", 111, notifier_loc_bc_attrib.IS1, 0);
	pnl.addcommand("Bottom Right", 112, notifier_loc_br_attrib.IS1, 0);
	pnl.addcommand("Top Left", 113, notifier_loc_tl_attrib.IS1, 0);
	pnl.addcommand("Top Center", 114, notifier_loc_tc_attrib.IS1, 0);
	pnl.addcommand("Top Right", 115, notifier_loc_tr_attrib.IS1, 0);
	pnl.addSeparator();
	pnl.addcommand("Relative to Viewport", 116, notifier_loc_vport_attrib.IS1, 0);
	pnl.addcommand("Relative to Monitor", 117, notifier_loc_monitor_attrib.IS1, 0);

	pn.addSubMenu(pnl, "Location");

// Notifications > Fade...
	pni.addcommand("Alpha Fade", 120, notifier_fdin_alpha.IS1, 0);
	pni.addcommand("Vertical Slide", 121, notifier_fdin_vslide.IS1, 0);
	pni.addcommand("Horizontal Slide", 122, notifier_fdin_hslide.IS1, 0);

	pn.addSubMenu(pni, "Fade In Effect");

	pno.addcommand("Alpha Fade", 130, notifier_fdout_alpha.IS1, 0);
	pno.addcommand("Vertical Slide", 131, notifier_fdout_vslide.IS1, 0);
	pno.addcommand("Horizontal Slide", 132, notifier_fdout_hslide.IS1, 0);

	pn.addSubMenu(pno, "Fade Out Effect");

	pn.addSeparator();
	pn.addcommand("Disable in fullscreen", 104, notifier_hideinfullscreen_attrib.IS1, 0);

	p.addSubMenu(pn, "Notifications");

	p.addSeparator();
	PopupMenu pb = new popupMenu;
	pb.addcommand("Enable Visualization", 71, vis_enabled_attrib.getData() == "1", 0);
	pb.addSeparator();
	pb.addcommand("VU - Dark to Light", 72, vis_mode_style_attrib.getData() == "0", 0);
	pb.addcommand("VU - Light to Dark", 73, vis_mode_style_attrib.getData() == "1", 0);
	p.addSubMenu(pb, "Beat Glow Viz");
	p.addcommand("Open RGB Color Changer", 70, cclay.isVisible(), 0);
	p.addSeparator();
	p.addcommand("About KrazyPlayer", 80, about.isVisible(), 0);	
	

	int res = p.popAtMouse();

	if (res < 10)
		return;
	else if (res < 12)
		ca_shuffle.setData(IntegerToString(res-10));
	else if (res < 22)
	{
		//System.messageBox(IntegerToString(res-20), "Debug Error", 0, "");
		ca_repeat.setData(IntegerToString(res-20));	
		
	}
	else if (res < 40)
	{
		//SLoB - martin this original logic dont work, this is a prefered way
		//ca_xfade.setData(IntegerToString(!ca_xfade.IS1));
		if (ca_xfade.getData() == "0") ca_xfade.setData("1");
		else ca_xfade.setData("0");
	}	
	else if (res < 70)
		ca_xfadet.setData(IntegerToString(res-40));
	else if (res == 70)
	{
		if (cclay.isVisible())
			cclay.hide();
		else
			cclay.show();
	}
	else if (res == 80)
	{
		if (about.isVisible())
		{
			if (animTimer.isRunning()) animTimer.stop();
			about.hide();
			
		}
		else
		{
			about.show();
			if (!animTimer.isRunning()) animTimer.start();
		}
	}
	else if (res == 71)
	{
		toggle(vis_enabled_attrib);
	}
	else if (res == 72)
	{
		vis_mode_style_attrib.setData("0");
	}
	else if (res == 73)
	{
		vis_mode_style_attrib.setData("1");
	}
	else if (res == 100)
		toggle(notifier_always_attrib);
	else if (res == 102)
		toggle(notifier_minimized_attrib);
	else if (res == 103)
		toggle(notifier_never_attrib);
	else if (res == 104)
		toggle(notifier_hideinfullscreen_attrib);
	else if (res == 110)
		toggle(notifier_loc_bl_attrib);
	else if (res == 111)
		toggle(notifier_loc_bc_attrib);
	else if (res == 112)
		toggle(notifier_loc_br_attrib);
	else if (res == 113)
		toggle(notifier_loc_tl_attrib);
	else if (res == 114)
		toggle(notifier_loc_tc_attrib);
	else if (res == 115)
		toggle(notifier_loc_tr_attrib);
	else if (res == 116)
		toggle(notifier_loc_vport_attrib);
	else if (res == 117)
		toggle(notifier_loc_monitor_attrib);
	else if (res == 120)
		toggle(notifier_fdin_alpha);
	else if (res == 121)
		toggle(notifier_fdin_vslide);
	else if (res == 122)
		toggle(notifier_fdin_hslide);
	else if (res == 130)
		toggle(notifier_fdout_alpha);
	else if (res == 131)
		toggle(notifier_fdout_vslide);
	else if (res == 132)
		toggle(notifier_fdout_hslide);
	else if (res == 104)
		toggle(notifier_hideinfullscreen_attrib);
	
}

animTimer.onTimer()
{
	int aboutbeatvis = ((System.getLeftVuMeter()+System.getRightVuMeter())/2);
	lyrbeatvis.setAlpha(aboutbeatvis);
	
	return;
  	
}

about.onSetVisible(boolean on)
{
  	if (on)
	{   
		if (!animTimer.isRunning()) animTimer.start();
  	}
	else
	{	
    	if (animTimer.isRunning()) animTimer.stop();
	}
}

toggle (ConfigAttribute ca)
{
	if (ca.getData() == "1")
	{
		ca.setData("0");		
	}
	else
	{
		ca.setData("1");
	}
}
