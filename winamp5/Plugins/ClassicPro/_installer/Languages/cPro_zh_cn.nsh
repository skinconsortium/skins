;###########################################################################################

; Lang:			SimpChinese
; LangID			2052
; Last udpdated:		24.02.2009
; Author:			x
; Email:			x@x

; Notes:
; Use ';' or '#' for comments
; Strings must be in double quotes.
; Only edit the strings in quotes:
; Make sure there's no trailing spaces at ends of lines
; To use double quote inside string - '$\'
; To force new line  - '$\r$\n'
; To insert tabulation  - '$\t'

;###########################################################################################

; Language selection
	LangString CPro_Language_Title ${LANG_SIMPCHINESE} "Installer language"
	LangString CPro_Language_Text ${LANG_SIMPCHINESE} "Please select a language:"

; First Page of Installer
	LangString CPro_Welcome_Title ${LANG_SIMPCHINESE} "Welcome to the $(^NameDA) Setup Wizard"
	LangString CPro_Welcome_Text ${LANG_SIMPCHINESE} "This wizard will guide you through the installation of $(^NameDA).$\r$\n$\r$\nIt is recommended that you close Winamp before starting Setup. This will make it possible to update all relevant Winamp files.$\n$\nYou'll at least need Winamp ${CPRO_WINAMP_VERSION} for this version of ${CPRO_NAME} to work!$\r$\n$\r$\n$_CLICK"

; Installer Header
	!ifdef CPRO_BETA
; Beta stage	
		LangString CPro_Caption ${LANG_SIMPCHINESE} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BETA} Setup"
	!else
; Release
		LangString CPro_Caption ${LANG_SIMPCHINESE} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} Setup"
	!endif
	
; Installation type	
	LangString CPro_Full ${LANG_SIMPCHINESE} "Full"
	LangString CPro_Minimal ${LANG_SIMPCHINESE} "Minimal"
	
; Installer sections
	LangString CPro_CProFiles ${LANG_SIMPCHINESE} "ClassicPro Engine"
	LangString CPro_wBrowserPro ${LANG_SIMPCHINESE} "BrowserPro"
	LangString CPro_wAlbumArt ${LANG_SIMPCHINESE} "Now Playing"
	LangString CPro_WidgetsSection ${LANG_SIMPCHINESE} "Widgets"
	LangString CPro_CProCustom ${LANG_SIMPCHINESE} "Components"
	LangString CPro_cPlaylistPro ${LANG_SIMPCHINESE} "Playlist Search"
		
; Installer sections descriptions	
	LangString CPro_Desc_CProFiles ${LANG_SIMPCHINESE} "This will install all the files that ClassicPro needs to work."
	LangString CPro_Desc_wBrowserPro ${LANG_SIMPCHINESE} "BrowserPro is a widget that will enable your browser to auto navigate to popular websites and explore the playing directory."
	LangString CPro_Desc_wAlbumArt ${LANG_SIMPCHINESE} "Now Playing is a widget that shows a big cd cover and information about the playing file."
	LangString CPro_Desc_WidgetsSection ${LANG_SIMPCHINESE} "ClassicPro skins support widgets and here you'll find some of them that we decided to bundle with this installer."
	LangString CPro_Desc_CProCustom ${LANG_SIMPCHINESE} "Optional components for ClassicPro."
	LangString CPro_Desc_cPlaylistPro ${LANG_SIMPCHINESE} "Add a search box above your playlist for easy searches in your playlist."

; Direcory Text	
	LangString CPro_DirText ${LANG_SIMPCHINESE} "Please select your Winamp path below (you will be able to proceed when Winamp is detected):"

; Finish Page	
	LangString CPro_FinishPage_1 ${LANG_SIMPCHINESE} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} installation finished"
	LangString CPro_FinishPage_2 ${LANG_SIMPCHINESE} "The setup wizard have finished installing ${CPRO_NAME} v${CPRO_VERSION}. You can now start using ${CPRO_NAME} skins and widgets in Winamp."
	LangString CPro_FinishPage_3 ${LANG_SIMPCHINESE} "If you like ${CPRO_NAME} and would like to help future development of the product please donate to the project."
	LangString CPro_FinishPage_4 ${LANG_SIMPCHINESE} "What do you want to do now?"
	LangString CPro_FinishPage_5 ${LANG_SIMPCHINESE} "Go to our homepage to get more ${CPRO_NAME} skins and widgets"
	LangString CPro_FinishPage_6 ${LANG_SIMPCHINESE} "Open the default ${CPRO_NAME} skin now"
	LangString CPro_FinishPage_7 ${LANG_SIMPCHINESE} "Finish"	
	
