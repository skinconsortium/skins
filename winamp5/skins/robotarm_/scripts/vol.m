#include <lib/std.mi>
Global AnimatedLayer volFeedback;
Global Button muteButton;
Global int preMuteVol;
System.onScriptLoaded ()
{
	preMuteVol = 0;
	volFeedback = getScriptGroup().findObject("vol.ctrl");
	muteButton = getScriptGroup().findObject("play.ctrl.mute");
	volFeedback.gotoFrame(System.getVolume()*16/255);
}
System.onVolumeChanged(int newvol)
{
	volFeedback.gotoFrame(newvol*16/255);
}
muteButton.onLeftClick ()
{
	if(System.getVolume() == 0)
	{
		System.setVolume(preMuteVol);
	}
	else
	{
		preMuteVol = System.getVolume();
		System.setVolume(0);
	}
}