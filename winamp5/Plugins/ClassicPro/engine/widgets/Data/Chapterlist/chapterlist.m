/**
 * Chapterlist.m
 *
 * @author pjn123
 * @date 27-Mar-2009
 */

#include <lib/std.mi>
#include <lib/fileio.mi>
#include <lib/application.mi>
#include <lib/ClassicProFile.mi>
#include <lib/colormgr.mi>

//#define ICON_NORMAL "icon.chapterlist.playing"
//#define ICON_LOOP "icon.chapterlist.loop"

Function readXmlList();
Function saveXmlList();
Function fillList(boolean save);
Function sortSyncTwoLists();
Function clearListNow();
Function int getChapterCurrent();
Function gotoChapter(int no);
Function updatePlayIcon();
Function setLoopChapter(boolean onOff);
Function String makeUrlSave(String url);
Function String replaceString(string baseString, string toreplace, string replacedby);

Global Group main;
Global GuiList myList;
Global List _times, _names, _times2, _names2;
Global XmlDoc myDoc;
Global Button addBut, remBut, prevBut, nextBut;
Global Edit editName;
Global String lastReadXml;
Global Timer playingTrack, loopCheck, sleepDblc;
Global int loopChapter;
Global boolean loop;
Global String iconpic, ICON_NORMAL, ICON_LOOP;

System.onScriptLoaded (){
	main = getScriptGroup();
	myList = main.findObject("chapterlist");
	addBut = main.findObject("chapterlist.add");
	remBut = main.findObject("chapterlist.rem");
	prevBut = main.findObject("chapterlist.prev");
	nextBut = main.findObject("chapterlist.next");
	editName = main.findObject("chaperlist.editbox");

	playingTrack = new Timer;
	playingTrack.setDelay(1000);
	
	sleepDblc = new Timer;
	sleepDblc.setDelay(100);

	myList.setIconWidth(16);
	myList.setShowIcons(1);
	
	Color myColor = ColorMgr.getColor("wasabi.list.text");
	int avCol = (myColor.getRed()+myColor.getGreen()+myColor.getBlue())/3;

	if(avCol<255/5){
		ICON_NORMAL = "icon.chapterlist.playing.black";
		ICON_LOOP = "icon.chapterlist.loop.black";
	}
	else if(avCol<255/5*3){
		ICON_NORMAL = "icon.chapterlist.playing.gray";
		ICON_LOOP = "icon.chapterlist.loop.gray";
	}
	else{
		ICON_NORMAL = "icon.chapterlist.playing.white";
		ICON_LOOP = "icon.chapterlist.loop.white";
	}
	
	iconpic = ICON_NORMAL;
	
	_times = new List;
	_names = new List;

	if(main.isVisible()) readXmlList();
	//saveXmlList();
}
System.onScriptUnLoading(){
	delete playingTrack;
	delete sleepDblc;
	delete loopCheck;
}

readXmlList(){

	String temp;
	
	if(System.strleft(System.getPlayItemString(),4)=="http"){
		//temp = Application.GetSettingsPath()+"\Chapterlist" +makeUrlSave(System.getPlayItemString()) + ".xml";
		temp = Application.GetSettingsPath() +makeUrlSave(System.getPlayItemString()) + ".xml";
	}
	else{
		temp = System.getPlayItemString() + ".xml";
		if(System.strsearch(temp, "file://")!=-1) temp = System.strright(temp, System.strlen(temp)-7);
	}

		//debug(temp);
	
	myDoc = new XmlDoc;
	myDoc.load (temp);

	//if(temp==lastReadXml) return;
	//lastReadXml = temp;

	delete _times;
	delete _names;

	_times = new List;
	_names = new List;
	
	
	if(!myDoc.exists()){
		clearListNow();
		myList.hide();
		playingTrack.stop();
		return;
	}
	
	myDoc.parser_addCallback("Chapterlist/*");
	myDoc.parser_start();
	myDoc.parser_destroy();

	fillList(false);
	delete myDoc;
}

myDoc.parser_onCallback (String xmlpath, String xmltag, list paramname, list paramvalue){
	if(strlower(xmltag) == "chapter"){
		if(paramname.getNumItems()==2){
			for(int i=0; i<paramname.getNumItems(); i++){
				if(strlower(paramname.enumItem(i))=="pos"){
					_times.addItem(paramvalue.enumItem(i));
				}
				else if(strlower(paramname.enumItem(i))=="name"){
					_names.addItem(paramvalue.enumItem(i));
				}
			}
		}
		else debug("Xml structure is wrong!!!");
	}
}


