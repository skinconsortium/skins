#include <lib/std.mi>
Global Boolean showMessageBox;
Global Timer myTimer;
Function int getCproVersion();

System.onScriptLoaded() {
	String cpro_path = getParam() + "\..\..\Plugins\classicPro";

	map m = new map;
	m.loadMap(cpro_path + "\\engine\\image\\installed.png");

	if(m.getWidth()!=1){
		showMessageBox=true;
		delete m;
		System.switchSkin("winamp classic");	// just switch away from our current skin
	}
	else{
		if(getCproVersion()<199){
			myTimer = new Timer;
			myTimer.setDelay(5000);
			myTimer.start();
		}
	}
}

System.onScriptUnloading ()
{
	if(showMessageBox){
		//yes_no msgbox has id=4
		int input= System.messageBox("For this skin to work, you'll need to install the ClassicPro Winamp plugin.\n\nDo you want to download it now?", "Can't find ClassicPro!", 4, "");
		
		if(input==4){
			System.navigateUrl("http://cpro.skinconsortium.com/");	// the direct subdir is .com/classicpro
		}
		System.switchSkin("classic");	// ensure this name is different from above
	}
}

System.onGetCancelComponent(String guid, boolean goingvisible){
	if(showMessageBox){
		return true;
	}
}

int getCproVersion(){
	map m = new map;
	String cpro_path = getParam() + "\..\..\Plugins\classicPro";
	m.loadMap(cpro_path + "\\engine\\image\\version.png");
	
	int output = (m.getWidth()-1)+(m.getHeight()-1)*100;
	if(output==6363) output=100;
	delete m;
	return output;
}

myTimer.onTimer(){
	myTimer.stop();
	int input= System.messageBox("This ClassicPro skin was designed for a newer ClassicPro version.\n\nDo you want to update your plugin now?", "Please update ClassicPro!", 4, "");
	if(input==4){
		System.navigateUrl("http://cpro.skinconsortium.com/");
	}
}