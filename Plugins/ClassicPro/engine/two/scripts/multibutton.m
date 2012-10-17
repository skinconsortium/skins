#include <lib/std.mi>
#include <lib/pldir.mi>
#include <lib/config.mi>
#include "../../lib/ClassicProFile.mi"
#include <lib/application.mi>
#include <lib/quickPlaylist.mi>

Function String getMyFile();

Global Group g;
Global Popupmenu selMenu;
Global Button bolt, fakeAbout, changeTheme;

System.onScriptLoaded() {
	g = getScriptGroup();
	String param = getParam();
	bolt = g.findObject(getToken(param,";",0));
	fakeAbout = g.findObject(getToken(param,";",1));
	changeTheme = g.findObject(getToken(param,";",2));
}

bolt.onLeftClick(){
	int a = getPublicInt("cPro.multibutton", 0);
	
	if(a==0){
		fakeAbout.leftClick();
	}
	else if(a==1){
		//System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
		ClassicProFile.exploreFile(getMyFile());
	}
	else if(a==2){
		popQuickPlaylist(40, false);
	}
	else if(a==3){
		changeTheme.leftClick();
	}
	
}

String getMyFile() {
	String bs = strleft("\ ",1);
	String output = "";

	if(System.strleft(System.getPlayItemString(),6) == "cda://") output = System.strmid(System.getPlayItemString(), 6, 1)+":"+bs;
	else output= getPlayItemMetaDataString("filename");
	return output;
}

bolt.onRightButtonUp(int x, int y){
	selMenu = new PopupMenu;
	selMenu.addCommand("Multi-Button Action:", -1, 0, 1);
	selMenu.addSeparator();
	selMenu.addCommand("Open About Winamp", 0, 0, 0);
	selMenu.addCommand("Explore Folder", 1, 0, 0);
	selMenu.addCommand("Show Quick Playlist", 2, 0, 0);
	selMenu.addCommand("Change Color Theme", 3, 0, 0);
	selMenu.checkCommand(getPublicInt("cPro.multibutton", 0), 1);
	
	//int a = selMenu.popAtMouse();
	int a = selMenu.popAtXY(clientToScreenX(bolt.getLeft())+2, clientToScreenY(bolt.getTop())+26);
	// clientToScreenX(trigger.getLeft()), clientToScreenY(trigger.getTop()+26)
	
	if(a>=0){
		setPublicInt("cPro.multibutton", a);
	}
	Complete;
	delete selMenu;
}