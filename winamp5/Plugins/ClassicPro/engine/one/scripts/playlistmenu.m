/*---------------------------------------------------
-----------------------------------------------------
Filename:	playlistmenu.m

Type:		maki/source
Version:	skin version 1.37
Date:		10:45 31.07.2008
Author:		Pieter Nieuwoudt aka pjn123
E-Mail:		sylvester@skinconsortium.com
Internet:	http://forums.skinconsortium.com
-----------------------------------------------------
-----------------------------------------------------

How to use it:

<SongTicker id="Songticker" x="0" y="0" h="20" w="0" relatw="1"	display="SONGTITLE"/>
<script file="playlistmenu.maki" param="Songticker;40"/>

The params:
	First param = GuiObject id
	Second param = How long must the menu be?
*/


#include <lib/std.mi>
#include <lib/pldir.mi>

Global Group myGroup;
Global GuiObject clickMe;
Global Popupmenu menuList;
Global int ListLength;
Global String tempString, menutext;

System.onScriptLoaded(){
	myGroup = getScriptGroup();
	clickMe = myGroup.findObject(System.getToken(System.getParam(), ";", 0));
	ListLength = stringToInteger(System.getToken(System.getParam(), ";", 1));
	if(ListLength<10)ListLength=10;
}

clickMe.onRightButtonUp(int x, int y){
	menuList = new PopupMenu;
	
	int startpos;
	menutext = "";
	
	if(PlEdit.getNumTracks()-PlEdit.getCurrentIndex() < ListLength/2) startpos=PlEdit.getNumTracks()-ListLength;
	else startpos=PlEdit.getCurrentIndex()-ListLength/2;
	
	if(startpos<0) startpos=0;
	
	for(int i = startpos; i<startpos+ListLength; i++){
		if(i==PlEdit.getNumTracks()) break;
		menutext=integerToString(i+1)+". "+ strleft(PlEdit.getTitle(i),70);
		if(strlen(PlEdit.getTitle(i))>70) menutext+="...";
		
		if(PlEdit.getLength(i)!="") tempString="\t["+PlEdit.getLength(i)+"]";
		//else if(PlEdit.getMetaData(i, "length")!="") tempString="\t["+integerToTime(stringToInteger(PlEdit.getMetaData(i, "length")))+"]"; //dont know if this will work good on optical media
		else tempString="";
	
		//menutext+="\t["+PlEdit.getLength(i)+"pjn"+PlEdit.getMetaData(i, "length")+"]";
		menutext+=tempString;
		menuList.addCommand(menutext, i, (PlEdit.getCurrentIndex()==i), (PlEdit.getCurrentIndex()==i));
	}
	
	int result = menuList.popAtMouse();
	
	if(result>=0){
		PlEdit.playTrack(result);
	}

	delete menuList;
	complete;
}