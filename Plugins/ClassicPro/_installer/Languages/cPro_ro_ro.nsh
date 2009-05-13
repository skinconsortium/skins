;###########################################################################################

; Lang:				Romanian
; LangID			1048
; Last udpdated:	13.03.2009 20:41 EET
; Author:			Cãtãlin ZAMFIRESCU
; Email:			x10@mail.com

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
	LangString CPro_Language_Title ${LANG_ROMANIAN} "Limbã instalare"
	LangString CPro_Un_Language_Title ${LANG_ROMANIAN} "Uninstaller language"	
	LangString CPro_Language_Text ${LANG_ROMANIAN} "Selectaþi o limbã:"

; First Page of Installer
	LangString CPro_Welcome_Title ${LANG_ROMANIAN} "Bun venit la asistentul pentru instalare a $(^NameDA)"
	LangString CPro_Welcome_Text ${LANG_ROMANIAN} "Acest asistent vã va ghida în procesul de instalare a $(^NameDA).$\r$\n$\r$\nSe recomandã închiderea Winamp înainte de începerea instalãrii. Aceasta va face posibilã actualizarea tuturor fiºierelor necesare.$\n$\nAveþi nevoie, cel puþin, de versiunea ${CPRO_WINAMP_VERSION} a Winamp pentru ca aceastã versiune a ${CPRO_NAME} sã funcþioneze!$\r$\n$\r$\n$_CLICK"

; Installer Header
	!if ${CPRO_BUILD_TYPE} == "BETA"
; Beta stage	
		LangString CPro_Caption ${LANG_ROMANIAN} "Instalare ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME}"
	!else if ${CPRO_BUILD_TYPE} == "NIGHTLY"
; Alpha stage	
		LangString CPro_Caption ${LANG_ROMANIAN} "Instalare ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME} (${CPRO_DATE})"		
	!else
; Release
		LangString CPro_Caption ${LANG_ROMANIAN} "Instalare ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION}"		
	!endif

; Installation type	
	LangString CPro_Full ${LANG_ROMANIAN} "Completã"
	LangString CPro_Minimal ${LANG_ROMANIAN} "Minimalã"

; Installer sections
	LangString CPro_CProFiles ${LANG_ROMANIAN} "Motor ${CPRO_NAME}"
	LangString CPro_wBrowserPro ${LANG_ROMANIAN} "BrowserPro"
	LangString CPro_wAlbumArt ${LANG_ROMANIAN} "Piesa curentã"
	LangString CPro_WidgetsSection ${LANG_ROMANIAN} "Gadgeturi"
	LangString CPro_CProCustom ${LANG_ROMANIAN} "Componente"
	LangString CPro_cPlaylistPro ${LANG_ROMANIAN} "Cãutare în listã"

; Installer sections descriptions	
	LangString CPro_Desc_CProFiles ${LANG_ROMANIAN} "Fiºiere necesare pentru funcþionarea ${CPRO_NAME}."
	LangString CPro_Desc_wBrowserPro ${LANG_ROMANIAN} "Gadget care permite navigarea automatã prin saiturile populare ºi explorarea dosarului în curs de redare."
	LangString CPro_Desc_wAlbumArt ${LANG_ROMANIAN} "Gadget care afiºeazã o copertã CD mare ºi informaþii despre piesa în curs de redare."
	LangString CPro_Desc_WidgetsSection ${LANG_ROMANIAN} "Gadgeturi suportate de interfeþele ${CPRO_NAME}, furnizate împreunã cu acest pachet de instalare."
	LangString CPro_Desc_CProCustom ${LANG_ROMANIAN} "Componente opþionale pentru ${CPRO_NAME}."
	LangString CPro_Desc_cPlaylistPro ${LANG_ROMANIAN} "Casetã de cãtare adãugatã deasupra gestionarului de liste pentru cãutãri facile în lista de redare."

; Direcory Text
	LangString CPro_DirText ${LANG_ROMANIAN} "Selectaþi dosarul unde a fost instalat Winamp (veþi putea continua dupã ce Winamp a fost detectat):"

