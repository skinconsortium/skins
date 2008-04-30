//SLoB - added bit more error handling as could produce errors
//stick to the format of jpg or png as per label

#include <lib/std.mi>
#include "../scripts/attribs.m"

/* Part of exd.mi */

Function String replaceString(string baseString, string toreplace, string replacedby);

/**
 replaceString()

 Returns the class name for the object.

 @param  baseString    The String which you want to modify.
 @param  toreplace     The String you want to be replaced.
 @param  replacedby    The String instead of 'toreplace'.
 @ret                  The replaced string.
*/

String replaceString(string baseString, string toreplace, string replacedby) {
	if (toreplace == "") return baseString;
	int i = strsearch(baseString, toreplace);
	if (i == -1) return baseString;
	string left = "", right = "";
	if (i != 0) left = strleft(baseString, i);

	if (strlen(basestring) - i - strlen(toreplace) != 0) {
		right = strright(basestring, strlen(basestring) - i - strlen(toreplace));
	}
	return left + replacedby + right;
}


//#define DEBUG

#ifdef DEBUG
Function debug(String debugStr);
debug(String debugStr) {
	messageBox(debugStr, getSkinName() +" :Debug Message", 0, "");
}
#endif

function addBkGround(string imageID, boolean tile);
function drawBkgrounds();
function string getBkEntryDetails(string objID, int tokennum);
function deleteBkground();

function ltrim(string strTextL);
function rtrim(string strTextR);
function trim(string strTextT);
function makeBGMenu();
function LoadFile();
function ProcessBGMenuResult(int a);

Global browser fselect;
Global Button select;
Global int gone;
Global Edit fileout;
Global string str_url;
Global Boolean b_path=0;

Global int numBkGround;
							
//class layer bkgroundIcon;
//global bkgroundIcon currImage;

Global group bkgroundGroupParent, bkgroundGroup;
Global button bkgroundAdd, bkgroundDelete;

Global container addQueryContainer, subConfirmContainer;
Global layout addQueryLayout, subConfirmLayout;
Global layer subPrev;
Global edit addPath;
Global button addButton, subYesButton;
Global checkbox addTile;
Global layer currImage;
Global String bkgroundUser;
global popupmenu bgMenu;


System.onScriptLoaded() {
	initAttribs();

	group xui = getScriptGroup();

	fselect = xui.getObject("filebrowse");
	fileout = xui.getObject("filename");
	select = xui.getObject("select");

	str_url = getParam();
	
	gone = 1;

	bkgroundAdd = xui.findObject("cyclelcdgrid");
	currImage = xui.findObject("userbg");

	#ifdef DEBUG
		debug(bkgroundUser);
	#endif

	bkgroundUser = getPrivateString(getSkinName(),"user bkgrounds","");

	addBkGround(bkgroundUser, 0);
	makeBGMenu();
}

System.onScriptUnLoading() {
	select = NULL;
	fselect = NULL;
	fileout = NULL;
}

/*
System.onSetXUIParam(string param, string value) {
	if (strlower(Param) == "getonlypath") {	
		if (value == "1") b_path=1;
		
	}

}
*/


makeBGMenu()
{
	bgMenu = new popupmenu;
	
	bgMenu.addCommand("LCD Backgrounds", -1, 0, 1);
	bgMenu.addSeparator();

	bgMenu.addCommand("Matrix", 1, myattr_bg.getData() == "1", 0);
	bgMenu.addCommand("Earth", 2, myattr_bg.getData() == "2", 0);
	bgMenu.addCommand("Glow", 3, myattr_bg.getData() == "3", 0);
	bgMenu.addCommand("Lines", 4, myattr_bg.getData() == "4", 0);
	bgMenu.addCommand("Storey", 5, myattr_bg.getData() == "5", 0);
	bgMenu.addCommand("Smoke", 6, myattr_bg.getData() == "6", 0);
	bgMenu.addCommand("Tubes", 7, myattr_bg.getData() == "7", 0);
	bgMenu.addCommand("Bars", 8, myattr_bg.getData() == "8", 0);
	bgMenu.addCommand("User", 9, myattr_bg.getData() == "9", 0);



}

ProcessBGMenuResult(int iCheck) {
  if(iCheck < 1) return;

	//stock backgrounds
	if(iCheck > 0 && iCheck < 10) 
	{
 		myattr_bg.setData(integerToString(iCheck));
	
	}
}

