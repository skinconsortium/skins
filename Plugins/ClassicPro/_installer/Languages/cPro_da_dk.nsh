;###########################################################################################

; Lang:		         	Danish
; LangID			    1030
; Last udpdated:		09.05.2009
; Author:			    Andreas Brandenborg
; Email:		       	brandenborg@gmail.com

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
	LangString CPro_Language_Title ${LANG_DANISH} "Installations sprog"
	LangString CPro_Un_Language_Title ${LANG_DANISH} "Uninstaller language"	
	LangString CPro_Language_Text ${LANG_DANISH} "Vælg venligst et sprog:"

; First Page of Installer
	LangString CPro_Welcome_Title ${LANG_DANISH} "Velkommen til $(^NameDA) installationen"
	LangString CPro_Welcome_Text ${LANG_DANISH} "Denne guide vil hjælpe dig igennem installationen af $(^NameDA).$\r$\n$\r$\nDet er anbefalet at lukke Winamp før installations start. Dette vil gøre det muligt at opdatere alle relevante Winamp filer.$\n$\nDu skal minimum have Winamp ${CPRO_WINAMP_VERSION} for denne version af ${CPRO_NAME} for at fungere!$\r$\n$\r$\n$_CLICK"

; Installer Header
	!if ${CPRO_BUILD_TYPE} == "BETA"
; Beta stage	
		LangString CPro_Caption ${LANG_DANISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME} Opsætning"
	!else if ${CPRO_BUILD_TYPE} == "NIGHTLY"
; Alpha stage	
		LangString CPro_Caption ${LANG_DANISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME} (${CPRO_DATE}) Opsætning"		
	!else
; Release
		LangString CPro_Caption ${LANG_DANISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} Opsætning"		
	!endif
	
; Installation type	
	LangString CPro_Full ${LANG_DANISH} "Komplet"
	LangString CPro_Minimal ${LANG_DANISH} "Minimal"
	
; Installer sections
	LangString CPro_CProFiles ${LANG_DANISH} "${CPRO_NAME} Motoren"
	LangString CPro_wBrowserPro ${LANG_DANISH} "BrowserPro"
	LangString CPro_wAlbumArt ${LANG_DANISH} "Now Playing"
	LangString CPro_WidgetsSection ${LANG_DANISH} "Widgets"
	LangString CPro_CProCustom ${LANG_DANISH} "Komponenter"
	LangString CPro_cPlaylistPro ${LANG_DANISH} "Playlist Søgning"
		
; Installer sections descriptions	
	LangString CPro_Desc_CProFiles ${LANG_DANISH} "Dette vil installere alle filer nødvendige for at ${CPRO_NAME} kan fungere."
	LangString CPro_Desc_wBrowserPro ${LANG_DANISH} "BrowserPro er en widget der muliggører din browser at auto navigere til populære hjemmesider, og udforske afspilnings biblioteket."
	LangString CPro_Desc_wAlbumArt ${LANG_DANISH} "Now Playing er en widget der viser et stort cd cover og information omkring den afspillende fil."
	LangString CPro_Desc_WidgetsSection ${LANG_DANISH} "${CPRO_NAME} skins understøtter widgets og her kan du finde nogle af dem vi besluttede at inkludere i denne installation."
	LangString CPro_Desc_CProCustom ${LANG_DANISH} "Valgfrie komponenter for ${CPRO_NAME}."
	LangString CPro_Desc_cPlaylistPro ${LANG_DANISH} "Tilføj en søgeboks over din afspilningsliste for nemme søgninger i din liste."

; Direcory Text	
	LangString CPro_DirText ${LANG_DANISH} "Vælg venligst din Winamp destination (du vil være i stand til at fortsætte når Winamp er fundet):"

