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
	LangString CPro_Language_Text ${LANG_ROMANIAN} "Selectaþi o limbã:"

; First Page of Installer
	LangString CPro_Welcome_Title ${LANG_ROMANIAN} "Bun venit la asistentul pentru instalare a $(^NameDA)"
	LangString CPro_Welcome_Text ${LANG_ROMANIAN} "Acest asistent vã va ghida în procesul de instalare a $(^NameDA).$\r$\n$\r$\nSe recomandã închiderea Winamp înainte de începerea instalãrii. Aceasta va face posibilã actualizarea tuturor fiºierelor necesare.$\n$\nAveþi nevoie, cel puþin, de versiunea ${CPRO_WINAMP_VERSION} a Winamp pentru ca aceastã versiune a ${CPRO_NAME} sã funcþioneze!$\r$\n$\r$\n$_CLICK"

; Installer Header
	!ifdef CPRO_BETA
; Beta stage
		LangString CPro_Caption ${LANG_ROMANIAN} "Instalare ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BETA}"
	!else
; Release
		LangString CPro_Caption ${LANG_ROMANIAN} "Instalare ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION}"
	!endif

; Installation type	
	LangString CPro_Full ${LANG_ROMANIAN} "Completã"
	LangString CPro_Minimal ${LANG_ROMANIAN} "Minimalã"

; Installer sections
	LangString CPro_CProFiles ${LANG_ROMANIAN} "Motor ClassicPro"
	LangString CPro_wBrowserPro ${LANG_ROMANIAN} "BrowserPro"
	LangString CPro_wAlbumArt ${LANG_ROMANIAN} "Piesa curentã"
	LangString CPro_WidgetsSection ${LANG_ROMANIAN} "Gadgeturi"
	LangString CPro_CProCustom ${LANG_ROMANIAN} "Componente"
	LangString CPro_cPlaylistPro ${LANG_ROMANIAN} "Cãutare în listã"

; Installer sections descriptions	
	LangString CPro_Desc_CProFiles ${LANG_ROMANIAN} "Fiºiere necesare pentru funcþionarea ClassicPro."
	LangString CPro_Desc_wBrowserPro ${LANG_ROMANIAN} "Gadget care permite navigarea automatã prin saiturile populare ºi explorarea dosarului în curs de redare."
	LangString CPro_Desc_wAlbumArt ${LANG_ROMANIAN} "Gadget care afiºeazã o copertã CD mare ºi informaþii despre piesa în curs de redare."
	LangString CPro_Desc_WidgetsSection ${LANG_ROMANIAN} "Gadgeturi suportate de interfeþele ClassicPro, furnizate împreunã cu acest pachet de instalare."
	LangString CPro_Desc_CProCustom ${LANG_ROMANIAN} "Componente opþionale pentru ClassicPro."
	LangString CPro_Desc_cPlaylistPro ${LANG_ROMANIAN} "Casetã de cãtare adãugatã deasupra gestionarului de liste pentru cãutãri facile în lista de redare."

; Direcory Text
	LangString CPro_DirText ${LANG_ROMANIAN} "Selectaþi dosarul unde a fost instalat Winamp (veþi putea continua dupã ce Winamp a fost detectat):"

; Finish Page
	LangString CPro_FinishPage_1 ${LANG_ROMANIAN} "Instalare ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} finalizatã"
	LangString CPro_FinishPage_2 ${LANG_ROMANIAN} "Asistentul a finalizat instalarea ${CPRO_NAME} v${CPRO_VERSION}. Puteþi începe sã folosiþi interfeþele ºi gadgeturile ${CPRO_NAME} în Winamp."
	LangString CPro_FinishPage_3 ${LANG_ROMANIAN} "Dacã vã place ${CPRO_NAME} ºi doriþi sã sprijiniþi dezvolarea ulterioarã, vã rugãm sã faceþi donaþii pentru proiect."
	LangString CPro_FinishPage_4 ${LANG_ROMANIAN} "Acþiuni dupã terminarea instalãrii:"
	LangString CPro_FinishPage_5 ${LANG_ROMANIAN} "Explorare pagina ${CPRO_NAME} ºi descãrcare interfeþe ºi gadgeturi"
	LangString CPro_FinishPage_6 ${LANG_ROMANIAN} "Deschidere interfaþa implicitã ${CPRO_NAME}"
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
	LangString CPro_Running_Winamp ${LANG_ROMANIAN} "Winamp funcþioneazã!"
	LangString CPro_Close_Winamp  ${LANG_ROMANIAN} "Înainte de a continua, trebuie sã închideþi toate instanþele Winamp!"	
	LangString CPro_Closing_Winamp ${LANG_ROMANIAN} "        Închidere Winamp (winamp.exe)..."
	LangString CPro_No_More_Winamp ${LANG_ROMANIAN} "        Toate instanþele Winamp sunt închise..."  
	LangString CPro_No_Winamp ${LANG_ROMANIAN} "Nici o instanþã Winamp nu este deschisã..."
	LangString CPro_Check_Winamp ${LANG_ROMANIAN} "Verificare instanþe Winamp deschise..."

