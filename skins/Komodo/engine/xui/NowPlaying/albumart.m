#include <lib/std.mi>

Function doMyMenu(int x, int y);
Function openMyFolder();

Global layer AlbumArt, AlbumArt2;

System.onScriptLoaded (){
	AlbumArt = getScriptGroup().findObject("main.albumart");
	AlbumArt2 = getScriptGroup().findObject("main.albumart.reflection");
}

AlbumArt.onRightButtonDown (int x, int y){
	doMyMenu(x, y);
}
AlbumArt2.onRightButtonDown (int x, int y){
	doMyMenu(x, y);
}
doMyMenu(int x, int y){
	popupmenu p = new popupmenu;

	p.addCommand("Get Album Art", 1, 0, 0);
	p.addCommand("Refresh Album Art", 2, 0, 0);
	p.addCommand("Open Folder", 3, 0, 0);

	int result = p.popatmouse();
	delete p;

	if(result == 1){
		if (System.getAlbumArt(system.getPlayItemString()) > 0){
			AlbumArt.setXmlParam("notfoundimage", AlbumArt.getXmlParam("cover.notfound"));
			AlbumArt2.setXmlParam("notfoundimage", AlbumArt2.getXmlParam("cover.notfound"));
		}
	}
	else if (result == 2){
		AlbumArt.setXmlParam("notfoundimage", AlbumArt.getXmlParam("cover.notfound"));
		AlbumArt2.setXmlParam("notfoundimage", AlbumArt2.getXmlParam("cover.notfound"));
	}
	else if (result == 3){
		openMyFolder();
	}
}

AlbumArt.onLeftButtonDblClk (int x, int y){
	doMyMenu(x, y);
	//openMyFolder();
}
AlbumArt2.onLeftButtonDblClk (int x, int y){
	doMyMenu(x, y);
	//openMyFolder();
}
openMyFolder(){
	System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
}