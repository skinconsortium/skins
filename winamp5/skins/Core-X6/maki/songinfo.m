function songinfoOnLoaded();

songinfoOnLoaded()
{
	LCDCrossfade.setAlpha(150*btnMNCrossfade.getActivated() + 155);
	LCDShuffle.setAlpha(150*btnMNShuffle.getActivated() + 155);	
	LCDRepeat.setAlpha(150*btnMNRepeat.getActivated() + 155);	
}

btnMNCrossfade.OnActivate(int activated)
{
	LCDCrossfade.setAlpha(150*activated + 155);
}

btnMNShuffle.OnActivate(int activated)
{
	LCDShuffle.setAlpha(150*activated + 155);
}

btnMNRepeat.OnActivate(int activated)
{
	LCDRepeat.setAlpha(150*activated + 155);
}