#include <lib/std.mi>

#define DEBUG
#ifndef DEBUG
#define debugString //
#endif

#include "../wasabi/mspp/msppver.m"

#define MSPP_PATH getPrivateString("mspp", "Path", "")
#define ENSURE_MSPP if (getPrivateInt("mspp", neededMSPP_Version(), 0) == 0) return;

Global Layer t1, t2;
global timer wait, wait2;
Global int enter = 0;
Global map rmap;
Global group XUIGroup;

System.onScriptLoaded() {
	XUIGroup = getScriptGroup();

	t1 = XUIGroup.findObject("rating.hover");
	t2 = XUIGroup.findObject("rating");

	rmap = new map;
	rmap.loadMap("rating.map");

	wait = new timer;
	wait.setdelay(200);

	wait2 = new timer;
	wait2.setdelay(200);

}

XUIGroup.onsetVisible(int v) {
	if (v) {
		wait2.stop();
		wait2.start();
	}
}	

System.onScriptUnloading() {
//	delete rmap;
}

System.onTitleChange(String newtitle) {
	wait2.stop();
	wait2.start();
}

wait2.onTimer() {
	wait2.stop();
	if(!getScriptGroup().getParentLayout().isvisible()) return;
	debugString("msppVersion: " + neededMSPP_Version(), 0);
	ENSURE_MSPP
	System.navigateUrl(MSPP_PATH + "\\rating\\getCurrentRating.exe");
	wait.stop();
	wait.start();
}

wait.onTimer() {
	wait.stop();
	map m = new map;
	if (m) m.loadMap(MSPP_PATH + "\\rating\\currentrating.jpg");
	if (m) int v = (m.getWidth() - 10) * 10;
	if (m) delete m;
	Region reg = new Region;
	if (reg) reg.loadFromMap(rmap, v, 1);
	//messagebox(integerToString(v),"",1,"");
	if (reg) t2.setRegion(reg);
	if (reg) delete reg;
	debugString("ratingDebug: " + integerToString(v), 0);
}

t1.onEnterArea() {
	enter = 1;
	t1.setAlpha(120);
}

t1.onLeaveArea() {
	enter = 0;
	t1.setAlpha(0);
}

t1.onMouseMove(int x, int y) {
	if(!enter) return;
	int v = rmap.getValue(x - t1.getLeft(), y - t1.getTop());

	Region reg = new Region;
	if (reg) reg.loadFromMap(rmap, v, 1);
	//messagebox(integerToString(v),"",1,"");
	if (reg) t1.setRegion(reg);
	if (reg) delete reg;

	int rating = v / 10;
/*
	if (rating == 0) {
//		System.navigateUrl(MSPP_PATH + "\sendMessage\sendMessage_40401");
		t1.setXmlParam("tooltip", "Rate item: No rating");
	}
	if (rating == 1) {
//		System.navigateUrl(MSPP_PATH + "\sendMessage\sendMessage_40400");
		t1.setXmlParam("tooltip", "Rate item: *");
	}
	if (rating == 2) {
//		System.navigateUrl(MSPP_PATH + "\sendMessage\sendMessage_40399");
		t1.setXmlParam("tooltip", "Rate item: **");
	}
	if (rating == 3) {
//		System.navigateUrl(MSPP_PATH + "\sendMessage\sendMessage_40398");
		t1.setXmlParam("tooltip", "Rate item: ***");
	}
	if (rating == 4) {
//		System.navigateUrl(MSPP_PATH + "\sendMessage\sendMessage_40397");
		t1.setXmlParam("tooltip", "Rate item: ****");
	}
	if (rating == 5) {
//		System.navigateUrl(MSPP_PATH + "\sendMessage\sendMessage_40396");
		t1.setXmlParam("tooltip", "Rate item: *****");
	}*/
}

t1.onLeftButtonDown(int x, int y) {
	if(!enter) return;
	int v = rmap.getValue(x - t1.getLeft(), y - t1.getTop());
	
	Region reg = new Region;
	if (reg) reg.loadFromMap(rmap, v, 1);
	//messagebox(integerToString(v),"",1,"");
	if (reg) t2.setRegion(reg);
	if (reg) delete reg;

	int rating = v / 10;

	debugString("ratingDebug(setRating): " + integerToString(v), 0);

	if (rating == 0) {
		System.navigateUrl(MSPP_PATH + "\\sendMessage\\sendMessage_40401");
//		t1.setXmlParam("tooltip", "Rating item: No rating");
	}
	if (rating == 1) {
		System.navigateUrl(MSPP_PATH + "\\sendMessage\\sendMessage_40400");
//		t1.setXmlParam("tooltip", "Rating item: *");
	}
	if (rating == 2) {
		System.navigateUrl(MSPP_PATH + "\\sendMessage\\sendMessage_40399");
//		t1.setXmlParam("tooltip", "Rating item: **");
	}
	if (rating == 3) {
		System.navigateUrl(MSPP_PATH + "\\sendMessage\\sendMessage_40398");
//		t1.setXmlParam("tooltip", "Rating item: ***");
	}
	if (rating == 4) {
		System.navigateUrl(MSPP_PATH + "\\sendMessage\\sendMessage_40397");
//		t1.setXmlParam("tooltip", "Rating item: ****");
	}
	if (rating == 5) {
		System.navigateUrl(MSPP_PATH + "\\sendMessage\\sendMessage_40396");
//		t1.setXmlParam("tooltip", "Rating item: *****");
	}
}
