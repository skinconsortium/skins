;###########################################################################################

; Lang:			German
; LangID			1031
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
	LangString CPro_Language_Title ${LANG_GERMAN} "Sprache wählen"
	LangString CPro_Language_Text ${LANG_GERMAN} "Bitte wählen Sie eine Sprache:"

; First Page of Installer
	LangString CPro_Welcome_Title ${LANG_GERMAN} "Willkommen zum $(^NameDA) Installationsprogramm"
	LangString CPro_Welcome_Text ${LANG_GERMAN} "Dieser Assistent führt Sie durch die Installation von $(^NameDA).$\r$\n$\r$\nEs wird empfohlen Winamp vor der der Installation zu beenden, um alle relevanten Winamp Dateien zu aktualisieren.$\n$\nSie benötigen mindestens Winamp ${CPRO_WINAMP_VERSION} für diese ${CPRO_NAME} Version!$\r$\n$\r$\n$_CLICK"

; Installer Header
	!ifdef CPRO_BETA
; Beta stage	
		LangString CPro_Caption ${LANG_GERMAN} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BETA} Setup"
	!else
; Release
		LangString CPro_Caption ${LANG_GERMAN} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} Setup"
	!endif
	
; Installation type	
	LangString CPro_Full ${LANG_GERMAN} "Vollständig"
	LangString CPro_Minimal ${LANG_GERMAN} "Minimal"
	
; Installer sections
	LangString CPro_CProFiles ${LANG_GERMAN} "ClassicPro Engine"
	LangString CPro_wBrowserPro ${LANG_GERMAN} "BrowserPro v2.0"
	LangString CPro_wAlbumArt ${LANG_GERMAN} "AlbumArt v1.1"
	LangString CPro_WidgetsSection ${LANG_GERMAN} "Widgets"
	LangString CPro_CProCustom ${LANG_GERMAN} "Komponenten"
	LangString CPro_cPlaylistPro ${LANG_GERMAN} "Playlist Suche"
		
; Installer sections descriptions	
	LangString CPro_Desc_CProFiles ${LANG_GERMAN} "ClassicPro Kernkomponenten(benötigt)."
	LangString CPro_Desc_wBrowserPro ${LANG_GERMAN} "Das BrowserPro Widget zeigt Informationen populärer Webseiten zum aktuell abgespielten Titel, oder den aktuellen Ordnerinhalt an."
	LangString CPro_Desc_wAlbumArt ${LANG_GERMAN} "Das AlbumArt Widget zeigt eine große CD-Cover Ansicht und Tag-Informationen zum aktuell abgespielten Titel an."
	LangString CPro_Desc_WidgetsSection ${LANG_GERMAN} "Widgets sind vielseitige Erweiterungen für ClassicPro."
	LangString CPro_Desc_CProCustom ${LANG_GERMAN} "Optionale Komponenten für ClassicPro."
	LangString CPro_Desc_cPlaylistPro ${LANG_GERMAN} "Suchfeld für den Playlist Editor zum einfachen durchsuchen der Playlist."

; Direcory Text	
	LangString CPro_DirText ${LANG_GERMAN} "Bitte den Winamp Installationsordner angeben (Das Installationsprogramm versucht den korrekten Ordner automatisch zu ermitteln):"

; Finish Page	
	LangString CPro_FinishPage_1 ${LANG_GERMAN} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} Installation beendet"
	LangString CPro_FinishPage_2 ${LANG_GERMAN} "Die Installation von ${CPRO_NAME} v${CPRO_VERSION} ist abgeschloßen. Sie können nun ${CPRO_NAME} Skins and Widgets mit Winamp verwenden."
	LangString CPro_FinishPage_3 ${LANG_GERMAN} "Wenn Ihnen ${CPRO_NAME} gefällt und Sie die weitere Entwicklung unterstützen wollen, würden wir uns über eine Spende für unser Projekt freuen."
	LangString CPro_FinishPage_4 ${LANG_GERMAN} "Wie möchten Sie fortfahren?"
	LangString CPro_FinishPage_5 ${LANG_GERMAN} "Unsere Homepage besuchen und weitere ${CPRO_NAME} Skins und Widgets finden."
	LangString CPro_FinishPage_6 ${LANG_GERMAN} "Winamp mit dem Standard ${CPRO_NAME} Skin öffnen."
	LangString CPro_FinishPage_7 ${LANG_GERMAN} "Beenden"	
	