fillList(boolean save){
	if(_times.getNumItems()==0){
		myList.hide();
		playingTrack.stop();
		clearListNow();
		return;
	}
	
	sortSyncTwoLists();
	
	
	//myList.deleteAllItems();
	clearListNow();
	
	
	
	for(int i=0; i<_times.getNumItems(); i++){
		myList.addItem(System.integerToLongTime(stringToInteger(_times.enumItem(i))));
		myList.setSubItem(i, 1, _names.enumItem(i));
	}
	if(_times.getNumItems()>0){
		myList.show();
		playingTrack.start();
		updatePlayIcon();
		if(save) saveXmlList();
	}
}

/*myList.onSetVisible(boolean onOff){
	if(onOff){
		playingTrack = new Timer;
		playingTrack.setDelay(1000);
		playingTrack.start();
	}
	else delete playingTrack;
}*/

myList.onDoubleClick(Int itemnum){
	//debugstring("onDoubleClick",9);
	//complete;
	if(getChapterCurrent()!=itemnum && loop) setLoopChapter(false);
	gotoChapter(itemnum);
	sleepDblc.start();
	//complete;
}

sortSyncTwoLists(){
	_times2 = new List;
	_names2 = new List;
	
	int t = _times.getNumItems();
	for(int x=0; x < t; x++){
		int lowest = _times.enumItem(0);
		int lowestPos = 0;
	
		for(int y=1; y < _times.getNumItems(); y++){
			int n1 = _times.enumItem(lowestPos);	//TIP: You need to create the int first because it dont sort that good without it!
			int n2 = _times.enumItem(y);
			
			if(n1>n2){
				//debug("TRUE!");
				lowest=_times.enumItem(y);
				lowestPos=y;
			}
		}
		
		_times2.addItem(_times.enumItem(lowestPos));
		_names2.addItem(_names.enumItem(lowestPos));
		_times.removeItem(lowestPos);
		_names.removeItem(lowestPos);
	}
	
	delete _times;
	delete _names;
	_times = new List;
	_names = new List;

	for(int x=0; x < _times2.getNumItems(); x++){
		_times.addItem(_times2.enumItem(x));
		_names.addItem(_names2.enumItem(x));
	}
	
	delete _times2;
	delete _names2;
}


addBut.onLeftClick(){
	if(_times.getNumItems()==0){
		_times.addItem("0");
		_names.addItem(System.translate("Start of first chapter"));
	}

	_times.addItem(integerToString(System.getPosition()));
	_names.addItem(System.translate("New Chapter"));
	
	fillList(true);
}

remBut.onLeftClick(){
	if(_times.getNumItems()<1) return;

	setLoopChapter(false);

	int sel = myList.getFirstItemSelected();
	if(sel==0 && _times.getNumItems()>1) return;
	
	_times.removeItem(sel);
	_names.removeItem(sel);
	fillList(true);
	
	int select = sel-1;
	if(select<0) select=0;
	
	if(_times.getNumItems()!=0) myList.setSelected(select, 1);
}

saveXmlList(){
	String temp;
	
	if(System.strleft(System.getPlayItemString(),4)=="http"){
		//temp = Application.GetSettingsPath()+"\Chapterlist" +makeUrlSave(System.getPlayItemString()) + ".xml";
		temp = Application.GetSettingsPath() +makeUrlSave(System.getPlayItemString()) + ".xml";
	}
	else{
		temp = System.getPlayItemString() + ".xml";
		if(System.strsearch(temp, "file://")!=-1) temp = System.strright(temp, System.strlen(temp)-7);
	}





	int qwe = ClassicProFile.createFile(temp);
	ClassicProFile.writeFile(qwe, "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n<Chapterlist version=\"1.0\">\n");

	for(int x=0; x < _times.getNumItems(); x++){
		ClassicProFile.writeFile(qwe, "	<Chapter pos=\""+integerToString(_times.enumItem(x))+"\" name=\""+_names.enumItem(x)+"\"/>\n");
	}

	ClassicProFile.writeFile(qwe, "</Chapterlist>");
	ClassicProFile.closeFile(qwe);
}

