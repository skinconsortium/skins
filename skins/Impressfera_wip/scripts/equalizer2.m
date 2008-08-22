#include <lib/std.mi>
#include <lib/SkinConsortium.mi>

Function setFG(Layer doThis, int newpos);
Function resetEq();

Global Group frameGroup;
Global Slider eqP, eq1, eq2, eq3, eq4, eq5, eq6, eq7, eq8, eq9, eq10;
Global Layer lEqP, lEq1, lEq2, lEq3, lEq4, lEq5, lEq6, lEq7, lEq8, lEq9, lEq10;

Global Button setAll255, setAll128, setAll0;

System.onScriptLoaded() {
	frameGroup = getScriptGroup();
	eqP = frameGroup.findObject("eqp");
	eq1 = frameGroup.findObject("eq1");
	eq2 = frameGroup.findObject("eq2");
	eq3 = frameGroup.findObject("eq3");
	eq4 = frameGroup.findObject("eq4");
	eq5 = frameGroup.findObject("eq5");
	eq6 = frameGroup.findObject("eq6");
	eq7 = frameGroup.findObject("eq7");
	eq8 = frameGroup.findObject("eq8");
	eq9 = frameGroup.findObject("eq9");
	eq10 = frameGroup.findObject("eq10");

	lEqP = frameGroup.findObject("eqp.fg");
	lEq1 = frameGroup.findObject("eq1.fg");
	lEq2 = frameGroup.findObject("eq2.fg");
	lEq3 = frameGroup.findObject("eq3.fg");
	lEq4 = frameGroup.findObject("eq4.fg");
	lEq5 = frameGroup.findObject("eq5.fg");
	lEq6 = frameGroup.findObject("eq6.fg");
	lEq7 = frameGroup.findObject("eq7.fg");
	lEq8 = frameGroup.findObject("eq8.fg");
	lEq9 = frameGroup.findObject("eq9.fg");
	lEq10 = frameGroup.findObject("eq10.fg");
	

	setAll255 = frameGroup.findObject("eq.plus12");
	setAll128 = frameGroup.findObject("eq.plus0");
	setAll0 = frameGroup.findObject("eq.min12");
	
	setFG(lEqP, getEqPreamp());
	setFG(lEq1, getEqBand(0));
	setFG(lEq2, getEqBand(1));
	setFG(lEq3, getEqBand(2));
	setFG(lEq4, getEqBand(3));
	setFG(lEq5, getEqBand(4));
	setFG(lEq6, getEqBand(5));
	setFG(lEq7, getEqBand(6));
	setFG(lEq8, getEqBand(7));
	setFG(lEq9, getEqBand(8));
	setFG(lEq10, getEqBand(9));
}

setFG(Layer doThis, int newpos){
	int temp = (newpos+127)/255*70;
	doThis.setXMLParam("h", integerToString(temp));
	doThis.setXMLParam("y", integerToString(139-temp));
}

eqP.onSetPosition(int newpos){
	setFG(lEqP, newpos);
}
eq1.onSetPosition(int newpos){
	setFG(lEq1, newpos);
}
eq2.onSetPosition(int newpos){
	setFG(lEq2, newpos);
}
eq3.onSetPosition(int newpos){
	setFG(lEq3, newpos);
}
eq4.onSetPosition(int newpos){
	setFG(lEq4, newpos);
}
eq5.onSetPosition(int newpos){
	setFG(lEq5, newpos);
}
eq6.onSetPosition(int newpos){
	setFG(lEq6, newpos);
}
eq7.onSetPosition(int newpos){
	setFG(lEq7, newpos);
}
eq8.onSetPosition(int newpos){
	setFG(lEq8, newpos);
}
eq9.onSetPosition(int newpos){
	setFG(lEq9, newpos);
}
eq10.onSetPosition(int newpos){
	setFG(lEq10, newpos);
}

System.onEqBandChanged(int band, int newpos){
	if(band==0){
		setFG(lEq1, newpos);
	}
	else if(band==1){
		setFG(lEq2, newpos);
	}
	else if(band==2){
		setFG(lEq3, newpos);
	}
	else if(band==3){
		setFG(lEq4, newpos);
	}
	else if(band==4){
		setFG(lEq5, newpos);
	}
	else if(band==5){
		setFG(lEq6, newpos);
	}
	else if(band==6){
		setFG(lEq7, newpos);
	}
	else if(band==7){
		setFG(lEq8, newpos);
	}
	else if(band==8){
		setFG(lEq9, newpos);
	}
	else if(band==9){
		setFG(lEq10, newpos);
	}
}


resetEq(){
	for(int a=0;a<10;a++){
		setEqBand(a,0);
	}
}

setAll255.onLeftClick(){
	setEqBands("127;127;127;127;127;127;127;127;127;127");
}
setAll128.onLeftClick(){
	setEqBands("0;0;0;0;0;0;0;0;0;0");
}
setAll0.onLeftClick(){
	setEqBands("-127;-127;-127;-127;-127;-127;-127;-127;-127;-127");
}