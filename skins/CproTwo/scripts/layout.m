#include <lib/std.mi>

#define i_info 40 
#define i_playback 30 

Function buildSkin();

Global Group g, g_screen, g_info, g_playback;
Global Container c;
Global Layer l_frame4, l_frame5, l_frame6;
Global int i_titlebar;

System.onScriptLoaded() {
	g = getScriptGroup();
	g_screen = g.getObject("two.screen");
	g_info = g_screen.getObject("two.info");
	g_playback = g_screen.getObject("two.playback");
	
	l_frame4 = g.getObject("two.frame.4");
	l_frame5 = g.getObject("two.frame.5");
	l_frame6 = g.getObject("two.frame.6");
	
	Map m = new Map;
	m.loadMap("frame.top");
	i_titlebar = m.getHeight();
	delete m;
	
	g.setXmlParam("minimum_h",integerToString(i_titlebar+i_info+i_playback+8));
	buildSkin();
}

System.onScriptUnloading(){
}

buildSkin(){
	String temp = integerToString(i_titlebar+i_info+i_playback);
	l_frame4.setXmlParam("y", temp);
	l_frame6.setXmlParam("y", temp);
	
	temp = integerToString(-i_titlebar-i_info-i_playback-8);
	l_frame4.setXmlParam("h", temp);
	l_frame6.setXmlParam("h", temp);

	temp = integerToString(i_titlebar);
	l_frame5.setXmlParam("y", temp);
	g_screen.setXmlParam("y", integerToString(i_titlebar));

	l_frame5.setXmlParam("h", integerToString(-i_titlebar-8));
	g_screen.setXmlParam("h", integerToString(i_info + i_playback));
}