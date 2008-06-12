/*---------------------------------------------------
-----------------------------------------------------
Filename:	maincore.m
Version:	1.0

Type:		maki
Project:	CTI
Date:		22. Dez. 2006 - 21:39
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
-----------------------------------------------------
---------------------------------------------------*/

#include <lib/std.mi>
#include <lib/config.mi>
#include <lib/AutoRepeatButton.m>
#include attribs/init_general.m

/* Define Center Vars */
#define CENTER_VAR CButtons
#include <lib/centerlayer.m>
#undef CENTER_VAR

#define CENTER_VAR ModeSel
#include <lib/centerlayer.m>
#undef CENTER_VAR

#define CENTER_VAR VolGroup
#include <lib/centerlayer.m>
#undef CENTER_VAR

#define CENTER_VAR PModeGroup
#include <lib/centerlayer.m>
#undef CENTER_VAR

#define CENTER_VAR ConfigGroup
#include <lib/centerlayer.m>
#undef CENTER_VAR


/* Define Release Type */
#define DEBUG
#ifndef DEBUG
#define debugString //
#define ABORT_ { string s = 
#define _ABORT ; return; }
#endif

#ifdef DEBUG
#define ABORT_ { DebugString(
#define _ABORT , 0); return; }
#endif

#define Rock_preset "49,29,-39,-55,-27,25,57,69,69,69,"
#define Tech_preset "49,37,1,-39,-35,1,49,61,61,57,"
#define Cty_preset "22,22,12,-6,-26,-32,-19,-3,16,47,"
#define HipH_preset "60,64,70,68,52,28,12,0,-10,-10,"
#define Normal_preset "0,0,0,0,0,0,0,0,0,0"
#define Bass_preset "59,59,59,35,7,-31,-59,-71,-75,-75"
#define Soft_preset "27,7,-11,-19,-11,23,51,59,67,75"
#define Pop_preset "-15,27,43,47,31,-11,-19,-19,-15,-15"

#define SKINTWEAKS_CFGPAGE "{0542AFA4-48D9-4c9f-8900-5739D52C114F}"

Function setFullscreen (layout l);
Function fitInt (group g, int x, int rx, int y, int ry, int w, int rw, int h, int rh);
Function Int getAutoResWidth ();
Function Int getAutoResHeight ();
Function setColorThemeForTime ();

Function setDTtxt();

Function ripProtection();

Class ToggleButton InfoButton;

Global layout normal;
Global GuiObject g_modesel, g_cbuttons, g_volume, g_pmode;
Global Button b_play, b_pause, b_back, b_min, sel_pl, sel_ml, sel_vis, sel_cf, sel_aa;
Global InfoButton b_repeat, b_shuffle;
Global AutoRepeatButton arb_volup, arb_voldown, arp_fwd, arp_rwd;
Global GuiObject SongTicker;
Global group g_pl, g_ml, g_vis, g_config, g_vid, g_avs, g_aa;
Global button s_vis, s_vid, s_avs, s_vis2, s_avs2, s_vid2;
Global Button ct_next, ct_prev;
Global timer dte_tmr;

Global text t_ct_day, t_ct_night, t_cftime;

Global Boolean oneclick = FALSE;

Global String video_close, video_resize;
Global ConfigAttribute video_close_attrib, video_resize_attrib;

