// Enable the gadget settings functionality. 
System.Gadget.settingsUI = "Settings.html";
// Delegate for when the Settings dialog is closed.
System.Gadget.onSettingsClosed = SettingsClosed;
// Delegate for when the Settings dialog is instantiated.
System.Gadget.onShowSettings = SettingsShow;

// --------------------------------------------------------------------
// Handle the Settings dialog closed event.
// event = System.Gadget.Settings.ClosingEvent argument.
// --------------------------------------------------------------------

var location = "422";

function SettingsClosed(event)
{
    // User hit OK on the settings page.
    if (event.closeAction == event.Action.commit)
    {
        init();

    }
    // User hit Cancel on the settings page.
    else if (event.closeAction == event.Action.cancel)
    {
		//Do Nothing
    }
}

// --------------------------------------------------------------------
// Handle the Settings dialog show event.
// --------------------------------------------------------------------
function SettingsShow()
{
	// Do Nothing
}
       
    var updateTimeOut = null;
	var curPos = 0;
    function init()
    {
    
        var set = System.Gadget.Settings.readString("mensaLocation");
        if (String(set) != "") 
        	location = set;
        
    	var currentTime = new Date();
		var h=currentTime.getHours();
		var m=currentTime.getMinutes();
		var timeLeft = 60*24 - (60*h+m) + 1;
		
		/*if (updateTimeOut != null)
       		clearTimeOut(updateTimeOut);
       	updateTimeOut = null;*/
       	updateTimeOut = setTimeout("update();",timeLeft*60*1000);
		
        var oBackground = document.getElementById("imgBackground");
        oBackground.src = "url(images/background.png)";
        
        curPos = 0;
        load();
       }
       
       
       function update()
       {
       	/*if (updateTimeOut)
       		clearTimeOut(updateTimeOut);
       	updateTimeOut = null;*/
       	updateTimeOut = setTimeout("update();",24*60*60*1000);
       	
       	curPos = 0;
       	load();
       }
       
	var xmlDoc;
	function load()
	{ 
		xmlDoc=getXmlDOM();
		var url="http://services.songbook.me/mensa?loc="+location;
//		var url="http://localhost/songbook.me/tmp/mensa.php";
		xmlDoc.load(url);
	}
	function xmlDocLoaded() 
	{
		adjust(0);
	}
	function adjust(adjustPos)
	{
		curPos += adjustPos;
		var currentTime = new Date();
		var month = currentTime.getMonth() + 1;
		var day = currentTime.getDate();
		var year = currentTime.getFullYear();
		if (day < 10) day = "0"+day;
		if (month < 10) month = "0"+month;
		var date = day+"."+month+"."+year;
		
		var plaene = xmlDoc.getElementsByTagName("Tagesplan");
		var gerichte = null;

		var done = false;
		for (i = 0; i < plaene.length; i++)
		{
			if (done)
				break;
			var attribs = plaene[i].attributes;
			for (j = 0; j < attribs.length; j++)
			{
				if (attribs[j].nodeName == "tag")
				{
					var isBigger = false;
					var d = attribs[j].nodeValue.substring(0,2);
					var m = attribs[j].nodeValue.substring(3,5);
					var y = attribs[j].nodeValue.substring(6,10);
					
					if (y > year)
						isBigger = true;
					else if (year == y && m > month)
						isBigger = true;
					else if (year == y && m == month && d > day)
						isBigger = true;
						
					if (attribs[j].nodeValue == date || isBigger)
					{
						if (i+curPos < 0)
						{
							curPos = -i;
						}
						if (i+curPos >= plaene.length)
						{
							curPos = plaene.length - i - 1;
						}

						var pos = i+curPos;
						gerichte = plaene[pos].getElementsByTagName("Gericht");
						
						// Now we need to set the date
							
						if (isBigger && curPos == 0)
						{
							document.getElementById("date").innerHTML = attribs[j].nodeValue;;
						}
						else if (curPos == 0)
						{
							document.getElementById("date").innerHTML = "Heute";
						}
						else
						{
							var attr = plaene[pos].attributes;
							for (h = 0; h < attr.length; h++)
							{
								if (attr[h].nodeName == "tag")
								{
									document.getElementById("date").innerHTML = attr[h].nodeValue;
									break;
								}
							}	
						}
						done = true;
						break;
					}
				}
			}
		}

		if (!gerichte)
			return;
					
		//document.getElementById("date").innerHTML=;//plan.attributes[1].nodeValue;
		for (j = 0; j < gerichte.length && j < 5; j++)
		{
			var g = gerichte[j].attributes;
			for (i = 0; i < g.length; i++)
			{
				var element = document.getElementById(g[i].nodeName + j);
				if (element)
					element.innerHTML = g[i].nodeValue;
			}
			document.getElementById("meal" + j).style.display = "block";
		}
		for (j = gerichte.length; j < 5; j++)
			document.getElementById("meal" + j).style.display = "none";
		document.getElementById("content").style.display = "block";
		
		document.getElementById("content").scrollTop = 0;
	}
	
	function getXmlDOM()
	{
		if( document.implementation && document.implementation.createDocument )
		{
			xmlDoc = document.implementation.createDocument("", "", null);
			xmlDoc.onload = xmlDocLoaded;
		}
		else if (window.ActiveXObject)
		{
			xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
			xmlDoc.async=false
			xmlDoc.onreadystatechange = function () { if (xmlDoc.readyState == 4) xmlDocLoaded();	};
	 	}
	 	return xmlDoc;
	}
	var downTimeout = null;
	var moveDelta = 0;
	function scrollDown()
	{
		  if (event)
		  {
		  	var y = event.clientY-24;
		  	if (y < 15)
		  		moveDelta = -3;
		  	else if (y < 40)
		  		moveDelta = -2;
		  	else if (y < 60)
		  		moveDelta = -1;
		  	else if (y > 105)
		  		moveDelta = 3;
		  	else if (y > 85)
		  		moveDelta = 2;
		  	else if (y > 65)
		  		moveDelta = 1;
		  	else
		  		moveDelta = 0;		  		
		  }
		  if (!moveDelta)
		  {
			if (downTimeout) 
				clearTimeout(downTimeout);
			downTimeout = null;			  
		  	return;
		  }
		  if (downTimeout == null)
		  {	
		  	downTimeout=setTimeout("scrollDown();",66);
		  	return;
		  }
		  downTimeout=setTimeout("scrollDown();",66);
		  var content = document.getElementById("content");
		  content.scrollTop = content.scrollTop + moveDelta;
	}
	function scrollDownStop()
	{
		clearTimeout(downTimeout);
		downTimeout = null;
	}