#include <lib/std.mi>
Function updBar();
Function extBar();
Function retBar();
Global Group scriptGroup;
Global Layer seekBar;
Global GuiObject seekRect;
Global Timer bomb;
System.onScriptLoaded ()
{
	seekBar = getScriptGroup().findObject("seek.bar");
	seekRect = getScriptGroup().findObject("seek.rect");
	updBar();
	bomb = new Timer;
	bomb.setDelay(250);
	if (System.GetStatus() == 1) {bomb.start();}
}
seekRect.onLeftButtonUp(int x, int y)
{
	x -= seekRect.getLeft() + 1;
	y -= seekRect.getTop();
	if (x >= 0) if (y >= 0) if ((x+1) <= seekRect.getWidth()) if (y <= seekRect.getHeight())
	{
		System.seekTo((x*System.getPlayItemLength())/(seekRect.getWidth()-2));
		seekBar.setXmlParam("w",System.integerToString((System.getPosition()*(seekRect.getWidth()-2))/System.getPlayItemLength()));
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
		seekBar.setXmlParam("y", "1");
		seekBar.setXmlParam("w",System.integerToString(System.getPosition()*(seekRect.getWidth()-2)/System.getPlayItemLength()));
		seekBar.setXmlParam("h", "10");
	}
	else
	{
		seekBar.setXmlParam("y", "4");
		seekBar.setXmlParam("w",System.integerToString(seekRect.getWidth()-2));
		seekBar.setXmlParam("h", "4");
	}
} 