System.onScriptLoaded ()
{

	normal = System.getContainer("main").getLayout("normal");
	//ripProtection();

	AutoRepeat_Load();
	initAttribs_general();

	// Set Video Options

	ConfigItem item = Config.getItem(SKINTWEAKS_CFGPAGE);

	video_close_attrib = item.getAttribute("Prevent video playback Stop on video window Close");
	video_resize_attrib = item.getAttribute("Prevent video resize");

	video_close = video_close_attrib.getdata();
	video_close_attrib.setData("1");

	video_resize = video_resize_attrib.getdata();
	video_resize_attrib.setData("1");

	g_cbuttons = normal.getObject("player.cbuttons");
	g_modesel = normal.getObject("player.modeselect");
	g_volume = normal.getObject("player.volume");
	g_pmode = normal.getObject("player.playmode");

	b_play = g_cbuttons.findObject("play");
	b_pause = g_cbuttons.findObject("pause");

	b_repeat = g_pmode.findObject("repeat");
	b_shuffle = g_pmode.findObject("shuffle");

	arb_volup = g_volume.findObject("vol.up");
	arb_voldown = g_volume.findObject("vol.down");

	arp_fwd = normal.findObject("player.button.next");
	arp_rwd = normal.findObject("player.button.previous");

	SongTicker = normal.findObject("songticker");

	b_back = normal.getObject("player.button.back");
	b_min = normal.getObject("player.button.minimize");

	sel_pl = g_modesel.findObject("sel.pl");
	sel_ml = g_modesel.findObject("sel.ml");
	sel_vis = g_modesel.findObject("sel.vis");
	sel_cf = g_modesel.findObject("sel.cf");
	sel_aa = g_modesel.findObject("sel.aa");

	g_pl = normal.findObject("player.playlist");
	g_ml = normal.findObject("player.library");
	g_vis = normal.findObject("player.vis");
	g_vid = normal.findObject("player.vid");
	g_avs = normal.findObject("player.avs");
	g_config = normal.findObject("player.config");
	g_aa = normal.findObject("player.albumart");

	s_vis = g_vid.getObject("s.vis");
	s_vid = g_vis.findObject("s.vid");
	s_avs = g_vid.getObject("s.avs");
	s_avs2 = g_vis.findObject("s.avs");
	s_vis2 = g_avs.getObject("s.vis");
	s_vid2 = g_avs.findObject("s.vid");

	t_ct_day = g_config.findObject("info.day");
	t_ct_night = g_config.findObject("info.night");
	t_cftime = g_config.findObject("xfade.time");

	setDTtxt();

	string mode = getPrivateString(getskinName(), "HoldConfig", "sel");
	g_config.sendAction("switchto", mode, 0,0,0,0);

	if (getStatus() != 1)
	{
		b_play.show();
		b_pause.hide();
	}

	_CButtonsInit(g_cbuttons, normal, TRUE, FALSE);
	_ModeSelInit(g_modesel, normal, TRUE, TRUE);
	_VolGroupInit(g_volume, normal, FALSE, TRUE);
	_PModeGroupInit(g_pmode, normal, FALSE, TRUE);
	_ConfigGroupInit(g_config, normal, TRUE, TRUE);

	mode = getPrivateString(getskinName(), "Hold", "g_modesel");

	if (mode == "g_pl")
	{
		sel_pl.onLeftClick();
	}
	else if (mode == "g_ml")
	{
		sel_ml.onLeftClick();
	}
	else if (mode == "g_vis")
	{
		sel_vis.onLeftClick();
	}
	else if (mode == "g_config")
	{
		sel_cf.onLeftClick();
	}
	else if (mode == "g_vis")
	{
		s_vid.onLeftClick();
	}
	else if (mode == "g_avs")
	{
		s_avs.onLeftClick();
	}
	else if (mode == "g_aa")
	{
		sel_aa.onLeftClick();
	}

	setFullscreen(normal);

	ct_next = normal.getObject("d.cthemes.next");
	ct_prev = normal.getObject("d.cthemes.prev");

	dte_tmr = new Timer;
	dte_tmr.setDelay(1000);

	if (getPrivateInt(getskinName(), "Colorthemes.Autoswitch", 1))
	{
		dte_tmr.start();	
	}
	else
	{
		g_config.findObject("cthemes.autoswitch").setXmlParam("text", "OFF");
	}

	g_config.findObject("volume.mutemode").setXmlParam("text", getPrivateString(getSkinNAme(), "Mute.method", "Mute"));
	g_config.findObject("monitor.mode").setXmlParam("text", getPrivateString(getSkinNAme(), "Monitor.mode", "Monitor"));
	g_config.findObject("vis.lclick").setXmlParam("text", getPrivateString(getSkinNAme(), "vis.lclick", "Next Preset"));
	crossfade_time_attrib.onDataChanged ();

	setFullscreen(normal);
}

System.onScriptUnloading ()
{
	//set back original values
	video_close_attrib.setData(video_close);
	video_resize_attrib.setData(video_resize);

	AutoRepeat_Unload();
	dte_tmr.stop();
	delete dte_tmr;
}


/*---------------------------------------------------
	play/pause handles
---------------------------------------------------*/

