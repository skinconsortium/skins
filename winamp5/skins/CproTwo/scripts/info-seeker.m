#include <lib/std.mi>

Function setSeekerPos(int newpos);

Global Group g;
Global Container c;
Global Layer l_seekerActive, l_seekerInactive, l_seekerFinder;
Global int i_titlebar, i_info, i_playback;
Global Slider s_seeker0, s_seeker1;

System.onScriptLoaded() {
	g = getScriptGroup();
	s_seeker0 = g.getObject("two.info.seeker.slider.0");
	s_seeker1 = g.getObject("two.info.seeker.slider.1");
	l_seekerInactive = g.getObject("two.info.seeker.inactive");
	l_seekerActive = g.getObject("two.info.seeker.active");
	l_seekerFinder = g.getObject("two.info.seeker.finder");
}

System.onScriptUnloading(){
}

s_seeker0.onPostedPosition(int newpos){
	setSeekerPos(newpos);
}
s_seeker1.onSetPosition(int newpos){
	int temp = g.getWidth();
	l_seekerFinder.setXmlParam("w", integerToString(temp*newpos/255));
}
s_seeker1.onSetFinalPosition(int pos){
	l_seekerFinder.setXmlParam("w", "0");
}
g.onResize(int x, int y, int w, int h){
	setSeekerPos(s_seeker0.getPosition());
}

setSeekerPos(int newpos){
	int temp = g.getWidth();
	l_seekerInactive.setXmlParam("x", integerToString(temp*newpos/255));
	l_seekerInactive.setXmlParam("w", integerToString(temp-temp*newpos/255));
	l_seekerActive.setXmlParam("w", integerToString(temp*newpos/255));
}


s_seeker1.onEnterArea(){
	l_seekerActive.setXmlParam("image", "info.bg.seeker.2");
}
s_seeker1.onLeaveArea(){
	l_seekerActive.setXmlParam("image", "info.bg.seeker.1");
}