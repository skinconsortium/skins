/*---------------------------------------------------
-----------------------------------------------------
Filename:	notifier.m
Version:	1.1 / lite

Type:		maki/notifier
Date:		15. Okt. 2006 - 22:23 
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
Credits:	Token from Winamp Modern
-----------------------------------------------------
---------------------------------------------------*/

#include <lib/std.mi>
#include "../../scripts/attribs/init_notifier.m"


Function reset();
Function createNotifier();
Function showNotifier(Int w);
Function onNext();

Function Int fillNextTrackInfo(String corneroverride);
Function Int fillCustomInfo(String customstring);

Function checkPref(int bypassfs);

Global Container notifier_container;
Global Layout notifier_layout;
Global Timer notifier_timer;
Global String last_autotitle;
Global layer NotifierCover, NotifierCoverGlass;
Global group grpNotifierText;

Function Noti_UpdateCDCover();
Function String Noti_GetSkinPath(String strRaw);
Function Noti_Cover_getLocal();
Function Noti_getMediaPath();
Global int localfound;
Global Boolean b_tohide = 0;
Global int yOffset, sy;
Global guiobject notired, notigreen, notiblue;
Global guiobject danotired, danotigreen, danotiblue;

// ------------------------------------------------------------------------------
// init
// ------------------------------------------------------------------------------
System.onScriptLoaded() {

	initAttribs_notifier();
	

	
	yOffset = system.getPrivateInt("Ebonite", "yoffset", 20); //default
	
	if(yOffset==20)	notifier_ypos_20_attrib.setData("1");
	if(yOffset==40)	notifier_ypos_40_attrib.setData("1");
	if(yOffset==60)	notifier_ypos_60_attrib.setData("1");
	if(yOffset==80)	notifier_ypos_80_attrib.setData("1");
	if(yOffset==100) notifier_ypos_100_attrib.setData("1");
	
	if(yOffset==0)
	{
		notifier_ypos_20_attrib.setData("0");
		notifier_ypos_40_attrib.setData("0");
		notifier_ypos_60_attrib.setData("0");
		notifier_ypos_80_attrib.setData("0");
		notifier_ypos_100_attrib.setData("0");		
	}
	
	

	notifier_timer = new Timer;
	
	//createNotifier();
	
  
  /*
	if(notifier_showcover_attrib.getData()=="1")
	{
		NotifierCover.show();
	}
	else
	{
		NotifierCover.hide();
	}
  */
  
}


notifier_showcover_attrib.onDataChanged()
{
	createNotifier();
	
	if(getData()=="1")
	{
		NotifierCover.show();
	}
	else
	{
		NotifierCover.hide();
	
	}
}  


// ------------------------------------------------------------------------------
// shutdown
// ------------------------------------------------------------------------------
System.onScriptUnloading() {
  delete notifier_timer;
  
  system.setPrivateInt("Ebonite", "yoffset", yOffset);
    
}

// ------------------------------------------------------------------------------
// called by the system when the global hotkey for notification is pressed
// ------------------------------------------------------------------------------
System.onShowNotification() {
  if (checkPref(1)) return;
  createNotifier();
  String str;
  if (getStatus() == STATUS_PLAYING) str = "Playing";
  if (getStatus() == STATUS_PAUSED) str = "Playback Paused";
  if (getStatus() == STATUS_STOPPED) str = "Playback Stopped";
  showNotifier(fillNextTrackInfo(str));
  complete; // prevents other scripts from getting the message
  return 1; // tells anybody else that might watch the returned value that, yes, we implemented that
}

// ------------------------------------------------------------------------------
// called by the system when the title for the playing item changes, this could be the result of the player
// going to the next track, or of an update in the track title
// ------------------------------------------------------------------------------
System.onTitleChange(String newtitle) {
  if (last_autotitle == newtitle) return;
  if (StrLeft(newtitle, 1) == "[") {
    if (StrLeft(newtitle, 7) == "[Buffer" ||
        StrLeft(newtitle, 4) == "[ICY") return;
  }
  last_autotitle = newtitle;
  onNext();
}

