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
//define SERVERFILE "http://localhost/updateSystem/updateSystem.php"

Global Browser brw;

Global String str_skinname, str_version;
Global String url;
Global int ready = 0;
Global boolean done;

System.onScriptLoaded ()
{
	if (!getPrivateInt(getSkinName(), "Check for Updates", 1))
		return; // we quit savely

	brw = getScriptgroup().findObject("brw");

	if (ready == 2) brw.navigateUrl(SERVERFILE + "?q=check&skin=" + str_skinname + "&version=" + str_version);
}

System.onSetXuiParam (String param, String value)
{
	if (strlower(param) == "skinname")
	{
		str_skinname = value;
		ready++;
	}
	else if (strlower(param) == "skinversion")
	{
		str_version = value;
		ready++;		
	}

	if (ready == 2 && brw != null)
	{
		brw.navigateUrl(SERVERFILE + "?q=check&skin=" + str_skinname + "&version=" + str_version);
	}
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
			+ "\n\nWould you like to download this version?"
			, "New Version Available", 12, "");

		if (i_upd == 4)				// if user clicks YES, we'll start downloading
		{
			String dl_invoke = SERVERFILE + "?q=get&skin=" + str_skinname;
			if (strsearch(query, "blank=1") != -1)
				System.navigateUrl(dl_invoke);
			else
				brw.navigateUrl(dl_invoke);
		}
	}
}