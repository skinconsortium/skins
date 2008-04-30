#include "../../../../lib/std.mi"

#define FILENAME "playback.m"
#include "../../wasabi/ripprotection.mi"

Function PlaybackLoad();
Function PlaybackSave();

Global Button startw, next1, next2, next0;
Global GuiObject wizard, wizard1, wizard2, normal;
Global Edit e;
Global Timer Playtimer;

#include "../../scripts/attribs.m"

System.onScriptLoaded() {
	initAttribs();

	wizard = getScriptGroup().findObject("-1");
	wizard2 = getScriptGroup().findObject("2");
	wizard1 = getScriptGroup().findObject("1");
	normal = getScriptGroup().findObject("0");
	startw = normal.findObject("swizard");
	next1 = wizard1.findObject("next");
	next2 = wizard2.findObject("next");
	next0 = wizard.findObject("next");

	string s = getPrivateString("Deimos/Playback/", "Command", "");
	
	e = wizard2.findObject("path");
	e.setAutoEnter(1);
	e.setText(s);

	if (s == "") {
		wizard2.hide();
		wizard1.hide();
		normal.hide();
		wizard.show();
	}

	PlaybackLoad();

/*** TO BE REMOVED ***/

	PlayTimer = new Timer;
	PlayTimer.setDelay(1000);
	Int PlayerStatus = getStatus();

	if ( PlayerStatus == 1 ) {
		PlayTimer.start();
	}

/******/

	ripProtection();
}

System.onScriptUnloading() {
	PlaybackSave();
}


System.onKeyDown(String key) {
  if (key == "ctrl+q") {
    	string sdata = playback_close_playlist_attrib.getData();
	if (sdata == "1") {
		playback_close_playlist_attrib.setData("0");
	}
	if (sdata == "0") {
		playback_close_playlist_attrib.setData("1");
	}
	complete;
  }
  if (key == "shift+q") {
    	string sdata = playback_close_track_attrib.getData();

	if (sdata == "1") {
		playback_close_track_attrib.setData("0");
	}
	if (sdata == "0") {
		playback_close_track_attrib.setData("1");
	}
	complete;
  }

  if (key == "ctrl+alt+q") {
    	string sdata = playback_shutdown_playlist_attrib.getData();
	if (sdata == "1") {
		playback_shutdown_playlist_attrib.setData("0");
	}
	if (sdata == "0") {
		playback_shutdown_playlist_attrib.setData("1");
	}
	complete;
  }
  if (key == "shift+alt+q") {
    	string sdata = playback_shutdown_track_attrib.getData();

	if (sdata == "1") {
		playback_shutdown_track_attrib.setData("0");
	}
	if (sdata == "0") {
		playback_shutdown_track_attrib.setData("1");
	}
	complete;
  }
  if (key == "f5") {
	setPublicInt("Deimos/Playback/Reload_Skin", 1);
  }
}

PlaybackLoad() {
	if (getStatus()) return;
	
	if (getPrivateInt("Deimos/Playback/Reload", "Skin", 0) == 1) {
		setPublicInt("Deimos/Playback/Reload_Skin", 0);
		return;
	}
	if (playback_restore_attrib.getData() == "1") {
		if (getPrivateInt("Deimos/Playback/", "State", 0) != 0) {
			int i_state = getPrivateInt("Deimos/Playback/", "State", 0);
			int i_pos = getPrivateInt("Deimos/Playback/", "Position", 0);
			Play();
			seekTo(i_pos);
			if (i_state == -1) {
				Pause();
			}
		}
	}
	if (playback_autoplay_attrib.getData() == "1") {
		if (playback_restore_attrib.getData() == "1") return;
		else {
			Next();
			Play();
		}
	}
	setPublicInt("Deimos/Playback/Reload_Skin", 0);
}

System.onStop() {
/*****/	PlayTimer.stop();
	if (getPlaylistLength() == (getPlaylistIndex()+1)) {
	    	string sdata = playback_shutdown_playlist_attrib.getData();
		if (sdata == "1") {
			System.Stop();
			playback_shutdown_playlist_attrib.setData("0");
			setPublicInt("Deimos/Playback/_State", 0);
			navigateUrl("file:///" + getPrivateString("Deimos/Playback/", "command", ""));
			Button b = System.getContainer("main").getLayout("normal").findObject("close");
			b.LeftClick();
		}
	    	string sdata = playback_close_playlist_attrib.getData();
		if (sdata == "1") {
			System.Stop();
			playback_close_playlist_attrib.setData("0");
			setPublicInt("Deimos/Playback/_State", 0);
			Button b = System.getContainer("main").getLayout("normal").findObject("close");
			b.LeftClick();
		}
	}
}

System.onTitleChange(string s) {
	string sdata = playback_shutdown_track_attrib.getData();
	if (sdata == "1") {
		System.Stop();
		playback_shutdown_track_attrib.setData("0");
		setPublicInt("Deimos/Playback/_State", 0);
		navigateUrl("file:///" + getPrivateString("Deimos/Playback/", "command", ""));
		Button b = System.getContainer("main").getLayout("normal").findObject("close");
		b.LeftClick();
	}
	sdata = playback_close_track_attrib.getData();
	if (sdata == "1") {
		System.Stop();
		playback_close_track_attrib.setData("0");
		setPublicInt("Deimos/Playback/_State", 0);
		Button b = System.getContainer("main").getLayout("normal").findObject("close");
		b.LeftClick();
	}
}

/*** TO BE REMOVED ***/

System.onPlay() {
	setPublicInt("Deimos/Playback/Reload_Skin", 0); 
	PlayTimer.start();
}

System.onResume() {
	PlayTimer.start();
}

System.onPause() {
	PlayTimer.stop();
}

/******/

PlaybackSave() {
	setPublicInt("Deimos/Playback/_State", System.getStatus());
}

PlayTimer.onTimer() {
	setPublicInt("Deimos/Playback/_Position", getPosition());
}


/*** Configpage ***/

startw.onLeftClick() {
	wizard.hide();
	normal.hide();
	wizard2.hide();
	wizard1.show();
}

next1.onLeftClick() {
	wizard.hide();
	normal.hide();
	wizard1.hide();
	wizard2.show();
}

next2.onLeftClick() {
	wizard.hide();
	wizard1.hide();
	wizard2.hide();
	setPublicString("Deimos/Playback/_Command", e.getText()); 
	normal.show();
}

next0.onLeftClick() {
	normal.hide();
	wizard.hide();
	wizard2.hide();
	wizard1.show();
}

e.onEnter() {
	setPublicString("Deimos/Playback/_Command", getText()); 
}

e.onEditUpdate() {
	setPublicString("Deimos/Playback/_Command", getText()); 
}