// ------------------------------------------------------------------------------
// called by the system when the user clicks the next button
// ------------------------------------------------------------------------------
onNext() {
  if (checkPref(0)) return;
  createNotifier();
  showNotifier(fillNextTrackInfo(""));

		//Noti_updateCDCover();

}

// ------------------------------------------------------------------------------
// called by the system when the user clicks the play button
// ------------------------------------------------------------------------------
System.onPlay() {
  if (checkPref(0)) return;
  createNotifier();
  showNotifier(fillNextTrackInfo("Playing"));
  
	
		//Noti_updateCDCover();

  
}

// ------------------------------------------------------------------------------
// called by the system when the user clicks the pause button
// ------------------------------------------------------------------------------
System.onPause() {
  if (checkPref(0)) return;
  createNotifier();
  showNotifier(fillCustomInfo("Playback Paused"));

		//Noti_updateCDCover();


}

// ------------------------------------------------------------------------------
// called by the system when the user clicks the pause button again
// ------------------------------------------------------------------------------
System.onResume() {
  if (checkPref(0)) return;
  createNotifier();
  showNotifier(fillNextTrackInfo("Playback Resumed"));

		//Noti_updateCDCover();
	

}

// ------------------------------------------------------------------------------
// called by the system when the user clicks the play button
// ------------------------------------------------------------------------------
System.onStop() {
  if (checkPref(0)) return;
  createNotifier();
  showNotifier(fillCustomInfo("Playback Stopped"));
  
		//Noti_updateCDCover();
	

}


// ------------------------------------------------------------------------------
// Y Position offset so that notifier can be moved if user wants a little space
// ------------------------------------------------------------------------------
notifier_ypos_20_attrib.onDataChanged()
{
	if(getdata()=="1")
	{
		yOffset = 20;
		notifier_ypos_40_attrib.setData("0");
		notifier_ypos_60_attrib.setData("0");
		notifier_ypos_80_attrib.setData("0");
		notifier_ypos_100_attrib.setData("0");		
	}

	if(notifier_ypos_20_attrib.getData()=="0" && notifier_ypos_40_attrib.getData()=="0" && notifier_ypos_60_attrib.getData()=="0" && notifier_ypos_80_attrib.getData()=="0" && notifier_ypos_100_attrib.getData()=="0")
	{
		yOffset = 0;
	}
}

notifier_ypos_40_attrib.onDataChanged()
{
	if(getdata()=="1")
	{
		yOffset = 40;
		notifier_ypos_20_attrib.setData("0");
		notifier_ypos_60_attrib.setData("0");
		notifier_ypos_80_attrib.setData("0");
		notifier_ypos_100_attrib.setData("0");		
	}

	if(notifier_ypos_20_attrib.getData()=="0" && notifier_ypos_40_attrib.getData()=="0" && notifier_ypos_60_attrib.getData()=="0" && notifier_ypos_80_attrib.getData()=="0" && notifier_ypos_100_attrib.getData()=="0")
	{
		yOffset = 0;
	}

}

notifier_ypos_60_attrib.onDataChanged()
{
	if(getdata()=="1")
	{
		yOffset = 60;
		notifier_ypos_20_attrib.setData("0");
		notifier_ypos_40_attrib.setData("0");
		notifier_ypos_80_attrib.setData("0");
		notifier_ypos_100_attrib.setData("0");		
	}
	
	if(notifier_ypos_20_attrib.getData()=="0" && notifier_ypos_40_attrib.getData()=="0" && notifier_ypos_60_attrib.getData()=="0" && notifier_ypos_80_attrib.getData()=="0" && notifier_ypos_100_attrib.getData()=="0")
	{
		yOffset = 0;
	}

}

notifier_ypos_80_attrib.onDataChanged()
{
	if(getdata()=="1")
	{
		yOffset = 80;
		notifier_ypos_20_attrib.setData("0");
		notifier_ypos_40_attrib.setData("0");
		notifier_ypos_60_attrib.setData("0");
		notifier_ypos_100_attrib.setData("0");		
	}	
	
	if(notifier_ypos_20_attrib.getData()=="0" && notifier_ypos_40_attrib.getData()=="0" && notifier_ypos_60_attrib.getData()=="0" && notifier_ypos_80_attrib.getData()=="0" && notifier_ypos_100_attrib.getData()=="0")
	{
		yOffset = 0;
	}


}