; First Page of Uninstaller
	LangString CPro_Un_Welcome_Title ${LANG_GERMAN} "Willkomen zum $(^NameDA) Deinstallationsprogramm"
	LangString CPro_Un_Welcome_Text ${LANG_GERMAN} "Dieser Assistent fürht Sie durch die Deinstallation von $(^NameDA).$\r$\n$\r$\nBevor Sie die Deinstallation starten, stellen Sie bitte sicher, dass ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} beendet ist.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_GERMAN} "winamp.ini wird aktualisiert..."
	LangString CPro_Account ${LANG_GERMAN} "Mehr-Benutzer Konfiguration"
	LangString CPro_No_Account ${LANG_GERMAN} "keine Mehr-Benutzer Konfiguration"
	LangString CPro_Winamp_Path ${LANG_GERMAN} "Pfad zur Winamp-Konfigurationsdatei..."	

; Close all instances of Winamp
	LangString CPro_Running_Winamp ${LANG_GERMAN} "Winamp ist aktiv!"
	LangString CPro_Close_Winamp  ${LANG_GERMAN} "Sie müssen Winamp beenden um fortfahren zu können!"	
	LangString CPro_Closing_Winamp ${LANG_GERMAN} "        Winamp wird beendet (winamp.exe)..."
	LangString CPro_No_More_Winamp ${LANG_GERMAN} "        OK. Winamp wurde beendet..."  
	LangString CPro_No_Winamp ${LANG_GERMAN} "OK. Winamp ist nicht aktiv..."
	LangString CPro_Check_Winamp ${LANG_GERMAN} "Überprüfe ob Winamp aktiv ist..."

; Menu Start
	LangString CPro_MenuStart1 ${LANG_GERMAN} "${CPRO_NAME} deinstallieren"
	LangString CPro_MenuStart2 ${LANG_GERMAN} "Was ist neu"
	LangString CPro_MenuStart3 ${LANG_GERMAN} "Mehr ${CPRO_NAME} Skins und Widgets!"	
	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_GERMAN} "Willkomen zum $(^NameDA) Installationsprogramm"
	LangString CPro_Widget_Welcome_Text ${LANG_GERMAN} "Dieser Assistent führt Sie durch die Installation von $(^NameDA).$\r$\n$\r$\nEs wird empfohlen Winamp vor der der Installation zu beenden, um alle relevanten Winamp Dateien zu aktualisieren.$\n$\nSie benötigen mindestens Winamp ${CPRO_WINAMP_VERSION} und ${CPRO_NAME} ${CPRO_VERSION} für diese ${CPRO_WIDGET_NAME} Version!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_GERMAN} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Setup"	
	LangString CPro_Widget_Name_Text ${LANG_GERMAN} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Widget für ClassicPro©"		
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_GERMAN} "Willkomen zum $(^NameDA) Deinstallationsprogramm"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_GERMAN} "Dieser Assistent führt Sie durch die Deinstallation von $(^NameDA).$\r$\n$\r$\nBevor Sie die Deinstallation starten, stellen Sie bitte sicher, dass ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} beendet ist.$\r$\n$\r$\n$_CLICK"
	
; Installer sections
	LangString CPro_Widget_Files ${LANG_GERMAN} "${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} für ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_GERMAN} "Benötigte Dateien für ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} werden istalliert."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_GERMAN} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Installation beendet"
	LangString CPro_Widget_FinishPage_2 ${LANG_GERMAN} "Die Installation von  ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}ist abgeschloßen. Sie können nun Ihr neues ${CPRO_WIDGET_NAME} Widget für ${CPRO_NAME} mit Winamp verwenden."
	LangString CPro_Widget_FinishPage_3 ${LANG_GERMAN} "Wenn Ihnen ${CPRO_WIDGET_NAME} gefällt und Sie die weitere Entwicklung unterstützen wollen, würden wir uns über eine Spende für unser Projekt freuen."
	LangString CPro_Widget_FinishPage_4 ${LANG_GERMAN} "Wie möchten Sie fortfahren?"
	LangString CPro_Widget_FinishPage_5 ${LANG_GERMAN} "Unsere Homepage besuchen und weitere ${CPRO_NAME} Skins und Widgets finden."
	LangString CPro_Widget_FinishPage_6 ${LANG_GERMAN} "Winamp mit dem Standard ${CPRO_NAME} Skin öffnen."
	LangString CPro_Widget_FinishPage_7 ${LANG_GERMAN} "Beenden"		