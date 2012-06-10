#include <lib/std.mi>

Global Group mainGroup, g_SecStop, g_SecShuf, g_SecRep, g_SecSeek, g_SecVis;

Global Container main;
Global Layout shade;

System.onScriptLoaded() {
	mainGroup = getScriptGroup();

	main = System.getContainer("main");
	shade = main.getLayout("shade");

	g_SecStop = mainGroup.findObject("shade.sect.stop");
	g_SecShuf = mainGroup.findObject("shade.sect.shuf");
	g_SecRep = mainGroup.findObject("shade.sect.rep");
	g_SecSeek = mainGroup.findObject("shade.sect.seek");
	g_SecVis = mainGroup.findObject("shade.sect.vis");
}

mainGroup.onResize(int x, int y, int w, int h){
	if(w>=240){
		g_SecVis.hide();
		g_SecSeek.hide();
		g_SecRep.hide();
		g_SecShuf.hide();
		g_SecStop.hide();
	
	}

	if(w<254){
		//nothing yet.. smallest size
	}
	else if(w<274){
		g_SecStop.show();
	}
	else if(w<294){
		g_SecStop.show();
		g_SecShuf.show();
	}
	else if(w<321){
		g_SecStop.show();
		g_SecShuf.show();
		g_SecRep.show();
	}
	else if(w<530){
		g_SecStop.show();
		g_SecShuf.show();
		g_SecRep.show();
		g_SecSeek.show();
		g_SecSeek.setXmlParam("w", "-297");
	}
	else{
		g_SecStop.show();
		g_SecShuf.show();
		g_SecRep.show();
		g_SecSeek.show();
		g_SecVis.show();
		g_SecSeek.setXmlParam("w", "-390");
	}
}