System.onPlay ()
{
	b_play.hide();
	b_pause.show();	
}

System.onResume ()
{
	b_play.hide();
	b_pause.show();	
}

System.onStop ()
{
	b_play.show();
	b_pause.hide();	
}

System.onPause ()
{
	b_play.show();
	b_pause.hide();		
}

/*---------------------------------------------------
	Component Switcher
---------------------------------------------------*/

b_back.onLeftClick ()
{
	if (getPrivateString(getskinName(), "Hold", "g_modesel") == "g_config")
	{
		if (getPrivateString(getskinName(), "HoldConfig", "sel") != "sel")
		{
			g_config.sendAction("switchto", "sel", 0,0,0,0);
			setPrivateString(getskinName(), "HoldConfig", "sel");
			return;
		}
	}
	setPrivateString(getskinName(), "Hold", "g_modesel");
	b_back.hide();
	b_min.show();

	g_modesel.show();
	g_pl.hide();
	g_ml.hide();
	g_vis.hide();
	g_vid.hide();
	g_avs.hide();
	g_config.hide();
	g_aa.hide();
}

sel_aa.onLeftClick ()
{
	setPrivateString(getskinName(), "Hold", "g_aa");
	b_back.show();
	b_min.hide();

	g_modesel.hide();
	g_aa.show();
}

sel_pl.onLeftClick ()
{
	setPrivateString(getskinName(), "Hold", "g_pl");
	b_back.show();
	b_min.hide();

	g_modesel.hide();
	g_pl.show();
}

sel_ml.onLeftClick ()
{
	setPrivateString(getskinName(), "Hold", "g_ml");
	b_back.show();
	b_min.hide();

	g_modesel.hide();
	g_ml.show();
}

sel_vis.onLeftClick ()
{
	setPrivateString(getskinName(), "Hold", "g_vis");
	b_back.show();
	b_min.hide();

	g_modesel.hide();
	g_vis.show();
}

sel_cf.onLeftClick ()
{
	setPrivateString(getskinName(), "Hold", "g_config");
	b_back.show();
	b_min.hide();

	g_modesel.hide();
	g_config.show();
}

s_vis.onLeftClick ()
{
	setPrivateString(getskinName(), "Hold", "g_vis");
	b_back.show();
	b_min.hide();

	g_modesel.hide();
	g_vid.hide();
	g_avs.hide();
	g_vis.show();
}

s_vid.onLeftClick ()
{
	setPrivateString(getskinName(), "Hold", "g_vid");
	b_back.show();
	b_min.hide();

	g_modesel.hide();
	g_vis.hide();
	g_avs.hide();
	g_vid.show();
}

s_avs.onLeftClick ()
{
	setPrivateString(getskinName(), "Hold", "g_avs");
	b_back.show();
	b_min.hide();

	g_modesel.hide();
	g_vis.hide();
	g_vid.hide();
	g_avs.show();
}

s_vis2.onLeftClick ()
{
	setPrivateString(getskinName(), "Hold", "g_vis");
	b_back.show();
	b_min.hide();

	g_modesel.hide();
	g_vid.hide();
	g_avs.hide();
	g_vis.show();
}

s_vid2.onLeftClick ()
{
	setPrivateString(getskinName(), "Hold", "g_vid");
	b_back.show();
	b_min.hide();

	g_modesel.hide();
	g_vis.hide();
	g_avs.hide();
	g_vid.show();
}

s_avs2.onLeftClick ()
{
	setPrivateString(getskinName(), "Hold", "g_avs");
	b_back.show();
	b_min.hide();

	g_modesel.hide();
	g_vis.hide();
	g_vid.hide();
	g_avs.show();
}

/*---------------------------------------------------
	Our ConfigTarget
---------------------------------------------------*/

