;###########################################################################################

; Lang:				German
; LangID			1031
; Last udpdated:	16.05.2009
; Author:			Marko Egger(mynameisnobody)
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
	LangString CPro_Un_Language_Title ${LANG_GERMAN} "Sprache wählen"	
	LangString CPro_Language_Text ${LANG_GERMAN} "Bitte wählen Sie eine Sprache:"

; First Page of Installer
	LangString CPro_Welcome_Title ${LANG_GERMAN} "Willkommen zum $(^NameDA) Installationsprogramm"
	LangString CPro_Welcome_Text ${LANG_GERMAN} "Dieser Assistent führt Sie durch die Installation von $(^NameDA).$\r$\n$\r$\nEs wird empfohlen Winamp vor der der Installation zu beenden, um alle relevanten Winamp Dateien zu aktualisieren.$\n$\nSie benötigen mindestens Winamp ${CPRO_WINAMP_VERSION} für diese ${CPRO_NAME} Version!$\r$\n$\r$\n$_CLICK"

; Installer Header
	!if ${CPRO_BUILD_TYPE} == "BETA"
; Beta stage	
		LangString CPro_Caption ${LANG_GERMAN} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME} Setup"
	!else if ${CPRO_BUILD_TYPE} == "NIGHTLY"
; Alpha stage	
		LangString CPro_Caption ${LANG_GERMAN} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME} (${CPRO_DATE}) Setup"		
	!else
; Release
		LangString CPro_Caption ${LANG_GERMAN} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} Setup"		
	!endif
	
; Installation type	
	LangString CPro_Full ${LANG_GERMAN} "Vollständig"
	LangString CPro_Minimal ${LANG_GERMAN} "Minimal"
	
; Installer sections
	LangString CPro_CProFiles ${LANG_GERMAN} "${CPRO_NAME} Kernkomponenten"
	LangString CPro_wBrowserPro ${LANG_GERMAN} "BrowserPro"
	LangString CPro_wAlbumArt ${LANG_GERMAN} "AlbumArt"
	LangString CPro_WidgetsSection ${LANG_GERMAN} "Widgets"
	LangString CPro_CProCustom ${LANG_GERMAN} "Komponenten"
	LangString CPro_cPlaylistPro ${LANG_GERMAN} "Playlist Suche"
		
; Installer sections descriptions	
	LangString CPro_Desc_CProFiles ${LANG_GERMAN} "${CPRO_NAME} Kernkomponenten(benötigt)."
	LangString CPro_Desc_wBrowserPro ${LANG_GERMAN} "zeigt Informationen ausgewählter Webseiten zum aktuellen Titel, oder den akt. Ordnerinhalt an."
	LangString CPro_Desc_wAlbumArt ${LANG_GERMAN} "zeigt eine große CD-Cover Ansicht und Tag-Informationen zum aktuellen Titel an."
	LangString CPro_Desc_WidgetsSection ${LANG_GERMAN} "Widgets sind vielseitige Erweiterungen für ${CPRO_NAME}."
	LangString CPro_Desc_CProCustom ${LANG_GERMAN} "Optionale Komponenten für ${CPRO_NAME}."
	LangString CPro_Desc_cPlaylistPro ${LANG_GERMAN} "Suchfeld für den Playlist Editor zum einfachen durchsuchen der Playlist."

; Direcory Text	
	LangString CPro_DirText ${LANG_GERMAN} "Bitte den Winamp Installationsordner angeben:$\r$\n(Das Installationsprogramm versucht den korrekten Ordner automatisch zu ermitteln)"

