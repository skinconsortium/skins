;###########################################################################################

; Lang:			Turkish
; LangID			1055
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
	LangString Language_Title ${LANG_TURKISH} "Installer language"
	LangString Language_Text ${LANG_TURKISH} "Please select a language:"

; First Page of Installer
	LangString Welcome_Title ${LANG_TURKISH} "Welcome to the $(^NameDA) Setup Wizard"
	LangString Welcome_Text ${LANG_TURKISH} "This wizard will guide you through the installation of $(^NameDA).$\r$\n$\r$\nIt is recommended that you close Winamp before starting Setup. This will make it possible to update all relevant Winamp files.$\n$\nYou'll at least need Winamp ${CPRO_WINAMP_VERSION} for this version of ${CPRO_NAME} to work!$\r$\n$\r$\n$_CLICK"

; Installer Header
	!ifdef CPRO_BETA
; Beta stage	
		LangString CPro_Caption ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BETA} Setup"
	!else
; Release
		LangString CPro_Caption ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} Setup"
	!endif
	
; Installation type	
	LangString CPro_Full ${LANG_TURKISH} "Full"
	LangString CPro_Minimal ${LANG_TURKISH} "Minimal"
	
; Installer sections
	LangString CProFiles ${LANG_TURKISH} "ClassicPro Engine"
	LangString wBrowserPro ${LANG_TURKISH} "BrowserPro v2.0"
	LangString wAlbumArt ${LANG_TURKISH} "AlbumArt v1.1"
	LangString WidgetsSection ${LANG_TURKISH} "Widgets"
	LangString CProCustom ${LANG_TURKISH} "Components"
	LangString cPlaylistPro ${LANG_TURKISH} "Playlist Search"
		
; Installer sections descriptions	
	LangString Desc_CProFiles ${LANG_TURKISH} "This will install all the files that ClassicPro needs to work."
	LangString Desc_wBrowserPro ${LANG_TURKISH} "BrowserPro is a widget that will enable your browser to auto navigate to popular websites and explore the playing directory."
	LangString Desc_wAlbumArt ${LANG_TURKISH} "AlbumArt is a widget that shows a big cd cover and information about the playing file."
	LangString Desc_WidgetsSection ${LANG_TURKISH} "ClassicPro skins support widgets and here you'll find some of them that we decided to bundle with this installer."
	LangString Desc_CProCustom ${LANG_TURKISH} "Optional components for ClassicPro."
	LangString Desc_cPlaylistPro ${LANG_TURKISH} "Add a search box above your playlist for easy searches in your playlist."

; Direcory Text	
	LangString CPro_DirText ${LANG_TURKISH} "Please select your Winamp path below (you will be able to proceed when Winamp is detected):"

; Finish Page	
	LangString FinishPage_1 ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} installation finished"
	LangString FinishPage_2 ${LANG_TURKISH} "The setup wizard have finished installing ${CPRO_NAME} v${CPRO_VERSION}. You can now start using ${CPRO_NAME} skins and widgets in Winamp."
	LangString FinishPage_3 ${LANG_TURKISH} "If you like ${CPRO_NAME} and would like to help future development of the product please donate to the project."
	LangString FinishPage_4 ${LANG_TURKISH} "What do you want to do now?"
	LangString FinishPage_5 ${LANG_TURKISH} "Go to our homepage to get more ${CPRO_NAME} skins and widgets"
	LangString FinishPage_6 ${LANG_TURKISH} "Open the default ${CPRO_NAME} skin now"
	LangString FinishPage_7 ${LANG_TURKISH} "Finish"	
	LangString FinishPage_8 ${LANG_TURKISH} "https://www.paypal.com/uk/cgi-bin/webscr?cmd=_flow&SESSION=8h5vlcm9CV3GH2N6PEu7syhffIV0c0JgJ4QZ2FUWaJRiYKCliUrjeMQMtZS&dispatch=5885d80a13c0db1fa798f5a5f5ae42e71cf8ee1e360382336fe24cc0d575d12c"		
	
; First Page of Uninstaller
	LangString Un_Welcome_Title ${LANG_TURKISH} "Welcome to the $(^NameDA) Uninstall Wizard"
	LangString Un_Welcome_Text ${LANG_TURKISH} "This wizard will guide you through the uninstallation of $(^NameDA).$\r$\n$\r$\nBefore starting the uninstallation, make sure ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} is not running.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_TURKISH} "Updating the winamp.ini configuration file..."
	LangString CPro_Account ${LANG_TURKISH} "Multi-user settings"
	LangString CPro_No_Account ${LANG_TURKISH} "No Multi-user settings"
	LangString CPro_Winamp_Path ${LANG_TURKISH} "Specifying path to Winamp configuration file..."	

; Close all instances of Winamp
	LangString CPro_Running_Winamp ${LANG_TURKISH} "Winamp is running!"
	LangString CPro_Close_Winamp  ${LANG_TURKISH} "Before continue, you must close all instances of Winamp!"	
	LangString CPro_Closing_Winamp ${LANG_TURKISH} "        Closing Winamp (winamp.exe)..."
	LangString CPro_No_More_Winamp ${LANG_TURKISH} "        OK. All instances of Winamp are closed..."  
	LangString CPro_No_Winamp ${LANG_TURKISH} "OK. No instances of Winamp is running..."
	LangString CPro_Check_Winamp ${LANG_TURKISH} "Checking if Winamp is running..."

; Menu Start
	LangString CPro_MenuStart1 ${LANG_TURKISH} "Uninstall ${CPRO_NAME}"
	LangString CPro_MenuStart2 ${LANG_TURKISH} "Whats new"
	LangString CPro_MenuStart3 ${LANG_TURKISH} "Get more ${CPRO_NAME} skins and widgets!"	
		