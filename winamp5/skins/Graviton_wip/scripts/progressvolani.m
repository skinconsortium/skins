#include <lib/std.mi>
#include <lib/config.mi>
#include "defines.m"

//SLoB added songticker back in for vol & seek

Global Layout lMain, lShade;
Global Animatedlayer progress, volume, progresskey, volumekey;
Global Layer shadevolume;
Global Map progressmap, volumemap, shadevolumemap;
Global Timer progresstimer;
Global Boolean progresschange, volumechange;
Global Text MainSongticker, ShadeSongticker;
Global Slider ShadeSeeker;
Global Int StickSeeking;
Global Togglebutton btnRepeat, btnShuffle, btnXFade;

Function setprogressani(int pos);
Function reloadprogress(int x, int y);

Function setvolumeani(int vol);
Function reloadvolume(int x, int y);

Function setshadevolume(int vol);
Function reloadshadevolume(int x, int y);

system.onScriptLoaded() {	
	lMain = getContainer("main").getLayout("normal");
	lShade = getContainer("main").getLayout("winshade");

	progress = lMain.findObject("progress.ani");
	volume = lMain.findObject("volume.ani");

	progresskey = lMain.findObject("progress.key.ani");
	volumekey = lMain.findObject("volume.key.ani");

	shadevolume = lShade.findObject("volume");

	MainSongticker = lMain.findObject("songticker");
	ShadeSongticker = lShade.findObject("ticker");
	ShadeSeeker = lShade.findObject("SeekerGhost");

	btnRepeat = lMain.findObject("Repeat");
	btnShuffle = lMain.findObject("Shuffle");
	btnXFade = lMain.findObject("Crossfade");


	progressmap = new map;
	progressmap.loadMap("main.slider.progress.map");

	volumemap = new map;
	volumemap.loadMap("main.slider.volume.map");

	shadevolumemap = new map;
	shadevolumemap.loadMap("winshade.slider.volume.map");

	progresstimer = new Timer;
	progresstimer.setDelay(1000);

	setvolumeani(System.getVolume());
	setshadevolume(System.getVolume());

	if(getStatus() != 0) {
		progresstimer.start();
		setprogressani(255 * System.getPosition() / System.getPlayItemLength());
	} else {
		setprogressani(0);
	}
}

System.onScriptUnloading() {
	delete progresstimer;
	delete progressmap;
	delete volumemap;
	delete shadevolumemap;
}

System.onPlay() {
	progresstimer.start();
}

System.onStop() {
	progresstimer.start();
	setprogressani(0);
}

progresstimer.onTimer() {
	setprogressani(255 * System.getPosition() / System.getPlayItemLength());
}

setprogressani(int pos) {
	int f = (pos * (progress.getLength()-1)) / 255;
    if (pos > 0) {
	progress.gotoFrame(f+1);
	progresskey.gotoFrame(f+1);
	}
    if (pos == 255) {
	progress.gotoFrame(f);
	progresskey.gotoFrame(f);
    }
    if (pos == 0) {
	progress.gotoFrame(0);
	progresskey.gotoFrame(0);
    }

}

progress.onLeftButtonDown(int x, int y) {
	progresstimer.stop();
	progresschange = 1;
	reloadprogress(x, y);
}

progress.onLeftButtonUp(int x, int y) {
	progresstimer.start();
	if (progresschange) {
		progresschange = 0;
		reloadprogress(x, y);
	}
}

progress.onMouseMove(int x, int y) {
	if (progresschange) {
		reloadprogress(x, y);
	}
}



ShadeSeeker.onSetPosition(int p) {
	if (StickSeeking) {
		Float f;
		f = p;
		f = f / 255 * 100;
		Float len = getPlayItemLength();
		if (len != 0) {
			int np = len * f / 100;
			ShadeSongticker.setAlternateText(integerToTime(np) + "/" + integerToTime(len) + " " + integerToString(f) + "% ");
			
		}
	}
}


ShadeSeeker.onLeftButtonDown(int x, int y) {
	StickSeeking = 1;
}

ShadeSeeker.onLeftButtonUp(int x, int y) {
	StickSeeking = 0;
	ShadeSongticker.setAlternateText("");
}

ShadeSeeker.onSetFinalPosition(int p) {
	ShadeSongticker.setAlternateText("");
}





