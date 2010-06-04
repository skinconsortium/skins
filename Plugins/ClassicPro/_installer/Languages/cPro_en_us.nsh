;###########################################################################################

; Lang:				English
; LangID			1033
; Last udpdated:	03.05.2009
; Author:			Pieter Nieuwoudt
; Email:			nieuwoudtpieter@gmail.com

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
	LangString CPro_Language_Title ${LANG_ENGLISH} "Installer language"
	LangString CPro_Un_Language_Title ${LANG_ENGLISH} "Uninstaller language"	
	LangString CPro_Language_Text ${LANG_ENGLISH} "Please select a language:"

; First Page of Installer
	LangString CPro_Welcome_Title ${LANG_ENGLISH} "Welcome to the $(^NameDA) Setup Wizard"
	LangString CPro_Welcome_Text ${LANG_ENGLISH} "This wizard will guide you through the installation of $(^NameDA).$\r$\n$\r$\nIt is recommended that you close Winamp before starting Setup. This will make it possible to update all relevant Winamp files.$\n$\nYou'll at least need Winamp ${CPRO_WINAMP_VERSION} for this version of ${CPRO_NAME} to work!$\r$\n$\r$\n$_CLICK"

; Installer Header
	!if ${CPRO_BUILD_TYPE} == "BETA"
; Beta stage	
		LangString CPro_Caption ${LANG_ENGLISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME} Setup"
	!else if ${CPRO_BUILD_TYPE} == "NIGHTLY"
; Alpha stage	
		LangString CPro_Caption ${LANG_ENGLISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME} (${CPRO_DATE}) Setup"		
	!else
; Release
		LangString CPro_Caption ${LANG_ENGLISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} Setup"		
	!endif
	
; Installation type	
	LangString CPro_Full ${LANG_ENGLISH} "Full"
	LangString CPro_Minimal ${LANG_ENGLISH} "Minimal"
	
; Installer sections
	LangString CPro_CProFiles ${LANG_ENGLISH} "${CPRO_NAME} Engine"
	LangString CPro_wBrowserPro ${LANG_ENGLISH} "BrowserPro"
	LangString CPro_wAlbumArt ${LANG_ENGLISH} "Now Playing"
	LangString CPro_WidgetsSection ${LANG_ENGLISH} "Widgets"
	LangString CPro_CProCustom ${LANG_ENGLISH} "Components"
	LangString CPro_cPlaylistPro ${LANG_ENGLISH} "Playlist Search"
		
; Installer sections descriptions	
	LangString CPro_Desc_CProFiles ${LANG_ENGLISH} "This will install all the files that ${CPRO_NAME} needs to work."
	LangString CPro_Desc_wBrowserPro ${LANG_ENGLISH} "BrowserPro is a widget that will enable your browser to auto navigate to popular websites and explore the playing directory."
	LangString CPro_Desc_wAlbumArt ${LANG_ENGLISH} "Now Playing is a widget that shows a big cd cover and information about the playing file."
	LangString CPro_Desc_WidgetsSection ${LANG_ENGLISH} "${CPRO_NAME} skins support widgets and here you'll find some of them that we decided to bundle with this installer."
	LangString CPro_Desc_CProCustom ${LANG_ENGLISH} "Optional components for ${CPRO_NAME}."
	LangString CPro_Desc_cPlaylistPro ${LANG_ENGLISH} "Add a search box above your playlist for easy searches in your playlist."

; Direcory Text	
	LangString CPro_DirText ${LANG_ENGLISH} "Please select your Winamp path below (you will be able to proceed when Winamp is detected):"