g_config.onAction (String action, String param, Int x, int y, int p1, int p2, GuiObject source)
{
	if (strlower(action) == "switchto")
	{
		int n = g_config.getNumObjects();
		for ( int i = 0; i < n; i++ )
		{
			g_config.enumoBject(i).hide();
		}
		g_config.getObject("player.config." + param).show();
		setPrivateString(getskinName(), "HoldConfig", param);
		return;
	}
	if (strlower(action) == "ct.autoswitch")
	{
		if (param == "toggle")
		{
			Button t = source;
			if (t.getXmlParam("text") == "ON") {
				t.setXmlParam("text", "OFF");
				setPrivateInt(getskinName(), "Colorthemes.Autoswitch", 0);
				dte_tmr.stop ();
			}
			else
			{
				t.setXmlParam("text", "ON");
				setPrivateInt(getskinName(), "Colorthemes.Autoswitch", 1);
				dte_tmr.start ();
				setColorThemeForTime ();
			}
			return;
		}
		if (param == "d.up")
		{
			int dt = getPrivateInt(getskinName(), "Colorthemes.Autoswitch.Day", 8);
			dt++;
			if (dt == getPrivateInt(getskinName(), "Colorthemes.Autoswitch.Night", 22)) return;
			if (dt > 23) dt = 0;
			setPrivateInt(getskinName(), "Colorthemes.Autoswitch.Day", dt);
			setDTtxt ();
			setColorThemeForTime ();
			return;
		}
		if (param == "d.down")
		{
			int dt = getPrivateInt(getskinName(), "Colorthemes.Autoswitch.Day", 8);
			dt--;
			if (dt == getPrivateInt(getskinName(), "Colorthemes.Autoswitch.Night", 22)) return;
			if (dt < 0) dt = 23;
			setPrivateInt(getskinName(), "Colorthemes.Autoswitch.Day", dt);
			setDTtxt ();
			setColorThemeForTime ();
			return;
		}
		if (param == "n.up")
		{
			int dt = getPrivateInt(getskinName(), "Colorthemes.Autoswitch.Night", 22);
			dt++;
			if (dt == getPrivateInt(getskinName(), "Colorthemes.Autoswitch.Day", 8)) return;
			if (dt > 23) dt = 0;
			setPrivateInt(getskinName(), "Colorthemes.Autoswitch.Night", dt);
			setDTtxt ();
			setColorThemeForTime ();
			return;
		}
		if (param == "n.down")
		{
			int dt = getPrivateInt(getskinName(), "Colorthemes.Autoswitch.Night", 22);
			dt--;
			if (dt == getPrivateInt(getskinName(), "Colorthemes.Autoswitch.Day", 8)) return;
			if (dt < 0) dt = 23;
			setPrivateInt(getskinName(), "Colorthemes.Autoswitch.Night", dt);
			setDTtxt ();
			setColorThemeForTime ();
			return;
		}
	}
	if (strlower(action) == "seteq")
	{
		if (strlower(param) == "normal")
		{
			for (Int i = 0; i <= 9; i++) {
				System.SetEqBand(i,StringtoInteger(GetToken(Normal_preset,",",i)));
			}
		}
		if (strlower(param) == "pop")
		{
			for (Int i = 0; i <= 9; i++) {
				System.SetEqBand(i,StringtoInteger(GetToken(Pop_preset,",",i)));
			}
		}
		if (strlower(param) == "rock")
		{
			for (Int i = 0; i <= 9; i++) {
				System.SetEqBand(i,StringtoInteger(GetToken(Rock_preset,",",i)));
			}
		}
		if (strlower(param) == "bass")
		{
			for (Int i = 0; i <= 9; i++) {
				System.SetEqBand(i,StringtoInteger(GetToken(Bass_preset,",",i)));
			}
		}
		if (strlower(param) == "techno")
		{
			for (Int i = 0; i <= 9; i++) {
				System.SetEqBand(i,StringtoInteger(GetToken(Tech_preset,",",i)));
			}
		}
		if (strlower(param) == "techno")
		{
			for (Int i = 0; i <= 9; i++) {
				System.SetEqBand(i,StringtoInteger(GetToken(Tech_preset,",",i)));
			}
		}
		if (strlower(param) == "soft")
		{
			for (Int i = 0; i <= 9; i++) {
				System.SetEqBand(i,StringtoInteger(GetToken(Soft_preset,",",i)));
			}
		}
		if (strlower(param) == "country")
		{
			for (Int i = 0; i <= 9; i++) {
				System.SetEqBand(i,StringtoInteger(GetToken(Cty_preset,",",i)));
			}
		}
		string txt = strupper(param);
		SongTicker.sendAction
		(
			"showinfo",
			"EqPreset: " + txt,
			0, 0, 0, 0
		);
		return;
	}
	if (strlower(action) == "volume")
	{
		if (strlower(param) == "mutemode")
		{
			if (source.getXmlParam("text") == "Mute") {
				source.setXmlParam("text", "Attenuate");
				setPrivateString(getSkinNAme(), "Mute.method", "Attenuate");
				return;
			}
			else
			{
				source.setXmlParam("text", "Mute");
				setPrivateString(getSkinNAme(), "Mute.method", "Mute");
				return;
			}
			return;			
		}
		else
		{
			setPrivateInt(getSkinNAme(), "Volume.rate", stringToInteger(param));
			SongTicker.sendAction
			(
				"showinfo",
				"Volume Rate: " + param + " %",
				0, 0, 0, 0
			);
			return;
		}
	}
	if (strlower(action) == "seek")
	{
		setPrivateInt(getSkinNAme(), "Seek.rate", stringToInteger(param));
		SongTicker.sendAction
		(
			"showinfo",
			"Seek Rate: " + param + " sec",
			0, 0, 0, 0
		);
		return;
	}
	if (strlower(action) == "monitormode")
	{
		if (source.getXmlParam("text") == "Monitor") {
			setPrivateString(getSkinNAme(), "Monitor.mode", "ViewPort");
			source.setXmlParam("text", "ViewPort");
			setFullscreen(normal);
			return;
		}
		if (source.getXmlParam("text") == "ViewPort") {
			setPrivateString(getSkinNAme(), "Monitor.mode", "Monitor");
			source.setXmlParam("text", "Monitor");
			setFullscreen(normal);
			return;
		}
	}
	if (strlower(action) == "visualizer" && strlower(param) == "lclick")
	{
		if (source.getXmlParam("text") == "Next Preset") {
			setPrivateString(getSkinNAme(), "vis.lclick", "Open Menu");
			source.setXmlParam("text", "Open Menu");
			setFullscreen(normal);
			return;
		}
		if (source.getXmlParam("text") == "Open Menu") {
			setPrivateString(getSkinNAme(), "vis.lclick", "Next Preset");
			source.setXmlParam("text", "Next Preset");
			setFullscreen(normal);
			return;
		}
	}
}


