;###########################################################################################

; Lang:				Dutch
; LangID			1043
; Last udpdated:	24.02.2009
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
	LangString CPro_Language_Title ${LANG_DUTCH} "Installer language"
	LangString CPro_Un_Language_Title ${LANG_DUTCH} "Uninstaller language"	
	LangString CPro_Language_Text ${LANG_DUTCH} "Please select a language:"

; First Page of Installer
	LangString CPro_Welcome_Title ${LANG_DUTCH} "Welcome to the $(^NameDA) Setup Wizard"
	LangString CPro_Welcome_Text ${LANG_DUTCH} "This wizard will guide you through the installation of $(^NameDA).$\r$\n$\r$\nIt is recommended that you close Winamp before starting Setup. This will make it possible to update all relevant Winamp files.$\n$\nYou'll at least need Winamp ${CPRO_WINAMP_VERSION} for this version of ${CPRO_NAME} to work!$\r$\n$\r$\n$_CLICK"

; Installer Header
	!if ${CPRO_BUILD_TYPE} == "BETA"
; Beta stage	
		LangString CPro_Caption ${LANG_DUTCH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME} Setup"
	!else if ${CPRO_BUILD_TYPE} == "NIGHTLY"
; Alpha stage	
		LangString CPro_Caption ${LANG_DUTCH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME} (${CPRO_DATE}) Setup"		
	!else
; Release
		LangString CPro_Caption ${LANG_DUTCH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} Setup"		
	!endif
	
; Installation type	
	LangString CPro_Full ${LANG_DUTCH} "Full"
	LangString CPro_Minimal ${LANG_DUTCH} "Minimal"
	
; Installer sections
	LangString CPro_CProFiles ${LANG_DUTCH} "${CPRO_NAME} Engine"
	LangString CPro_wBrowserPro ${LANG_DUTCH} "BrowserPro"
	LangString CPro_wAlbumArt ${LANG_DUTCH} "Now Playing"
	LangString CPro_WidgetsSection ${LANG_DUTCH} "Widgets"
	LangString CPro_CProCustom ${LANG_DUTCH} "Components"
	LangString CPro_cPlaylistPro ${LANG_DUTCH} "Playlist Search"
		
; Installer sections descriptions	
	LangString CPro_Desc_CProFiles ${LANG_DUTCH} "This will install all the files that ${CPRO_NAME} needs to work."
	LangString CPro_Desc_wBrowserPro ${LANG_DUTCH} "BrowserPro is a widget that will enable your browser to auto navigate to popular websites and explore the playing directory."
	LangString CPro_Desc_wAlbumArt ${LANG_DUTCH} "Now Playing is a widget that shows a big cd cover and information about the playing file."
	LangString CPro_Desc_WidgetsSection ${LANG_DUTCH} "${CPRO_NAME} skins support widgets and here you'll find some of them that we decided to bundle with this installer."
	LangString CPro_Desc_CProCustom ${LANG_DUTCH} "Optional components for ${CPRO_NAME}."
	LangString CPro_Desc_cPlaylistPro ${LANG_DUTCH} "Add a search box above your playlist for easy searches in your playlist."

; Direcory Text	
	LangString CPro_DirText ${LANG_DUTCH} "Please select your Winamp path below (you will be able to proceed when Winamp is detected):"

; Cleanup Page	
	LangString CPro_CleanupPage_Title ${LANG_DUTCH} "Winamp Cleanup"
	LangString CPro_CleanupPage_Subtitle ${LANG_DUTCH} "Cleanup some Winamp Preferences."
	LangString CPro_CleanupPage_Caption0 ${LANG_DUTCH} "Using the options on this page will remove some Winamp Configuration files which may not work across different versions of both Winamp and ${CPRO_NAME}."
	LangString CPro_CleanupPage_Caption1 ${LANG_DUTCH} "If you have problems getting ${CPRO_NAME} to run properly you can reinstall ${CPRO_NAME} at any time and use this page to solve your problems."
	LangString CPro_CleanupPage_Caption2 ${LANG_DUTCH} "NOTE: It's perfectly ok, these files will be rebuilt by Winamp."
	LangString CPro_CleanupPage_Caption3 ${LANG_DUTCH} "The reinstall with these options should be used only if you are experiencing difficulties using ${CPRO_NAME} with Winamp."
	LangString CPro_CleanupPage_Caption4 ${LANG_DUTCH} "Thank you for your understanding."
	LangString CPro_CleanupPage_Footer ${LANG_DUTCH} "If you are still having problems using ${CPRO_NAME},"
	LangString CPro_CleanupPage_TSLink ${LANG_DUTCH} "Ask for free support in the Skin Consortium Forums."
	LangString CPro_CleanupPage_StudioXnf ${LANG_DUTCH} "Delete Skin Configuration (studio.xnf)"
	LangString CPro_CleanupPage_StudioXnf_Desc ${LANG_DUTCH} "Deletes skin-specific settings like: window positions, active tabs, current windowmode, ..."
	LangString CPro_CleanupPage_WinampIni ${LANG_DUTCH} "Delete Winamp Configuration (winamp.ini)"
	LangString CPro_CleanupPage_WinampIni_Desc ${LANG_DUTCH} "Deletes winamp-specific settings like: current skin, advanced title formatting, current language, ..."

