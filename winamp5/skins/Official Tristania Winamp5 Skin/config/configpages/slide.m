#include "../../../../lib/std.mi"

Global Layer slide, slide2;
Global Group thisl;
Global Timer tmr;
Global int count;

System.onScriptLoaded() {

  thisl = getScriptGroup();
  slide = thisl.getObject("slideshow");
  slide2 = thisl.getObject("slideshow2");

  tmr = new Timer;
  tmr.setDelay(5000);
}

slide.onsetVisible(int v) {
	if (v) {
		count = 0;
		slide.setAlpha(255);
		slide2.setAlpha(0);
		slide.setXMLParam("image", "about.slide1");
		tmr.start();
	} else tmr.stop();
}

tmr.onTimer() {
	count++;
	if (count == 5) {
		count = 1;
	}
	if (!slide.getAlpha()) {
		slide2.bringToFront();
		slide.setXMLParam("image", "about.slide" + integerToString(count));
		slide.setAlpha(255);
		slide2.setTargetA(0);
		slide2.setTargetSpeed(0.5);
		slide2.gotoTarget();
	}
	if (!slide2.getAlpha()) {
		slide.bringToFront();
		slide2.setXMLParam("image", "about.slide" + integerToString(count));
		slide2.setAlpha(255);
		slide.setTargetA(0);
		slide.setTargetSpeed(0.5);
		slide.gotoTarget();
	}


}
/*
slide.onTargetReached() {
	if (slide.getAlpha() == 255) {
		slide2.setAlpha(0);
	}
}

slide2.onTargetReached() {
	if (slide.getAlpha() == 255) {
		slide.setAlpha(0);
	}
}*/