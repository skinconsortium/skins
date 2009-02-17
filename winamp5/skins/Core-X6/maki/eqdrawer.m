/**************************************************************
The script handles the drawer opening/closing as well as transforming
of 3 Eq bars into 10 by using the 3-d power curves
**************************************************************/

function eqdrawerOnLoaded();
function setEqBars(); // Set Bass, Middle and Tremple according to EQ values
function setEqualizer(); // Set All Eq values according to Bass, Middle and Tremble values

eqdrawerOnLoaded()
{
	if (cattrEq.getData()== "1")
	{
		grpEq.setXMLParam("y","203");
	} else
	{
		grpEq.setXMLParam("y","133");
	}
	MyChange = 2;
	setEqBars();
	MyChange = 0;
}

cattrEq.OnDataChanged()
{
	if (cattrEq.getData()== "1")
	{
		grpEq.setTargetX(199);
		grpEq.setTargetY(203);
		grpEq.setTargetSpeed(1);
		grpEq.GotoTarget();
	} else
	{
		grpEq.setTargetX(199);
		grpEq.setTargetY(133);
		grpEq.setTargetSpeed(1);
		grpEq.GotoTarget();
	}
}

lyrEQButton.onLeftButtonUp(int x, int y)
{
	// A standard button triggers when the button was pressed on it, then released, but in it's area too.
	if (lyrEQButton.isMouseOver(x, y))
	{
		if (cattrEq.getData()=="1")
		{
			cattrEq.setData("0");
		} else
		{
			cattrEq.setData("1");
		}	
	}
	
}

System.onEqBandChanged(int band, int newvalue)
{
	if (MyChange != 1)
	{
		MyChange = 2;
		setEqBars();
		MyChange = 0;
	}
}

setEqBars()
{
	int value;
	int b1 = System.getEqBand(0);
	int b2 = System.getEqBand(5);
	int b3 = System.getEqBand(9);
	// Counting curve coefficients for better presision
	float a1 = b1;
	float a3 = ((5 * b3) + (4 * a1) - (9 * b2)) / 180;
	float a2 = (b2 - a1) / 5 - (5 * a3);
	value = ((b1 + 127) / 254 * 22) + 0.5;
	sldEqBass.setPosition(value);
	value = (((a3 * 20.25) + (a2 * 4.5) + a1 + 127) / 254 * 22) +0.5;
	if (value > 22) value = 22;
	if (value <0) value = 0;
	sldEqMiddle.setPosition(value);
	value = ((b3 + 127) / 254 * 22) + 0.5;
	sldEqTremble.setPosition(value);
}

setEqualizer()
{
	MyChange = 1;
	int value;
	int b1 = sldEqBass.getPosition() / 22  * 254 - 127;
	int b2 = sldEqMiddle.getPosition() / 22 * 254 - 127;
	int b3 = sldEqTremble.getPosition() / 22 * 254 - 127;
	// Counting the coefficients of the curve
	float a1 = b1;
	float a2 = ((4*b2) - (3*b1) - b3) /18;
	float a3 = (b2 - b1 - (9 * a2))/81;
	a2 = 2 * a2;
	a3 = 4 * a3;
	for ( int i = 0; i <= 9; i++ )
	{
		value = (a3 * (i * i) ) + (a2 * i) + a1;
		if (value > 127) value = 127;
		if (value < -127) value = -127;
		System.setEqBand(i, value);
	}
	MyChange = 0;
}

sldEqBass.onSetPosition(int newpos)
{
	if (MyChange == 0)
	{
		setEqualizer();
	}
}
sldEqMiddle.onSetPosition(int newpos)
{
	if (MyChange == 0)
	{
		setEqualizer();
	}
}
sldEqTremble.onSetPosition(int newpos)
{
	if (MyChange == 0)
	{
		setEqualizer();
	}
}
