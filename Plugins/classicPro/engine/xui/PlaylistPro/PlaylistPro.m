/*
PlaylistPro build 001
by pjn123 (www.skinconsortium.com)
*/

#include <lib/std.mi>
#include <lib/pldir.mi>
Function resizeResults(int items);
Function doSearch(String input);
Function setSearchBox(boolean onOff);
Function clearSearchBox();

Global Group frameGroup, topbar;
Global Edit searchBox;
Global Text clearButtonText, helpSearch;
Global GuiObject fakeSB, searchXUI;
Global Button searchButton, clearButton;
Global GuiList searchResults;
Global Boolean foundsomething;
Global int tn;
Global String temptoken;
Global Windowholder plwh;

Global Container results_container;
Global Layout results_layout, main_layout;

System.onScriptLoaded() {
	frameGroup = getScriptGroup();
	topbar = frameGroup.findObject("PlaylistPro.topbar");
	plwh = frameGroup.findObject("PlaylistPro.wdh");
	
	searchBox = frameGroup.findObject("wasabi.edit.box");
	searchXUI = frameGroup.findObject("pl.search.edit");
	searchButton = frameGroup.findObject("pl.search.go");
	fakeSB = frameGroup.findObject("pl.search.edit.rect");
	clearButton = frameGroup.findObject("pl.search.edit.clear");
	clearButtonText = frameGroup.findObject("pl.search.edit.clear.text");
	helpSearch = frameGroup.findObject("pl.search.edit.searchhelp");
	
	results_container = newDynamicContainer("searchresults");
	results_layout = results_container.getLayout("normal");
	searchResults = results_layout.findObject("combobox.list");
	searchResults.setXmlParam("antialias", "0");
	
	main_layout = getContainer("main").getLayout("normal");
	
}

/*main_layout.onSetVisible(boolean onOff){
	if(onOff) results_layout.resize(fakeSB.clientToScreenX(fakeSB.getLeft()), fakeSB.clientToScreenY(fakeSB.getTop() + fakeSB.getHeight()),fakeSB.getWidth(),400);
}*/

frameGroup.onSetVisible(boolean onOff){
	if(!onOff) clearSearchBox();
}

searchButton.onLeftClick(){
	doSearch(searchBox.getText());
}

resizeResults(int items){
	results_layout.setTargetX(results_layout.getLeft());
	results_layout.setTargetY(results_layout.getTop());
	results_layout.setTargetW(results_layout.getWidth());
	results_layout.setTargetH(500);
	results_layout.setTargetSpeed(1);
	results_layout.gotoTarget();

	items++; //temp add one extra for info... xx items found
	if(items>20) items=20;
	
	//results_layout.setXmlParam("h", integerToString(20+items*18));

	results_layout.setTargetX(results_layout.getLeft());
	results_layout.setTargetY(results_layout.getTop());
	results_layout.setTargetW(results_layout.getWidth());
	results_layout.setTargetH(20+items*18);
	results_layout.setTargetSpeed(0.3);
	results_layout.gotoTarget();
}

searchBox.onEnter(){
	doSearch(searchBox.getText());
}

