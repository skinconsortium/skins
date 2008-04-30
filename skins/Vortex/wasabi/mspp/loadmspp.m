#include <lib/std.mi>

#include msppver.m

Global Layer l;
Global Layout n;
Global String mspp_path;
Global timer check;
Global Button c, d, inf;
Global Text _1, _2, _3;
Global CheckBox x;
Global Boolean no = 0;

Global Timer w;

System.onScriptLoaded() {
	n = getContainer("mspp").getLayout("normal");
	n.hide();
	l = n.findObject("l");
	c = n.findObject("c");
	_1 = n.findObject("_1");
	_2 = n.findObject("_2");
	_3 = n.findObject("_3");
	x = n.findObject("x");
	d = n.findObject("d");
	inf = n.findObject("inf");
	check = new timer;
	check.setDelay(500);
	w = new timer;
	w.setDelay(5000);
	//little hack: get the Winamp path via @COLORTHEMESPATH@..\..\ = WINAMP-DIRECTORY :)
	//mspp_path = getToken(getParam(), "ColorThemes", 0) + "Plugins\MSPP";
	mspp_path = strleft(getParam() ,System.strsearch(getParam(), "ColorThemes")) + "Plugins\MSPP";
	map m = new map;
	//the clou: if mspp is installed there is a jpg with the versionnumber!
	m.loadMap(mspp_path + "\_versioncheck\v" + MSPP_VERSION + ".jpg");
	if (m.getWidth() > 0 && m.getWidth() != 64) {
		setPrivateInt("MSPP", MSPP_VERSION, 1);
		setPrivateString("MSPP", "Path", mspp_path);
	} else {
		if (getPrivateInt("MSPP", MSPP_VERSION, 0) == -1) return;
		setPrivateInt("MSPP", MSPP_VERSION, 0);
		w.start();
	}
	delete m;
	

}

w.onTimer() {
	w.stop();
	n.show();
	n.center();
	n.setFocus();
	n.bringToFront();
}

n.onSetVisible(int v) {
	int addw = 184 + getWidth() - l.getWidth();
	int addh = 200 + getheight() - l.getheight();
	setXMLParam("w", integerToString(addw));
	setXMLParam("h", integerToString(addh));
}

c.onLeftClick() {
	if (no == 1) {
		no = 0;
		x.setChecked(0);
		x.onToggle(0);
		return;
	}	
	if(!check.isRunning()) {
		_1.settext("Searching for");
		_3.settext("in: " + mspp_path);
		check.start();
	}
}

d.onLeftClick() {
	if (no == 1) {
		setPrivateInt("MSPP", MSPP_VERSION, -1);
		n.hide();
		return;
	}
	if (no == 2) {
		n.hide();
		return;
	}
	_1.settext("Downloading");
	_3.settext("Install MSPP & click on check...");
	System.navigateURL("http://www.skinconsortium.com/mspp");
}

check.onTimer() {
	check.stop();
	map m = new map;
	//the clou: if mspp is installed there is a jpg with the versionnumber!
	m.loadMap(mspp_path + "\_versioncheck\v" + MSPP_VERSION + ".jpg");
	if (m.getWidth() > 0 && m.getWidth() != 64) {
		_1.settext("Success,");
		_3.settext("was found!");
		setPrivateInt("MSPP", MSPP_VERSION, 1);
		setPrivateString("MSPP", "Path", mspp_path);
		x.hide();
		c.hide();
		no = 2;
		d.setXMLParam("text", "Close Window");
	} else {
		_1.settext("Please download and install MSPP!");
		_3.settext("is NOT installed!");
		setPrivateInt("MSPP", MSPP_VERSION, 0);
	}	
	delete m;
}

x.onToggle(Boolean on) {
	if (on) {
		no = 1;
		_1.settext("Don't you really want to install");
		_3.settext("and don't want to get the functionality?");
		d.setXMLParam("text", "Yes, I don't want to use MSPP");
		c.setXMLParam("text", "No, I want to use MSPP");
	}
	if (!on) {
		no = 0;
		_1.settext("Please install");
		_3.settext("to get the skin's full functionality");
		d.setXMLParam("text", "Download MSPP 0.14 now");
		c.setXMLParam("text", "Check if MSPP 0.14 is installed");
	}
}
inf.onLeftClick()  {
			System.getContainer("config").getLayout("normal").show();
			GuiTree _tree = System.getContainer("config").getLayout("normal").findObject("wasabi.preferences.group").findObject("wasabi.preferences.tree.embedded").findObject("mylist");
			_tree.sendAction("switchToItem", "MSPP Info", 0, 0, 0, 0);
}