editName.onEnter(){
	int sel = myList.getFirstItemSelected();
	
	_times.addItem(_times.enumItem(sel));
	_names.addItem(editName.getText());
	
	_times.removeItem(sel);
	_names.removeItem(sel);
	
	fillList(true);
	
	myList.setSelected(sel, 1);
}

myList.onItemSelection(Int itemnum, Int selected){
	editName.setText(_names.enumItem(itemnum));
}

System.onTitleChange(String newtitle){
	if(!main.isVisible()) return;
	
	setLoopChapter(false);
	readXmlList();
}

main.onSetVisible(boolean onOff){
	if(onOff){
		setLoopChapter(false);
		readXmlList();
	}

}

clearListNow(){
	while(myList.getNumItems()!=0) myList.deleteByPos(0);
	editName.setText("");
}

int getChapterCurrent(){
	int output = 0;
	for(int x=1; x < _times.getNumItems(); x++){
		if(System.getPosition()<_times.enumItem(x)) return x-1;
	}
	return _times.getNumItems()-1;
}

prevBut.onLeftClick(){
	if(_times.getNumItems()<1) return;

	setLoopChapter(false);
	int i = getChapterCurrent()-1;
	if(i<0)i=0;
	gotoChapter(i);
}
nextBut.onLeftClick(){
	if(_times.getNumItems()<1) return;

	setLoopChapter(false);
	int i = getChapterCurrent()+1;

	if(_times.getNumItems()==i) return; // do nothing

	if(i>_times.getNumItems()-1) i=_times.getNumItems()-1;
	gotoChapter(i);
}

gotoChapter(int no){
	System.seekTo(_times.enumItem(no));
	updatePlayIcon();
}


playingTrack.onTimer(){
	updatePlayIcon();
}

updatePlayIcon(){
	int active = getChapterCurrent();
	for(int x=0; x < _times.getNumItems(); x++){
		if(x==active) myList.setItemIcon(x, iconpic);
		else myList.setItemIcon(x, "");
	}
	//myList.scrollToItem(active);
}

myList.onIconLeftClick(int itemnum, int x, int y){
	if(sleepDblc.isRunning()) return;
	
	//debugstring("onIconLeftClick",9);
	if(itemnum == getChapterCurrent()){
		setLoopChapter(!loop);
	}
}
sleepDblc.onTimer(){sleepDblc.stop();}

setLoopChapter(boolean onOff){
	if(getChapterCurrent() == _times.getNumItems()-1) return;
	
	if(onOff){
		iconpic = ICON_LOOP;
		loopChapter = getChapterCurrent();
		loopCheck = new Timer;
		loopCheck.setDelay(100);
		loopCheck.start();
	}
	else{
		iconpic = ICON_NORMAL;
		delete loopCheck;
	}
	updatePlayIcon();
	loop=onOff;
}

loopCheck.onTimer(){
	if(getChapterCurrent()!=loopChapter) gotoChapter(loopChapter);
}

System.onStop(){
	setLoopChapter(false);
	playingTrack.stop();
}

String makeUrlSave(String url){
	String wip;
	while(wip != url){
		wip = url;
		url = replaceString(url, strleft("\ ",1), "_");
		url = replaceString(url, strleft("/ ",1), "_");
		url = replaceString(url, strleft(": ",1), "_");
		url = replaceString(url, strleft("* ",1), "_");
		url = replaceString(url, strleft("? ",1), "_");
		url = replaceString(url, strleft("< ",1), "_");
		url = replaceString(url, strleft("> ",1), "_");
		url = replaceString(url, strleft("| ",1), "_");
	}
	return strleft("\ ",1) + url;
}

String replaceString(string baseString, string toreplace, string replacedby){
	if (toreplace == "") return baseString;
	string sf1 = strupper(baseString);
	string sf2 = strupper(toreplace);
	int i = strsearch(sf1, sf2);
	if (i == -1) return baseString;
	string left = "", right = "";
	if (i != 0) left = strleft(baseString, i);
	if (strlen(basestring) - i - strlen(toreplace) != 0) {
		right = strright(basestring, strlen(basestring) - i - strlen(toreplace));
	}
	return left + replacedby + right;
}
