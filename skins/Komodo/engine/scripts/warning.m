// Komodo Installation / Version check.
// by leechbite.com

#include <lib/std.mi>
#include <lib/fileio.mi>

// the current skin is designed for komodo version 1.0
#define KOMODO_VER 1.0

Global string path, versionPath;
Global int getNewVer, currVersion;

Global XmlDoc versionCheck;
Global timer delayVersionCheck;

System.onScriptLoaded() { 
	
	path = getParam();
	versionPath = path + "Komodo\engine\version.xml";
	path = path + "Komodo\engine\load.xml";
	
	getNewVer = 0;
	currVersion = 0;
	
	int ret, exist;
	file installFile = new file;
	installFile.load(path);
	exist = installFile.exists();
	delete installFile;
	
	if (!exist) {
		ret = System.messageBox("For this skin to work, you'll need to install the Komodo Winamp plugin.\n\nDo you want to download it now?", "Komodo Plugin not found.", 4, "");
		if (ret==4) {
			getNewVer = 1;
		}
		System.switchSkin("winamp classic");
	} else {
		delayVersionCheck = new Timer;
		delayVersionCheck.setDelay(500);
		delayVersionCheck.start();
	}
	
	setPrivateString(getSkinName(),"KomodoString",floatToString(KOMODO_VER,2));
}

delayVersionCheck.onTimer() {
	stop();
	
	versionCheck = new XmlDoc;
	versionCheck.load(versionPath);
	versionCheck.parser_addCallback("komododata/komodoversion");
	versionCheck.parser_start();
	versionCheck.parser_destroy();
}

versionCheck.parser_onCallback (String xmlpath, String xmltag, list paramname, list paramvalue) {

	if (xmltag == "komodoversion") {

		string param, value;
		value = "";
		int c = paramname.findItem("skinversion");
		if (c>=0) {
			param = paramname.enumItem(c);
			value = paramvalue.enumItem(c);
			currVersion = stringToInteger(value);
		} else {
			currVersion = -1;
		}
		
		if (currVersion < KOMODO_VER) {
			int ret = System.messageBox("This skin requires the latest Komodo Winamp plugin.\n\nDo you want to download it now?", "Komodo Plugin incorrect version.", 4, "");
				if (ret==4) {
				getNewVer = 1;
			}
			System.switchSkin("winamp classic");
		}
	}
}

system.onScriptUnloading() {
	delete delayVersionCheck;
	if (getNewVer)	System.navigateUrl("http://komodo.nitrousaudio.com");
}
