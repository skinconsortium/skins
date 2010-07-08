;###########################################################################################

; Lang:				Dutch
; LangID			1043
; Last udpdated:	24.02.2009
; Author:			Muhda
; Email:			mohamed_dahhouch@hotmail.com

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
	LangString CPro_Language_Title ${LANG_DUTCH} "Installatie taal"
	LangString CPro_Un_Language_Title ${LANG_DUTCH} "Uninstallatie taal"	
	LangString CPro_Language_Text ${LANG_DUTCH} "Kies een Taal alsjeblieft:"

; First Page of Installer
	LangString CPro_Welcome_Title ${LANG_DUTCH} "Welcome Bij de $(^NameDA) Setup Wizard"
	LangString CPro_Welcome_Text ${LANG_DUTCH} "Deze wizard zal u helpen bij de installatie van $(^NameDA).$\r$\n$\r$\nHet is aanbevolen dat u Winamp afsluit voor het starten van de Setup. Dit maakt het mogelijk om alle relevante winamp bestanden te updaten.$\n$\nU zal ten minste Winamp ${CPRO_WINAMP_VERSION} nodig moeten hebben om deze versie van ${CPRO_NAME} correct te laten werken!$\r$\n$\r$\n$_CLICK"

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
	LangString CPro_Full ${LANG_DUTCH} "volledig"
	LangString CPro_Minimal ${LANG_DUTCH} "Minimaal"
	
; Installer sections
	LangString CPro_CProFiles ${LANG_DUTCH} "${CPRO_NAME} Engine"
	LangString CPro_wBrowserPro ${LANG_DUTCH} "BrowserPro"
	LangString CPro_wAlbumArt ${LANG_DUTCH} "Now Playing"
	LangString CPro_WidgetsSection ${LANG_DUTCH} "Widgets"
	LangString CPro_CProCustom ${LANG_DUTCH} "Components"
	LangString CPro_cPlaylistPro ${LANG_DUTCH} "Playlist Search"
		
; Installer sections descriptions	
	LangString CPro_Desc_CProFiles ${LANG_DUTCH} "Dit installeert alle bestanden die ${CPRO_NAME} nodig heeft om te werken."
	LangString CPro_Desc_wBrowserPro ${LANG_DUTCH} "BrowserPro is een widget dat jouw automatisch naar populaire websites en door het directory afspelen laat navigeren."
	LangString CPro_Desc_wAlbumArt ${LANG_DUTCH} "Now Playing is een widget dat een groot cd cover en informatie over de afspelende bestand laat zien."
	LangString CPro_Desc_WidgetsSection ${LANG_DUTCH} "${CPRO_NAME} skins ondersteunen widgets en hier zul je een paar vinden die we gebundeld hebben met de installer."
	LangString CPro_Desc_CProCustom ${LANG_DUTCH} "Optionele componenten voor ${CPRO_NAME}."
	LangString CPro_Desc_cPlaylistPro ${LANG_DUTCH} "Voegt een zoekbalk boven je afspeellijst , om makkelijk te zoeken in je afspeellijst."

; Direcory Text	
	LangString CPro_DirText ${LANG_DUTCH} "Seleceer jouw Winamp Instalatie pad (u kunt verder gaan als de instalatie pad van Winamp is gedetecteerd) :"

; Cleanup Page	
	LangString CPro_CleanupPage_Title ${LANG_DUTCH} "Winamp Cleanup"
	LangString CPro_CleanupPage_Subtitle ${LANG_DUTCH} "Ruim sommige Winamp voorkeuren op."
	LangString CPro_CleanupPage_Caption0 ${LANG_DUTCH} "Met behulp van de opties op deze pagina, zullen sommige Winamp Configuratie bestanden worden verwijdert die niet kunnen samenwerken met verschillende versies van Winamp ${CPRO_NAME}."
	LangString CPro_CleanupPage_Caption1 ${LANG_DUTCH} "Heeft u problemen om ${CPRO_NAME} correct te laten werken, dan kunt u ${CPRO_NAME} op elke moment her-installeren en deze pagina gebruiken om je problemen op te lossen."
	LangString CPro_CleanupPage_Caption2 ${LANG_DUTCH} "NOTE: Het is volkomen in orde!, deze bestanden zullen door Winamp herbouwd worden."
	LangString CPro_CleanupPage_Caption3 ${LANG_DUTCH} "Herinstalleren met deze opties, mag alleen worden gebruikt als u problemen ervaart met ${CPRO_NAME} in Winamp."
	LangString CPro_CleanupPage_Caption4 ${LANG_DUTCH} "Dank u wel voor uw begrip ."
	LangString CPro_CleanupPage_Footer ${LANG_DUTCH} "Als u nog steeds problemen heeft met het gebruik van ${CPRO_NAME},"
	LangString CPro_CleanupPage_TSLink ${LANG_DUTCH} "Vraag gratis om hulp in de Skin Consortium Forums."
	LangString CPro_CleanupPage_StudioXnf ${LANG_DUTCH} "Verwijder Skin Configuratie (studio.xnf)"
	LangString CPro_CleanupPage_StudioXnf_Desc ${LANG_DUTCH} "Verwijdert specifieke-skins instellingen zoals: window posities, active tabs, huidige windowmode, ..."
	LangString CPro_CleanupPage_WinampIni ${LANG_DUTCH} "Verwijdert Winamp Configuratie (winamp.ini)"
	LangString CPro_CleanupPage_WinampIni_Desc ${LANG_DUTCH} "Verwijdert winamp-specifieke instellingen zoals: huidige skin, geavanceerde title formatting, huidige taal, ..."

