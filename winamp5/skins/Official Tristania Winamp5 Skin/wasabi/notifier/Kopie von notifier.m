//Original Winamp Modern Notifier Script
//modified for Titan by Martin P. alias Deimos

#include "../../../../lib/std.mi" //!
#include "../../scripts/attribs.m"

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
Class Button ShowNotBtn;
Global ShowNotBtn show_not, show_not_aa, show_not_fade;
Global GuiObject _configimp;
Global String str_location;

Global Timer endTimer;

// ------------------------------------------------------------------------------
// init
// ------------------------------------------------------------------------------
System.onScriptLoaded() {
	initAttribs();
	notifier_timer = new Timer;
	_configimp = System.getContainer("config").getLayout("normal").findObject("wasabi.preferences.group").findObject("config.imp"); //!
	show_not = _configimp.findObject("Notifications").findObject("show"); //!
	show_not_aa = _configimp.findObject("Notifications.cover").findObject("show"); //!
	show_not_fade = _configimp.findObject("Notifications.fade").findObject("show"); //!

	endTimer = new Timer;
	endTimer.setDelay(1000);

	if (getStatus() == 1 && notifier_endoftrack_attrib.getData() == "1") endTimer.start();
}

// ------------------------------------------------------------------------------
// shutdown
// ------------------------------------------------------------------------------
System.onScriptUnloading() {
  delete notifier_timer;
  delete endTimer;
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
  if (getStatus() == 1 && notifier_endoftrack_attrib.getData() == "1") endTimer.start();
}

// ------------------------------------------------------------------------------
// called by the system when the user clicks the play button
// ------------------------------------------------------------------------------
System.onPlay() {
  if (checkPref(0)) return;
  createNotifier();
  showNotifier(fillNextTrackInfo("Playing"));
  if (notifier_endoftrack_attrib.getData() == "1") endTimer.start();
}

// ------------------------------------------------------------------------------
// called by the system when the user clicks the pause button
// ------------------------------------------------------------------------------
System.onPause() {
  if (checkPref(0)) return;
  createNotifier();
  showNotifier(fillCustomInfo("Playback Paused"));
  endTimer.stop();
}

// ------------------------------------------------------------------------------
// called by the system when the user clicks the pause button again
// ------------------------------------------------------------------------------
System.onResume() {
  if (checkPref(0)) return;
  createNotifier();
  showNotifier(fillNextTrackInfo("Resuming Playback"));
  if (notifier_endoftrack_attrib.getData() == "1") endTimer.start();
}

// ------------------------------------------------------------------------------
// called by the system when the user clicks the play button
// ------------------------------------------------------------------------------
System.onStop() {
  if (checkPref(0)) return;
  createNotifier();
  showNotifier(fillCustomInfo("End of Playback"));
  endTimer.stop();
}

// ------------------------------------------------------------------------------
// Checks the end of a track
// ------------------------------------------------------------------------------
notifier_endoftrack_attrib.onDataChanged() {
	if (getStatus() == 1 && getData() == "1") endTimer.start();
	else endTimer.stop();
}

endTimer.onTimer() {
	return;
	if (checkPref(0)) return;
	if (notifier_endoftrack_attrib.getData() == "0") stop();
	int timebuffer;
	timebuffer = stringToInteger(notifier_fadeintime_attrib.getData());
	timebuffer += stringToInteger(notifier_holdtime_attrib.getData());
	timebuffer += stringToInteger(notifier_fadeouttime_attrib.getData());
	timebuffer += 7000;
	if (getPlayItemLength() - getPosition() < timebuffer) {
		createNotifier();
		showNotifier(fillNextTrackInfo("Playing"));
		stop();
	} 

}

// ------------------------------------------------------------------------------
// checks if we should display anything
// ------------------------------------------------------------------------------
Int checkPref(int bypassfs) {
  if (!bypassfs && notifier_disablefullscreen_attrib.getData() == "1" && isVideoFullscreen()) return 1;
  if (notifier_never_attrib.getData() == "1") return 1;
  if (notifier_minimized_attrib.getData() == "1" && !isMinimized()) return 1;
  if (notifier_windowshade_attrib.getData() == "1") {
    if (isMinimized()) return 0;
    Container c = getContainer("main");
    if (!c) return 1;
    Layout l = c.getCurLayout();
    if (!l) return 1;
    if (l.getId() != "shade") return 1;
  }
  return 0;
}