reloadprogress(int x, int y) {
	int newValue = progressmap.getValue(x - progress.getLeft(), y - progress.getTop());
	if (System.getPlayItemLength() >= 0) {
		int p = (newValue * 100) / 255;
		int s = (newValue * System.getPlayItemLength()) / 255;

		if(MainSongticker.isVisible())
		{
			MainSongticker.setAlternateText(System.integerToTime(s) + "/" + System.integerToTime(System.getPlayItemLength()) + " " + System.integerToString(p) + "%");
		}
		if(ShadeSongticker.isVisible())
		{
			ShadeSongticker.setAlternateText(System.integerToTime(s) + "/" + System.integerToTime(System.getPlayItemLength()) + " " + System.integerToString(p) + "%");
		}

		if (!progresschange) {
			System.seekTo(s);
		}
		setprogressani(255 * s / System.getPlayItemLength());
	}
}

System.onVolumeChanged(int newVol) {
	setvolumeani(newVol);
	setshadevolume(newVol);
	int p = (newVol * 100) / 255;
	
	if(MainSongticker.isVisible())
	{
		MainSongticker.setAlternateText("Vol:" + System.integerToString(p) + "%");
	}
	if(ShadeSongticker.isVisible())
	{
		ShadeSongticker.setAlternateText("Vol:" + System.integerToString(p) + "%");
	}
}

setvolumeani(int vol) {
	int f = (vol * (volume.getLength()-1)) / 255;
    if (vol > 0) {
		volume.gotoFrame(f+1);
		volumekey.gotoFrame(f+1);
	}
	if (vol == 255) {
		volume.gotoFrame(f);
		volumekey.gotoFrame(f);
	}
	if (vol == 0) {
		volume.gotoFrame(0);
		volumekey.gotoFrame(0);
	}
}

setshadevolume(int vol) {
	Region r = new Region;
	r.loadFromMap(shadevolumemap, vol, 1);
	shadevolume.setRegion(r);
	delete r;
}


volume.onLeftButtonDown(int x, int y) {
	volumechange = 1;
	reloadvolume(x, y);
}

volume.onLeftButtonUp(int x, int y) {
	if (volumechange) {
		volumechange = 0;
		reloadvolume(x, y);
	}
}

volume.onMouseMove(int x, int y) {
	if (volumechange) {
		reloadvolume(x, y);
	}
}

shadevolume.onLeftButtonDown(int x, int y) {
	volumechange = 1;
	reloadshadevolume(x, y);
}

shadevolume.onLeftButtonUp(int x, int y) {
	if (volumechange) {
		volumechange = 0;
		reloadshadevolume(x, y);
	}
}

shadevolume.onMouseMove(int x, int y) {
	if (volumechange) {
		reloadshadevolume(x, y);
	}
}

reloadvolume(int x, int y) {
	int newValue = volumemap.getValue(x - volume.getLeft(), y - volume.getTop());
	System.setVolume(newValue);
}

reloadshadevolume(int x, int y) {
	int newValue = shadevolumemap.getValue(x - shadevolume.getLeft(), y - shadevolume.getTop());
	System.setVolume(newValue);
}



btnRepeat.onEnterArea() {
	if(MainSongticker.isVisible())
	{
		MainSongticker.setAlternateText("Repeat");
	}	
}


btnRepeat.onRightButtonDown(int x, int y) {

	configItem item = Config.getItem("Playlist editor");
  	configAttribute attrRepeat = item.getAttribute("repeat");

  	popUpMenu repeatmenu = new popUpMenu;

  	int x;
  	Int iRepeatmode = stringtointeger(btnRepeat.getXmlParam("cfgval")); //getCurCfgVal() still doesnt exist? wtf? 

  	repeatmenu.addCommand("Repeat", -1, 0, 1);
  	repeatmenu.addSeparator();
  	repeatmenu.addCommand("Repeat Off", 0, (iRepeatmode == 0), 0);
  	repeatmenu.addCommand("Repeat All", 1, (iRepeatmode == 1), 0);
  	repeatmenu.addCommand("Repeat Track", 2, (iRepeatmode == -1), 0);

  	int iRep = repeatmenu.popAtMouse();
  
	delete repeatmenu;

	complete;

	if(MainSongticker.isVisible())
	{
		if (iRep == 0)
		{
			MainSongticker.setAlternateText("Repeat Off");
		}
		else if(iRep == 1)
		{
			MainSongticker.setAlternateText("Repeat All");
		}
		else if(iRep == 2)
		{
			MainSongticker.setAlternateText("Repeat Track");
		}

	}	

  	if (iRep < 0) return;
  	if (iRep == 2) iRep = -1;

  	
  	attrRepeat.setData(integerToString(iRep));

  	btnRepeat.onToggle(iRep!=0);
}


btnShuffle.onEnterArea() {
	if(MainSongticker.isVisible())
	{
		MainSongticker.setAlternateText("Shuffle");
	}
	
}


btnXFade.onEnterArea() {
	if(MainSongticker.isVisible())
	{
		MainSongticker.setAlternateText("CrossFade");
	}
	
}

