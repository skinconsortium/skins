/*
Optimized on 6 Jan 2010 by pjn123
*/

#include <lib/std.mi>

Global Group g;
Global Button b_play, b_pause;

System.onScriptLoaded() {
	g = getScriptGroup();
	b_play = g.getObject("shade.play");
	b_pause = g.getObject("shade.pause");
	
	// Play-Pause button
	if(System.getStatus() == STATUS_PLAYING){
		b_play.hide();
		b_pause.show();
	}
	else{
		b_play.show();
		b_pause.hide();
	}
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