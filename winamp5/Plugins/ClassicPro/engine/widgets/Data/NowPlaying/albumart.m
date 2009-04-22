#include <lib/std.mi>
#include "../../../lib/ClassicProFile.mi"

Function doMyMenu(int x, int y);
Function openMyFolder();
Function String getMyFile();

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
			AlbumArt.setXmlParam("notfoundimage", AlbumArt.getXmlParam("notfoundimage"));
			AlbumArt2.setXmlParam("notfoundimage", AlbumArt2.getXmlParam("notfoundimage"));
		}
	}
	else if (result == 2){
		AlbumArt.setXmlParam("notfoundimage", AlbumArt.getXmlParam("notfoundimage"));
		AlbumArt2.setXmlParam("notfoundimage", AlbumArt2.getXmlParam("notfoundimage"));
	}
	else if (result == 3){
		openMyFolder();
	}
}

AlbumArt.onLeftButtonDblClk (int x, int y){
	openMyFolder();
}
AlbumArt2.onLeftButtonDblClk (int x, int y){
	openMyFolder();
}
openMyFolder(){
	ClassicProFile.exploreFile(getMyFile());
}
String getMyFile() {
	String bs = strleft("\ ",1);
	String output = "";

	if(System.strleft(System.getPlayItemString(),6) == "cda://") output = System.strmid(System.getPlayItemString(), 6, 1)+":"+bs;
	else output= getPlayItemMetaDataString("filename");
	return output;
}