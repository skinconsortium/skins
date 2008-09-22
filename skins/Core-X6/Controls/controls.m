#include <lib/std.mi>

Global Slider sdrSeeker;
Global Slider sdrSeekerGhost;
Global Timer tmrSeeker;

System.onScriptLoaded()
{

	sdrSeeker = System.GetScriptGroup().GetObject("seeker");
	sdrSeekerGhost = System.GetScriptGroup().GetObject("seeker.ghost");
	tmrSeeker = new Timer;
	tmrSeeker.setDelay(100);
	tmrSeeker.Start();
}

tmrSeeker.onTimer()
{

	sdrSeeker.setPosition (sdrSeekerGhost.getPosition());

}

sdrSeeker.onLeftButtonDown(int x,int y)
{

tmrSeeker.Stop();

}

sdrSeeker.onLeftButtonUp (int x, int y)
{
	System.seekTo(sdrSeeker.getPosition()/255*System.getPlayItemLength());
	tmrSeeker.Start();
}
