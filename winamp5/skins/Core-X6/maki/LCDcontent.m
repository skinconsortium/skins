function LCDcontentOnLoaded();
function CarrtibMNcontentChange(int ContentNumber);

LCDcontentOnLoaded()
{
	ConfigAttribute cattribTemp;
	Group grpTemp;

	for ( int i = 0; i <= 2; i++ )
	{
		cattribTemp = aCattrMNcontent.enumItem(i);
		if (cattribTemp.getData() == "0")
		{
			grpTemp = aGrpMNLCD.enumItem(i);
			grpTemp.Hide();
		}
	}
}

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
CarrtibMNcontentChange(int ContentNumber)
{
	ConfigAttribute cattribTemp; // Temp item is required as list items can not be parsed directly
	Group grpTemp;

	if (MyChange != 1)
	{
		MyChange = 1;
		cattribTemp = aCattrMNcontent.enumItem(ContentNumber);
		
		// If the menu item is  checked, then all sthe others should be unchecked
		if (cattribTemp.getData() == "1")
		{
			grpTemp = aGrpMNLCD.enumItem(ContentNumber);
			grpTemp.show();
			for ( int i = 0; i < aCattrMNcontent.getNumItems(); i++ )
			{
				if (ContentNumber != i)
				{
					cattribTemp = aCattrMNcontent.enumItem(i);
					cattribTemp.setData("0");
					grpTemp = aGrpMNLCD.enumItem(i);
					grpTemp.hide();
				}
			}
		}
		// If the item is unchecked by user is should be checked again (some item should be always checked)
		else
		{
			cattribTemp = aCattrMNcontent.enumItem(ContentNumber);
			cattribTemp.setData("1");
		}
		MyChange = 0;
	}
}