#include <lib/std.mi>

Global Group g, g_volume, g_vis, g_buttons, g_ejectVol, g_volbig;
Global Layer l_left, l_right, l_volbig1, l_volbig2;
Global Button b_play, b_pause, b_eject, b_mute;
Global Guiobject gui_vis;
Global Slider s_volbig;

System.onScriptLoaded() {
	g = getScriptGroup();
	g_vis = g.getObject("two.playback.vis");
	g_buttons = g.getObject("two.playback.buttons");
	g_volume = g.getObject("two.playback.volume");

	l_left = g_vis.getObject("two.playback.left");
	gui_vis = g_vis.getObject("two.playback.visobject");
	
	b_play = g_buttons.getObject("two.playback.play");
	b_pause = g_buttons.getObject("two.playback.paus");
	b_eject = g_buttons.getObject("two.playback.eject");
	g_ejectVol = g_buttons.getObject("two.playback.ejectvol");

	l_right = g_volume.getObject("two.playback.right");
	g_volbig = g_volume.getObject("two.playback.volume.slider");
	b_mute = g_volume.getObject("two.player.mute");

	s_volbig = g_volbig.getObject("two.playback.volslider");
	
	
	//l_butright = g_buttons.getObject("two.playback.buttons.right");
	
	
	// Play-Pause button
	if(System.getStatus() == STATUS_PLAYING){
		b_play.hide();
		b_pause.show();
	}
	else{
		b_play.show();
		b_pause.hide();
	}
	
	// Reader for classic vis colors from bitmap (wa5.51)
	Map myMap = new Map;
	myMap.loadMap("cpro2.color.read");
	
	gui_vis.setXmlParam("colorbandpeak",integerToString(myMap.getARGBValue(0,0,2))+","+integerToString(myMap.getARGBValue(0,0,1))+","+integerToString(myMap.getARGBValue(0,0,0)));
	
	for(int i=2;i<18;i++){
		gui_vis.setXmlParam("colorband"+integerToString(18-i),integerToString(myMap.getARGBValue(0,i,2))+","+integerToString(myMap.getARGBValue(0,i,1))+","+integerToString(myMap.getARGBValue(0,i,0)));
	}

	for(int i=0;i<5;i++){
		gui_vis.setXmlParam("colorosc"+integerToString(5-i),integerToString(myMap.getARGBValue(2,i,2))+","+integerToString(myMap.getARGBValue(2,i,1))+","+integerToString(myMap.getARGBValue(2,i,0)));
	}

}

g.onResize(int x, int y, int w, int h){
	if(w<334){
		g_vis.hide();
		g_volume.hide();
		
		b_eject.hide();
		g_ejectVol.show();
		b_mute.hide();
	
		/*l_left.setXmlParam("image","playback.bg.left.1");
		l_right.hide();
		l_butright.setXmlParam("image","playback.bg.buttons.right.1");
		g_vis.hide();
		g_volume.hide();
		//g_butVol.show();
		//g_butShufRep.hide();*/
	}
	else if(w<406){
		g_vis.show();
		g_volume.show();

		b_eject.show();
		g_ejectVol.hide();
		b_mute.hide();

		l_left.setXmlParam("image","playback.bg.left.3");
		g_vis.setXmlParam("w","47");
		gui_vis.setXmlParam("w","35");
		
		l_right.setXmlParam("image","playback.bg.right.3");
		g_volume.setXmlParam("w","47");
		g_volume.setXmlParam("x","-55");
		g_volbig.setXmlParam("x","3");
		g_volbig.setXmlParam("w","41");
	
	
		/*
		l_left.setXmlParam("image","playback.bg.left.2");
		l_right.show();
		l_butright.setXmlParam("image","playback.bg.buttons.right.2");
		g_vis.show();
		g_volume.show();
		g_volume.setXmlParam("x","-83");
		g_volume.setXmlParam("w","83");
		//g_butVol.hide();
		//g_butShufRep.show();*/
	}
	else if(w<466){
		g_vis.show();
		g_volume.show();

		b_eject.show();
		g_ejectVol.hide();
		b_mute.hide();

		l_left.show();
		l_left.setXmlParam("image","playback.bg.left.2");
		g_vis.setXmlParam("w","83");
		gui_vis.setXmlParam("w","71");
		
		l_right.show();
		l_right.setXmlParam("image","playback.bg.right.2");
		g_volume.setXmlParam("w","83");
		g_volume.setXmlParam("x","-91");
		g_volbig.setXmlParam("x","3");
		g_volbig.setXmlParam("w","77");


		/*l_left.setXmlParam("image","playback.bg.left.2");
		l_right.show();
		l_butright.setXmlParam("image","playback.bg.buttons.right.2");
		g_vis.show();
		g_volume.show();
		g_volume.setXmlParam("x","-83");
		g_volume.setXmlParam("w","83");
		//g_butVol.hide();
		//g_butShufRep.show();*/
	}
	else{
		g_vis.show();
		g_volume.show();

		b_eject.show();
		g_ejectVol.hide();
		b_mute.show();

		l_left.show();
		l_left.setXmlParam("image","playback.bg.left.1");
		g_vis.setXmlParam("w","113");
		gui_vis.setXmlParam("w","71");

		l_right.show();
		l_right.setXmlParam("image","playback.bg.right.1");
		g_volume.setXmlParam("w","113");
		g_volume.setXmlParam("x","-121");
		g_volbig.setXmlParam("x","33");
		g_volbig.setXmlParam("w","77");

		/*l_left.setXmlParam("image","playback.bg.left.2");
		l_right.show();
		l_butright.setXmlParam("image","playback.bg.buttons.right.2");
		g_vis.show();
		g_volume.show();
		g_volume.setXmlParam("x","-113");
		g_volume.setXmlParam("w","113");
		//g_butVol.hide();
		//g_butShufRep.show();*/
	}
	
	
	g_buttons.setXmlParam("x", integerToString(w/2-112));
}

// Play-Pause button
System.onPlay(){
	b_play.hide();
	b_pause.show();
}
System.onStop(){
	b_play.show();
	b_pause.hide();
}
System.onPause(){
	b_play.show();
	b_pause.hide();
}
System.onResume(){
	b_play.hide();
	b_pause.show();
}

//Restart current track ;)
b_pause.onRightButtonDown(int x, int y){ //Winamp bug hack
	b_pause.setXmlParam("action", "");
}
b_pause.onRightButtonUp(int x, int y){ 
	System.play();
	complete;
	b_pause.setXmlParam("action", "PAUSE");
}