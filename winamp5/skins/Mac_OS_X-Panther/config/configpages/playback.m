#include "../../../../lib/std.mi"

#include "../../wasabi/mspp/msppver.m"

#define ENSURE_MSPP getPrivateInt("mspp", MSPP_VERSION, 0) != 0
#define MSPP_PATH getPrivateString("mspp", "Path", "")

#define FILENAME "playback.m"
#include "../../wasabi/ripprotection.mi"

Function PlaybackLoad();
Function PlaybackSave();

Global Button m2, m1;
Global GuiObject normal;
Global Timer Playtimer;

#include "../../scripts/attribs.m"

System.onScriptLoaded() {
	initAttribs();

	normal = getScriptGroup().findObject("0");
	m2 = normal.findObject("m2");
	m1 = normal.findObject("m1");
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

m2.onLeftClick() {
	GuiTree _tree = System.getContainer("config").getLayout("normal").findObject("wasabi.preferences.group").findObject("wasabi.preferences.tree.embedded").findObject("mylist");
	_tree.sendAction("switchToItem", "MSPP Info", 0, 0, 0, 0);
}
m1.onLeftClick() {
	GuiTree _tree = System.getContainer("config").getLayout("normal").findObject("wasabi.preferences.group").findObject("wasabi.preferences.tree.embedded").findObject("mylist");
	_tree.sendAction("switchToItem", "MSPP Info", 0, 0, 0, 0);
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
		if (sdata == "1" && ENSURE_MSPP) {
			System.Stop();
			playback_shutdown_playlist_attrib.setData("0");
			setPublicInt("Deimos/Playback/_State", 0);
			navigateUrl(MSPP_PATH + "\BatchFiles\shutdown_pc.bat");
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
	if (sdata == "1" && ENSURE_MSPP) {
		System.Stop();
		playback_shutdown_track_attrib.setData("0");
		setPublicInt("Deimos/Playback/_State", 0);
		navigateUrl(MSPP_PATH + "\BatchFiles\shutdown_pc.bat");
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