; Cleanup Page	
	LangString CPro_CleanupPage_Title ${LANG_DANISH} "Winamp oprydning"
	LangString CPro_CleanupPage_Subtitle ${LANG_DANISH} "Rengør nogle Winamp indstillinger."
	LangString CPro_CleanupPage_Caption0 ${LANG_DANISH} "Ved brug af valgmuligheder på denne side vil fjerne nogle Winamp konfigurations filer som måske ikke virker på kryds af forskellige versioner af både Winamp og ${CPRO_NAME}."
	LangString CPro_CleanupPage_Caption1 ${LANG_DANISH} "Hvis du har problemer med at få ${CPRO_NAME} til at køre ordenligt kan du re-installere ${CPRO_NAME} på hvilket som helst tidspunkt og benytte denne side til at ordne dine problemer."
	LangString CPro_CleanupPage_Caption2 ${LANG_DANISH} "NOTAT: Det er helt iorden, disse filer vil blive gendannet til standard af Winamp."
	LangString CPro_CleanupPage_Caption3 ${LANG_DANISH} "Re-installering med disse muligheder bør kun benyttes hvis du er ude for problemer ved brug af ${CPRO_NAME} med Winamp."
	LangString CPro_CleanupPage_Caption4 ${LANG_DANISH} "Tak for din forståelse."
	LangString CPro_CleanupPage_Footer ${LANG_DANISH} "Hvis der stadig opstår problemer ved brug af ${CPRO_NAME},"
	LangString CPro_CleanupPage_TSLink ${LANG_DANISH} "Sprøg efter gratis assistance i Skin Consortiums forum."
	LangString CPro_CleanupPage_StudioXnf ${LANG_DANISH} "Fjern skin konfiguration (studio.xnf)"
	LangString CPro_CleanupPage_StudioXnf_Desc ${LANG_DANISH} "Fjerner skin specifike indstillinger som: vindue position, aktive tabs, nuværende windowmode, ..."
	LangString CPro_CleanupPage_WinampIni ${LANG_DANISH} "Fjern Winamp konfiguration (winamp.ini)"
	LangString CPro_CleanupPage_WinampIni_Desc ${LANG_DANISH} "Fjerner winamp specifike indstillinger som: nuværende skin, advanceret titel formattering, nuværende sprog, ..."

; Finish Page	
	LangString CPro_FinishPage_1 ${LANG_DANISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} installation færdig"
	LangString CPro_FinishPage_2 ${LANG_DANISH} "Guiden har udført installationen af ${CPRO_NAME} v${CPRO_VERSION}. Du kan nu starte med at benytte ${CPRO_NAME} skins og widgets i Winamp."
	LangString CPro_FinishPage_3 ${LANG_DANISH} "Hvis du holder af ${CPRO_NAME} og gerne vil se fremtidig udvikling af dette produkt donér venligst til projektet."
	LangString CPro_FinishPage_4 ${LANG_DANISH} "Hvad vil du nu?"
	LangString CPro_FinishPage_5 ${LANG_DANISH} "Gå til vores hjemmeside for at få flere ${CPRO_NAME} skins og widgets"
	LangString CPro_FinishPage_6 ${LANG_DANISH} "Åben standard ${CPRO_NAME} skin nu"
	LangString CPro_FinishPage_7 ${LANG_DANISH} "Afslut"	
	
; First Page of Uninstaller
	LangString CPro_Un_Welcome_Title ${LANG_DANISH} "Velkommen til $(^NameDA) Afinstallations Guiden"
	LangString CPro_Un_Welcome_Text ${LANG_DANISH} "Guiden vil hjælpe dig igennem afinstallationen af $(^NameDA).$\r$\n$\r$\nFør du starter afinstalleringen, vær sikker på ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ikke kører.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_DANISH} "Opdaterer winamp.ini konfigurations filen..."
	LangString CPro_Account ${LANG_DANISH} "Flerbruger indstillinger"
	LangString CPro_No_Account ${LANG_DANISH} "Ingen Flerbruger indstillinger"
	LangString CPro_Winamp_Path ${LANG_DANISH} "Specifér sti til Winamp konfigurations filen..."

