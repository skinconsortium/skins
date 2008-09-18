#include <lib/std.mi>
#include <lib/cprowidget.mi>
#include <lib/pldir.mi>
#include <lib/fileio.mi>
#include <lib/application.mi>
#include "convert_address.mi"

Function refreshStuff();
Function addProvider(list paramname, list paramvalue);
Function String replaceString(string baseString, string toreplace, string replacedby);
Function int searchInListForItem(String input);
Function selectSaved();
Function surfSelected();
Function initLoadFiles();


Global Layout mainLayout;

Global Group myGroup;
Global GuiList myList;
Global XmlDoc myDoc;
Global List loaded_P_Names, loaded_P_Url;
Global int sourceNo;
Global boolean onetime;
Global Text statusInfo;
Global ToggleButton enabledSwitch;
Global Button menuOptions;
Global PopUpMenu popMenu;
Global GuiObject browserXUI;

System.onScriptLoaded(){
	setPublicInt("ClassicPro.BrowserPro.loaded", 1);
	initWidget();
	
	mainLayout = getContainer("main").getLayout("normal");
	browserXUI = mainLayout.findObject("cpro.browser");
	myGroup = getScriptGroup();
	myList = myGroup.findObject("bp.servicelist");
	statusInfo = myGroup.findObject("bp.statusbar");
	enabledSwitch = myGroup.findObject("bp.onoff");
	menuOptions = myGroup.findObject("bp.options");
	

	myList.setIconWidth(16);
	myList.setShowIcons(1);
	sourceNo=0;
	enabledSwitch.setActivated(getPublicInt("ClassicPro.BrowserPro.enabled", 0));
}

System.onShowLayout(Layout _layout){
	mainLayout = getContainer("main").getLayout("normal");
	browserXUI = mainLayout.findObject("cpro.browser");
	if(mainLayout==_layout){
		if(getPublicInt("cPro.lastComponentPage", 0)==3 && getPublicInt("ClassicPro.BrowserPro.enabled", 0)){
			initLoadFiles();
			surfSelected();
		}
		/*else if(getPublicInt("ClassicPro.BrowserPro.opentab", 1) && getPublicInt("ClassicPro.BrowserPro.enabled", 0)){
			initLoadFiles();
			surfSelected();
		}*/
	}
}

System.onScriptUnloading (){
	setPublicInt("ClassicPro.BrowserPro.loaded", 0);
	myGroup.hide();
	delete loaded_P_Names;
	delete loaded_P_Url;
}

enabledSwitch.onToggle(boolean onOff){
	setPublicInt("ClassicPro.BrowserPro.enabled", onOff);
	if(onOff && (browserXUI.isVisible() || getPublicInt("ClassicPro.BrowserPro.opentab", 0))) surfSelected();
}

browserXUI.onSetVisible(boolean onOff){
	if(onOff && getPublicInt("ClassicPro.BrowserPro.enabled", 0)){
		surfSelected();
	}
}

myGroup.onSetVisible(boolean onOff){
	if(onOff && !onetime){
		initLoadFiles();
	}
}

initLoadFiles(){
	if(!onetime){
		loaded_P_Names = new List;
		loaded_P_Url = new List;
		myDoc = new XmlDoc;
		
		String temp = Application.GetApplicationPath()+"\Plugins\classicPro\engine\widgets\Data\BrowserPro\source.xml";
		myDoc.load (temp);

		myDoc.parser_addCallback("WasabiXML/BrowserPro/*");
		myDoc.parser_start();
		myDoc.parser_destroy();
		delete myDoc;
		
		//myList.setAutoSort(1);
		//myList.setXmlParam("sort", "1");
		selectSaved();

		onetime=true;
	}
}

addProvider(list paramname, list paramvalue){
	myList.addItem("Read error");
	for(int i=0; i<paramname.getNumItems(); i++){
		if(strlower(paramname.enumItem(i))=="name"){
			myList.setItemLabel(sourceNo, paramvalue.enumItem(i));
		}
		else if(strlower(paramname.enumItem(i))=="comment"){
			myList.setSubItem(sourceNo, 1, paramvalue.enumItem(i));
		}
		else if(strlower(paramname.enumItem(i))=="url"){
			loaded_P_Url.addItem(paramvalue.enumItem(i));
		}
		else if(strlower(paramname.enumItem(i))=="icon"){
			myList.setItemIcon(sourceNo, paramvalue.enumItem(i));
		}		
	}
	loaded_P_Names.addItem(myList.getItemLabel(sourceNo, 0));
	sourceNo++;
}

myDoc.parser_onCallback (String xmlpath, String xmltag, list paramname, list paramvalue){
	if(strlower(xmltag) == "sourceitem"){
		addProvider(paramname, paramvalue);
	}
}

myList.onDoubleClick(Int itemnum){
	String myUrl = loaded_P_Url.enumItem(loaded_P_Names.findItem(myList.getItemLabel(itemnum, 0)));
	gotoBrowserUrl(prepareCustomUrl(myUrl));
}

myList.onLeftClick(Int itemnum){
	setPublicString("ClassicPro.BrowserPro", myList.getItemLabel(itemnum, 0));

	String myUrl = loaded_P_Url.enumItem(loaded_P_Names.findItem(myList.getItemLabel(itemnum, 0)));
	setPublicString("ClassicPro.BrowserPro.lastselected", myUrl);
}
myList.onColumnLabelClick(Int col, Int x, Int y){
	selectSaved();
}
myList.onItemSelection(Int itemnum, Int selected){
	if(selected){
		statusInfo.setText("Selected auto search: " + myList.getItemLabel(itemnum, 0));
	}
}

String replaceString(string baseString, string toreplace, string replacedby) {
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

searchInListForItem(String input){
	for(int i=0; i<myList.getNumItems();i++){
		if(input == myList.getItemLabel(i, 0)) return i;
	}
	return 0; //if nothing was found
}

selectSaved(){
	int i = searchInListForItem(getPublicString("ClassicPro.BrowserPro", "0"));
	myList.setSelected(i,1);
}

surfSelected(){
	if(getContainer("main").getCurLayout() != mainLayout) return;

	cpro_sui = getContainer("main").getLayout("normal").findObject("cpro.sui");
	String myUrl = loaded_P_Url.enumItem(loaded_P_Names.findItem(getPublicString("ClassicPro.BrowserPro", "0")));
	gotoBrowserUrl(prepareCustomUrl(myUrl));
	
	
	//testing download
	//System.downloadMedia("", "C:/", false, false);
}

System.onTitleChange(String newtitle){
	initLoadFiles();
	if(getPublicInt("ClassicPro.BrowserPro.enabled", 0)){
		if(getPublicInt("ClassicPro.BrowserPro.opentab", 0)){
			surfSelected();
		}
		else if(getPublicInt("cPro.lastComponentPage", 0)==3){
			surfSelected();
		}
	}
}

menuOptions.onLeftClick(){
	popMenu = new PopUpMenu;
	popMenu.addCommand("Open browser if it's closed", 1, getPublicInt("ClassicPro.BrowserPro.opentab", 0), 0);

	int result = popMenu.popAtXY(clientToScreenX(menuOptions.getLeft()), clientToScreenY(menuOptions.getTop() + menuOptions.getHeight()));

	if(result==1){
		setPublicInt("ClassicPro.BrowserPro.opentab", !getPublicInt("ClassicPro.BrowserPro.opentab", 0));
	}

	delete popMenu;
	complete;


}