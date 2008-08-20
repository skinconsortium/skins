#include <lib/std.mi>
#include <lib/pldir.mi>

Function refreshPlaylist();

Global Group myGroup;
Global GuiList myList;
Global PlEdit PeListener;
Global Text fakeText;
Global String previousTxt;

System.onScriptLoaded(){
	myGroup = getScriptGroup();
	myList = myGroup.findObject("tpl.list");
	fakeText = myGroup.findObject("tpl.text.hidden");
	
	refreshPlaylist();
	PeListener = new PlEdit;
}

refreshPlaylist(){
	myList.deleteAllItems();
	for(int i=0;i<PlEdit.getNumTracks();i++){
		myList.addItem(integerToString(i+1)+". "+PlEdit.getTitle(i));
	}
	//myList.scrollToItem(PlEdit.getCurrentIndex());
	myList.setSelected(PlEdit.getCurrentIndex(), 1);
}


//playlist listeners
PlEdit.onPleditModified(){
	refreshPlaylist();
}
fakeText.onTextChanged(String newtxt){
	if(getToken(newtxt, "/", 1)!=previousTxt) refreshPlaylist();

	previousTxt = getToken(newtxt, "/", 1);
}


//list stuff
myList.onDoubleClick(int itemnum){
	PlEdit.playTrack(itemnum);
}