notifier_ypos_100_attrib.onDataChanged()
{
	if(getdata()=="1")
	{
		yOffset = 100;
		notifier_ypos_20_attrib.setData("0");
		notifier_ypos_40_attrib.setData("0");
		notifier_ypos_60_attrib.setData("0");
		notifier_ypos_80_attrib.setData("0");		
	}
	
	if(notifier_ypos_20_attrib.getData()=="0" && notifier_ypos_40_attrib.getData()=="0" && notifier_ypos_60_attrib.getData()=="0" && notifier_ypos_80_attrib.getData()=="0" && notifier_ypos_100_attrib.getData()=="0")
	{
		yOffset = 0;
	}

	
}




// ------------------------------------------------------------------------------
// checks if we should display anything
// ------------------------------------------------------------------------------
Int checkPref(int bypassfs) {
  if (!bypassfs && notifier_showfullscreen_attrib.getData() == "0" && isVideoFullscreen()) return 1;
  if (notifier_never_attrib.getData() == "1") return 1;
  if (notifier_minimized_attrib.getData() == "1" && !isMinimized()) return 1;
  return 0;
}

// ------------------------------------------------------------------------------
// fade in/out completed
// ------------------------------------------------------------------------------
notifier_layout.onTargetReached() {
  if (b_tohide) {
    notifier_layout.setAlpha(0);
    reset();  
    return;
  }
  int a = notifier_layout.getAlpha();
  if (a == 255 && !b_tohide) {
    notifier_timer.setDelay(StringToInteger(notifier_holdtime_attrib.getData()));
    notifier_timer.start();
  }
  else if (a == 0) {
    reset();
  }
}

// ------------------------------------------------------------------------------
// hold time elapsed
// ------------------------------------------------------------------------------
notifier_timer.onTimer() {
	stop();
	if (notifier_fdout_alpha.getData() == "1") {
		if (notifier_layout.isTransparencySafe()) {
			notifier_layout.setTargetA(0);
			notifier_layout.setTargetSpeed(StringToInteger(notifier_fadeouttime_attrib.getData()) / 1000);
			notifier_layout.gotoTarget();
			return;
		} else {
			reset();
			return;
		}
	} else if (notifier_fdout_vslide.getData() == "1") {
		b_tohide = 1;
		
		if (notifier_layout.getGuiY() == 2) sy = -80;
		else sy = getViewportHeight() + 80;
		
		//test top offset
		if (notifier_loc_tl_attrib.getData() == "1" || notifier_loc_tr_attrib.getData() == "1") 
		{
			sy = -80;
		}
		
		
		notifier_layout.setTargetY(sy);

					
		notifier_layout.setTargetSpeed(StringToInteger(notifier_fadeintime_attrib.getData()) / 1000);
		notifier_layout.gotoTarget();
		return;
	} else  {
		if (b_tohide) return;
		b_tohide = 1;
		int sx;
		if (notifier_layout.getGuiX() == 2) sx = -notifier_layout.getWidth();
		else sx = getViewportWidth() + notifier_layout.getWidth();
		notifier_layout.setTargetX(sx);
		notifier_layout.setTargetSpeed(StringToInteger(notifier_fadeintime_attrib.getData()) / 1000);
		notifier_layout.gotoTarget();
		return;
	}
}

// ------------------------------------------------------------------------------
// when notifier is clicked, bring back the app from minimized state if its minimized and focus it
// ------------------------------------------------------------------------------
notifier_layout.onLeftButtonDown(int x, int y) {
  notifier_timer.stop();
  notifier_layout.cancelTarget();
  reset();
  restoreApplication();
  activateApplication();
}

// ------------------------------------------------------------------------------
// close the notifier window, destroys the container automatically because it's dynamic
// ------------------------------------------------------------------------------
reset() {
  notifier_container.close();
  notifier_container = NULL;
  notifier_layout = NULL;
}

