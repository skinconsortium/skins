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

Function readXmlList();
Function saveXmlList();
Function fillList();
Function sortSyncTwoLists();
Function clearListNow();
Function int getChapterCurrent();
Function gotoChapter(int no);

Global Group main;
Global GuiList myList;
Global List _times, _names, _times2, _names2;
Global XmlDoc myDoc;
Global Button addBut, remBut, prevBut, nextBut;
Global Edit editName;
Global String lastReadXml;

System.onScriptLoaded (){
	main = getScriptGroup();
	myList = main.findObject("chapterlist");
	addBut = main.findObject("chapterlist.add");
	remBut = main.findObject("chapterlist.rem");
	prevBut = main.findObject("chapterlist.prev");
	nextBut = main.findObject("chapterlist.next");
	editName = main.findObject("chaperlist.editbox");
	
	readXmlList();
	//saveXmlList();
}

readXmlList(){
	String temp = System.getPlayItemString() + ".xml";
	
	if(System.strsearch(temp, "file://")!=-1){
		temp = System.strright(temp, System.strlen(temp)-7);
	}
	
	if(temp==lastReadXml) return;
	lastReadXml = temp;

	delete _times;
	delete _names;

	_times = new List;
	_names = new List;
	
	myDoc = new XmlDoc;
	
	myDoc.load (temp);
	
	if(!myDoc.exists()){
		clearListNow();
		myList.hide();
		return;
	}
	
	myDoc.parser_addCallback("Chapterlist/*");
	myDoc.parser_start();
	myDoc.parser_destroy();

	fillList();
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


fillList(){
	if(_times.getNumItems()==0){
		myList.hide();
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
	if(_times.getNumItems()>0) myList.show();
}


myList.onDoubleClick(Int itemnum){
	gotoChapter(itemnum);
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
		_names.addItem("Start of first chapter");
	}

	_times.addItem(integerToString(System.getPosition()));
	_names.addItem("New Chapter");
	
	fillList();
}

remBut.onLeftClick(){
	if(_times.getNumItems()<1) return;
	int sel = myList.getFirstItemSelected();
	if(sel==0 && _times.getNumItems()>1) return;
	
	_times.removeItem(sel);
	_names.removeItem(sel);
	fillList();
	
	int select = sel-1;
	if(select<0) select=0;
	
	if(_times.getNumItems()!=0) myList.setSelected(select, 1);
}

saveXmlList(){
	int qwe = ClassicProFile.createFile("C:/testtest.xml");
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
	
	fillList();
	
	myList.setSelected(sel, 1);
}

myList.onItemSelection(Int itemnum, Int selected){
	editName.setText(_names.enumItem(itemnum));
}

System.onTitleChange(String newtitle){
	readXmlList();
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

	int i = getChapterCurrent()-1;
	if(i<0)i=0;
	gotoChapter(i);
}
nextBut.onLeftClick(){
	if(_times.getNumItems()<1) return;

	int i = getChapterCurrent()+1;

	if(_times.getNumItems()==i) return; // do nothing

	if(i>_times.getNumItems()-1) i=_times.getNumItems()-1;
	gotoChapter(i);
}

gotoChapter(int no){
	System.seekTo(_times.enumItem(no));
}