// ------------------------------------------------------------------------------
// fade in/out completed
// ------------------------------------------------------------------------------
notifier_layout.onTargetReached() {
  int a = notifier_layout.getAlpha();
  if (a == 255) {
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
  if (notifier_layout.isTransparencySafe()) {
    notifier_layout.setTargetA(0);
    notifier_layout.setTargetSpeed(StringToInteger(notifier_fadeouttime_attrib.getData()) / 1000);
    notifier_layout.gotoTarget();
  } else {
    reset();
  }
}

// ------------------------------------------------------------------------------
// when notifier is clicked, bring back the app from minimized state if its minimized and focus it
// ------------------------------------------------------------------------------
notifier_layout.onLeftButtonDown(int _x, int _y) {
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
// save a global location string for faster notification load
// ------------------------------------------------------------------------------

ConfifNotifLocAttribute.onDataChanged() {
	if (getData() == "1") {
		str_location = getAttributeName();
	}
}

// ------------------------------------------------------------------------------
createNotifier() {
  if (notifier_container == NULL) {
    notifier_container = newDynamicContainer("notifier");
    if (!notifier_container) return; // reinstall duh!
    if (isDesktopAlphaAvailable())
      notifier_layout = notifier_container.getLayout("desktopalpha");
    else
      notifier_layout = notifier_container.getLayout("normal");
    if (!notifier_layout) return; // reinstall twice, man
  } else {
    notifier_layout.cancelTarget();
    notifier_timer.stop();
  }
}

// ------------------------------------------------------------------------------
showNotifier(int w) {
/*	Group _norm = notifier_layout.findObject("notifier.text");
	Group _left = notifier_layout.findObject("notifier.text.left");
	Group _right = notifier_layout.findObject("notifier.text.right");
	_norm.hide();
	_left.hide();
	_right.hide();*/
/*	if (notifier_aa_enabled.getData() == "1") {
		AnimatedLayer _dummy;
		if (notifier_aa_right.getData() == "1") {
			_dummy = _right.findObject("cover").findObject("cover.dummy");
			if (_dummy.getLength() == 0) { w = w + 32; _norm.show(); }
			else { _right.show(); w = w + 32 + 68; }
		} if (notifier_aa_left.getData() == "1") {
			_dummy = _left.findObject("cover").findObject("cover.dummy");
			if (_dummy.getLength() == 0) { w = w + 32; _norm.show(); }
			else { _left.show(); w = w + 32 + 68; }
		}
	} else {*/ w = w + 32; //_norm.show();// }
	//int x; int y;
//	if (str_location == "Bottom Right") {
		int x = getViewportWidth() + getViewportLeft() - w - 2;
		int y = getViewportHeight() + getViewportTop() - 80 - 2;
//	}
/*	else if (str_location == "Bottom Left") {
		x = 2;
		y = getViewportHeight() + getViewportTop() - 80 - 2;
	}
	else if (str_location == "Bottom Center") {
		x = (getViewportWidth() + getViewportLeft())/2 - w/2;
		y = getViewportHeight() + getViewportTop() - 80 - 2;
	}
	else if (str_location == "Top Right") {
		x = getViewportWidth() + getViewportLeft() - w - 2;
		y = 2;
	}
	else if (str_location == "Top Center") {
		x = 2;
		y = 2;
	}
	else if (str_location == "Top Left") {
		x = (getViewportWidth() + getViewportLeft())/2 - w/2;
		y = 2;
	}*/
  notifier_layout.resize(x, y, w, 80);
  if (notifier_layout.isTransparencySafe()) {
    notifier_layout.show();
    notifier_layout.setTargetA(255);
    notifier_layout.setTargetX(x);
    notifier_layout.setTargetY(y);
    notifier_layout.setTargetW(w);
    notifier_layout.setTargetH(80);
    notifier_layout.setTargetSpeed(StringToInteger(notifier_fadeintime_attrib.getData()) / 1000);
    notifier_layout.gotoTarget();
  } else {
    notifier_layout.setAlpha(255);
    notifier_layout.show();
    notifier_timer.setDelay(StringToInteger(notifier_holdtime_attrib.getData()));
    notifier_timer.start();
  }
}

// ------------------------------------------------------------------------------
Int fillNextTrackInfo(String corneroverride) {
  Int maxv = 0;
  Int stream = 0;
 /* 	Group _norm = notifier_layout.findObject("notifier.text");
	Group _left = notifier_layout.findObject("notifier.text.left");
	Group _right = notifier_layout.findObject("notifier.text.right");
*/	Group p = notifier_layout;
/*	if (notifier_aa_enabled.getData() == "1") {
		if (notifier_aa_right.getData() == "1") p = _right;
		if (notifier_aa_left.getData() == "1") p = _left;
		AnimatedLayer _dummy = p.findObject("cover").findObject("cover.dummy");
		if (_dummy.getLength() == 0) p = _norm;
	} else p = _norm;*/
  Text plentry = p.findObject("plentry");
  Text nexttrack = p.findObject("nexttrack");
  Text _title = p.findObject("title");
  Text album = p.findObject("album");
  Text artist = p.findObject("artist");
  Text endofplayback = p.findObject("endofplayback");

  DebugString("got callback for " + getPlayItemString(), 0);
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
  if (maxv < 128) maxv = 128;
  if (maxv > getViewportWidth()/4) maxv = getViewportWidth()/4;
  
  return maxv;
}

// ------------------------------------------------------------------------------
Int fillCustomInfo(String customtext) {
/*	Group _norm = notifier_layout.findObject("notifier.text");
	Group _left = notifier_layout.findObject("notifier.text.left");
	Group _right = notifier_layout.findObject("notifier.text.right");
*/	Group p = notifier_layout;
/*	if (notifier_aa_enabled.getData() == "1") {
		if (notifier_aa_right.getData() == "1") p = _right;
		if (notifier_aa_left.getData() == "1") p = _left;
		AnimatedLayer _dummy = p.findObject("cover").findObject("cover.dummy");
		if (_dummy.getLength() == 0) p = _norm;
	} else p = _norm;
*/  Text plentry = p.findObject("plentry");
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


// START OWNCODE.
// ------------------------------------------------------------------------------
// Show the Notifier by clicking "Show Notification" in Preferences
// ------------------------------------------------------------------------------

ShowNotBtn.onLeftClick() {
//	if (checkPref(0)) return;
	createNotifier();
	String str;
	if (getStatus() == STATUS_PLAYING) str = "Playing";
	if (getStatus() == STATUS_PAUSED) str = "Playback Paused";
	if (getStatus() == STATUS_STOPPED) str = "Playback Stopped";
	showNotifier(fillNextTrackInfo(str));
}