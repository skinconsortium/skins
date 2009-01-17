#include <lib/std.mi>

Function refreshCover();
Function String getMyPath();

Global Group XUIGroup;
Global GuiObject albumart;
Global PopUpMenu popMenu;
Global Timer lookagain;

System.onScriptLoaded(){
	XUIGroup = getScriptGroup();
	albumart = XUIGroup.findObject("main.albumart");
	lookagain = new Timer;
	lookagain.setDelay(1000);
}
System.onScriptUnloading(){
	delete lookagain;
}

albumart.onRightButtonUp(int x, int y){
	popMenu = new PopUpMenu;

	popMenu.addCommand("Get Album Art", 1, 0, 0);
	popMenu.addCommand("Refresh Album Art", 2, 0, 0);
	popMenu.addCommand("Open Folder", 3, 0, 0);

	int result = popMenu.popAtMouse();

	if (result==1){
		if (system.getAlbumArt(system.getPlayItemString()) > 0)	{
			albumart.setXmlParam("notfoundimage", getXmlParam("notfoundimage"));
		}
	}
	else if(result == 2){
		albumart.setXmlParam("notfoundimage", getXmlParam("notfoundimage"));
	}
	else if (result == 3){
		System.navigateUrl(getMyPath());
	}

	delete popMenu;
	complete;
}

albumart.onLeftButtonDblClk (int x, int y){
	System.navigateUrl(getMyPath());
}

System.onTitleChange (String newtitle){
	refreshCover();
}

refreshCover(){
	// ---------- Stream info ----------
	String stype = getPlayItemMetaDataString("streamtype"); //"streamtype" will return "2" for SHOUTcast and "3" for AOL Radio

	if (stype == "2"){
		albumart.setXmlParam("notfoundimage","cover.sc");
	}
	else if (stype == "3"){
		albumart.setXmlParam("notfoundimage", "cover.aolr");
	}
	else{
		albumart.setXmlParam("notfoundimage","cover.notfound");
	}
	
	if(stype == "" && !lookagain.isRunning()) lookagain.start();
	else if(stype != "") lookagain.stop();
}

lookagain.onTimer(){
	refreshCover();
}

String getMyPath() {
	String bs = strleft("\ ",1);
	String output = "";

	if(System.strleft(System.getPlayItemString(),6) == "cda://") output = System.strmid(System.getPlayItemString(), 6, 1)+":"+bs;
	else output= getPath(getPlayItemMetaDataString("filename"));
	return output;
}