; Cleanup Page	
	LangString CPro_CleanupPage_Title ${LANG_ROMANIAN} "Winamp Cleanup"
	LangString CPro_CleanupPage_Subtitle ${LANG_ROMANIAN} "Cleanup some Winamp Preferences."
	LangString CPro_CleanupPage_Caption0 ${LANG_ROMANIAN} "Using the options on this page will remove some Winamp Configuration files which may not work across different versions of both Winamp and ${CPRO_NAME}."
	LangString CPro_CleanupPage_Caption1 ${LANG_ROMANIAN} "If you have problems getting ${CPRO_NAME} to run properly you can reinstall ${CPRO_NAME} at any time and use this page to solve your problems."
	LangString CPro_CleanupPage_Caption2 ${LANG_ROMANIAN} "NOTE: It's perfectly ok, these files will be rebuilt by Winamp."
	LangString CPro_CleanupPage_Caption3 ${LANG_ROMANIAN} "The reinstall with these options should be used only if you are experiencing difficulties using ${CPRO_NAME} with Winamp."
	LangString CPro_CleanupPage_Caption4 ${LANG_ROMANIAN} "Thank you for your understanding."
	LangString CPro_CleanupPage_Footer ${LANG_ROMANIAN} "If you are still having problems using ${CPRO_NAME},"
	LangString CPro_CleanupPage_TSLink ${LANG_ROMANIAN} "Ask for free support in the Skin Consortium Forums."
	LangString CPro_CleanupPage_StudioXnf ${LANG_ROMANIAN} "Delete Skin Configuration (studio.xnf)"
	LangString CPro_CleanupPage_StudioXnf_Desc ${LANG_ROMANIAN} "Deletes skin-specific settings like: window positions, active tabs, current windowmode, ..."
	LangString CPro_CleanupPage_WinampIni ${LANG_ROMANIAN} "Delete Winamp Configuration (winamp.ini)"
	LangString CPro_CleanupPage_WinampIni_Desc ${LANG_ROMANIAN} "Deletes winamp-specific settings like: current skin, advanced title formatting, current language, ..."

; Finish Page
	LangString CPro_FinishPage_1 ${LANG_ROMANIAN} "Instalare ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} finalizatã"
	LangString CPro_FinishPage_2 ${LANG_ROMANIAN} "Asistentul a finalizat instalarea ${CPRO_NAME} v${CPRO_VERSION}. Puteþi începe sã folosiþi interfeþele ºi gadgeturile ${CPRO_NAME} în Winamp."
	LangString CPro_FinishPage_3 ${LANG_ROMANIAN} "Dacã vã place ${CPRO_NAME} ºi doriþi sã sprijiniþi dezvolarea ulterioarã, vã rugãm sã faceþi donaþii pentru proiect."
	LangString CPro_FinishPage_4 ${LANG_ROMANIAN} "Acþiuni dupã terminarea instalãrii:"
	LangString CPro_FinishPage_5 ${LANG_ROMANIAN} "Explorare pagina ${CPRO_NAME} ºi descãrcare interfeþe ºi gadgeturi"
	LangString CPro_FinishPage_6 ${LANG_ROMANIAN} "Open Winamp with the default ${CPRO_NAME} skin now"
	LangString CPro_FinishPage_7 ${LANG_ROMANIAN} "Terminare"	

; First Page of Uninstaller
	LangString CPro_Un_Welcome_Title ${LANG_ROMANIAN} "Bun venit la asistentul pentru dezinstalare a $(^NameDA)"
	LangString CPro_Un_Welcome_Text ${LANG_ROMANIAN} "Acest asistent vã va ghida prin procesul de dezinstalare a $(^NameDA).$\r$\n$\r$\nÎnainte de începerea dezinstalãrii, asiguraþi-vã cã ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} nu funcþioneazã.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_ROMANIAN} "Actualizare fiºier de configurare winamp.ini..."
	LangString CPro_Account ${LANG_ROMANIAN} "Configuraþie multi-utilizator"
	LangString CPro_No_Account ${LANG_ROMANIAN} "Configuraþie mono-utilizator"
	LangString CPro_Winamp_Path ${LANG_ROMANIAN} "Specificare dosar fiºier de configurare Winamp..."	