; Finish Page	
	LangString CPro_FinishPage_1 ${LANG_DUTCH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} installatie is klaar"
	LangString CPro_FinishPage_2 ${LANG_DUTCH} "The setup wizard is klaar met installeren ${CPRO_NAME} v${CPRO_VERSION}. U kunt nu gebruik maken van ${CPRO_NAME} skins and widgets in Winamp."
	LangString CPro_FinishPage_3 ${LANG_DUTCH} "Als u ${CPRO_NAME} Bevalt, en u wilt toekomstige ontwikkeling van het product ondersteunen dan kunt u een donatie geven aan het project."
	LangString CPro_FinishPage_4 ${LANG_DUTCH} "Wat wilt u nu doen?"
	LangString CPro_FinishPage_5 ${LANG_DUTCH} "Ga naar onze homepage voor meer ${CPRO_NAME} skins and widgets"
	LangString CPro_FinishPage_6 ${LANG_DUTCH} "Open Winamp met de standaard ${CPRO_NAME} skin nu"
	LangString CPro_FinishPage_7 ${LANG_DUTCH} "Klaar"
	LangString CPro_FinishPage_8 ${LANG_DUTCH} "Open Winamp with current skin"	
	LangString CPro_FinishPage_9 ${LANG_DUTCH} "Do not open Winamp at all"
	
; First Page of Uninstaller
	LangString CPro_Un_Welcome_Title ${LANG_DUTCH} "Welkom bij de $(^NameDA) Uninstall Wizard"
	LangString CPro_Un_Welcome_Text ${LANG_DUTCH} "Deze Wizard zal u helpen bij de uninstallatie van $(^NameDA).$\r$\n$\r$\nVoor het starten van de uninstallatie, weet dan zeker of ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} Afgesloten is.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_DUTCH} "Update de winamp.ini configuratie bestand..."
	LangString CPro_Account ${LANG_DUTCH} "Multi-gebruikers instellingen"
	LangString CPro_No_Account ${LANG_DUTCH} "Geen Multi-gebruikers instellingen"
	LangString CPro_Winamp_Path ${LANG_DUTCH} "pad naar Winamp configuratie bestand Specificeren..."	
	LangString CPro_Warning_CreateMutex		${LANG_DUTCH}	"${CPRO_NAME} v${CPRO_VERSION} installer is already running."
	LangString CPro_Warning_No_Winamp		${LANG_DUTCH} "Winamp wasn't detected on this system.$\r$\nPlease install latest Winamp version from Winamp.com,$\r$\nbefore you can install ${CPRO_NAME} v${CPRO_VERSION}.$\r$\nInstallation will be aborted."
	LangString CPro_Warning_Low_Version		${LANG_DUTCH} "${CPRO_NAME} v${CPRO_VERSION} requires at least Winamp ${CPRO_WINAMP_VERSION} or above.$\r$\n$\nPlease update your Winamp version first (You have installed: $R0).$\r$\nInstallation will be aborted."
	LangString CPro_Warning_AtLeast_2000	${LANG_DUTCH} "Sorry, your system is not supported. ${CPRO_NAME} v${CPRO_VERSION} only runs on Windows 2000 or newer.$\r$\nInstallation will be aborted."

