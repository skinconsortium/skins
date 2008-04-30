                        /*
+-----------------------------------------------+
|draw_r.m                                       |
+-----------------------------------------------+
|Made by: hammerhead and Rohan Prabhu           |
|Application: Controls right drawer(made by     |
|             hammerhead) and advanced lightning|
|             setup(made by Rohan Prabhu)       |
|Copyrights/License: Use freely                 |
+-----------------------------------------------+
                       */

#include "../../../lib/std.mi"
#include "attribs.m"

#define DRAWER_STATUS System.getPrivateInt("vortex", "rdraw", 0)
#define SET_DRAW_CLOSED System.setPrivateInt("vortex", "rdraw", 0)
#define SET_DRAW_OPEN System.setPrivateInt("vortex", "rdraw", 1)

Global Int BEAT_MODE;

Global Group Grp;
Global layer light;
Global timer pulseback;

Function Int getBeatLevel(int mode);
Function Int getBass();
Function Int getTreble();

int getBeatLevel(int mode) {
	if(mode == 1) {
		int out = ( System.getRightVuMeter() + System.getLeftVuMeter() ) / 2;
		return out;   //Terminate subroutine on 'out' computation to save resources
	} else if(mode == 2) {
		int out = getBass();
		return out;   //Terminate subroutine on 'out' computation to save resources
	} else if(mode == 3) {
		int out = getTreble();
		return out;   //Terminate subroutine on 'out' computation to save resources
	} else if(mode == 4) {
		int out = 0;
		if( ((System.getRightVuMeter() + System.getLeftVuMeter())/2) > 128) {
			out = 255;
		} else {
			out = 0;
		}
		return out;
	}
}

System.OnScriptLoaded ()
{
	initAttribs();
	layout main=getContainer("main").getLayout("normal");

	Grp = getScriptGroup();

	light=main.getObject("lights");

	if(DRAWER_STATUS == 1) {
		Grp.onLeftButtonUp(NULL, NULL);
	}

	pulseback = new Timer;
	pulseback.setDelay(0.1);

	lightmode_attrib.onDataCHanged();


	/*light.setAlpha(stringtoInteger(lightval_attrib.getData()));*/
}

Grp.OnLeftButtonUp (int x, int y)
{
	if (Grp.GetLeft() < 408)
	{
		Grp.SetTargetX(409);
		Grp.SetTargetSpeed(0.5);
		Grp.GotoTarget();
		SET_DRAW_OPEN;
	}
	else
	{
		Grp.SetTargetX(350);
		Grp.SetTargetSpeed(0.5);
		Grp.GotoTarget();
		SET_DRAW_CLOSED;
	}
}

/*light_attrib.onDataChanged() {
	if(getData() == "0") {
		light.cancelTarget();
		light.setTargetA(0);
		light.setTargetSpeed(1);
		light.gotoTarget();
	} else if(getData() == "1") {
		light.cancelTarget();
		light.show();
		light.setAlpha(stringtoInteger(lightval_attrib.getData()));
	}
}*/

light.onTargetReached() {
	light.hide();
}

lightval_attrib.onDataChanged() {
	if(BEAT_MODE == 5) {
		light.setAlpha(stringtoInteger(getData()));
	}
}

Int getBass() {
	int bass;
	for (int i = 0; i < 5; i++) {
		bass += System.getVisBand(0, i);
	}
	bass=bass/5;
	return bass;
}

Int getTreble() {
	int treble;
	for (int i = 0; i < 6; i++) {
		treble += System.getVisBand(0, 75 - i * 2);
	}
	treble /= 5;
	return treble;
}

pulseback.onTimer() {
	if(BEAT_MODE == 5) {
		light.setAlpha(stringToInteger(lightval_attrib.getData()));
		pulseback.stop();
	} else if(BEAT_MODE == 6) {		
		light.setAlpha(0);
		pulseback.stop();
	} else {
		light.setAlpha(getBeatLevel(BEAT_MODE));
	}
}

System.onPlay() {
	pulseback.start();
}

System.onStop() {
	pulseback.stop();
}

System.onPause() {
	pulseback.stop();
}

System.onResume() {
	pulseback.start();
}

lightmode_attrib.onDataChanged() {
	if (getData() == "*Off") {
		BEAT_MODE = 6;
			pulseback.start();
	} else if (getData() == "*User") {
		BEAT_MODE = 5;
			pulseback.start();
	} else if (getData() == "Volume") {
		BEAT_MODE = 1;
		if(System.getStatus() == 1) {
			pulseback.start();
		}
	} else if (getData() == "Bass") {
		BEAT_MODE = 2;
		if(System.getStatus() == 1) {
			pulseback.start();
		}
	} else if (getData() == "Treble") {
		BEAT_MODE = 3;
		if(System.getStatus() == 1) {
			pulseback.start();
		}
	} else if (getData() == "Blink") {
		BEAT_MODE = 4;
		if(System.getStatus() == 1) {
			pulseback.start();
		}
	}
}