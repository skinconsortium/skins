//Original Winamp Modern Notifier Script
//modified for Titan by Martin P. alias Deimos

#include "../../../../lib/std.mi" //!
#include "../../scripts/attribs.m"

#define FILENAME "notifier.m"
#include "../ripprotection.mi"

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

Global Boolean b_tohide = 0;

Global Timer endTimer;

// ------------------------------------------------------------------------------
// init
// ------------------------------------------------------------------------------
System.onScriptLoaded() {
	initAttribs();
	notifier_timer = new Timer;
	_configimp = System.getContainer("config").getLayout("normal").findObject("wasabi.preferences.group").findObject("config.imp"); //!
	show_not = _configimp.findObject("Notifications").findObject("show"); //!
	show_not_aa = _configimp.findObject("Album Art").findObject("show"); //!
	show_not_fade = _configimp.findObject("Fading").findObject("show"); //!

	endTimer = new Timer;
	endTimer.setDelay(1000);

	if (getStatus() == 1 && notifier_endoftrack_attrib.getData() == "1") endTimer.start();
	ripProtection();
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
	if (checkPref(0)) return;
	if (notifier_endoftrack_attrib.getData() == "0") stop();
	int timebuffer;
	timebuffer = stringToInteger(notifier_fadeintime_attrib.getData());
	timebuffer += stringToInteger(notifier_holdtime_attrib.getData());
	timebuffer += stringToInteger(notifier_fadeouttime_attrib.getData());
	timebuffer += 5000;
	if (getPlayItemLength() - getPosition() < timebuffer) {
		createNotifier();
		showNotifier(fillNextTrackInfo("End of Track"));
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
  if (b_tohide) {
    notifier_layout.hide();
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
		int sy;
		if (notifier_layout.getGuiY() == 2) sy = -80;
		else sy = getViewportHeight() + 80;
		notifier_layout.setTargetY(sy);
		notifier_layout.setTargetSpeed(StringToInteger(notifier_fadeintime_attrib.getData()) / 1000);
		notifier_layout.gotoTarget();
		return;
	} else if (notifier_fdout_hslide.getData() == "1") {
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
createNotifier() {
  if (notifier_container == NULL) {
    notifier_container = newDynamicContainer("notifier");
    if (!notifier_container) return; // reinstall duh!
/*    if (isDesktopAlphaAvailable()) {
      if ( cover_web_attrib.getData() == "1" && notifier_aa_right.getData() == "1" ) notifier_layout = notifier_container.getLayout("normal");
      else notifier_layout = notifier_container.getLayout("desktopalpha");
    } else*/
      notifier_layout = notifier_container.getLayout("normal");
    if (!notifier_layout) return; // reinstall twice, man
  } else {
    notifier_layout.cancelTarget();
    notifier_timer.stop();
  }
}

// ------------------------------------------------------------------------------
showNotifier(int w) {
	b_tohide = 0;
/*	Group _left;
	Group _right;
	Group _norm = notifier_layout.findObject("notifier.text");
	if (!isDesktopAlphaAvailable()) {
		_left = notifier_layout.findObject("notifier.text.left");
		_right = notifier_layout.findObject("notifier.text.right");
	} else {
		_left = notifier_layout.findObject("notifier.nw.text.left");
		_right = notifier_layout.findObject("notifier.nw.text.right");
	}*/
	Group _left = notifier_layout.findObject("notifier.text.left");
	Group _right = notifier_layout.findObject("notifier.text.right");
	Group _norm = notifier_layout.findObject("notifier.text");
	_norm.hide();
	_left.hide();
	_right.hide();
	if (notifier_aa_enabled.getData() == "1") {
		AnimatedLayer _dummy;
		if (notifier_aa_right.getData() == "1") {
			_dummy = _right.findObject("cover").findObject("cover.dummy");
			if (_dummy.getLength() == 0 && cover_web_attrib.getData() == "0") { w = w + 32; _norm.show(); }
			else { _right.show(); w = w + 32 + 68; }
		} if (notifier_aa_left.getData() == "1") {
			_dummy = _left.findObject("cover").findObject("cover.dummy");
			if (_dummy.getLength() == 0 && cover_web_attrib.getData() == "0") { w = w + 32; _norm.show(); }
			else { _left.show(); w = w + 32 + 68; }
		}
	} else { w = w + 32; _norm.show(); }
	int x; int y;
	if (notifier_loc_br_attrib.getData() == "1") {
		x = getViewportWidth() + getViewportLeft() - w - 2;
		y = getViewportHeight() + getViewportTop() - 80 - 2;
	}
	if (notifier_loc_bl_attrib.getData() == "1") {
		x = 2;
		y = getViewportHeight() + getViewportTop() - 80 - 2;
	}
	if (notifier_loc_bc_attrib.getData() == "1") {
		x = (getViewportWidth() + getViewportLeft())/2 - w/2;
		y = getViewportHeight() + getViewportTop() - 80 - 2;
	}
	if (notifier_loc_tr_attrib.getData() == "1") {
		x = getViewportWidth() + getViewportLeft() - w - 2;
		y = 2;
	}
	if (notifier_loc_tl_attrib.getData() == "1") {
		x = 2;
		y = 2;
	}
	if (notifier_loc_tc_attrib.getData() == "1") {
		x = (getViewportWidth() + getViewportLeft())/2 - w/2;
		y = 2;
	}
	if (notifier_fdin_alpha.getData() == "1") {
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
	} else if (notifier_fdin_vslide.getData() == "1") {
		int sy;
		if (y == 2) sy = -80;
		else sy = getViewportHeight() + 80;
		notifier_layout.resize(x, sy, w, 80);
		notifier_layout.show();
		notifier_layout.setAlpha(255);
		notifier_layout.setTargetA(255);
		notifier_layout.setTargetX(x);
		notifier_layout.setTargetY(y);
		notifier_layout.setTargetW(w);
		notifier_layout.setTargetH(80);
		notifier_layout.setTargetSpeed(StringToInteger(notifier_fadeintime_attrib.getData()) / 1000);
		notifier_layout.gotoTarget();
	} else if (notifier_fdin_hslide.getData() == "1") {
		int sx;
		if (x < (getViewportWidth() + getViewportLeft())/2) sx = -w;
		else sx = getViewportWidth() + w;
		notifier_layout.resize(sx, y, w, 80);
		notifier_layout.show();
		notifier_layout.setAlpha(255);
		notifier_layout.setTargetA(255);
		notifier_layout.setTargetX(x);
		notifier_layout.setTargetY(y);
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
/*	Group _left;
	Group _right;
	Group _norm = notifier_layout.findObject("notifier.text");
	if (!isDesktopAlphaAvailable()) {
		_left = notifier_layout.findObject("notifier.text.left");
		_right = notifier_layout.findObject("notifier.text.right");
	} else {
		_left = notifier_layout.findObject("notifier.nw.text.left");
		_right = notifier_layout.findObject("notifier.nw.text.right");
	}*/
	Group _left = notifier_layout.findObject("notifier.text.left");
	Group _right = notifier_layout.findObject("notifier.text.right");
	Group _norm = notifier_layout.findObject("notifier.text");
	Group p = notifier_layout;
	if (notifier_aa_enabled.getData() == "1") {
		if (notifier_aa_right.getData() == "1") p = _right;
		if (notifier_aa_left.getData() == "1") p = _left;
		AnimatedLayer _dummy = p.findObject("cover").findObject("cover.dummy");
		if (_dummy.getLength() == 0 && cover_web_attrib.getData() == "0") p = _norm;
	} else p = _norm;
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
/*	Group _left;
	Group _right;
	Group _norm = notifier_layout.findObject("notifier.text");
	if (!isDesktopAlphaAvailable()) {
		_left = notifier_layout.findObject("notifier.text.left");
		_right = notifier_layout.findObject("notifier.text.right");
	} else {
		_left = notifier_layout.findObject("notifier.nw.text.left");
		_right = notifier_layout.findObject("notifier.nw.text.right");
	}*/
	Group _left = notifier_layout.findObject("notifier.text.left");
	Group _right = notifier_layout.findObject("notifier.text.right");
	Group _norm = notifier_layout.findObject("notifier.text");
	Group p = notifier_layout;
	if (notifier_aa_enabled.getData() == "1") {
		if (notifier_aa_right.getData() == "1") p = _right;
		if (notifier_aa_left.getData() == "1") p = _left;
		AnimatedLayer _dummy = p.findObject("cover").findObject("cover.dummy");
		if (_dummy.getLength() == 0) p = _norm;
	} else p = _norm;
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