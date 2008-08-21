#include <lib/std.mi>

Global Group XUIGroup;
Global GuiObject albumart;
Global PopUpMenu popMenu;

System.onScriptLoaded(){
	XUIGroup = getScriptGroup();
	albumart = XUIGroup.findObject("main.albumart");
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
		System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
	}

	delete popMenu;
	complete;
}

albumart.onLeftButtonDblClk (int x, int y){
	System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
}