// ------------------------------------------------------------------------------
createNotifier() {
  if (notifier_container == NULL) 
  {
    notifier_container = newDynamicContainer("notifier");
	if (!notifier_container) return; // reinstall duh!
    if (isDesktopAlphaAvailable())
	{
		notifier_layout = notifier_container.getLayout("desktopalpha");
		//NotifierCover = notifier_layout.findObject("notifier.local.cdcover");
		NotifierCover = notifier_layout.findObject("aanotifier");
		
		grpNotifierText = notifier_layout.findObject("notifier.text");
		NotifierCoverGlass = notifier_layout.findObject("notifier.local.cdcover.glass");
		danotired = notifier_layout.findObject("danotired");
		danotigreen = notifier_layout.findObject("danotigreen");
		danotiblue = notifier_layout.findObject("danotiblue");
		
		danotired.setAlpha(getPrivateInt(getSkinName(),"redbg", 0));
		danotigreen.setAlpha(getPrivateInt(getSkinName(),"greenbg", 0));
		danotiblue.setAlpha(getPrivateInt(getSkinName(),"bluebg", 0));
	}
    else
	{
		notifier_layout = notifier_container.getLayout("normal");	  
		//NotifierCover = notifier_layout.findObject("notifier.local.cdcover");
		NotifierCover = notifier_layout.findObject("aanotifier");
		
		grpNotifierText = notifier_layout.findObject("notifier.text");
		NotifierCoverGlass = notifier_layout.findObject("notifier.local.cdcover.glass");
		notired = notifier_layout.findObject("notired");
		notigreen = notifier_layout.findObject("notigreen");
		notiblue = notifier_layout.findObject("notiblue");
	
		notired.setAlpha(getPrivateInt(getSkinName(),"redbg", 0));
		notigreen.setAlpha(getPrivateInt(getSkinName(),"greenbg", 0));
		notiblue.setAlpha(getPrivateInt(getSkinName(),"bluebg", 0));
		
	}
	
	  
    if (!notifier_layout) return; // reinstall twice, man
  } else {
    notifier_layout.cancelTarget();
    notifier_timer.stop();
		
  }
}

