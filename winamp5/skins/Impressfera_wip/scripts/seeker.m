#include <lib/std.mi>

Global Group myGroup;
Global Layer seekerLayer1, seekerLayer2;
Global Map SeekerMap1;
Global Boolean volClicked;
Global Slider seeker;
Global int finalseek;
Global GuiObject SongTicker;

System.onScriptLoaded() {
	myGroup = getScriptGroup();
	volClicked = false;

	if(myGroup == NULL) return;

	String vLayer = getToken(getParam(), ";", 0);
	String vMap = getToken(getParam(), ";", 1);

	SongTicker = myGroup.findObject("infosongticker");
	
	seeker = myGroup.getObject("seeker.slider");
	seekerLayer1 = myGroup.getObject(vLayer);
	seekerLayer2 = myGroup.getObject("seeker.bg.2");
	SeekerMap1 = new map;
	SeekerMap1.loadMap(vMap);
	
	seekerLayer1.setRegionFromMap(SeekerMap1,seeker.getPosition(),1);
	seekerLayer2.setRegionFromMap(SeekerMap1,0,1);
}

/*System.onSeek(int newpos) {
	if(System.getPlayItemLength()>0) seekerLayer1.setRegionFromMap(SeekerMap1,newpos/System.getPlayItemLength()*255,1);
	else seekerLayer1.setRegionFromMap(SeekerMap1,0,1);
}*/
seeker.onPostedPosition(int newpos){
	seekerLayer1.setRegionFromMap(SeekerMap1,newpos,1);
}

seekerLayer1.onLeftButtonDown(int x, int y) {
	volClicked = true;
	x -= seekerLayer1.getLeft();
	y -= seekerLayer1.getTop();
	if(SeekerMap1.inRegion(x,y)) {
		int tvol = SeekerMap1.getValue(x, y);
		//System.seekTo(System.getPlayItemLength()*tvol/255);
		finalseek = System.getPlayItemLength()*tvol/255;
		seekerLayer2.setRegionFromMap(SeekerMap1,tvol,1);
		SongTicker.sendAction("showinfo",System.translate("Seek") +": "+integerToTime(tvol/255*getPlayItemLength()) + "/" + integerToTime(getPlayItemLength()) +" ("+ integerToString(tvol/255*100)+"%)", 0, 0, 0, 0);
	}
	seekerLayer2.show();
}

seekerLayer1.onLeftButtonUp(int x, int y) {
	volClicked = false;
	System.seekTo(finalseek);
	seekerLayer2.hide();
	seekerLayer2.setRegionFromMap(SeekerMap1,0,1);
}

seekerLayer1.onMouseMove(int x, int y) {
	if(volClicked == true) {
		x -= seekerLayer1.getLeft();
		y -= seekerLayer1.getTop();
		if(SeekerMap1.inRegion(x,y)) {
			int tvol = SeekerMap1.getValue(x, y);
			finalseek = System.getPlayItemLength()*tvol/255;
			seekerLayer2.setRegionFromMap(SeekerMap1,tvol,1);
			SongTicker.sendAction("showinfo",System.translate("Seek") +": "+integerToTime(tvol/255*getPlayItemLength()) + "/" + integerToTime(getPlayItemLength()) +" ("+ integerToString(tvol/255*100)+"%)", 0, 0, 0, 0);
		}
	}
}