; Cleanup Page	
	LangString CPro_CleanupPage_Title ${LANG_GERMAN} "Winamp Aufräumen"
	LangString CPro_CleanupPage_Subtitle ${LANG_GERMAN} "Winamp Einstellungen aufräumen."
	LangString CPro_CleanupPage_Caption0 ${LANG_GERMAN} "Mit den Optionen auf dieser Seite können Einstellungen von Winamp gelöscht werden, welche nicht über verschiedene Versionen von Winamp und ${CPRO_NAME} hinweg funktionieren."
	LangString CPro_CleanupPage_Caption1 ${LANG_GERMAN} "Falls Probleme mit ${CPRO_NAME} auftreten ist es jederzeit möglich ${CPRO_NAME} erneut zu installieren und mit Hilfe dieser Optionen diese Probleme zu lösen."
	LangString CPro_CleanupPage_Caption2 ${LANG_GERMAN} "ANMERKUNG: Das löschen der Einstellungen ist unbedenklich, sie werden nur erneuert."
	LangString CPro_CleanupPage_Caption3 ${LANG_GERMAN} "Die erneute Installation mit Hilfe dieser Optionen sollte nur durchgeführt werden, falls Probleme mit ${CPRO_NAME} und Winamp auftreten."
	LangString CPro_CleanupPage_Caption4 ${LANG_GERMAN} "Danke für das Verständnis."
	LangString CPro_CleanupPage_Footer ${LANG_GERMAN} "Falls es weiterhin zu Problemen mit ${CPRO_NAME} kommt,"
	LangString CPro_CleanupPage_TSLink ${LANG_GERMAN} "Bitte den kostenlosen Support im Skin Consortium Forum kontaktieren."
	LangString CPro_CleanupPage_StudioXnf ${LANG_GERMAN} "Skin Einstellungen löschen (studio.xnf)"
	LangString CPro_CleanupPage_StudioXnf_Desc ${LANG_GERMAN} "Löscht Skin-spezifische Einstellungen wie: Fenster Positionen, Aktive Reiter, Fenstermodus, ..."
	LangString CPro_CleanupPage_WinampIni ${LANG_GERMAN} "Winamp Einstellungen löschen (winamp.ini)"
	LangString CPro_CleanupPage_WinampIni_Desc ${LANG_GERMAN} "Löscht Winamp-spezifische Einstellungen wie: Aktueller Skin, Erweiterte Titelformatierung,..."

; Finish Page	
	LangString CPro_FinishPage_1 ${LANG_GERMAN} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} Installation beendet"
	LangString CPro_FinishPage_2 ${LANG_GERMAN} "Die Installation von ${CPRO_NAME} v${CPRO_VERSION} ist abgeschloßen. Sie können nun ${CPRO_NAME} Skins and Widgets mit Winamp verwenden."
	LangString CPro_FinishPage_3 ${LANG_GERMAN} "Wenn Ihnen ${CPRO_NAME} gefällt und Sie die weitere Entwicklung unterstützen wollen, würden wir uns über eine Spende für unser Projekt freuen."
	LangString CPro_FinishPage_4 ${LANG_GERMAN} "Wie möchten Sie fortfahren?"
	LangString CPro_FinishPage_5 ${LANG_GERMAN} "Weitere ${CPRO_NAME} Skins und Widgets finden."
	LangString CPro_FinishPage_6 ${LANG_GERMAN} "Winamp mit der Standard ${CPRO_NAME} Skin öffnen"
	LangString CPro_FinishPage_7 ${LANG_GERMAN} "Beenden"	
	LangString CPro_FinishPage_8 ${LANG_GERMAN} "Open Winamp with current skin"
	
; First Page of Uninstaller
	LangString CPro_Un_Welcome_Title ${LANG_GERMAN} "Willkomen zum $(^NameDA) Deinstallationsprogramm"
	LangString CPro_Un_Welcome_Text ${LANG_GERMAN} "Dieser Assistent führt Sie durch die Deinstallation von $(^NameDA).$\r$\n$\r$\nBevor Sie die Deinstallation starten, stellen Sie bitte sicher, dass ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} beendet ist.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_GERMAN} "winamp.ini wird aktualisiert..."
	LangString CPro_Account ${LANG_GERMAN} "Mehr-Benutzer Konfiguration"
	LangString CPro_No_Account ${LANG_GERMAN} "keine Mehr-Benutzer Konfiguration"
	LangString CPro_Winamp_Path ${LANG_GERMAN} "Pfad zur Winamp-Konfigurationsdatei..."	