// ------------------------------------------------------------------------------
showNotifier(int w) {
	//DebugString(IntegerToString(w), 0);
	b_tohide = 0;
	int x; int y;
	int sx;
	
	if (isDesktopAlphaAvailable())
	{
		danotired.setAlpha(getPrivateInt(getSkinName(),"redbg", 0));
		danotigreen.setAlpha(getPrivateInt(getSkinName(),"greenbg", 0));
		danotiblue.setAlpha(getPrivateInt(getSkinName(),"bluebg", 0));
	}
	else
	{
		notired.setAlpha(getPrivateInt(getSkinName(),"redbg", 0));
		notigreen.setAlpha(getPrivateInt(getSkinName(),"greenbg", 0));
		notiblue.setAlpha(getPrivateInt(getSkinName(),"bluebg", 0));
	}
		
	
	if(notifier_showcover_attrib.getData()=="1")
	{
		NotifierCover.show();
		
		NotifierCoverGlass.show();
		w = w + 112;
		grpNotifierText.setXmlParam("x", "62");
				
	}
	else
	{
		NotifierCover.hide();
		
		NotifierCoverGlass.hide();
		w = w + 41;
		grpNotifierText.setXmlParam("x", "0");
	}
	
	
	if (notifier_loc_br_attrib.getData() == "1") {
		x = getViewportWidth() + getViewportLeft() - w - 2;
		y = getViewportHeight() + getViewportTop() - 80 - 2;
	}
	else if (notifier_loc_bl_attrib.getData() == "1") {
		x = 2;
		y = getViewportHeight() + getViewportTop() - 80 - 2;
	}
	else if (notifier_loc_tr_attrib.getData() == "1") {
		x = getViewportWidth() + getViewportLeft() - w - 2;
		y = 2;
	}
	else  {
		x = 2;
		y = 2;
	}
	
	
	if (notifier_fdin_alpha.getData() == "1") {
		if (!notifier_layout.isVisible())
		{ 
			//notifier_layout.resize(x, y, w, 80);
			if (notifier_loc_tl_attrib.getData() == "1" || notifier_loc_tr_attrib.getData() == "1") 
			{
				notifier_layout.resize(x, y+yOffset, w, 80);
			}
			else
			{
				notifier_layout.resize(x, y-yOffset, w, 80);
			}
				
		}
		else
		{
			
			if (notifier_loc_tl_attrib.getData() == "1" || notifier_loc_tr_attrib.getData() == "1") 
			{
				notifier_layout.resize(notifier_layout.getguiX(), y+yOffset, notifier_layout.getGuiW(), 80);
			}
			else
			{
				notifier_layout.resize(notifier_layout.getguiX(), y-yOffset, notifier_layout.getGuiW(), 80);
			}
			
			
		}
		if (notifier_layout.isTransparencySafe()) {
			notifier_layout.show();
			notifier_layout.settargetA(255);
			notifier_layout.setTargetX(x);
			
			if (notifier_loc_tl_attrib.getData() == "1" || notifier_loc_tr_attrib.getData() == "1") 
			{
				notifier_layout.setTargetY(y+yOffset);
			}
			else
			{
				notifier_layout.setTargetY(y-yOffset);
			}
			
			//notifier_layout.setTargetY(y);
			notifier_layout.setTargetW(w);
			notifier_layout.setTargetH(80);
			notifier_layout.setTargetSpeed(StringToInteger(notifier_fadeintime_attrib.getData()) / 1000);
			notifier_layout.gotoTarget();
		} else {
			notifier_layout.setAlpha(255);
			notifier_layout.show();
			notifier_layout.settargetA(255);
			notifier_layout.setTargetX(x);
			notifier_layout.setTargetY(y);
			notifier_layout.setTargetW(w);
			notifier_layout.setTargetH(80);
			notifier_timer.setDelay(StringToInteger(notifier_holdtime_attrib.getData()));
			notifier_timer.start();
		}
	} else if (notifier_fdin_vslide.getData() == "1") {
		
		if (y == 2) sy = -80;
		else sy = getViewportHeight() + 80;
		
		//test top offset
		if (notifier_loc_tl_attrib.getData() == "1" || notifier_loc_tr_attrib.getData() == "1") 
		{
			sy = -80;
		}
		if (!notifier_layout.isVisible()) notifier_layout.resize(x, sy, w, 80);
		else
		{
			if (notifier_loc_tl_attrib.getData() == "1" || notifier_loc_tr_attrib.getData() == "1") 
			{
				notifier_layout.resize(notifier_layout.getguiX(), y + yOffset, notifier_layout.getGuiW(), 80);
			}
			else
			{
				notifier_layout.resize(notifier_layout.getguiX(), y-yOffset, notifier_layout.getGuiW(), 80);
			}
		}
		notifier_layout.show();
		notifier_layout.setAlpha(255);
		notifier_layout.setTargetX(x);
		
		//notifier_layout.setTargetY(y);
		//bottom offset sorted, dont touch
		if (notifier_loc_bl_attrib.getData() == "1" || notifier_loc_br_attrib.getData() == "1") 
		{
			notifier_layout.setTargetY(y-yOffset);
		}
		else
		{
			notifier_layout.setTargetY(y + yOffset);
		}
		
		notifier_layout.setTargetW(w);
		notifier_layout.setTargetH(80);
		notifier_layout.setTargetSpeed(StringToInteger(notifier_fadeintime_attrib.getData()) / 1000);
		notifier_layout.gotoTarget();
	} else  {
		if (x < (getViewportWidth() + getViewportLeft())/2) sx = -w;
		else sx = getViewportWidth() + w;
		if (!notifier_layout.isVisible()) 
		{			
			if (notifier_loc_tl_attrib.getData() == "1" || notifier_loc_tr_attrib.getData() == "1") 
			{
				notifier_layout.resize(sx, y+yOffset, w, 80);
			}
			else
			{
				notifier_layout.resize(sx, y-yOffset, w, 80);
			}

		}	
		else
		{			
			if (notifier_loc_tl_attrib.getData() == "1" || notifier_loc_tr_attrib.getData() == "1") 
			{
				
				notifier_layout.resize(notifier_layout.getguiX(), y+yOffset, notifier_layout.getGuiW(), 80);
			}
			else
			{
				notifier_layout.resize(notifier_layout.getguiX(), y-yOffset, notifier_layout.getGuiW(), 80);
			}
			
		}
		notifier_layout.show();
		notifier_layout.setAlpha(255);		
		notifier_layout.setTargetX(x);
		//notifier_layout.setTargetY(y);
		if (notifier_loc_tl_attrib.getData() == "1" || notifier_loc_tr_attrib.getData() == "1") 
		{
			notifier_layout.setTargetY(y+yOffset);
		}
		else
		{
			notifier_layout.setTargetY(y-yOffset);
		}
		
		notifier_layout.setTargetW(w);
		notifier_layout.setTargetH(80);
		notifier_layout.setTargetSpeed(StringToInteger(notifier_fadeintime_attrib.getData()) / 1000);
		notifier_layout.gotoTarget();
	}
}