; Menu Start
	LangString CPro_MenuStart1 ${LANG_ROMANIAN} "Dezinstalare ${CPRO_NAME}"
	LangString CPro_MenuStart2 ${LANG_ROMANIAN} "Ce-i nou"
	LangString CPro_MenuStart3 ${LANG_ROMANIAN} "Mai multe interfeþe ºi gadgeturi ${CPRO_NAME}!"
	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_ROMANIAN} "Bun venit la asistentul pentru instalare a $(^NameDA)"
	LangString CPro_Widget_Welcome_Text ${LANG_ROMANIAN} "Acest asistent vã va ghida în procesul de instalare a $(^NameDA).$\r$\n$\r$\nSe recomandã închiderea Winamp înainte de începerea instalãrii. Aceasta va face posibilã actualizarea tuturor fiºierelor necesare.$\n$\nAveþi nevoie, cel puþin, de versiunea ${CPRO_WINAMP_VERSION} a Winamp ºi de ${CPRO_NAME} ${CPRO_VERSION} pentru ca aceastã versiune a  ${CPRO_WIDGET_NAME} sã funcþioneze!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_ROMANIAN} "Instalare ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}"
	LangString CPro_Widget_Name_Text ${LANG_ROMANIAN} "Gadget ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} pentru ClassicPro©"

; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_ROMANIAN} "Bun venit la asistentul pentru dezinstalare a $(^NameDA)"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_ROMANIAN} "Acest asistent vã va ghida prin procesul de dezinstalare a $(^NameDA).$\r$\n$\r$\nÎnainte de începerea dezinstalãrii, asiguraþi-vã cã ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} nu funcþioneazã.$\r$\n$\r$\n$_CLICK"
	
; Installer sections
	LangString CPro_Widget_Files ${LANG_ROMANIAN} "${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} pentru ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION}"

; Installer sections descriptions
	LangString CPro_Widget_Desc_Files ${LANG_ROMANIAN} "Fiºiere necesare pentru funcþionarea ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION}."

; Finish Page
	LangString CPro_Widget_FinishPage_1 ${LANG_ROMANIAN} "Instalare ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} finalizatã"
	LangString CPro_Widget_FinishPage_2 ${LANG_ROMANIAN} "Asistentul a finalizat instalarea ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}. Puteþi începe sã folosiþi noul gadget ${CPRO_WIDGET_NAME} pentru ${CPRO_NAME} în Winamp."
	LangString CPro_Widget_FinishPage_3 ${LANG_ROMANIAN} "Dacã vã place ${CPRO_WIDGET_NAME} ºi doriþi sã sprijiniþi dezvolarea ulterioarã, vã rugãm sã faceþi donaþii pentru proiect."
	LangString CPro_Widget_FinishPage_4 ${LANG_ROMANIAN} "Acþiuni dupã terminarea instalãrii:"
	LangString CPro_Widget_FinishPage_5 ${LANG_ROMANIAN} "Explorare pagina ${CPRO_NAME} ºi descãrcare interfeþe ºi gadgeturi"
	LangString CPro_Widget_FinishPage_6 ${LANG_ROMANIAN} "Deschidere interfaþa implicitã ${CPRO_NAME}"
	LangString CPro_Widget_FinishPage_7 ${LANG_ROMANIAN} "Terminare"

