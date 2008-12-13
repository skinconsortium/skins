/*************************************************************

  shufflerepeat.m
  by Leechbite

  Controls the shufflerepeat text.

*************************************************************/


#define ENABLE_TEMPTEXT

#include <lib/std.mi>
#include <lib/config.mi>

Global group scriptGroup;

Global text shuffleInd, repeatInd;
Global ConfigAttribute attrRepeat, attrShuffle;

System.onScriptLoaded() {
	scriptGroup = getScriptGroup();
	
	configItem item = Config.getItem("Playlist editor");
	attrRepeat = item.getAttribute("repeat");
	attrShuffle = item.getAttribute("shuffle");
	
	shuffleInd = scriptGroup.getObject("shuffle.text.ind");
	repeatInd = scriptGroup.getObject("repeat.text.ind");
	
	attrRepeat.onDataChanged();
	attrShuffle.onDataChanged();
}

System.onScriptUnloading() {
	return;
}

attrRepeat.onDataChanged() {
	if (getData()=="1")
		repeatInd.setText("ALL");
	else if (getData()=="-1")
		repeatInd.setText("TRACK");
	else
		repeatInd.setText("OFF");
}

attrShuffle.onDataChanged() {
	if (getData()=="1")
		shuffleInd.setText("ON");
	else
		shuffleInd.setText("OFF");
}