; First Page of Uninstaller
	LangString CPro_Un_Welcome_Title ${LANG_SIMPCHINESE} "Welcome to the $(^NameDA) Uninstall Wizard"
	LangString CPro_Un_Welcome_Text ${LANG_SIMPCHINESE} "This wizard will guide you through the uninstallation of $(^NameDA).$\r$\n$\r$\nBefore starting the uninstallation, make sure ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} is not running.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_SIMPCHINESE} "Updating the winamp.ini configuration file..."
	LangString CPro_Account ${LANG_SIMPCHINESE} "Multi-user settings"
	LangString CPro_No_Account ${LANG_SIMPCHINESE} "No Multi-user settings"
	LangString CPro_Winamp_Path ${LANG_SIMPCHINESE} "Specifying path to Winamp configuration file..."	

; Close all instances of Winamp
	LangString CPro_Running_Winamp ${LANG_SIMPCHINESE} "Winamp is running!"
	LangString CPro_Close_Winamp  ${LANG_SIMPCHINESE} "Before continue, you must close all instances of Winamp!"	
	LangString CPro_Closing_Winamp ${LANG_SIMPCHINESE} "        Closing Winamp (winamp.exe)..."
	LangString CPro_No_More_Winamp ${LANG_SIMPCHINESE} "        OK. All instances of Winamp are closed..."  
	LangString CPro_No_Winamp ${LANG_SIMPCHINESE} "OK. No instances of Winamp is running..."
	LangString CPro_Check_Winamp ${LANG_SIMPCHINESE} "Checking if Winamp is running..."

; Menu Start
	LangString CPro_MenuStart1 ${LANG_SIMPCHINESE} "Uninstall ${CPRO_NAME}"
	LangString CPro_MenuStart2 ${LANG_SIMPCHINESE} "Whats new"
	LangString CPro_MenuStart3 ${LANG_SIMPCHINESE} "Get more ${CPRO_NAME} skins and widgets!"	
	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_SIMPCHINESE} "Welcome to the $(^NameDA) Setup Wizard"
	LangString CPro_Widget_Welcome_Text ${LANG_SIMPCHINESE} "This wizard will guide you through the installation of $(^NameDA).$\r$\n$\r$\nIt is recommended that you close Winamp before starting Setup. This will make it possible to update all relevant Winamp files.$\n$\nYou'll at least need Winamp ${CPRO_WINAMP_VERSION} and ${CPRO_NAME} ${CPRO_VERSION} for this version of ${CPRO_WIDGET_NAME} to work!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_SIMPCHINESE} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Setup"	
	LangString CPro_Widget_Name_Text ${LANG_SIMPCHINESE} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ClassicPro©"		
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_SIMPCHINESE} "Welcome to the $(^NameDA) Uninstall Wizard"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_SIMPCHINESE} "This wizard will guide you through the uninstallation of $(^NameDA).$\r$\n$\r$\nBefore starting the uninstallation, make sure ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} is not running.$\r$\n$\r$\n$_CLICK"
	
; Installer sections
	LangString CPro_Widget_Files ${LANG_SIMPCHINESE} "${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} for ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_SIMPCHINESE} "This will install all the files that ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} needs to work."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_SIMPCHINESE} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} installation finished"
	LangString CPro_Widget_FinishPage_2 ${LANG_SIMPCHINESE} "The setup wizard have finished installing ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}. You can now start using your new ${CPRO_WIDGET_NAME} widget for ${CPRO_NAME} in Winamp."
	LangString CPro_Widget_FinishPage_3 ${LANG_SIMPCHINESE} "If you like ${CPRO_WIDGET_NAME} and would like to help future development of the product please donate to the project."
	LangString CPro_Widget_FinishPage_4 ${LANG_SIMPCHINESE} "What do you want to do now?"
	LangString CPro_Widget_FinishPage_5 ${LANG_SIMPCHINESE} "Go to our homepage to get more ${CPRO_NAME} skins and widgets"
	LangString CPro_Widget_FinishPage_6 ${LANG_SIMPCHINESE} "Open the default ${CPRO_NAME} skin now"
	LangString CPro_Widget_FinishPage_7 ${LANG_SIMPCHINESE} "Finish"		