LoadFile()
{
	if (isObjectValid(addQueryContainer)) { // if open, dont reopen
		layout addLayout = addQueryContainer.enumLayout(0);
		addLayout.setFocus();
		addLayout.center();
		return;
	}
	addQueryContainer = newDynamicContainer("config.addbkground");
	
	if (addQueryContainer) {
		addQueryContainer.show();
		addQueryLayout = addQueryContainer.getLayout("normal");
		addQueryLayout.center();
		addPath = addQueryLayout.findObject("filename");
		addButton = addQueryLayout.findObject("add");
		addTile = addQueryLayout.findObject("tile");
		addTile.setChecked(1);
	}

}

myattr_bg.onDataChanged()
{

	int iBG = stringtointeger(getData());
	string sBG = integertostring(iBG);
	//stock backgrounds
	if(iBG > 0 && iBG < 9) 
	{
		addBkGround("player.bg.bg" + sBG, 0);
	
	}

	//user background
	if(iBG == 9) 
	{
 		
		LoadFile();
	
	}

}


bkgroundAdd.onRightButtonDown(int x, int y) {
	makeBGMenu();

	int iCatchBGMenu = bgMenu.popAtMouse();
	ProcessBGMenuResult(iCatchBGMenu);

	
}

bkgroundAdd.onRightButtonUp(int x, int y) {
	delete bgMenu;
	complete;
}


ltrim(string strTextL) { 
	// this will get rid of leading spaces
	int i = strlen(strTextL);

	for(int x=0;x<=i;x++){
		if (strLeft(strTextL, 1) == " ")
		{
			strTextL = strRight(strTextL,strLen(strTextL)-1);
			//debug(strTextL);
		}
	}
	return strTextL;
}


rtrim(string strTextR)
{
	// this will get rid of trailing spaces 
	int j = strlen(strTextR);

	for(int y=0;y<=j;y++){

		if (strRight(strTextR, 1) == " ")
		{				
			strTextR = strLeft(strTextR,strLen(strTextR)-1);
			//debug(">" + strTextR + "<");			
		}	
	}
	return strTextR;
}


trim(string strTextT) 
{ 
	// this will get rid of leading/trailing spaces
	// funny conversion error on multiple function calls, hacky workaround
	string sCheckString = ltrim(strTextT);

	string sReturnString = rtrim(sCheckString);

	
	return sReturnString;

} 


addButton.onLeftClick() {
	map filecheck;
	filecheck = new map;

	string sCheckedPath = trim(addPath.getText());

	filecheck.loadMap(sCheckedPath);

	#ifdef DEBUG
		debug("length=" + integertostring(strlen(sCheckedPath)));
	#endif

	if (filecheck.getWidth() > 0) {
	  //-1 if found
	  if(strsearch(sCheckedPath, ".jpg") >= 0 || strsearch(sCheckedPath, ".png") >= 0)
	  {
		addBkGround(sCheckedPath, addTile.isChecked());
		addQueryContainer.close();
		addQueryContainer = NULL;
	  }
  	  else 
	  {
		text label = addQueryLayout.findObject("label");
		label.setText("ERROR: Cannot load image. Re-enter image path:");
	  }
	}

	delete filecheck;

}

addPath.onEnter() {
	addButton.onLeftClick();
}


subYesButton.onLeftClick() {
	deleteBkground();
	subConfirmContainer.close();
	subConfirmContainer = NULL;
}


deleteBkground(){
	currImage.setXMLParam("image", "");
}


addBkGround(string imageID, boolean tile) {

  if(strlen(imageID)>0)
  {

	bkgroundUser = imageID;

	setPrivateString(getSkinName(),"user bkgrounds",bkgroundUser);

	//fixes guru error if not found yet
	if(currImage)
	{
		currImage.setXMLParam("image", imageID);
	}

//	currImage.setXMLParam("x", "195");
//	currImage.setXMLParam("y", "32");
//	currImage.setXMLParam("w", "200");
//	currImage.setXMLParam("h", "53");
//	currImage.setXMLParam("move", "0");
	

  }
	
}


select.onLeftClick() { fselect.navigateUrl(str_url); }

fselect.onDocumentComplete(String url) {
	if(gone == 1) {
		int flocpos = strsearch(url, "?add={__");

		if(flocpos != -1) {
			int starting = (flocpos + strlen("?add={__"));
			int length = (strlen(url) - (flocpos + strlen("?add={__")));
			String floc = strmid(url, starting, length);
			for ( int i = 0; i < 666; i++ ) {	
				if (strsearch(floc, "%20") != -1) {
					floc = replaceString(floc, "%20", " ");
					i = 0;
				} else i = 666;
			}
			if (b_path) floc = getPath(floc);
			fileout.setText(floc);
			fselect.navigateUrl("about:blank");
		}
	}
}

/* browse about:blank to prevent autoopen box on browser set visible */

fselect.onSetVisible(int v) {
	if (!v) {
		fselect.navigateUrl("about:blank");
	}
}
