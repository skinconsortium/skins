#include "../../../lib/std.mi"

// Declare local functions for use in script
Function setEqAnim(int eqValue, Layer eqName);
Function updateEqBand(Layer eqName, int eqNum, int x, int y);

// Declare global variables for use in script
Global Layer eqpre, eq0, eq1, eq2, eq3, eq4, eq5, eq6, eq7, eq8, eq9;
Global Button reseteq;
Global Map eqMap;
Global Boolean eqChanging;

// When the script/skin is loaded, do this
System.onScriptLoaded() {
	Group eqLayout = getScriptGroup();

	//get Layers
	eqpre = eqLayout.findObject("eqpre");
	eq0 = eqLayout.findObject("eq1");
	eq1 = eqLayout.findObject("eq2");
	eq2 = eqLayout.findObject("eq3");
	eq3 = eqLayout.findObject("eq4");
	eq4 = eqLayout.findObject("eq5");
	eq5 = eqLayout.findObject("eq6");
	eq6 = eqLayout.findObject("eq7");
	eq7 = eqLayout.findObject("eq8");
	eq8 = eqLayout.findObject("eq9");
	eq9 = eqLayout.findObject("eq10");

	reseteq = eqLayout.findObject("reset");

	//initialize Map
	EQMap = new Map;
	EQMap.loadMap("eq.slider.eq.map");

	//initialize Band positions
	setEqAnim(128 - System.getEqPreamp(), eqpre);
	setEqAnim(128 - System.getEqBand(0), eq0);
	setEqAnim(128 - System.getEqBand(1), eq1);
	setEqAnim(128 - System.getEqBand(2), eq2);
	setEqAnim(128 - System.getEqBand(3), eq3);
	setEqAnim(128 - System.getEqBand(4), eq4);
	setEqAnim(128 - System.getEqBand(5), eq5);
	setEqAnim(128 - System.getEqBand(6), eq6);
	setEqAnim(128 - System.getEqBand(7), eq7);
	setEqAnim(128 - System.getEqBand(8), eq8);
	setEqAnim(128 - System.getEqBand(9), eq9);
}

reseteq.onleftbuttonup(int x, int y) {
	setEqPreamp(0);
	setEqBand(0, 0);
	setEqBand(1, 0);
	setEqBand(2, 0);
	setEqBand(3, 0);
	setEqBand(4, 0);
	setEqBand(5, 0);
	setEqBand(6, 0);
	setEqBand(7, 0);
	setEqBand(8, 0);
	setEqBand(9, 0);
}

System.onEqPreampChanged(int newValue) {
	setEqAnim(128 - newValue, eqpre);
}

System.onEqBandChanged(int band, int newValue) {
	if (band == 0) {
		setEqAnim(128 - newValue, eq0);
	} else if (band == 1) {
		setEqAnim(128 - newValue, eq1);
	} else if (band == 2) {
		setEqAnim(128 - newValue, eq2);
	} else if (band == 3) {
		setEqAnim(128 - newValue, eq3);
	} else if (band == 4) {
		setEqAnim(128 - newValue, eq4);
	} else if (band == 5) {
		setEqAnim(128 - newValue, eq5);
	} else if (band == 6) {
		setEqAnim(128 - newValue, eq6);
	} else if (band == 7) {
		setEqAnim(128 - newValue, eq7);
	} else if (band == 8) {
		setEqAnim(128 - newValue, eq8);
	} else if (band == 9) {
		setEqAnim(128 - newValue, eq9);
	}
}

eqpre.onLeftButtonDown(int x, int y) {
	updateEQBand(eqpre, 10, x, y);
	EqChanging = 1;
}

eqpre.onLeftButtonUp(int x, int y) {
	if (EQChanging) {
		EQChanging = 0;
	}
}

eqpre.onMouseMove(int x, int y) {
	if (EQChanging) {
		updateEQBand(eqpre, 10, x, y);
	}
}

// Sets Region to Display Partial Bar
setEqAnim(int eqValue, Layer eqName) {
	Region r = new Region;
	r.loadFromMap(EQMap, eqValue, 0);
	eqName.setRegion(r);
	delete r;
}

// Handles Band 0 Mouse Events
eq0.onLeftButtonDown(int x, int y) {
	updateEQBand(eq0, 0, x, y);
	EqChanging = 1;
}
eq0.onLeftButtonUp(int x, int y) {
	if (EQChanging) {
		EQChanging = 0;
	}
}
eq0.onMouseMove(int x, int y) {
	if (EQChanging) {
		updateEQBand(eq0, 0, x, y);
	}
}

// Handles Band 1 Mouse Events
eq1.onLeftButtonDown(int x, int y) {
	updateEQBand(eq1, 1, x, y);
	EqChanging = 1;
}
eq1.onLeftButtonUp(int x, int y) {
	if (EQChanging) {
		EQChanging = 0;
	}
}
eq1.onMouseMove(int x, int y) {
	if (EQChanging) {
		updateEQBand(eq1, 1, x, y);
	}
}

