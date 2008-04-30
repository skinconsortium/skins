#include "../../../lib/std.mi"

Global Text statustext, songinfo, dummy;
Global Boolean set = 0;

Global Timer sta;

System.onScriptLoaded() {
	if (getParam() != "dashboard") statustext = getScriptgroup().findObject("type");
	songinfo = getScriptgroup().findObject("infoline");

	dummy = getScriptgroup().findObject("infoline.dummy");

	sta = new Timer;
	sta.setDelay(100);

	if (getStatus() == 1) sta.start();
	

	System.onTitleChange(System.getPlayItemString());
}

system.onPlay() { sta.start(); }
system.onResume() { sta.start(); }
system.onStop() { sta.stop(); }
system.onPause() { sta.stop(); }

System.onTitleChange(string newTitle) {
	set = 0;	
	if (getParam() != "dashboard") {
		string isvid;
		string ext;
		if (System.isVideo() == 1) {
			isvid = "Video";
		} else if (System.isVideo() == 0) {
			isvid = "Audio";
		} else {
			isvid = "";
		}

		string extension = getExtension(getPlayItemMetaDataString("Filename"));
		string source = strleft(getPlayItemMetaDataString("Filename"), 3);

		if (strlower(source) == "vox" || strlower(source) == "htt") {
			statustext.setText("Stream: " + extension);
		} else if (strlower(extension) == "cda") {
			string drive = strmid(getPlayItemMetaDataString("Filename"), 6, 1);
			statustext.setText("Audio CD " + strUpper(drive) + ":");
		}
		else statustext.setText(isvid + ": " + extension);
	}

	songinfo.setText(dummy.getText());
}

sta.onTimer() {
	songinfo.setText(dummy.getText());
}

