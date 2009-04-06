function SetVisFrame (animatedlayer vislayer, int Length, int ValStoredItem, int Offset);
function custom_visGetSpectrum(int Number);
function custom_visOnLoaded();
function custom_visOnUnloading();
function custom_visSpectrumAlphaVis(layer vislayer, int ValStoreItem);

custom_visOnLoaded()
{
	tmrVis = new Timer;
// Timer triggers often enough for the eye not to see
	tmrVis.SetDelay(30);
	tmrVis.Start();
	tmrVis.OnTimer();
}

custom_visOnUnloading()
{
	tmrVis.Stop();
}

// Sets new vis positions every timer tick
tmrVis.OnTimer(){
	
	if (WorkingVis.getItem(0) && !WorkingVis.getItem(1))
	{
		custom_visGetSpectrum(21);
		SetVisFrame(lyrVis1, 3, 0, 0);
		SetVisFrame(lyrVis2, 6, 1, 0);
		SetVisFrame(lyrVis3, 8, 2, 0);
		SetVisFrame(lyrVis4, 10, 3, 0);
		SetVisFrame(lyrVis5, 11, 4, 0);
		SetVisFrame(lyrVis6, 12, 5, 0);
		SetVisFrame(lyrVis7, 13, 6, 0);
		SetVisFrame(lyrVis8, 14, 7, 0);
		SetVisFrame(lyrVis9, 14, 8, 0);
		SetVisFrame(lyrVis10, 14, 9, 0);
		SetVisFrame(lyrVis11, 15, 10, 0);
		SetVisFrame(lyrVis12, 15, 11, 0);
		SetVisFrame(lyrVis13, 15, 12, 0);
		SetVisFrame(lyrVis14, 15, 13, 0);
		SetVisFrame(lyrVis15, 15, 14, 0);
		SetVisFrame(lyrVis16, 15, 15, 0);
		SetVisFrame(lyrVis17, 15, 16, 0);
		SetVisFrame(lyrVis18, 15, 17, 0);
		SetVisFrame(lyrVis19, 14, 18, 0);
		SetVisFrame(lyrVis20, 13, 19, 0);
		SetVisFrame(lyrVis21, 11, 20, 0);	
	}
	if (WorkingVis.getItem(0) && WorkingVis.getItem(1))
	{
		custom_visGetSpectrum(6);
		custom_visSpectrumAlphaVis(lyrAdvVis1_1,0);
		custom_visSpectrumAlphaVis(lyrAdvVis1_2,1);
		custom_visSpectrumAlphaVis(lyrAdvVis1_3,2);
		custom_visSpectrumAlphaVis(lyrAdvVis1_4,3);
		custom_visSpectrumAlphaVis(lyrAdvVis1_5,4);
		custom_visSpectrumAlphaVis(lyrAdvVis1_6,5);
	}
}

/*************************************************************************
Function, that sets animated layer to frame according to loudness
of frequencies:
vislayer - the animated layer to be set
length - number of frames of vislayer to be used (less or equal 
to the whole number of it's frames - offset)
ValStoredItem - index of SpectrumList List, that contains spectrum values
!!! Values of SpectrumList should be set manually
Offset - shows the offset of the first frame to be used 
(if animation is not from the first frame)
*************************************************************************/
SetVisFrame(animatedlayer vislayer, int Length, int ValStoredItem, int Offset)
{
	double BandValue = SpectrumList.eNumItem(ValStoredItem);
	int newFrame = Integer(BandValue / 255 * Length) + Offset;
	If (newFrame >= Length) newFrame = Length - 1;
	If (newFrame < 0) newFrame = 0;
	vislayer.gotoFrame(newFrame);
}

custom_visSpectrumAlphaVis(layer vislayer, int ValStoredItem)
{

		vislayer.setAlpha( 75+ Integer (180 /255 * SpectrumList.eNumItem(ValStoredItem)));		
}

custom_visGetSpectrum(int Number)
{
	List PrevValList = SpectrumList;
	if (SpectrumList.getNumItems() != Number)
	{
		PrevValList.removeAll();
		for ( int i = 0; i < Number; i++ )
		{
			PrevValList.addItem(0);
		}
	}

	SpectrumList = new List;
	int BarValue;
	double dValuesPerBar = 70 / Number;
	int iValuesPerBar = Integer(dValuesPerBar);
	if (System. getStatus()!= 0)
	{
		for ( int i = 0; i < Number; i++ )
		{
			for ( int j = 0; j < iValuesPerBar; j++ )
			{
				BarValue = BarValue + System.getVisBand(0,Integer(dValuesPerBar * i + j));
			}
			BarValue = BarValue / iValuesPerBar;
			If (PrevValList.eNumItem(i) > BarValue)
				BarValue = (PrevValList.eNumItem(i) * 4/5) + (BarValue / 5); // Using the old values too
			SpectrumList.addItem(BarValue);
		}
	}
	else
	{
		for ( int i = 0; i < Number; i++ )
		{		
			BarValue = (PrevValList.eNumItem(i) * 4/5); // Using the old values only
			SpectrumList.addItem(BarValue);
		}
	}
	delete PrevValList;
}

/*grpMNLCD2.onRightButtonUp(int x, int y)
{
// .isMouseOver(int x, int y)
	PopupMenu Popup = new PopupMenu;
	PopupMenu Type = new PopupMenu;
	PopupMenu  Style = new PopupMenu;
	Type.addCommand("Waveform", 0, 0, 0);
	Type.addCommand("Spectrum", 1, 1, 0);
	Style.addCommand("Small Circles", 2, 0,0);
	Style.addCommand("Large Circles", 3, 1,0);
	Style.addCommand("Beams", 4, 0,0);
	Popup.addSubMenu(Style, "Style");
	Popup.addSubMenu(Type, "Type");
	Popup.popAtMouse();
	delete Popup;
	delete Type;
	delete Style;
}*/