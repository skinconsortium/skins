#include <lib/std.mi>

Global Group frameGroup, content;
Global String x, y, w, h, rx, ry, rw, rh;

Global Timer tmr;

Function setNewGroup(String groupid);

System.onScriptLoaded() {
  frameGroup = getScriptGroup();
  String param = getParam();
  x = getToken(param, ",", 0);
  y = getToken(param, ",", 1);
  w = getToken(param, ",", 2);
  h = getToken(param, ",", 3);
  rx = getToken(param, ",", 4);
  ry = getToken(param, ",", 5);
  rw = getToken(param, ",", 6);
  rh = getToken(param, ",", 7);
  tmr = new Timer;
  tmr.setDelay(1000);
}

System.onScriptUnloading() {
	if (tmr) {
		tmr.stop();
		delete tmr;
	}
}

frameGroup.onsetVisible(int v) {
	if (v) tmr.start();
	else tmr.stop();
}

tmr.onTimer() {
	layout l = frameGroup.getParentLayout();
	int x = l.getGuiX();
	int y = l.getGuiY();
	int h = l.getGuiH();
	int w = l.getGuiW();

	if (x+w < 0 || y+h < 0 || x > getViewPortWidth() || y > getViewPortHeight()) {
		l.center();
	}
	
}
	

System.onSetXuiParam(String param, String value) {
  if (param == "content") {
    setNewGroup(value);
  }
}

// backward compatibility for prerelease notify trick
frameGroup.onNotify(String cmd, String param, int a, int b) {
  String _command = getToken(cmd, ",", 0);
  String _param = getToken(cmd, ",", 1);
  if (_command == "content" || _command == "padtitleright" || _command == "padtitleleft" || _command == "shade") {
    onSetXuiParam(_command, _param);
  }
}

setNewGroup(String groupid) {
  content = newGroup(groupid);
  if (content == NULL) {
    messagebox("group \"" + groupid + "\" not found", "ButtonGroup", 0, "");
    return;
  }
  content.setXmlParam("x", x);
  content.setXmlParam("y", y);
  content.setXmlParam("w", w);
  content.setXmlParam("h", h);
  content.setXmlParam("relatx", rx);
  content.setXmlParam("relaty", ry);
  content.setXmlParam("relatw", rw);
  content.setXmlParam("relath", rh);
  content.init(frameGroup);
}