; Close all instances of Winamp
	LangString CPro_CloseWinamp_Welcome_Title ${LANG_ROMANIAN} "Programs to close"
	LangString CPro_CloseWinamp_Welcome_Text  ${LANG_ROMANIAN} "Programs, that must be closed before continuing installation"	
	LangString CPro_CloseWinamp_Heading ${LANG_ROMANIAN} "Close all programs from the list before continuing installation..."
	LangString CPro_CloseWinamp_Searching ${LANG_ROMANIAN} "Searching programs, please wait..."
	LangString CPro_CloseWinamp_EndSearch ${LANG_ROMANIAN} "Searching programs finished..."
	LangString CPro_CloseWinamp_EndMonitor ${LANG_ROMANIAN} "Closing active process monitor, please wait..."
	LangString CPro_CloseWinamp_NoPrograms ${LANG_ROMANIAN} "Installer didn't find any programs to close"
	LangString CPro_CloseWinamp_ColHeadings1 ${LANG_ROMANIAN} "Application"
	LangString CPro_CloseWinamp_ColHeadings2 ${LANG_ROMANIAN} "Process"
	LangString CPro_CloseWinamp_Autoclosesilent ${LANG_ROMANIAN} "Closing program failed"

; Menu Start
	LangString CPro_MenuStart1 ${LANG_ROMANIAN} "Dezinstalare ${CPRO_NAME}"
	LangString CPro_MenuStart2 ${LANG_ROMANIAN} "Ce-i nou"
	LangString CPro_MenuStart3 ${LANG_ROMANIAN} "Mai multe interfeþe ºi gadgeturi ${CPRO_NAME}!"

	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_ROMANIAN} "Welcome to the $(^NameDA) Setup Wizard"
	LangString CPro_Widget_Welcome_Text ${LANG_ROMANIAN} "This wizard will guide you through the installation of $(^NameDA).$\r$\n$\r$\nYou'll at least need Winamp ${CPRO_WINAMP_VERSION} and ${CPRO_NAME} ${CPRO_VERSION} for this version of ${CPRO_WIDGET_NAME} to work!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_ROMANIAN} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Setup"	
	LangString CPro_Widget_Name_Text ${LANG_ROMANIAN} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS}"		
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_ROMANIAN} "Welcome to the $(^NameDA) Uninstall Wizard"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_ROMANIAN} "This wizard will guide you through the uninstallation of $(^NameDA).$\r$\n$\r$\n$_CLICK"

; Installer sections
	LangString CPro_Widget_Files ${LANG_ROMANIAN} "${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} for ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_ROMANIAN} "This will install all the files that ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} needs to work."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_ROMANIAN} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} installation finished"
	LangString CPro_Widget_FinishPage_2 ${LANG_ROMANIAN} "The setup wizard has finished installing ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}. You can now start using your new ${CPRO_WIDGET_NAME} widget for ${CPRO_NAME} in Winamp."
	LangString CPro_Widget_FinishPage_3 ${LANG_ROMANIAN} "If you like ${CPRO_WIDGET_NAME} and would like to help future development of the product please donate to the project."
	LangString CPro_Widget_FinishPage_4 ${LANG_ROMANIAN} "What do you want to do now?"
	LangString CPro_Widget_FinishPage_5 ${LANG_ROMANIAN} "Go to our homepage to get more ${CPRO_NAME} widgets"
	LangString CPro_Widget_FinishPage_6 ${LANG_ROMANIAN} "Reload ${CPRO_NAME} or open Winamp now"
	LangString CPro_Widget_FinishPage_7 ${LANG_ROMANIAN} "Finish"	
	
; UnFinish Page	
	LangString CPro_Widget_UnFinishPage_1 ${LANG_ROMANIAN} "Completing the ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS} Uninstall Wizard"
	LangString CPro_Widget_UnFinishPage_2 ${LANG_ROMANIAN} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS} has been uninstalled from your computer."
	LangString CPro_Widget_UnFinishPage_3 ${LANG_ROMANIAN} "Click $(CPro_Widget_FinishPage_7) to close this wizard"
	LangString CPro_Widget_UnFinishPage_4 ${LANG_ROMANIAN} "Reload ${CPRO_NAME} if Winamp is running"