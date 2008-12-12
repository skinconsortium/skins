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
}

System.onScriptUnloading() {
	return;
}