// ------------------------------------------------------------------------------
Int fillNextTrackInfo(String corneroverride) {
  Int maxv = 0;
  Int stream = 0;
  Group p = notifier_layout;
  Text plentry = p.findObject("plentry");
  Text nexttrack = p.findObject("nexttrack");
  Text _title = p.findObject("title");
  Text album = p.findObject("album");
  Text artist = p.findObject("artist");
  Text endofplayback = p.findObject("endofplayback");
  
  
  	if(notifier_showcover_attrib.getData()=="1")
	{
		nexttrack.setXmlParam("x", "-180");
	}
	else
	{
		nexttrack.setXmlParam("x", "-130");
	}
  

  //DebugString("got callback for " + getPlayItemString(), 0);
  if (StrLeft(getPlayItemString(), 7) == "http://") stream = 1;

  if (endofplayback) endofplayback.hide();

  if (plentry) { plentry.setText(integerToString(getPlaylistIndex()+1)+"/"+integerToString(getPlaylistLength())); plentry.show(); }
  if (nexttrack) {
    if (corneroverride == "") {
      if (!stream) {
        if (!isVideo())
          nexttrack.setText("New track");
        else
          nexttrack.setText("New video");
      }
      else nexttrack.setText("On air");
    } else nexttrack.setText(corneroverride);
    nexttrack.show();
  }
  if (_title) {
    String str;
    if (!stream) {
      _title.setXmlParam("ticker", "0");
      _title.setXmlParam("display", "");
      str = getPlayitemMetaDataString("title"); 
      if (str == "") str = getPlayitemDisplayTitle();
      String l = getPlayItemMetaDataString("length");
      if (l != "") {
        str += " (" + integerToTime(stringtointeger(l)) + ")";
      }
      _title.setText(str);
    } else {
      _title.setXmlParam("ticker", "1");
      _title.setXmlParam("display", "songtitle");
      _title.setText("");
    }
    _title.show(); 
  }
  if (artist) { 
    if (!stream) {
      if (isVideo())
        artist.setText(""); 
      else
        artist.setText(getPlayitemMetaDataString("artist")); 
    } else {
      if (isVideo())
        artist.setText("Internet TV"); 
      else
        artist.setText("Internet Radio"); 
    }
    artist.show(); 
  }
  if (album) { 
    String str;
    if (!stream && !isVideo()) {
      album.setXmlParam("display", "");
      str = getPlayitemMetaDataString("album");
      String l = getPlayitemMetaDataString("track");
      if (l != "" && l != "-1") str += " (Track " + l + ")";
      album.setText(str); 
    } else {
      album.setText("");
      album.setXmlParam("display", "songinfo");
    }
    album.show(); 
  }
  maxv = artist.getAutoWidth();
  if (maxv < album.getAutoWidth()) maxv = album.getAutoWidth();
  if (maxv < _title.getAutoWidth()) maxv = _title.getAutoWidth();
  if (maxv < (plentry.getAutoWidth() + 10 + nexttrack.getAutoWidth())) maxv = (plentry.getAutoWidth() + 10 + nexttrack.getAutoWidth());
  if (maxv < 128) maxv = 128;
  if (maxv > getViewportWidth()/4) maxv = getViewportWidth()/4;
  
  return maxv;
}

