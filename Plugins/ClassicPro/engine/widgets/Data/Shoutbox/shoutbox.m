/**
 * Shoutbox.m
 *
 * @author mpdeimos
 * @date 08/02/26
 */

#include <lib/std.mi>
#include <lib/colormgr.mi>
#include "../BrowserPro/convert_address.mi"

Function updateMode(int newMode);

Global Browser brw;
Global Edit msg;
Global Text txt;
Global layer trap;

Global String baseurl;
Global String name;

Global Timer ref;

Global Group parent;

Global int curMode, delay;

Global ColorMgr cm;

#define SHOUTBOX_VERSION "0.4"

#define MODE_USERNAME 1
#define MODE_CHAT 2
#define MODE_REFRESH 3

system.onScriptLoaded ()
{
	parent = getScriptGroup();
	brw = parent.findObject("brw");
	msg = parent.findObject("edit.msg");
	txt = parent.findObject("txt.msg");
	trap = parent.findObject("trap");

	name = getPrivateString("classicPro_shoutbox", "username", "");
	if (name == "")
	{
		updateMode(MODE_USERNAME);
	}
	else
	{
		updateMode(MODE_CHAT);	
	}

	//baseurl = "http://localhost/sc3/classicpro/services/cpro-shoutbox.php?bg="+getColorHex("wasabi.list.background")+"&txt="+getColorHex("wasabi.list.text");
	baseurl = "http://cpro.skinconsortium.com/services/cpro-shoutbox.php?bg="+getColorHex("wasabi.list.background")+"&txt="+getColorHex("wasabi.list.text")+"&v="+SHOUTBOX_VERSION;

	ref = new Timer;
	delay = getPrivateInt("classicPro_shoutbox", "refresh", 30)*1000;
	if (delay > 0)
		ref.setDelay(delay);

	cm = new ColorMgr;
}

cm.oncolorthemechanged(String newtheme)
{
	baseurl = "http://cpro.skinconsortium.com/services/cpro-shoutbox.php?bg="+getColorHex("wasabi.list.background")+"&txt="+getColorHex("wasabi.list.text")+"&v="+SHOUTBOX_VERSION;
	brw.navigateUrl(baseurl);
}

/*
Global boolean inited = false;
init()
{
	if (inited)
		return;
	inited = true;
}*/

updateMode(int newmode)
{
	if (newMode == MODE_USERNAME)
	{
		txt.setText("Username:");
		msg.setText(getPrivateString("classicPro_shoutbox", "username", ""));
	}
	else if (newMode == MODE_CHAT)
	{
		txt.setText("Message:");
		msg.setText("");
	}
	else if (newMode == MODE_REFRESH)
	{
		txt.setText("Seconds:");
		msg.setText(integerToString(getPrivateInt("classicPro_shoutbox", "refresh", 30)));		
	}
	
	curMode = newMode;
}

parent.onSetVisible (Boolean onoff)
{
	if (onoff && delay > 0)
	{
		ref.start();
	}
	else
	{
		ref.stop();
	}
	brw.navigateUrl(baseurl);
}

ref.onTimer ()
{
	if (isMinimized())
	{
		return;
	}
	brw.navigateUrl(baseurl);
}

msg.onEnter()
{
	if (getText() == "")
	{
		return;
	}

	if (curMode == MODE_USERNAME)
	{
		name = getText();
		setPrivateString("classicPro_shoutbox", "username", name);
		updateMode(MODE_CHAT);
	}
	else if (curMode == MODE_CHAT)
	{
		if (name == "")
		{
			updateMode(MODE_USERNAME);
			return;
		}
		
		ref.stop();
		brw.navigateUrl(baseurl + "&msg=" + urlencode(msg.getText()) + "&name=" + urlencode(name) + "&artist=" + urlEncode(getPlayItemMetaDataString("artist")) + "&title=" + urlEncode(getPlayItemMetaDataString("title")));
		setText("");
		if (delay > 0)
		{
			ref.start();
		}
		
	}
	else if (curMode == MODE_REFRESH)
	{
		delay = stringToInteger(getText());
		setPrivateInt("classicPro_shoutbox", "refresh", delay);
		delay *= 1000;
		if (delay > 0)
		{
			ref.stop();
			ref.setDelay(delay);
			ref.start();
		}
		else
		{
			ref.stop();
		}
		updateMode(MODE_CHAT);
	}
}

trap.onEnterArea ()
{
	txt.setText("<Options>");
}

trap.onLeaveArea ()
{
	if (curMode == MODE_USERNAME)
	{
		txt.setText("username:");
	}
	else if (curMode == MODE_CHAT)
	{
		txt.setText("Message:");
	}
	else if (curMode == MODE_REFRESH)
	{
		txt.setText("Seconds:");
	}
}

trap.onLeftButtonUp (int x, int y)
{
	PopupMenu men = new PopupMenu;
	men.addCommand("Let's Shout!", MODE_CHAT, curMode == MODE_CHAT, curMode == MODE_CHAT);
	men.addCommand("Set Username", MODE_USERNAME, curMode == MODE_USERNAME, curMode == MODE_USERNAME);
	men.addCommand("Set Refresh-Interval", MODE_REFRESH, curMode == MODE_REFRESH, curMode == MODE_REFRESH);
	men.addSeparator();
	men.addCommand("Reload Shoutbox", 1001, 0, 0);

	int res = men.popAtMouse();

	if (res > 1000)
	{
		if (res == 1001)
		{
			brw.navigateUrl(baseurl);
		}
		
	}
	else if (res > 0)
		updateMode(res);

	complete;
}