/*---------------------------------------------------
	Volume Handles
---------------------------------------------------*/

arb_volup.onLeftClick ()
{
	if (AutoRepeat_ClickType == 0)
	{
		return;
	}
	else
	{
		int vol = System.getVolume();
		vol += getPrivateInt(getSkinNAme(), "Volume.rate", 2)*2.55;
		if (vol > 255)
		{
			vol = 255;
		}
		System.setVolume(vol);
	}	
}

arb_voldown.onLeftClick ()
{
	if (AutoRepeat_ClickType == 0)
	{
		return;
	}
	else
	{
		int vol = System.getVolume();
		vol -= getPrivateInt(getSkinNAme(), "Volume.rate", 2)*2.55;
		if (vol < 0)
		{
			vol = 0;
		}
		System.setVolume(vol);
	}	
}

/*System.onvolumechanged(int newvol)
{
	if (getPrivateInt(getSkinNAme(), "muted", 0)) return;
	SongTicker.sendAction
		(
			"showinfo",
			"Volume:" + System.integerToString(newvol/2.55) + " %",
			0, 0, 0, 0
	);
}*/

/*---------------------------------------------------
	Seek Handles
---------------------------------------------------*/

arp_fwd.onLeftClick ()
{
	if (AutoRepeat_ClickType != 2)
	{
		if (AutoRepeat_ClickType == 1)
		{
			oneclick = TRUE;
		}
		return;
	}
	else
	{
		oneclick = FALSE;
		int pos = System.getPosition();
		pos += getPrivateInt(getSkinNAme(), "Seek.rate", 5)*1000;
		System.seekTo(pos);
	}	
}

arp_rwd.onLeftClick ()
{
	if (AutoRepeat_ClickType != 2)
	{
		if (AutoRepeat_ClickType == 1)
		{
			oneclick = TRUE;
		}
		return;
	}
	else
	{
		oneclick = FALSE;
		int pos = System.getPosition();
		pos -= getPrivateInt(getSkinNAme(), "Seek.rate", 5)*1000;
		if (pos < 0) pos = 0;
		System.seekTo(pos);
	}	
}

