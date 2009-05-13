#include <lib/std.mi>
#include <lib/config.mi>
//#include "../scripts/attribs/init_songticker.m"
#include "../scripts/attribs.m"


#define TEXT_PROPS "antialias,Font,fontsize,color,shadowcolor,shadowx,shadowy,timeroffstyle,timecolonwidth,forcefixed,forceupcase,forceuppercase,forcelocase,forcelowercase,bold,wrap,valign,offsety,dblclickaction,rightclickaction,move"

Function chooseBehavior();
Function CopyTextProperties();

Global Int TextWidth;
GLobal Int AutoWidth;
Global Int MainX;

Global Int FirstDelay;
Global Int Delay;
Global String strBetween;
Global boolean Moving;
Global boolean NoSpeed;
Global Int MouseX;

Global Group SG;

Global Text txtMain;
Global Text txt2;

Global Timer moveText;

//Global ConfigAttribute attrTextDirect;
//Global ConfigAttribute attrTextSpeed;

System.onScriptLoaded()
{
	//initAttribs_songTicker();
	initAttribs();
	
	SG = System.getScriptGroup();

	//attrTextSpeed = Config.getItemByGuid("{9149C445-3C30-4e04-8433-5A518ED0FDDE}").getAttribute("Text Ticker Speed");
	NoSpeed = 0;
	Delay = 20000;
	If (attrTextSpeed.getData() != "0")
	{
		Delay = 20/stringToFloat(attrTextSpeed.getData());
	}
	else
	{
		NoSpeed = 1;
	}
	FirstDelay = Delay + 1;
	strBetween = "***";
	txtMain = SG.findObject("My.Text.Main");
	txt2 = SG.findObject("My.Text.2");
	
	moveText = new Timer;
	
	//songticker_scrolling_enabled_attrib.onDataChanged ();
}

System.onSetXuiParam(String param, String value)
{
	txtMain.setXMLParam(param,value);
	If (strlower(param) == "betweenstring") strBetween = value;
	If (strlower(param) == "configattrib")
	{
		String strItemGuid = GetToken(value,";",0);
		String strAttrName = GetToken(value,";",1);
		If (strAttrName != "" && strItemGuid != "")
		{ 
			ConfigItem cfgMyOptMenu = Config.getItemByGuid(strItemGuid);
			If (cfgMyOptMenu != NULL) attrTextDirect = cfgMyOptMenu.getAttribute(strAttrName);
			If (attrTextDirect == NULL) messagebox("Error: Declared attribute not found","OneDirection Text",1,"");
		}
	}
	If (strlower(param) == "firstdelay")
	{
		If (StringtoInteger(Value) > Delay) FirstDelay = StringtoInteger(Value);
	}
	chooseBehavior();	
}

txtMain.onTextChanged(String newtxt)
{
	chooseBehavior();
}

attrTextDirect.OnDataChanged()
{
	chooseBehavior();
}

attrTextSpeed.OnDataChanged()
{
	NoSpeed = 0;
	If (attrTextSpeed.getData() != "0")
	{
		Delay = 20/stringToFloat(attrTextSpeed.getData());
		moveText.setDelay(Delay);
	}
	else
	{
		NoSpeed = 1;
		chooseBehavior();
	}
}


chooseBehavior()
{
	moving = 0;
	TextWidth = SG.GetWidth();
	AutoWidth = txtMain.getAutoWidth();
	int AutoWidth2;
	If (AutoWidth <= TextWidth || NoSpeed || songticker_scrolling_enabled_attrib.getData() == "0")
	{
		txtMain.Show();
		txt2.Hide();
		moveText.Stop();
	}
	else if (attrTextDirect != NULL)
	{
		if (attrTextDirect.getData() == "0")
		{
			txtMain.Show();
			txt2.Hide();
			moveText.Stop();
		}
		else
		{
			MainX = 0;
			txt2.setText(txtMain.getText() + strBetween + txtMain.getText());
			CopyTextProperties();
			TextWidth = SG.GetWidth();
			AutoWidth2 = txt2.getAutoWidth();
			txt2.setXMLParam("w",IntegertoString(AutoWidth2));
			txt2.setXMLParam("x",IntegertoString(-AutoWidth2+AutoWidth));
			txtMain.Hide();
			txt2.Show();
			moveText.SetDelay(FirstDelay);
			moveText.Start();
		}
	}
	else
	{
		MainX = 0;
		txt2.setText(txtMain.getText() + strBetween + txtMain.getText());
		CopyTextProperties();
		TextWidth = SG.GetWidth();
		AutoWidth2 = txt2.getAutoWidth();
		txt2.setXMLParam("w",IntegertoString(AutoWidth2));
		txt2.setXMLParam("x",IntegertoString(-AutoWidth2+AutoWidth));
		txtMain.Hide();
		txt2.Show();
		moveText.SetDelay(FirstDelay);
		moveText.Start();
	}
}

moveText.OnTimer()
{
	CopyTextProperties();
	int BWidth = txt2.getAutoWidth() - AutoWidth*2;
	If (AutoWidth != txtMain.getAutoWidth() || TextWidth != SG.GetWidth())
	{
		chooseBehavior();
	}
	else if (AutoWidth <= TextWidth || NoSpeed) {
		// Do nothing
	}
	else
	{
		If (moveText.GetDelay() == FirstDelay)
		{
			moveText.SetDelay(Delay);
		}
		If (!Moving)
		{
			MainX = MainX - 1;
		}
		else
		{
			MainX = MainX + System.getMousePosX() - MouseX;
			MouseX = System.getMousePosX();
		}
		if (MainX >= TextWidth + BWidth) MainX = MainX - AutoWidth - BWidth;
		if (MainX < - AutoWidth + TextWidth) MainX = MainX + AutoWidth + BWidth;
		txt2.setXMLParam("x",IntegertoString(MainX - AutoWidth - BWidth));
	}
}

txt2.OnLeftButtonDown(int x, int y)
{
	If (StringtoInteger(txtMain.getXMLParam("nograb")) == 0 || txtMain.getXMLParam("move") == "1")
	{
		moveText.SetDelay(30);
		moving = 1;
		MouseX = getMousePosX();
	}
}

txt2.OnLeftButtonUp(int x, int y)
{
	If (moving == 1)
	{
		moving = 0;
		moveText.SetDelay(FirstDelay);
	}
}

txt2.onLeftButtonDblClk(int x, int y)
{
	If (moving == 1)
	{
		moving = 0;
		moveText.SetDelay(FirstDelay);
	}
}

System.OnScriptUnloading()
{
	delete MoveText;
}

CopyTextProperties()
{
	boolean blnCheckProp;
	blnCheckProp = 0;
	for (Int i = 0; i <= 20; i++)
	{
		If (txtMain.getXMLParam(System.getToken(TEXT_PROPS,",",i)) != txt2.getXMLParam(System.getToken(TEXT_PROPS,",",i))) blnCheckProp = 1;
	}

	If (blnCheckProp)
	{
		for (Int i = 0; i <= 20; i++)
		{
			txt2.SetXMLParam(System.getToken(TEXT_PROPS,",",i),txtMain.getXMLParam(System.getToken(TEXT_PROPS,",",i)));
		}
	}
}

songticker_scrolling_enabled_attrib.onDataChanged ()
{
	txtMain.setXMLParam("ticker", getData());
	txt2.setXMLParam("ticker", getData());
	chooseBehavior();
}

txtMain.onAction (String action, String param, Int x, int y, int p1, int p2, GuiObject source)
{
	if (action == "setText")
	{
		setText(param);
	}
}
