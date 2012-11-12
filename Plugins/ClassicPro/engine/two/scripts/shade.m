#include <lib/std.mi>

Global Group mainGroup, g_SecStop, g_SecShuf, g_SecRep, g_SecSeek, g_SecVis, g_SecVol, g_SecAot, g_SecOpen;

Global Container main;
Global Layout shade;

System.onScriptLoaded() {
	mainGroup = getScriptGroup();

	main = System.getContainer("main");
	shade = main.getLayout("shade");

	g_SecStop = mainGroup.getObject("shade.sect.stop");
	g_SecShuf = mainGroup.getObject("shade.sect.shuf");
	g_SecRep = mainGroup.getObject("shade.sect.rep");
	g_SecOpen = mainGroup.getObject("shade.sect.open");
	g_SecSeek = mainGroup.getObject("shade.sect.seek");
	g_SecAot = mainGroup.getObject("shade.sect.aot");
	g_SecVis = mainGroup.getObject("shade.sect.vis");
	g_SecVol = mainGroup.getObject("shade.sect.volume");
}

mainGroup.onResize(int x, int y, int w, int h){
	if(w>=240){
		g_SecStop.hide();
		g_SecShuf.hide();
		g_SecRep.hide();
		g_SecOpen.hide();
		g_SecSeek.hide();
		g_SecAot.hide();
		g_SecVis.hide();
		g_SecVol.hide();
	
	}

	if(w<254){						//0
		//nothing yet.. smallest size
	}
	else if(w<274){					//1
		g_SecStop.show();
	}
	else if(w<294){					//2
		g_SecStop.show();
		g_SecShuf.show();
	}
	else if(w<314){					//3
		g_SecStop.show();
		g_SecShuf.show();
		g_SecRep.show();
	}
	else if(w<346){					//4
		g_SecStop.show();
		g_SecShuf.show();
		g_SecRep.show();
		g_SecOpen.show();
	}
	else if(w<443){					//5
		g_SecStop.show();
		g_SecShuf.show();
		g_SecRep.show();
		g_SecOpen.show();
		g_SecSeek.show();
		
		g_SecSeek.setXmlParam("x", "234");
		g_SecSeek.setXmlParam("w", "-321");
	}
	else if(w<546){					//6
		g_SecStop.show();
		g_SecShuf.show();
		g_SecRep.show();
		g_SecOpen.show();
		g_SecSeek.show();
		g_SecAot.show();

		g_SecSeek.setXmlParam("x", "234");
		g_SecSeek.setXmlParam("w", "-346");
	}
	else if(w<701){					//7
		g_SecStop.show();
		g_SecShuf.show();
		g_SecRep.show();
		g_SecOpen.show();
		g_SecSeek.show();
		g_SecAot.show();
		g_SecVis.show();

		g_SecSeek.setXmlParam("x", "290");
		g_SecSeek.setXmlParam("w", "-402");
		g_SecVis.setXmlParam("x", "234");
	}
	else{							//8
		g_SecStop.show();
		g_SecShuf.show();
		g_SecRep.show();
		g_SecOpen.show();
		g_SecSeek.show();
		g_SecAot.show();
		g_SecVis.show();
		g_SecVol.show();


		g_SecSeek.setXmlParam("x", "397");
		g_SecSeek.setXmlParam("w", "-509");
		g_SecVis.setXmlParam("x", "341");
	}
}