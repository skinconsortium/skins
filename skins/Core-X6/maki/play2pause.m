function play2pauseOnLoaded();

#define PRESSSPEED 0.25

play2pauseOnLoaded()
{
	tmrPlay2Pause.SetDelay(1000);
	
	if (System.getStatus() == 0)
	{
		btnMNPlay.SetXMLParam("tooltip",system.translate("Play"));
		btnMNPlay.SetXMLParam("action","play");
	}
	if (System.getStatus() == -1)
	{
		btnMNPlay.SetXMLParam("tooltip",system.translate("Play"));
		btnMNPlay.SetXMLParam("action","play");
		tmrPlay2Pause.Start();
	}
	if (System.getStatus() == 1)
	{
		btnMNPlay.SetXMLParam("tooltip",system.translate("Pause"));
		btnMNPlay.SetXMLParam("action","pause");
		lyrMNPlayLight.setXMLParam("image","player.normal.play.glowlight.bitmap");
	}
		
}

btnMNPlay.OnLeftButtonDown(int x, int y)
{
	lyrMNPlayDown.SetTargetA(255);
	lyrMNPlayDown.SetTargetX(Stringtointeger(GetXMLParam("X")));
	lyrMNPlayDown.SetTargetY(Stringtointeger(GetXMLParam("Y")));
	lyrMNPlayDown.SetTargetSpeed(PRESSSPEED);
	lyrMNPlayDown.GoToTarget();
	lyrMNPlayLight.SetTargetA(150);
	lyrMNPlayLight.SetTargetX(Stringtointeger(GetXMLParam("X")));
	lyrMNPlayLight.SetTargetY(Stringtointeger(GetXMLParam("Y")));
	lyrMNPlayLight.SetTargetSpeed(PRESSSPEED);
	lyrMNPlayLight.GoToTarget();
}

btnMNPlay.OnLeftButtonUp(int x, int y)
{
	lyrMNPlayDown.SetTargetA(0);
	lyrMNPlayDown.SetTargetX(Stringtointeger(GetXMLParam("X")));
	lyrMNPlayDown.SetTargetY(Stringtointeger(GetXMLParam("Y")));
	lyrMNPlayDown.SetTargetSpeed(PRESSSPEED);
	lyrMNPlayDown.GoToTarget();
	lyrMNPlayLight.SetTargetA(255);
	lyrMNPlayLight.SetTargetX(Stringtointeger(GetXMLParam("X")));
	lyrMNPlayLight.SetTargetY(Stringtointeger(GetXMLParam("Y")));
	lyrMNPlayLight.SetTargetSpeed(PRESSSPEED);
	lyrMNPlayLight.GoToTarget();
}

System.OnStop()
{
	btnMNPlay.SetXMLParam("tooltip",system.translate("Play"));
	btnMNPlay.SetXMLParam("action","play");
	tmrPlay2Pause.Stop();
	lyrMNPlayLight.setXMLParam("image","player.normal.play.light.bitmap");	
}
System.OnPause()
{
	btnMNPlay.SetXMLParam("tooltip",system.translate("Play"));
	btnMNPlay.SetXMLParam("action","play");	
	tmrPlay2Pause.Start();
}
System.OnPlay()
{
	btnMNPlay.SetXMLParam("tooltip",system.translate("Pause"));
	btnMNPlay.SetXMLParam("action","pause");
	tmrPlay2Pause.Stop();
	lyrMNPlayLight.setXMLParam("image","player.normal.play.glowlight.bitmap");
}
System.OnResume()
{
	btnMNPlay.SetXMLParam("tooltip",system.translate("Pause"));
	btnMNPlay.SetXMLParam("action","pause");
	tmrPlay2Pause.Stop();
	lyrMNPlayLight.setXMLParam("image","player.normal.play.glowlight.bitmap");
}

tmrPlay2Pause.OnTimer()
{
	if (lyrMNPlayLight.getXMLParam("image") == "player.normal.play.light.bitmap")
	{
		lyrMNPlayLight.setXMLParam("image","player.normal.play.glowlight.bitmap");
	}
	else
	{
		lyrMNPlayLight.setXMLParam("image","player.normal.play.light.bitmap");	
	}
}