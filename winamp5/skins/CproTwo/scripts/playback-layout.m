#include <lib/std.mi>

Global Group g, g_volume, g_vis, g_buttons;
Global Layer l_left, l_right, l_butright;

System.onScriptLoaded() {
	g = getScriptGroup();
	g_buttons = g.getObject("two.playback.buttons");
	g_volume = g.getObject("two.playback.volume");
	g_vis = g.getObject("two.playback.vis");
	
	l_butright = g_buttons.getObject("two.playback.buttons.right");
	
	l_left = g.getObject("two.playback.left");
	l_right = g.getObject("two.playback.right");
}

g.onResize(int x, int y, int w, int h){
	if(w<406){
		l_left.setXmlParam("image","playback.bg.left.1");
		l_right.setXmlParam("image","playback.bg.right.1");
		l_right.setXmlParam("x","-8");
		l_butright.setXmlParam("image","playback.bg.buttons.right.1");
		g_vis.hide();
		g_volume.hide();
	}
	else if(w<466){
		l_left.setXmlParam("image","playback.bg.left.2");
		l_right.setXmlParam("image","playback.bg.right.2");
		l_right.setXmlParam("x","-91");
		l_butright.setXmlParam("image","playback.bg.buttons.right.2");
		g_vis.show();
		g_volume.show();
		g_volume.setXmlParam("x","-91");
		g_volume.setXmlParam("w","91");
	}
	else{
		l_left.setXmlParam("image","playback.bg.left.2");
		l_right.setXmlParam("image","playback.bg.right.2");
		l_right.setXmlParam("x","-91");
		l_butright.setXmlParam("image","playback.bg.buttons.right.2");
		g_vis.show();
		g_volume.show();
		g_volume.setXmlParam("x","-121");
		g_volume.setXmlParam("w","121");
	}
	
	
	g_buttons.setXmlParam("x", integerToString(w/2-112));
}