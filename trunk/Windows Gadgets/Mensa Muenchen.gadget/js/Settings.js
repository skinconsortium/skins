// Delegate for the settings closing event. 
System.Gadget.onSettingsClosing = SettingsClosing;
        
// --------------------------------------------------------------------
// Initialize the settings.
// --------------------------------------------------------------------
function LoadSettings()
{
    var currentSetting = System.Gadget.Settings.readString("mensaLocation");
    if (currentSetting == "")
    	currentSetting = "422";
    mensaSelect.selectedIndex = 0;
    if (currentSetting)
    {
    	for(i = 0; i < mensaSelect.options.length; i++)
    	{
    		if (mensaSelect.options[i].value == currentSetting)
       		{
       			mensaSelect.selectedIndex = i;
       			break;
       		}
       	}
    }
    check();
}

// --------------------------------------------------------------------
// Handle the Settings dialog closing event.
// Parameters:
// event - System.Gadget.Settings.ClosingEvent argument.
// --------------------------------------------------------------------
function SettingsClosing(event)
{
    // User hit OK on the settings page.
    if (event.closeAction == event.Action.commit)
    {
        if (mensaSelect.selectedIndex >= 0)
        {   
            System.Gadget.Settings.writeString("mensaLocation", mensaSelect.options[mensaSelect.selectedIndex].value);
            // Allow the Settings dialog to close.
            event.cancel = false;  
        }
        // No user entry and 'Ok' invoked, cancel the Settings closing event.
        else
        {
            if (event.cancellable == false)
            {
                event.cancel = true;  
            }
        }
    }
}
function check()
{
	if (mensaSelect.options[mensaSelect.selectedIndex].text.substring(0, 9) == "Cafeteria")
		document.getElementById("spTest").innerHTML = "Die Preise in den Cafeterien weichen von den angezeigten Preisen ab!";
	else
		document.getElementById("spTest").innerHTML = "";
}