; Cleanup Page	
	LangString CPro_CleanupPage_Title ${LANG_ENGLISH} "Winamp Cleanup"
	LangString CPro_CleanupPage_Subtitle ${LANG_ENGLISH} "Cleanup some Winamp Preferences."
	LangString CPro_CleanupPage_Caption0 ${LANG_ENGLISH} "Using the options on this page will remove some Winamp Configuration files which may not work across different versions of both Winamp and ${CPRO_NAME}."
	LangString CPro_CleanupPage_Caption1 ${LANG_ENGLISH} "If you have problems getting ${CPRO_NAME} to run properly you can reinstall ${CPRO_NAME} at any time and use this page to solve your problems."
	LangString CPro_CleanupPage_Caption2 ${LANG_ENGLISH} "NOTE: It's perfectly ok, these files will be rebuilt by Winamp."
	LangString CPro_CleanupPage_Caption3 ${LANG_ENGLISH} "The reinstall with these options should be used only if you are experiencing difficulties using ${CPRO_NAME} with Winamp."
	LangString CPro_CleanupPage_Caption4 ${LANG_ENGLISH} "Thank you for your understanding."
	LangString CPro_CleanupPage_Footer ${LANG_ENGLISH} "If you are still having problems using ${CPRO_NAME},"
	LangString CPro_CleanupPage_TSLink ${LANG_ENGLISH} "Ask for free support in the Skin Consortium Forums."
	LangString CPro_CleanupPage_StudioXnf ${LANG_ENGLISH} "Delete Skin Configuration (studio.xnf)"
	LangString CPro_CleanupPage_StudioXnf_Desc ${LANG_ENGLISH} "Deletes skin-specific settings like: window positions, active tabs, current windowmode, ..."
	LangString CPro_CleanupPage_WinampIni ${LANG_ENGLISH} "Delete Winamp Configuration (winamp.ini)"
	LangString CPro_CleanupPage_WinampIni_Desc ${LANG_ENGLISH} "Deletes winamp-specific settings like: current skin, advanced title formatting, current language, ..."

; Finish Page	
	LangString CPro_FinishPage_1 ${LANG_ENGLISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} installation finished"
	LangString CPro_FinishPage_2 ${LANG_ENGLISH} "The setup wizard has finished installing ${CPRO_NAME} v${CPRO_VERSION}. You can now start using ${CPRO_NAME} skins and widgets in Winamp."
	LangString CPro_FinishPage_3 ${LANG_ENGLISH} "If you like ${CPRO_NAME} and would like to help future development of the product please donate to the project."
	LangString CPro_FinishPage_4 ${LANG_ENGLISH} "What do you want to do now?"
	LangString CPro_FinishPage_5 ${LANG_ENGLISH} "Go to our homepage to get more ${CPRO_NAME} skins and widgets"
	LangString CPro_FinishPage_6 ${LANG_ENGLISH} "Open Winamp with the default ${CPRO_NAME} skin now"
	LangString CPro_FinishPage_7 ${LANG_ENGLISH} "Finish"
	LangString CPro_FinishPage_8 ${LANG_ENGLISH} "Open Winamp with current skin"	
	
; First Page of Uninstaller
	LangString CPro_Un_Welcome_Title ${LANG_ENGLISH} "Welcome to the $(^NameDA) Uninstall Wizard"
	LangString CPro_Un_Welcome_Text ${LANG_ENGLISH} "This wizard will guide you through the uninstallation of $(^NameDA).$\r$\n$\r$\nBefore starting the uninstallation, make sure ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} is not running.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_ENGLISH} "Updating the winamp.ini configuration file..."
	LangString CPro_Account ${LANG_ENGLISH} "Multi-user settings"
	LangString CPro_No_Account ${LANG_ENGLISH} "No Multi-user settings"
	LangString CPro_Winamp_Path ${LANG_ENGLISH} "Specifying path to Winamp configuration file..."