arp_fwd.onLeftButtonUp (int x, int y)
{
	if (oneclick == TRUE)
	{
		system.Next();
	}
	oneclick = FALSE;
}

arp_rwd.onLeftButtonUp (int x, int y)
{
	if (oneclick == TRUE)
	{
		system.Previous();
	}
	oneclick = FALSE;
}


/*System.onSeek (int newpos)
{
	Int f;
	int len = getPlayItemLength();
	f = newpos;
	f = f / len * 100;
	if (len != 0) {
		SongTicker.sendAction
		(
			"showinfo",
			"SEEK: " + integerToTime(newpos) + "/" + integerToTime(len) + " (" + integerToString(f) + "%) ",
			0, 0, 0, 0
		);
	}
}*/


/*---------------------------------------------------
	Colortheme Switching
---------------------------------------------------*/

dte_tmr.onTimer ()
{
	dte_tmr.setDelay(60000);
	setColorThemeForTime ();
}


setColorThemeForTime ()
{
	int TIME = getDateHour(getDate());
	string CT = strlower(getPublicString("Color Themes/" + getSkinName(), "error"));

	if (CT == "error")
	{
		return;
	}
	int dtn = getPrivateInt(getskinName(), "Colorthemes.Autoswitch.Night", 22);
	int dtd = getPrivateInt(getskinName(), "Colorthemes.Autoswitch.Day", 8);

	if (dtn > dtd)
	{
		if (TIME >= dtn || TIME <= dtd)
		{
			if (strsearch(CT, "night") == -1)
			{
				ct_next.leftClick();
			}
		}
		else
		{
			if (strsearch(CT, "day") == -1)
			{
				ct_prev.leftClick();
			}		
		}		
	}
	else
	{
		if (TIME >= dtn && TIME <= dtd)
		{
			if (strsearch(CT, "night") == -1)
			{
				ct_next.leftClick();
			}
		}
		else
		{
			if (strsearch(CT, "day") == -1)
			{
				ct_prev.leftClick();
			}		
		}			
	}
}

setDTtxt ()
{
	int dt = getPrivateInt(getskinName(), "Colorthemes.Autoswitch.Day", 8);

	string suffix = " AM";
	if (dt > 12)
	{
		dt -= 12;
		suffix = " PM";
	}

	t_ct_day.settext(integerToString(dt) + suffix);

	int dt = getPrivateInt(getskinName(), "Colorthemes.Autoswitch.Night", 22);

	suffix = " AM";
	if (dt > 12)
	{
		dt -= 12;
		suffix = " PM";
	}

	t_ct_night.settext(integerToString(dt) + suffix);
}

/*---------------------------------------------------
	Info Messages from Buttons
---------------------------------------------------*/

/*InfoButton.onLeftClick ()
{
	if (InfoButton == b_crossfade)
	{
		if (getCurCfgVal() == 1)
		{
			SongTicker.sendAction("showinfo", "Crossfade: On", 0, 0, 0, 0);
		}
		else
		{
			SongTicker.sendAction("showinfo", "Crossfade: Off", 0, 0, 0, 0);
		}
	}
	else if (InfoButton == b_shuffle)
	{
		if (getCurCfgVal() == 1)
		{
			SongTicker.sendAction("showinfo", "Shuffle: On", 0, 0, 0, 0);
		}
		else
		{
			SongTicker.sendAction("showinfo", "Shuffle: Off", 0, 0, 0, 0);
		}
	}
	else if (InfoButton == b_repeat)
	{
		if (getCurCfgVal() == 1)
		{
			SongTicker.sendAction("showinfo", "Repeat: Playlist", 0, 0, 0, 0);
		}
		else if (getCurCfgVal() == -1)
		{
			SongTicker.sendAction("showinfo", "Repeat: Track", 0, 0, 0, 0);
		}
		else if (getCurCfgVal() == 0)
		{
			SongTicker.sendAction("showinfo", "Repeat: Off", 0, 0, 0, 0);
		}
	}
}
*/
crossfade_time_attrib.onDataChanged ()
{
	t_cftime.setText(getData() + " sec");
}