// ------------------------------------------------------------------------------
Int fillCustomInfo(String customtext) {
  Group p = notifier_layout;
  Text plentry = p.findObject("plentry");
  Text nexttrack = p.findObject("nexttrack");
  Text _title = p.findObject("title");
  Text album = p.findObject("album");
  Text artist = p.findObject("artist");
  Text endofplayback = p.findObject("endofplayback");

  if (plentry) { plentry.hide(); }
  if (nexttrack) nexttrack.hide();
  if (_title) { _title.hide(); }
  if (artist) { artist.hide(); }
  if (album) { album.hide(); }

  if (endofplayback) {
    endofplayback.setText(customtext);
    int aw = endofplayback.getAutoWidth();
    endofplayback.show();
    if (aw > 128)
      return aw;
  }
  return 128;
}



//copied from local main cover

Noti_getMediaPath()
{

	String sMediaPath = System.getPlayItemString();
	sMediaPath = getPath(sMediaPath);
	sMediaPath = strRight(sMediaPath, strLen(sMediaPath) - (strSearch(sMediaPath, "//") + 2));
	return sMediaPath;	
}	
	

Noti_Cover_getLocal()
{
	string filenames = "cover.jpg,coverart.jpg,folder.jpg,Folder.jpg,front.jpg,cover.png,coverart.png,folder.png,Folder.png,front.png,AlbumArtLarge.jpg,AlbumArtMedium.jpg,AlbumArtSmall.jpg";	
	//string mediaPath = System.getPlayItemString();
	//mediaPath = getPath(mediaPath);
	//mediaPath = strRight(mediaPath, strLen(mediaPath) - (strSearch(mediaPath, "//") + 2));
	string mediaPath = Noti_getMediaPath();
	
	//debug(mediaPath);
	int ctr = 0;
	localfound = 0;

	map fileload = new Map;

	string currFileName = getToken(filenames, ",", ctr);

	while ((currFileName!="") && (!localfound)) 
	{
		fileload.loadMap(mediaPath+chr(92)+currFileName);
		localfound = (fileload.getWidth() != 64) && (fileload.getWidth() > 0);
		if (!localfound)
		{
			ctr++;
			currFileName = getToken(filenames, ",", ctr);
		}
	}

	delete fileload;

	
	#ifdef DEBUG
		debug("localfound=" + integertostring(localfound));	
		debug(mediaPath+chr(92)+currFileName);
	#endif
	
	if (localfound>0) 
	{
		//NotifierCover.setXMLParam("image",mediaPath+chr(92)+currFileName);
		
	}
	else
	{
		//NotifierCover.setXMLParam("image","cdcover.noimage");
		
	}

}

Noti_updateCDCover() 
{	
	return;
	//Noti_Cover_getLocal();		
}


/*
		if (!notifier_layout.isVisible())
		{
			
			if (notifier_loc_tl_attrib.getData() == "1" || notifier_loc_tr_attrib.getData() == "1") 
			{
				notifier_layout.setTargetY(y+yOffset);
				sy = -80;
			}
			else 
			{
				sy = getViewportHeight() + 80;
			}
			notifier_layout.resize(x, sy, w, 80);
			
		}
		else
		{
		
			if (notifier_loc_tl_attrib.getData() == "1" || notifier_loc_tr_attrib.getData() == "1") 
			{
				
				notifier_layout.setTargetY(y+yOffset);
				sy = -80;
			}
			else 
			{
				sy = getViewportHeight() + 80;
			}
			
			notifier_layout.resize(notifier_layout.getguiX(), y, notifier_layout.getGuiW(), 80);
		}

*/
