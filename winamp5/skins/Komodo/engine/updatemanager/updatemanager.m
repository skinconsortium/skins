/********************************************************\
**  Filename:	updateSystem.m				**
**  Version:	3.0					**
**  Date:	19. Mrz. 2008 - 11:45			**
**********************************************************
**  Type:	winamp.wasabi/XUI Object		**
**  Project:	misc					**
**********************************************************
**  Author:	Martin Poehlmann aka Deimos		**
**  E-Mail:	martin@skinconsortium.com		**
**  Internet:	http://www.skinconsortium.com		**
**		http://home.cs.tum.edu/~poehlman	**
\********************************************************/


#include <lib/std.mi>
#include <lib/exd.mi>

#define SERVERFILE "http://www.skinconsortium.com/updatemanager/updateSystem.php"

Function shutdownScript();

Global Browser brw;

Global String str_skinname, str_version;
Global String url;
Global int ready = 0;
Global boolean done;

Global Timer tmr_fill;
Global Map map_fill;
Global layer l_fill;
Global layer l_txt;
Global Container c_updater;
Global Layout l_updater;
Global int finished = 0;
Global int mappos;
Global Button btn_cancel, btn_donate;

System.onScriptLoaded ()
{
	if (!getPrivateInt(getSkinName(), "Check for Updates", 1))
		return;

	c_updater = System.getContainer("sc.updatemanager");
	if (c_updater == null)
		return shutdownScript();

	l_updater = c_updater.getLayout("normal");
	if (l_updater == null)
		return shutdownScript();

	brw = l_updater.findObject("brw");
	if (brw == null)
		return shutdownScript();

	brw.setCancelIEErrorPage(true);

	l_fill = l_updater.findObject("progress");
	l_txt = l_updater.findObject("txt");

	btn_cancel = l_updater.findObject("cancel");
	//btn_donate = l_updater.findObject("donate");

	str_skinname = getToken(getParam(), ";", 0);
	str_version = getToken(getParam(), ";", 1);

	map_fill = new Map;
	map_fill.loadMap("sc.updatemanager.progress.map");

	mappos = -20;

	tmr_fill = new Timer;
	tmr_fill.setDelay(200);
	tmr_fill.start();
}

System.onScriptUnloading ()
{
	shutdownScript();
	delete tmr_fill;
}

tmr_fill.onTimer ()
{
	if (finished == -1)
	{
		shutdownScript();
		return;
	}
	
	mappos++;
	if (mappos < 0) return;

	if (mappos == 0)
	{
		c_updater.show();
		l_updater.center();
		brw.navigateUrl(SERVERFILE + "?noheaderquit=1&q=check&skin=" + str_skinname + "&version=" + str_version);
		//tmr_fill.setDelay(200);
	}
	
	if (mappos >= map_fill.getWidth())
	{
		if (!finished)
		{
			brw.navigateUrl("about:blank");
			l_txt.setXmlParam("image", "sc.updatemanager.txt.na");
			finished = -1;
			tmr_fill.setDelay(2000);
		}
		return;
	}
	
	l_fill.setRegionFromMap(map_fill, map_fill.getValue(mappos, 0), 1);
}


// The browser is used as interface between the skin and our server
brw.onDocumentComplete (String url)
{
	// Once we've started to querry our server we might get a response via redirection
	// skinupdate.php will redirect to skinupdate.php?avmsg=somemessage&blank=0 if a new version is available.
	// you can response to this site via skinupdate.php?download=1&skin=xxx
	// blank=0 means that you should response in this browser, blank=1 will tell you that it's better to open a browser wnd
	
	if (done)
		return;	

	String query = getToken(url, "?", 1);		// Get URL Query

	if (strsearch(query, "avmsg=") != -1)		// There is a new version available
	{
		done = true;				// Set flag, so this will be the last handled response

		tmr_fill.stop();
		mappos = map_fill.getWidth()-1;
		l_fill.setRegionFromMap(map_fill, map_fill.getValue(mappos, 0), 1);
		l_txt.setXmlParam("image", "sc.updatemanager.txt.av");
		btn_cancel.setXmlParam("ghost", "1");

		// Extract the message to be displayed later on
		String msg = getToken(query, "&", 0);	// Per definition avmsg= should be the 1st param
		msg = getToken(msg, "=", 1);		// Now we've the raw message

		while(strsearch(msg, "%20") != -1)	// Replace every '%40' with a space
			msg = replaceString(msg, "%20", " ");

		while(strsearch(msg, "%40") != -1)	// replace every '%40' with a new line char --  dunno if there is a real sombol instead of %40
			msg = replaceString(msg, "%40", "\n");

		// Display the messagebox
		int i_upd = messageBox(
			"A new version of this skin is available!\n\n" 
			+ msg
			+ "\n\nDo you like to download this version?"
			, "New Version Available", 12, "");

		if (i_upd == 4)				// if user clicks YES, we'll start downloading
		{
			String dl_invoke = SERVERFILE + "?q=get&skin=" + str_skinname;
			if (strsearch(query, "blank=1") != -1)
			{
				System.navigateUrl(dl_invoke);
				tmr_fill.setDelay(200);
			}
			else
			{
				brw.navigateUrl(dl_invoke);
				tmr_fill.setDelay(2000);
			}
		}
		else
		{
			tmr_fill.setDelay(200);	
		}
		finished = -1;
		tmr_fill.start();
	}
	else if (query == "notavailable")
	{
		tmr_fill.setdelay(5);
	}	
}

shutdownScript()
{
	if (finished == -2) return;
	finished = -2;
	if (tmr_fill) tmr_fill.stop();
	delete map_fill;
	if (c_updater) c_updater.hide();
}

btn_cancel.onLeftClick ()
{
	shutdownScript();
}
/*
btn_donate.onLeftClick ()
{
	System.navigateUrl("https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=donate%40skinconsortium%2ecom&item_name=SkinConsortium%20Donation&item_number=%3e%20for%20skin%3a%20"+str_skinname+"&no_shipping=1&no_note=1&cn=Optional%20Message&tax=0&currency_code=EUR&lc=GB&bn=PP%2dDonationsBF&charset=UTF%2d8");
}
*/