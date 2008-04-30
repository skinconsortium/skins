/*********************************************************************

	QuickSongPick test
	by leechbite

*********************************************************************/

#include "../../../lib/std.mi"

// **** global variables *****

function temptext(string t);

global Container maincont;
global Layout mainnormal;

class button MemoryButtons;

global MemoryButtons Mem1, Mem2, Mem3, Mem4, Mem5;

global timer buttondelay;
global boolean buttondown=0, songrecorded=0;
global string ButtonID;

global text songticker;
global timer temptextdelay;

System.onScriptLoaded() {
  maincont = getContainer("main");
  mainnormal = maincont.getLayout("normal");

  Mem1 = mainnormal.findObject("Mem1");
  Mem2 = mainnormal.findObject("Mem2");
  Mem3 = mainnormal.findObject("Mem3");
  Mem4 = mainnormal.findObject("Mem4");
  Mem5 = mainnormal.findObject("Mem5");

  songticker = mainnormal.findObject("songticker");

  temptextdelay = new Timer;
  temptextdelay.setDelay(1000);

  buttondelay = new Timer;
  buttondelay.setDelay(2000);
}

system.onScriptUnloading() {
  delete buttondelay;
  delete temptextdelay;
}

MemoryButtons.onLeftButtonDown(int x, int y) {
  buttonDown = 1;
  songrecorded = 0;

  buttonID = getID();
  buttondelay.start();
}

MemoryButtons.onLeftButtonUp(int x, int y) {
  buttonDown = 0;
  buttondelay.stop();

  if (songrecorded) return;

  string filename = getPrivateString(getSkinName(), buttonID, "");
  if (filename!="") {

    playfile(filename);

    tempText("Play file: "+filename);
  }
}

buttondelay.onTimer() {
  stop();

  if (buttonDown) {
    string filename = getPlayItemMetaDataString("Filename");

    if (filename!="") {

      setPrivateString(getSkinName(), buttonID, filename);
  
      tempText("Song recorded: "+buttonID);
    }

    songrecorded = 1;
  }


}

tempText(string t) {
  songticker.setText(t);
  temptextdelay.start();
}

temptextdelay.onTimer() {
  stop();
  songticker.setText("");
}


