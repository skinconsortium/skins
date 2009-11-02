#include <lib/std.mi>
Function updBar();
Function extBar();
Function retBar();
Global Layer seekBar;
Global GuiObject seekRect, aArt;
Global Group stateButtonsGroup;
Global Button extend, retract;
Global Timer bomb;
Global int seekWidth, hideAArt;
System.onScriptLoaded ()
{
	seekBar = getScriptGroup().findObject("seek.bar");
	seekRect = getScriptGroup().findObject("seek.rect");
	extend = getScriptGroup().findObject("album.art.off");
	retract = getScriptGroup().findObject("album.art.on");
	aArt = getScriptGroup().findObject("album.art");
	stateButtonsGroup = getScriptGroup().findObject("state.buttons");
	updBar();
	bomb = new Timer;
	bomb.setDelay(250);
	if (System.GetStatus() == 1) {bomb.start();}
	hideAArt = System.getPrivateInt("robotarm", "HideAArt", 0);
	if (hideAArt) extBar();
	else retBar();
}
System.onScriptUnloading()
{
	System.setPrivateInt("robotarm", "HideAArt", hideAArt);
}
seekRect.onLeftButtonUp(int x, int y)
{
	x -= seekRect.getLeft() + 1;
	y -= seekRect.getTop();
	if (x >= 0) if (y >= 0) if ((x+1) <= seekRect.getWidth()) if (y <= seekRect.getHeight())
	{
		System.seekTo((x*System.getPlayItemLength())/seekWidth);
		seekBar.setXmlParam("w",System.integerToString((System.getPosition()*seekWidth)/System.getPlayItemLength()));
	}
}
System.onTitleChange (String newtitle) {updBar();}
System.onPlay () {bomb.start();updBar();}
System.onResume () {bomb.start();}
System.onPause () {bomb.stop();}
System.onStop () {bomb.stop();updBar();}
bomb.onTimer() {updBar();}
System.onScriptUnloading()
{
	bomb.stop();
	delete bomb;
}
updBar()
{
	if ((System.getPlayItemLength()>0)&&(System.getPosition() > 0)&&(System.getPosition() < System.getPlayItemLength()))
	{
		seekBar.setXmlParam("y", "27");
		seekBar.setXmlParam("w",System.integerToString((System.getPosition()*seekWidth)/System.getPlayItemLength()));
		seekBar.setXmlParam("h", "10");
	}
	else
	{
		seekBar.setXmlParam("y", "30");
		seekBar.setXmlParam("w",System.integerToString(seekWidth));
		seekBar.setXmlParam("h", "4");
	}
}
extend.onLeftClick()
{
	extBar();
}
retract.onLeftClick()
{
	retBar();
}
extBar()
{
	aArt.hide();
	extend.hide();
	retract.show();
	seekRect.setXmlParam("w", "208");
	stateButtonsGroup.setXmlParam("x", "165");
	seekWidth = 206;
	hideAArt = 1;
	updBar();
}
retBar()
{
	aArt.show();
	extend.show();
	retract.hide();
	seekRect.setXmlParam("w", "137");
	stateButtonsGroup.setXmlParam("x", "94");
	seekWidth = 135;
	hideAArt = 0;
	updBar();
}