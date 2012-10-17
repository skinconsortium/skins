#include <lib/std.mi>
#include <lib/pldir.mi>
#include "../lib/ClassicProFile.mi"

Function String getMyPath();

Global Group myGroup;
Global Button openBut;

System.onScriptLoaded() {
	myGroup = getScriptGroup();
	openBut = myGroup.findObject(getParam());
}

openBut.onLeftClick(){
	if(System.isKeyDown(VK_ALT)){
		String curFile = getPlayItemMetaDataString("filename");
		String curPath = getMyPath();
		List returnValueStorage;
		returnValueStorage = new List;
		int error = ClassicProFile.findFiles(curPath, "*.mp3", returnValueStorage);
		if(error==-1) return;

		PlEdit.clear();
		String enqFile = "";
		for(int i = 0; i<returnValueStorage.getNumItems();i++){
			enqFile = curPath + returnValueStorage.enumItem(i);
			PlEdit.enqueueFile(enqFile);
			if(curFile==enqFile) PlEdit.playTrack(i);
		}
		complete;
	}
}

String getMyPath(){
	String bs = strleft("\ ",1);
	String output = "";

	if(System.strleft(System.getPlayItemString(),6) == "cda://") output = System.strmid(System.getPlayItemString(), 6, 1)+":"+bs;
	else output= getPath(getPlayItemMetaDataString("filename"))+bs;
	return output;
}