#include <lib/std.mi>
#include <lib/config.mi>

#define MARGIN 0

Function resizeObjects();

Global GuiObject left, right, center;
Global Text tcenter, plcenter;
Global Layer lcenter, l2center, l3center, l4center, l5logo;
Global Group sg;
Global int padleft, padright;

system.onScriptLoaded() {

  padleft = 0;
  padright = 0;

  sg = getScriptGroup();

  if (sg == NULL) {
    messageBox("titlebar.maki can only run within a group", "Error", 0, "");
    return;
  }

  left = sg.findObject(getToken(getParam(), ";", 0));
  center = sg.findObject(getToken(getParam(), ";", 1));
  if (center != NULL) {
    tcenter = center.findObject("window.titlebar.title");

  }
  right = sg.findObject(getToken(getParam(), ";", 2));
}


system.onScriptUnloading() {
	sg = NULL; // clears all events
}

// backward compatibility with prerelease notify trick
sg.onNotify(String cmd, String param, int a, int b) {
  String _command = getToken(cmd, ",", 0);
  String _param = getToken(cmd, ",", 1);
  if (_command == "padtitleright" || _command == "padtitleright")
    onSetXuiParam(_command, _param);
}

System.onSetXuiParam(String param, String value) {
  if (param == "padtitleright") {
    padright = padright + StringToInteger(value);
    resizeObjects();
  }
  if (param == "padtitleleft") {
    padleft = padleft + StringToInteger(value);
    resizeObjects();
  }
}

resizeObjects() 
{
  int text_width = 0;
  int layout_width = 0;
  int group_width = sg.getWidth();

  Layout l = sg.getParentLayout();
  layout_width = l.getWidth();

  if (center != NULL) {
    //text_width = center.getAutoWidth();
    //try fixed width, seems to work better & all text is within this boundary width
	text_width = 120;
	
  }

  int lx = ((layout_width - (text_width)) / 2);
  lx = l.clientToScreenX(lx);
  lx = sg.screenToClientX(lx);
  lx = lx - sg.getLeft();

  if (center != NULL) {
    center.setXmlParam("x", IntegerToString(lx));
    center.setXmlParam("relatx", "0");
    center.setXmlParam("w", IntegerToString(text_width));
    center.setXmlParam("relatw", "0");

    tcenter.setXmlParam("x", IntegerToString(lx));
    tcenter.setXmlParam("relatx", "0");
    tcenter.setXmlParam("w", IntegerToString(text_width));
    tcenter.setXmlParam("relatw", "0");
  }

  if (left != NULL) {
    left.setXmlParam("x", IntegerToString(padleft));
    left.setXmlParam("relatx", "0");
    left.setXmlParam("w", IntegerToString(lx-padleft-MARGIN));
    left.setXmlParam("relatw", "0");
  }
  if (right != NULL) {
    right.setXmlParam("x", IntegerToString(lx+text_width+MARGIN+1));
    right.setXmlParam("relatx", "0");
    right.setXmlParam("w", "-" + IntegerToString(lx+text_width+1+padright+MARGIN+1)); //IntegerToString(group_width-(lx+text_width)));
    right.setXmlParam("relatw", "1");
  }
}

tcenter.onTextChanged(string newtext) {
  resizeObjects();
}


sg.onResize(int x, int y, int w, int h) {
  resizeObjects();
}