// Handles Band 2 Mouse Events
eq2.onLeftButtonDown(int x, int y) {
	updateEQBand(eq2, 2, x, y);
	EqChanging = 1;
}
eq2.onLeftButtonUp(int x, int y) {
	if (EQChanging) {
		EQChanging = 0;
	}
}
eq2.onMouseMove(int x, int y) {
	if (EQChanging) {
		updateEQBand(eq2, 2, x, y);
	}
}

// Handles Band 3 Mouse Events
eq3.onLeftButtonDown(int x, int y) {
	updateEQBand(eq3, 3, x, y);
	EqChanging = 1;
}
eq3.onLeftButtonUp(int x, int y) {
	if (EQChanging) {
		EQChanging = 0;
	}
}
eq3.onMouseMove(int x, int y) {
	if (EQChanging) {
		updateEQBand(eq3, 3, x, y);
	}
}

// Handles Band 4 Mouse Events
eq4.onLeftButtonDown(int x, int y) {
	updateEQBand(eq4, 4, x, y);
	EqChanging = 1;
}
eq4.onLeftButtonUp(int x, int y) {
	if (EQChanging) {
		EQChanging = 0;
	}
}
eq4.onMouseMove(int x, int y) {
	if (EQChanging) {
		updateEQBand(eq4, 4, x, y);
	}
}

// Handles Band 5 Mouse Events
eq5.onLeftButtonDown(int x, int y) {
	updateEQBand(eq5, 5, x, y);
	EqChanging = 1;
}
eq5.onLeftButtonUp(int x, int y) {
	if (EQChanging) {
		EQChanging = 0;
	}
}
eq5.onMouseMove(int x, int y) {
	if (EQChanging) {
		updateEQBand(eq5, 5, x, y);
	}
}

// Handles Band 6 Mouse Events
eq6.onLeftButtonDown(int x, int y) {
	updateEQBand(eq6, 6, x, y);
	EqChanging = 1;
}
eq6.onLeftButtonUp(int x, int y) {
	if (EQChanging) {
		EQChanging = 0;
	}
}
eq6.onMouseMove(int x, int y) {
	if (EQChanging) {
		updateEQBand(eq6, 6, x, y);
	}
}

// Handles Band 7 Mouse Events
eq7.onLeftButtonDown(int x, int y) {
	updateEQBand(eq7, 7, x, y);
	EqChanging = 1;
}
eq7.onLeftButtonUp(int x, int y) {
	if (EQChanging) {
		EQChanging = 0;
	}
}
eq7.onMouseMove(int x, int y) {
	if (EQChanging) {
		updateEQBand(eq7, 7, x, y);
	}
}

// Handles Band 8 Mouse Events
eq8.onLeftButtonDown(int x, int y) {
	updateEQBand(eq8, 8, x, y);
	EqChanging = 1;
}
eq8.onLeftButtonUp(int x, int y) {
	if (EQChanging) {
		EQChanging = 0;
	}
}
eq8.onMouseMove(int x, int y) {
	if (EQChanging) {
		updateEQBand(eq8, 8, x, y);
	}
}

// Handles Band 9 Mouse Events
eq9.onLeftButtonDown(int x, int y) {
	updateEQBand(eq9, 9, x, y);
	EqChanging = 1;
}
eq9.onLeftButtonUp(int x, int y) {
	if (EQChanging) {
		EQChanging = 0;
	}
}
eq9.onMouseMove(int x, int y) {
	if (EQChanging) {
		updateEQBand(eq9, 9, x, y);
	}
}


// Updates EQ Band Image and System Value
updateEQBand(Layer eqName, int eqNum, int x, int y) {
	int newValue = eqMap.getValue(x - eqName.getLeft(), y - eqName.getTop());
	newValue = 128 - newValue;
	if (eqNum == 0) {
		System.setEqBand(0, newValue);
	} else if (eqNum == 1) {
		System.setEqBand(1, newValue);
	} else if (eqNum == 2) {
		System.setEqBand(2, newValue);
	} else if (eqNum == 3) {
		System.setEqBand(3, newValue);
	} else if (eqNum == 4) {
		System.setEqBand(4, newValue);
	} else if (eqNum == 5) {
		System.setEqBand(5, newValue);
	} else if (eqNum == 6) {
		System.setEqBand(6, newValue);
	} else if (eqNum == 7) {
		System.setEqBand(7, newValue);
	} else if (eqNum == 8) {
		System.setEqBand(8, newValue);
	} else if (eqNum == 9) {
		System.setEqBand(9, newValue);
	} else if (eqNum == 10) {
		System.setEqPreamp(newValue);
	}
}

System.onScriptUnloading() {
	delete eqMap;
}