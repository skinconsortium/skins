function LCDcontentOnLoaded();
function CarrtibMNcontentChange(int AttribNumber);
function LCDcontentButtonSwitch(int newTab);

LCDcontentOnLoaded()
{
	ConfigItem cgiLCDcontentT = Config.getItemByGuid(CUSTOM_PAGE_LCD_CONTENT_TRANSLATED);
	ConfigAttribute cattribTemp;
	Group grpTemp;

	for ( int i = 0; i <= 2; i++ )
	{
		cattribTemp = cgiLCDcontentT.getAttribute(LCDattrNames.enumItem(i));
		if (cattribTemp.getData() == "0")
		{
			grpTemp = grpLCD.GetObject("player.normal.LCD.content." + IntegertoString(i + 1));
			grpTemp.Hide();
		}
		else
		{
			// Setting working vis
			if (i == 0)
			{
				WorkingVis.setItem(0,1); //working
				WorkingVis.setItem(1,0); //first tab
			}
			if (i == 1)
			{
				WorkingVis.setItem(0,1); //working
				WorkingVis.setItem(1,1); //second tab
			}
			if (i == 2)
			{
				WorkingVis.setItem(0,0); //not working
			}
		}
	}
}
// Attributes
CattrMNcontent1.onDataChanged()
{
	CarrtibMNcontentChange(0);
}

CattrMNcontent2.onDataChanged()
{
	CarrtibMNcontentChange(1);	
}

CattrMNcontent3.onDataChanged()
{
	CarrtibMNcontentChange(2);
}

// Buttons
btnMNcontent1.onLeftClick()
{
	LCDcontentButtonSwitch(0);
}
btnMNcontent2.onLeftClick()
{
	LCDcontentButtonSwitch(1);
}
btnMNcontent3.onLeftClick()
{
	LCDcontentButtonSwitch(2);
}

/********************************************************************************
This function switches menu items and dependent groups
AttribNumber - menu item to be checked
********************************************************************************/
CarrtibMNcontentChange(int AttribNumber)
{
	int InnnerAttribNumber; // This is required as recursive function requests though allowed, overwrite variable values
	ConfigItem cgiLCDcontentT = Config.getItemByGuid(CUSTOM_PAGE_LCD_CONTENT_TRANSLATED);
	ConfigAttribute cattribTemp;
	Group grpTemp;

	if (MyChange != 1)
	{
		MyChange = 1;
		InnnerAttribNumber = AttribNumber;
		cattribTemp = cgiLCDcontentT.getAttribute(LCDattrNames.enumItem(InnnerAttribNumber));
		if (cattribTemp.getData() == "1")
		{
			for ( int i = 0; i < LCDattrNames.getNumItems(); i++ )
			{
				grpTemp =  grpLCD.GetObject("player.normal.LCD.content." + IntegertoString(i + 1));
				if (InnnerAttribNumber != i)
				{
					cattribTemp = cgiLCDcontentT.getAttribute(LCDattrNames.enumItem(i));
					cattribTemp.setData("0"); // If the menu item is  checked, then all the others should be unchecked
					grpTemp.hide();
				}
				else
				{
					grpTemp.show();
					// Setting working vis
					if (i == 0)
					{
						WorkingVis.setItem(0,1); //working
						WorkingVis.setItem(1,0); //first tab
					}
					if (i == 1)
					{
						WorkingVis.setItem(0,1); //working
						WorkingVis.setItem(1,1); //second tab
					}
					if (i == 2)
					{
						WorkingVis.setItem(0,0); //not working
					}
				}
				
			}
		}
		// If the item is unchecked by user is should be checked again (some item should be always checked)
		else
		{
			cattribTemp = cgiLCDcontentT.getAttribute(LCDattrNames.enumItem(InnnerAttribNumber));
			cattribTemp.setData("1");
		}
		MyChange = 0;
	}
}

/******************************************************************************************
This function changes the attribute thus changing the content
newTab - the number of the attribute to be switched on
******************************************************************************************/
LCDcontentButtonSwitch(int newTab)
{
	ConfigItem cgiLCDcontentT = Config.getItemByGuid(CUSTOM_PAGE_LCD_CONTENT_TRANSLATED);	
	ConfigAttribute cattribTemp = cgiLCDcontentT.getAttribute(LCDattrNames.enumItem(newTab));
	if (cattribTemp.getData() == "0")
	{
		cattribTemp.setData("1");
	}
}