; Finish Page	
	LangString CPro_FinishPage_1 ${LANG_DUTCH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} installation finished"
	LangString CPro_FinishPage_2 ${LANG_DUTCH} "The setup wizard has finished installing ${CPRO_NAME} v${CPRO_VERSION}. You can now start using ${CPRO_NAME} skins and widgets in Winamp."
	LangString CPro_FinishPage_3 ${LANG_DUTCH} "If you like ${CPRO_NAME} and would like to help future development of the product please donate to the project."
	LangString CPro_FinishPage_4 ${LANG_DUTCH} "What do you want to do now?"
	LangString CPro_FinishPage_5 ${LANG_DUTCH} "Go to our homepage to get more ${CPRO_NAME} skins and widgets"
	LangString CPro_FinishPage_6 ${LANG_DUTCH} "Open Winamp with the default ${CPRO_NAME} skin now"
	LangString CPro_FinishPage_7 ${LANG_DUTCH} "Finish"	
	
; First Page of Uninstaller
	LangString CPro_Un_Welcome_Title ${LANG_DUTCH} "Welcome to the $(^NameDA) Uninstall Wizard"
	LangString CPro_Un_Welcome_Text ${LANG_DUTCH} "This wizard will guide you through the uninstallation of $(^NameDA).$\r$\n$\r$\nBefore starting the uninstallation, make sure ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} is not running.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_DUTCH} "Updating the winamp.ini configuration file..."
	LangString CPro_Account ${LANG_DUTCH} "Multi-user settings"
	LangString CPro_No_Account ${LANG_DUTCH} "No Multi-user settings"
	LangString CPro_Winamp_Path ${LANG_DUTCH} "Specifying path to Winamp configuration file..."	

; Close all instances of Winamp
	LangString CPro_CloseWinamp_Welcome_Title ${LANG_DUTCH} "Programs to close"
	LangString CPro_CloseWinamp_Welcome_Text  ${LANG_DUTCH} "Programs, that must be closed before continuing installation"	
	LangString CPro_CloseWinamp_Heading ${LANG_DUTCH} "Close all programs from the list before continuing installation..."
	LangString CPro_CloseWinamp_Searching ${LANG_DUTCH} "Searching programs, please wait..."
	LangString CPro_CloseWinamp_EndSearch ${LANG_DUTCH} "Searching programs finished..."
	LangString CPro_CloseWinamp_EndMonitor ${LANG_DUTCH} "Closing active process monitor, please wait..."
	LangString CPro_CloseWinamp_NoPrograms ${LANG_DUTCH} "Installer didn't find any programs to close"
	LangString CPro_CloseWinamp_ColHeadings1 ${LANG_DUTCH} "Application"
	LangString CPro_CloseWinamp_ColHeadings2 ${LANG_DUTCH} "Process"
	LangString CPro_CloseWinamp_Autoclosesilent ${LANG_DUTCH} "Closing program failed"

; Menu Start
	LangString CPro_MenuStart1 ${LANG_DUTCH} "Uninstall ${CPRO_NAME}"
	LangString CPro_MenuStart2 ${LANG_DUTCH} "Whats new"
	LangString CPro_MenuStart3 ${LANG_DUTCH} "Get more ${CPRO_NAME} skins and widgets!"	

	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_DUTCH} "Welcome to the $(^NameDA) Setup Wizard"
	LangString CPro_Widget_Welcome_Text ${LANG_DUTCH} "This wizard will guide you through the installation of $(^NameDA).$\r$\n$\r$\nYou'll at least need Winamp ${CPRO_WINAMP_VERSION} and ${CPRO_NAME} ${CPRO_VERSION} for this version of ${CPRO_WIDGET_NAME} to work!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_DUTCH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Setup"	
	LangString CPro_Widget_Name_Text ${LANG_DUTCH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS}"		
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_DUTCH} "Welcome to the $(^NameDA) Uninstall Wizard"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_DUTCH} "This wizard will guide you through the uninstallation of $(^NameDA).$\r$\n$\r$\n$_CLICK"

; Installer sections
	LangString CPro_Widget_Files ${LANG_DUTCH} "${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} for ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_DUTCH} "This will install all the files that ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} needs to work."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_DUTCH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} installation finished"
	LangString CPro_Widget_FinishPage_2 ${LANG_DUTCH} "The setup wizard has finished installing ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}. You can now start using your new ${CPRO_WIDGET_NAME} widget for ${CPRO_NAME} in Winamp."
	LangString CPro_Widget_FinishPage_3 ${LANG_DUTCH} "If you like ${CPRO_WIDGET_NAME} and would like to help future development of the product please donate to the project."
	LangString CPro_Widget_FinishPage_4 ${LANG_DUTCH} "What do you want to do now?"
	LangString CPro_Widget_FinishPage_5 ${LANG_DUTCH} "Go to our homepage to get more ${CPRO_NAME} widgets"
	LangString CPro_Widget_FinishPage_6 ${LANG_DUTCH} "Reload ${CPRO_NAME} or open Winamp now"
	LangString CPro_Widget_FinishPage_7 ${LANG_DUTCH} "Finish"	
	
; UnFinish Page	
	LangString CPro_Widget_UnFinishPage_1 ${LANG_DUTCH} "Completing the ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS} Uninstall Wizard"
	LangString CPro_Widget_UnFinishPage_2 ${LANG_DUTCH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS} has been uninstalled from your computer."
	LangString CPro_Widget_UnFinishPage_3 ${LANG_DUTCH} "Click $(CPro_Widget_FinishPage_7) to close this wizard"
	LangString CPro_Widget_UnFinishPage_4 ${LANG_DUTCH} "Reload ${CPRO_NAME} if Winamp is running"