; Close all instances of Winamp
	LangString CPro_CloseWinamp_Welcome_Title ${LANG_GERMAN} "Laufende Programme beenden"
	LangString CPro_CloseWinamp_Welcome_Text  ${LANG_GERMAN} "Programme, die vor der weiterführun der Installation beendet werden müssen"	
	LangString CPro_CloseWinamp_Heading ${LANG_GERMAN} "Bitte beenden Sie alle aufgelisteten Programme bevor Sie forfahren..."
	LangString CPro_CloseWinamp_Searching ${LANG_GERMAN} "Suche Programme, bitte warten..."
	LangString CPro_CloseWinamp_EndSearch ${LANG_GERMAN} "Suche abgeschlossen..."
	LangString CPro_CloseWinamp_EndMonitor ${LANG_GERMAN} "Beende aktiven Prozess Monitor, bitte warten..."
	LangString CPro_CloseWinamp_NoPrograms ${LANG_GERMAN} "Keine zu beendenden Programme gefunden"
	LangString CPro_CloseWinamp_ColHeadings1 ${LANG_GERMAN} "Applikation"
	LangString CPro_CloseWinamp_ColHeadings2 ${LANG_GERMAN} "Prozess"
	LangString CPro_CloseWinamp_Autoclosesilent ${LANG_GERMAN} "Beenden fehlgeschlagen"

; Menu Start
	LangString CPro_MenuStart1 ${LANG_GERMAN} "${CPRO_NAME} deinstallieren"
	LangString CPro_MenuStart2 ${LANG_GERMAN} "Was ist neu"
	LangString CPro_MenuStart3 ${LANG_GERMAN} "Mehr ${CPRO_NAME} Skins und Widgets!"	

	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_GERMAN} "Willkomen zum $(^NameDA) Installationsprogramm"
	LangString CPro_Widget_Welcome_Text ${LANG_GERMAN} "Dieser Assistent führt Sie durch die Installation von $(^NameDA).$\r$\n$\r$\nSie benötigen mindestens Winamp ${CPRO_WINAMP_VERSION} und ${CPRO_NAME} ${CPRO_VERSION} für diese Version von ${CPRO_WIDGET_NAME}!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_GERMAN} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Setup"	
	LangString CPro_Widget_Name_Text ${LANG_GERMAN} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Widget für ${CPRO_NAME}${CPRO_CRS}"		
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_GERMAN} "Willkomen zum $(^NameDA) Deinstallationsprogramm"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_GERMAN} "Dieser Assistent führt Sie durch die Deinstallation von $(^NameDA).$\r$\n$\r$\n$_CLICK"

; Installer sections
	LangString CPro_Widget_Files ${LANG_GERMAN} "${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} für ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_GERMAN} "Für ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} benötigte Dateien werden installiert."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_GERMAN} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Installation beendet"
	LangString CPro_Widget_FinishPage_2 ${LANG_GERMAN} "Der Assistent hat die Installation von ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} abgeschlossen. Sie können nun ${CPRO_WIDGET_NAME} Widget für ${CPRO_NAME} mit Winamp verwenden."
	LangString CPro_Widget_FinishPage_3 ${LANG_GERMAN} "Wenn Ihnen ${CPRO_WIDGET_NAME} gefällt und Sie die weitere Entwicklung unterstützen wollen, würden wir uns über eine Spende für unser Projekt freuen."
	LangString CPro_Widget_FinishPage_4 ${LANG_GERMAN} "Wie möchten Sie fortfahren?"
	LangString CPro_Widget_FinishPage_5 ${LANG_GERMAN} "unsere Homepage öffnen und weitere ${CPRO_NAME} Widgets finden"
	LangString CPro_Widget_FinishPage_6 ${LANG_GERMAN} "${CPRO_NAME} neu laden oder Winamp starten"
	LangString CPro_Widget_FinishPage_7 ${LANG_GERMAN} "Beenden"	
	
; UnFinish Page	
	LangString CPro_Widget_UnFinishPage_1 ${LANG_GERMAN} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Widget für ${CPRO_NAME}${CPRO_CRS} Deinstallation abschließen"
	LangString CPro_Widget_UnFinishPage_2 ${LANG_GERMAN} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Widget für ${CPRO_NAME}${CPRO_CRS} wurde von Ihrem Computer entfernt."
	LangString CPro_Widget_UnFinishPage_3 ${LANG_GERMAN} "Klicken Sie auf $(CPro_Widget_FinishPage_7) um das Deinstallationsprogramm zu beenden"
	LangString CPro_Widget_UnFinishPage_4 ${LANG_GERMAN} "${CPRO_NAME} neu laden falls Winamp läuft"