; Close all instances of Winamp
	LangString CPro_CloseWinamp_Welcome_Title ${LANG_DANISH} "Programs to close"
	LangString CPro_CloseWinamp_Welcome_Text  ${LANG_DANISH} "Programs, that must be closed before continuing installation"	
	LangString CPro_CloseWinamp_Heading ${LANG_DANISH} "Close all programs from the list before continuing installation..."
	LangString CPro_CloseWinamp_Searching ${LANG_DANISH} "Searching programs, please wait..."
	LangString CPro_CloseWinamp_EndSearch ${LANG_DANISH} "Searching programs finished..."
	LangString CPro_CloseWinamp_EndMonitor ${LANG_DANISH} "Closing active process monitor, please wait..."
	LangString CPro_CloseWinamp_NoPrograms ${LANG_DANISH} "Installer didn't find any programs to close"
	LangString CPro_CloseWinamp_ColHeadings1 ${LANG_DANISH} "Application"
	LangString CPro_CloseWinamp_ColHeadings2 ${LANG_DANISH} "Process"
	LangString CPro_CloseWinamp_Autoclosesilent ${LANG_DANISH} "Closing program failed"

; Menu Start
	LangString CPro_MenuStart1 ${LANG_DANISH} "Afinstaller ${CPRO_NAME}"
	LangString CPro_MenuStart2 ${LANG_DANISH} "Hvad der er nyt"
	LangString CPro_MenuStart3 ${LANG_DANISH} "Få flere ${CPRO_NAME} skins og widgets!"	

	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_DANISH} "Welcome to the $(^NameDA) Setup Wizard"
	LangString CPro_Widget_Welcome_Text ${LANG_DANISH} "This wizard will guide you through the installation of $(^NameDA).$\r$\n$\r$\nYou'll at least need Winamp ${CPRO_WINAMP_VERSION} and ${CPRO_NAME} ${CPRO_VERSION} for this version of ${CPRO_WIDGET_NAME} to work!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_DANISH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Setup"	
	LangString CPro_Widget_Name_Text ${LANG_DANISH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS}"		
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_DANISH} "Welcome to the $(^NameDA) Uninstall Wizard"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_DANISH} "This wizard will guide you through the uninstallation of $(^NameDA).$\r$\n$\r$\n$_CLICK"

; Installer sections
	LangString CPro_Widget_Files ${LANG_DANISH} "${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} for ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_DANISH} "This will install all the files that ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} needs to work."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_DANISH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} installation finished"
	LangString CPro_Widget_FinishPage_2 ${LANG_DANISH} "The setup wizard has finished installing ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}. You can now start using your new ${CPRO_WIDGET_NAME} widget for ${CPRO_NAME} in Winamp."
	LangString CPro_Widget_FinishPage_3 ${LANG_DANISH} "If you like ${CPRO_WIDGET_NAME} and would like to help future development of the product please donate to the project."
	LangString CPro_Widget_FinishPage_4 ${LANG_DANISH} "What do you want to do now?"
	LangString CPro_Widget_FinishPage_5 ${LANG_DANISH} "Go to our homepage to get more ${CPRO_NAME} widgets"
	LangString CPro_Widget_FinishPage_6 ${LANG_DANISH} "Reload ${CPRO_NAME} or open Winamp now"
	LangString CPro_Widget_FinishPage_7 ${LANG_DANISH} "Finish"	
	
; UnFinish Page	
	LangString CPro_Widget_UnFinishPage_1 ${LANG_DANISH} "Completing the ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS} Uninstall Wizard"
	LangString CPro_Widget_UnFinishPage_2 ${LANG_DANISH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS} has been uninstalled from your computer."
	LangString CPro_Widget_UnFinishPage_3 ${LANG_DANISH} "Click $(CPro_Widget_FinishPage_7) to close this wizard"
	LangString CPro_Widget_UnFinishPage_4 ${LANG_DANISH} "Reload ${CPRO_NAME} if Winamp is running"