/*---------------------------------------------------
	set fullscreen stuff
---------------------------------------------------*/

normal.onResize (int x, int y, int w, int h)
{
	if (getPrivateString(getSkinNAme(), "Monitor.mode", "Monitor") == "Monitor")
	{
		if (x != 0 || y != 0)
		{
			setFullscreen(normal);
		}
	}
}

normal.onMove ()
{
	if (getPrivateString(getSkinNAme(), "Monitor.mode", "Monitor") == "Monitor")
	{
		if (getLeft() != 0 || getTop() != 0)
		{
			setFullscreen(normal);
		}
	}
}


normal.onScale (Double newscalevalue)
{
	setFullscreen(normal);
}

setFullscreen (layout l)
{
	if (!l) ABORT_ "setFullscreen () -> Unexisting Layout!" _ABORT
	double d = l.getScale();
	int x = 0, y = 0;
	if (getPrivateString(getSkinNAme(), "Monitor.mode", "Monitor") != "Monitor")
	{
		y = getViewPortTop();
		x = getViewPortLeft();
	}
	fitInt (l,
		x, 0,
		y, 0,
		getAutoResWidth() / d, 0,
		getAutoResHeight() / d, 0
	);
}

Int getAutoResWidth ()
{
	int w = getMonitorWidth();
	if (w == NULL)
	{
		// if we have wa5.03 - 5.32
		string s;
		int i = messageBox ("This skin requires Winamp 5.33 or any newer version to run!\nDo you wish to downlaod the newest version now?\n\nIf you choose YES, Winamp will close now and start the download!\nIf you click NO Winamp will switch to default Modern Skin\n", "Wrong Winamp Version" , 4, s);
		if (i == 4)
		{
			system.navigateUrl("http://www.winamp.com/player");
			button b = normal.getObject("player.button.close");
			b.leftclick();
		}
		else
		{
			System.switchSkin("Winamp Modern");
		}
		return;
	}
	else
	{
		// if we have wa5.33+
		if (getPrivateString(getSkinNAme(), "Monitor.mode", "Monitor") == "Monitor")
		{
			if (w < 600)
			{
				normal.setScale(0.75);
			}
			return w;
		}
		else
		{
			w = getViewPortWidth();
			if (w < 600)
			{
				normal.setScale(0.75);
			}
			return getViewPortWidth();
		}
	}
}

Int getAutoResHeight ()
{
	// if we have wa5.33+
	if (getPrivateString(getSkinName(), "Monitor.mode", "Monitor") == "Monitor")
	{
		int h = getMonitorHeight();
		if (h < 480)
		{
			normal.setScale(0.75);
		}
		return h;
	}
	else
	{
		int h = getViewPortHeight();
		if (h < 480)
		{
			normal.setScale(0.75);
		}
		return h;
	}
}

fitInt (group g, int x, int rx, int y, int ry, int w, int rw, int h, int rh)
{
	if (!g) ABORT_ "fitInt () -> Unexisting GuiObject!" _ABORT

	g.setXmlParam("x", integerToString(x));
	g.setXmlParam("y", integerToString(y));
	g.setXmlParam("w", integerToString(w));
	g.setXmlParam("h", integerToString(h));
	g.setXmlParam("relatx", integerToString(rx));
	g.setXmlParam("relaty", integerToString(ry));
	g.setXmlParam("relatw", integerToString(rw));
	g.setXmlParam("relath", integerToString(rh));
}

ripProtection() {
	boolean qu = 0;
	if (strsearch(strlower(getSkinName()), "nitrous audio - cti") < 0) 
	{
		qu = 1;
	}

	string ppath = strleft(getParam(),System.strsearch(getParam(), "ColorThemes")) + "Plugins\\avs\\nwhite.jpg";
	map m = new map;
	m.loadMap(ppath);
	if (m.getWidth() != 5 || m.getheight() != 5) {
		qu = 1;
	}
	delete m;

	if (qu == 1)
	{
		messageBox("CTI doesn't run in the same enviroment you have installed it!\nWinamp will close now!\nPlease reinstall the product or contact info@nitrousaudio.com!", "Rip Protection", 1, "");
		button b = normal.getObject("player.button.close");
		b.leftclick();		
	}
}