; Close all instances of Winamp
	LangString CPro_CloseWinamp_Welcome_Title ${LANG_DUTCH} "Programma's die afgesloten moeten worden"
	LangString CPro_CloseWinamp_Welcome_Text  ${LANG_DUTCH} "Programma's, die afgesloten moeten worden voor dat u verder gaat met de instalatie"	
	LangString CPro_CloseWinamp_Heading ${LANG_DUTCH} "Sluit alle programma's af die in de lijst staan voor dat u verder gaat met de instalatie..."
	LangString CPro_CloseWinamp_Searching ${LANG_DUTCH} "Programma's zoeken, ogenblik geduld..."
	LangString CPro_CloseWinamp_EndSearch ${LANG_DUTCH} "Programma zoeken klaar..."
	LangString CPro_CloseWinamp_EndMonitor ${LANG_DUTCH} "Active process monitor Afsluiten, ogenblik geduld..."
	LangString CPro_CloseWinamp_NoPrograms ${LANG_DUTCH} "Installer heeft geen programma's gevonden om af te sluiten"
	LangString CPro_CloseWinamp_ColHeadings1 ${LANG_DUTCH} "Applicatie"
	LangString CPro_CloseWinamp_ColHeadings2 ${LANG_DUTCH} "Proces"
	LangString CPro_CloseWinamp_Autoclosesilent ${LANG_DUTCH} "Programa Afsluiten is mislukt"
	LangString CPro_CloseWinamp_MenuItem1 ${LANG_DUTCH} "Close"
	LangString CPro_CloseWinamp_MenuItem2 ${LANG_DUTCH} "Copy list"
	
; Menu Start
	LangString CPro_MenuStart1 ${LANG_DUTCH} "Uninstall ${CPRO_NAME}"
	LangString CPro_MenuStart2 ${LANG_DUTCH} "Wat is nieuw?"
	LangString CPro_MenuStart3 ${LANG_DUTCH} "Verkrijg meer ${CPRO_NAME} skins and widgets!"	

	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_DUTCH} "Welkom bij de $(^NameDA) Setup Wizard"
	LangString CPro_Widget_Welcome_Text ${LANG_DUTCH} "Deze wizard zal u helpen bij de installatie van $(^NameDA).$\r$\n$\r$\nU hebt tenminste Winamp ${CPRO_WINAMP_VERSION} en ${CPRO_NAME} ${CPRO_VERSION} om deze versie van ${CPRO_WIDGET_NAME} correct te laten werken!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_DUTCH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Setup"	
	LangString CPro_Widget_Name_Text ${LANG_DUTCH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget voor ${CPRO_NAME}${CPRO_CRS}"		
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_DUTCH} "Welkom bij de $(^NameDA) Uninstall Wizard"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_DUTCH} "Deze wizard zal u helpen bij de uninstallatie van $(^NameDA).$\r$\n$\r$\n$_CLICK"

; Installer sections
	LangString CPro_Widget_Files ${LANG_DUTCH} "${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} voor ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_DUTCH} "Dit installeert alle bestanden die ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} nodig heeft om correct te kunnen werken."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_DUTCH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} installatie is klaar"
	LangString CPro_Widget_FinishPage_2 ${LANG_DUTCH} "De setup wizard is klaar met de installatie ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}. U kunt nu gebruik maken van de nieuwe ${CPRO_WIDGET_NAME} widget voor ${CPRO_NAME} in Winamp."
	LangString CPro_Widget_FinishPage_3 ${LANG_DUTCH} "Als u ${CPRO_WIDGET_NAME} Bevalt, en u wilt toekomstige ontwikkeling van het product ondersteunen dan kunt u een donatie geven aan het project."
	LangString CPro_Widget_FinishPage_4 ${LANG_DUTCH} "Wat wilt u nu doen?"
	LangString CPro_Widget_FinishPage_5 ${LANG_DUTCH} "Ga naar onze homepage voor meer ${CPRO_NAME} widgets"
	LangString CPro_Widget_FinishPage_6 ${LANG_DUTCH} "Herlaad ${CPRO_NAME} of open Winamp nu"
	LangString CPro_Widget_FinishPage_7 ${LANG_DUTCH} "Klaar"	
	
; UnFinish Page	
	LangString CPro_Widget_UnFinishPage_1 ${LANG_DUTCH} "Voltooiing van ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget voor ${CPRO_NAME}${CPRO_CRS} Uninstall Wizard"
	LangString CPro_Widget_UnFinishPage_2 ${LANG_DUTCH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget voor ${CPRO_NAME}${CPRO_CRS} is ge-uninstalleerd van you computer."
	LangString CPro_Widget_UnFinishPage_3 ${LANG_DUTCH} "klik $(CPro_Widget_FinishPage_7) om de wizard af te sluiten"
	LangString CPro_Widget_UnFinishPage_4 ${LANG_DUTCH} "Herlaad ${CPRO_NAME} als Winamp open is"