; Close all instances of Winamp
	LangString CPro_CloseWinamp_Welcome_Title ${LANG_ENGLISH} "Programs to close"
	LangString CPro_CloseWinamp_Welcome_Text  ${LANG_ENGLISH} "Programs, that must be closed before continuing installation"	
	LangString CPro_CloseWinamp_Heading ${LANG_ENGLISH} "Close all programs from the list before continuing installation..."
	LangString CPro_CloseWinamp_Searching ${LANG_ENGLISH} "Searching programs, please wait..."
	LangString CPro_CloseWinamp_EndSearch ${LANG_ENGLISH} "Searching programs finished..."
	LangString CPro_CloseWinamp_EndMonitor ${LANG_ENGLISH} "Closing active process monitor, please wait..."
	LangString CPro_CloseWinamp_NoPrograms ${LANG_ENGLISH} "Installer didn't find any programs to close"
	LangString CPro_CloseWinamp_ColHeadings1 ${LANG_ENGLISH} "Application"
	LangString CPro_CloseWinamp_ColHeadings2 ${LANG_ENGLISH} "Process"
	LangString CPro_CloseWinamp_Autoclosesilent ${LANG_ENGLISH} "Closing program failed"	
	LangString CPro_CloseWinamp_MenuItem1 ${LANG_ENGLISH} "Close"
	LangString CPro_CloseWinamp_MenuItem2 ${LANG_ENGLISH} "Copy list"
	
; Menu Start
	LangString CPro_MenuStart1 ${LANG_ENGLISH} "Uninstall ${CPRO_NAME}"
	LangString CPro_MenuStart2 ${LANG_ENGLISH} "Whats new"
	LangString CPro_MenuStart3 ${LANG_ENGLISH} "Get more ${CPRO_NAME} skins and widgets!"	
	
	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_ENGLISH} "Welcome to the $(^NameDA) Setup Wizard"
	LangString CPro_Widget_Welcome_Text ${LANG_ENGLISH} "This wizard will guide you through the installation of $(^NameDA).$\r$\n$\r$\nYou'll at least need Winamp ${CPRO_WINAMP_VERSION} and ${CPRO_NAME} ${CPRO_VERSION} for this version of ${CPRO_WIDGET_NAME} to work!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_ENGLISH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Setup"	
	LangString CPro_Widget_Name_Text ${LANG_ENGLISH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS}"		
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_ENGLISH} "Welcome to the $(^NameDA) Uninstall Wizard"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_ENGLISH} "This wizard will guide you through the uninstallation of $(^NameDA).$\r$\n$\r$\n$_CLICK"

; Installer sections
	LangString CPro_Widget_Files ${LANG_ENGLISH} "${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} for ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_ENGLISH} "This will install all the files that ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} needs to work."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_ENGLISH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} installation finished"
	LangString CPro_Widget_FinishPage_2 ${LANG_ENGLISH} "The setup wizard has finished installing ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}. You can now start using your new ${CPRO_WIDGET_NAME} widget for ${CPRO_NAME} in Winamp."
	LangString CPro_Widget_FinishPage_3 ${LANG_ENGLISH} "If you like ${CPRO_WIDGET_NAME} and would like to help future development of the product please donate to the project."
	LangString CPro_Widget_FinishPage_4 ${LANG_ENGLISH} "What do you want to do now?"
	LangString CPro_Widget_FinishPage_5 ${LANG_ENGLISH} "Go to our homepage to get more ${CPRO_NAME} widgets"
	LangString CPro_Widget_FinishPage_6 ${LANG_ENGLISH} "Reload ${CPRO_NAME} or open Winamp now"
	LangString CPro_Widget_FinishPage_7 ${LANG_ENGLISH} "Finish"	
	
; UnFinish Page	
	LangString CPro_Widget_UnFinishPage_1 ${LANG_ENGLISH} "Completing the ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS} Uninstall Wizard"
	LangString CPro_Widget_UnFinishPage_2 ${LANG_ENGLISH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS} has been uninstalled from your computer."
	LangString CPro_Widget_UnFinishPage_3 ${LANG_ENGLISH} "Click $(CPro_Widget_FinishPage_7) to close this wizard"
	LangString CPro_Widget_UnFinishPage_4 ${LANG_ENGLISH} "Reload ${CPRO_NAME} if Winamp is running"