doSearch(String input){
	if(input==""){
		clearSearchBox();
		return; 
	}

	int itemsfound = 0;
	input = strlower(input);
	
	//if(!results_layout.isVisible()){
	//results_layout.resize(fakeSB.clientToScreenX(fakeSB.getLeft()), fakeSB.clientToScreenY(fakeSB.getTop() + fakeSB.getHeight()),fakeSB.getWidth(),1);

	results_layout.setXmlParam("x", integerToString(fakeSB.clientToScreenX(fakeSB.getLeft())));
	results_layout.setXmlParam("y", integerToString(fakeSB.clientToScreenY(fakeSB.getTop() + fakeSB.getHeight())));
	results_layout.setXmlParam("w", integerToString(fakeSB.getWidth()));
	
	if(!results_layout.isVisible()) results_layout.setXmlParam("h", "1");

	//}
	//else results_layout.hide();

	searchResults.deleteAllItems();
	
	for(int i = 0; i<PlEdit.getNumTracks(); i++){
		foundsomething=false;

		for(tn = 0; tn<10; tn++){
			if(getToken(input, " ", tn)==""){
				break;
			}
		
			temptoken = getToken(input, " ", tn);
			if(strsearch(strlower(PlEdit.getTitle(i)), temptoken)>=0){
				foundsomething=true;
			}
			else{
				foundsomething=false;
			}
			
			if(!foundsomething){
				break;
			}
		}
		
		if(foundsomething){
			itemsfound++;
			searchResults.addItem(integerToString(i+1)+". " + PlEdit.getTitle(i));
			if(itemsfound>500){
				searchResults.addItem("** SEARCH LIMITED TO 500 ITEMS **");
				break;
			}
		}

		
		/*if(strsearch(strlower(PlEdit.getTitle(i)), input)!=-1){
			itemsfound++;
			
			searchResults.addItem(integerToString(i+1)+". " + PlEdit.getTitle(i));
			//searchResults.setSubItem(searchResults.getLastAddedItemPos(), 1, integerToString(PlEdit.getLength (i)));
			
			//searchResults.addItem(integerToString(i));
			//searchResults.addItem("a");
			if(itemsfound>500){
				searchResults.addItem("** SEARCH LIMITED TO 500 ITEMS **");
				break;
			}
		}*/
	}

	if(itemsfound==0){
				searchResults.addItem("** Nothing found **");
	}
	else if(itemsfound<=500){
		if(itemsfound>1){
			searchResults.addItem("** Found "+integerToString(itemsfound)+" items **");
		}
		else{
			searchResults.addItem("** Found 1 item **");
		}
	}
	resizeResults(itemsfound);

	// Fix if always on top is enabled.. it just refresh the ontop ;)
	//results_layout.setXmlParam("ontop", "0");
	results_layout.setXmlParam("ontop", "1");

	results_layout.show();
}

searchResults.onDoubleClick(Int itemnum){
	PlEdit.showTrack(stringToInteger(getToken(searchResults.getItemLabel(itemnum,0), ". ", 0))-1);
	PlEdit.playTrack (stringToInteger(getToken(searchResults.getItemLabel(itemnum,0), ". ", 0))-1);
	results_layout.hide();
	setSearchBox(false);
}

setSearchBox(boolean onOff){
	if(onOff){
		//searchXUI.show();
		searchBox.show();
		clearButton.show();
		clearButtonText.show();
		helpSearch.hide();
		searchBox.setFocus();
	}
	else{
		searchBox.hide();
		clearButton.hide();
		clearButtonText.hide();
		helpSearch.show();
		//searchXUI.hide();
	}
}
fakeSB.onLeftButtonDown(int x, int y){
	setSearchBox(true);
}
clearSearchBox(){
	searchBox.setText("");
	setSearchBox(false);
	results_layout.hide();
}
searchXUI.onKillFocus(){
	//if(searchBox.getText()=="")
	setSearchBox(false);
}
results_layout.onKillFocus(){
	//if(searchBox.getText()=="")
	setSearchBox(false);
}

main_layout.onMove(){
	//results_layout.resize(fakeSB.clientToScreenX(fakeSB.getLeft()), fakeSB.clientToScreenY(fakeSB.getTop() + fakeSB.getHeight()),fakeSB.getWidth(),400);
	if(results_layout.isVisible()){
		results_layout.setXmlParam("x", integerToString(fakeSB.clientToScreenX(fakeSB.getLeft())));
		results_layout.setXmlParam("y", integerToString(fakeSB.clientToScreenY(fakeSB.getTop() + fakeSB.getHeight())));
		//results_layout.setXmlParam("ontop", "0");
		results_layout.setXmlParam("ontop", "1");
	}
}
main_layout.onResize(int x, int y, int w, int h){
	if(results_layout.isVisible()) clearSearchBox();
}

frameGroup.onResize(int x, int y, int w, int h){
	if(results_layout.isVisible()) clearSearchBox();
	
	if(h<100){
		topbar.hide();
		plwh.setXmlParam("y", "0");
		plwh.setXmlParam("h", "0");
	}
	else{
		topbar.show();
		plwh.setXmlParam("y", "24");
		plwh.setXmlParam("h", "-24");
	}
}

clearButton.onLeftClick(){
	clearSearchBox();
}