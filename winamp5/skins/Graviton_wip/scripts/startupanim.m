#include "../../../lib/std.mi"
#include "defines.m"

Global AnimatedLayer aniButtonChange;
Global Layer innerMask, outerMask;
Global Int AnimCount, curAniState;

system.onScriptLoaded() {
	aniButtonChange = getScriptGroup().getObject("button.ani");

	innerMask = getScriptGroup().findObject("main.inner.mask");
	outerMask = getScriptGroup().findObject("main.outer.mask");
	

	AnimCount = 0;
	curAniState = ANI_FORWARDS;

	aniButtonChange.play();
}

aniButtonChange.onStop() {
	if(AnimCount==1) {
		aniButtonChange.setTargetA(0);
		aniButtonChange.gotoFrame(0);
		aniButtonChange.setStartFrame(0);
		aniButtonChange.setEndFrame(aniButtonChange.getLength()-1);
		aniButtonChange.gotoTarget();
		aniButtonChange.setXmlParam("ghost", "1");

		innerMask.setTargetA(0);
		outerMask.setTargetA(0);
		innerMask.setTargetSpeed(1);
		outerMask.setTargetSpeed(1);
		innerMask.gotoTarget();
		outerMask.gotoTarget();
		innerMask.setXmlParam("ghost", "1");
		outerMask.setXmlParam("ghost", "1");

	} else if(curAniState == ANI_FORWARDS) {
		aniButtonChange.gotoFrame(aniButtonChange.getLength()-1);
		aniButtonChange.setEndFrame(0);
		aniButtonChange.setStartFrame(aniButtonChange.getLength()-1);
		curAniState = ANI_BACKWARDS;
		aniButtonChange.play();
		AnimCount = AnimCount + 1;
	} else {
		aniButtonChange.gotoFrame(0);
		aniButtonChange.setStartFrame(0);
		aniButtonChange.setEndFrame(aniButtonChange.getLength()-1);
		aniButtonChange.gotoTarget();
		curAniState = ANI_BACKWARDS;
		aniButtonChange.play();
		AnimCount = AnimCount + 1;
	}
}