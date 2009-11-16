#include <lib/std.mi>

Global Group g, g_volume, g_vis;

System.onScriptLoaded() {
	g = getScriptGroup();
	g_volume = g.getObject("two.playback.volume");
	g_vis = g.getObject("two.playback.vis");
}

g.onResize(int x, int y, int w, int h){
	if(w<391){
		g_volume.hide();
		g_vis.hide();
	}
	else if(w<468){
		g_volume.show();
		g_vis.hide();
	}
	else{
		g_volume.show();
		g_vis.show();
		g_vis.setXmlParam("x", integerToString(165+(w-165-75-151)/2-39));
	}
}