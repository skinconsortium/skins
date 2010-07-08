;###########################################################################################

; Lang:				Romanian
; LangID			1048
; Last udpdated:	01.09.2009 22:27 EET
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
	LangString CPro_Un_Language_Title ${LANG_ROMANIAN} "Limbã dezinstalare"	
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
	LangString CPro_CleanupPage_Title ${LANG_ROMANIAN} "Reconfigurare Winamp"
	LangString CPro_CleanupPage_Subtitle ${LANG_ROMANIAN} "Eliminare configuraþii Winamp."
	LangString CPro_CleanupPage_Caption0 ${LANG_ROMANIAN} "Alegând opþiunile din aceastã paginã se vor elimina câteva dintre fiºierele de configurare Winamp care ar putea produce disfuncþionalitãþi în utilizarea împreunã a diferite versiuni ale Winamp ºi ${CPRO_NAME}."
	LangString CPro_CleanupPage_Caption1 ${LANG_ROMANIAN} "Dacã întâmpinaþi probleme de funcþionare a ${CPRO_NAME}, puteþi reinstala programul în orice moment ºi folosi aceastã paginã pentru rezolvarea lor."
	LangString CPro_CleanupPage_Caption2 ${LANG_ROMANIAN} "NOTÃ: Totul este în regulã, aceste fiºiere vor fi rescrise de Winamp."
	LangString CPro_CleanupPage_Caption3 ${LANG_ROMANIAN} "Reinstalarea ${CPRO_NAME} cu aceste opþiuni ar trebui folositã numai dacã întâmpinaþi dificultãþi la utilizarea programului împreunã cu Winamp."
	LangString CPro_CleanupPage_Caption4 ${LANG_ROMANIAN} "Vã mulþumim pentru înþelegere."
	LangString CPro_CleanupPage_Footer ${LANG_ROMANIAN} "Dacã încã întâmpinaþi dificultãþi în folosirea ${CPRO_NAME}, cereþi"
	LangString CPro_CleanupPage_TSLink ${LANG_ROMANIAN} "Suport gratuit în Forumurile Skin Consortium."
	LangString CPro_CleanupPage_StudioXnf ${LANG_ROMANIAN} "ªtergere configuraþie interfeþe (studio.xnf)"
	LangString CPro_CleanupPage_StudioXnf_Desc ${LANG_ROMANIAN} "Se eliminã opþiunile specifice interfeþelor, ca: poziþia ferestrei, fila activã, modul de afiºare, ..."
	LangString CPro_CleanupPage_WinampIni ${LANG_ROMANIAN} "ªtergere configuraþie Winamp (winamp.ini)"
	LangString CPro_CleanupPage_WinampIni_Desc ${LANG_ROMANIAN} "Se eliminã opþiunile specifice Winamp, ca: interfaþa curentã, formatarea complexã a titlului, limba curentã, ..."

; Finish Page
	LangString CPro_FinishPage_1 ${LANG_ROMANIAN} "Instalare ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} finalizatã"
	LangString CPro_FinishPage_2 ${LANG_ROMANIAN} "Asistentul a finalizat instalarea ${CPRO_NAME} v${CPRO_VERSION}. Puteþi începe sã folosiþi interfeþele ºi gadgeturile ${CPRO_NAME} în Winamp."
	LangString CPro_FinishPage_3 ${LANG_ROMANIAN} "Dacã vã place ${CPRO_NAME} ºi doriþi sã sprijiniþi dezvolarea ulterioarã, vã rugãm sã faceþi donaþii pentru proiect."
	LangString CPro_FinishPage_4 ${LANG_ROMANIAN} "Acþiuni dupã terminarea instalãrii:"
	LangString CPro_FinishPage_5 ${LANG_ROMANIAN} "Explorare pagina ${CPRO_NAME} ºi descãrcare interfeþe ºi gadgeturi"
	LangString CPro_FinishPage_6 ${LANG_ROMANIAN} "Deschidere Winamp cu interfaþa implicitã ${CPRO_NAME}"
	LangString CPro_FinishPage_7 ${LANG_ROMANIAN} "Terminare"
	LangString CPro_FinishPage_8 ${LANG_ROMANIAN} "Deschidere Winamp cu interfaþa curentã"	
	LangString CPro_FinishPage_9 ${LANG_ROMANIAN} "Do not open Winamp at all"
	
; First Page of Uninstaller
	LangString CPro_Un_Welcome_Title ${LANG_ROMANIAN} "Bun venit la asistentul pentru dezinstalare a $(^NameDA)"
	LangString CPro_Un_Welcome_Text ${LANG_ROMANIAN} "Acest asistent vã va ghida prin procesul de dezinstalare a $(^NameDA).$\r$\n$\r$\nÎnainte de începerea dezinstalãrii, asiguraþi-vã cã ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} nu funcþioneazã.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_ROMANIAN} "Actualizare fiºier de configurare winamp.ini..."
	LangString CPro_Account ${LANG_ROMANIAN} "Configuraþie multi-utilizator"
	LangString CPro_No_Account ${LANG_ROMANIAN} "Configuraþie mono-utilizator"
	LangString CPro_Winamp_Path ${LANG_ROMANIAN} "Specificare dosar fiºier de configurare Winamp..."	
	LangString CPro_Warning_CreateMutex		${LANG_ROMANIAN}	"${CPRO_NAME} v${CPRO_VERSION} installer is already running."
	LangString CPro_Warning_No_Winamp		${LANG_ROMANIAN} "Winamp wasn't detected on this system.$\r$\nPlease install latest Winamp version from Winamp.com,$\r$\nbefore you can install ${CPRO_NAME} v${CPRO_VERSION}.$\r$\nInstallation will be aborted."
	LangString CPro_Warning_Low_Version		${LANG_ROMANIAN} "${CPRO_NAME} v${CPRO_VERSION} requires at least Winamp ${CPRO_WINAMP_VERSION} or above.$\r$\n$\nPlease update your Winamp version first (You have installed: $R0).$\r$\nInstallation will be aborted."
	LangString CPro_Warning_AtLeast_2000	${LANG_ROMANIAN} "Sorry, your system is not supported. ${CPRO_NAME} v${CPRO_VERSION} only runs on Windows 2000 or newer.$\r$\nInstallation will be aborted."

; Close all instances of Winamp
	LangString CPro_CloseWinamp_Welcome_Title ${LANG_ROMANIAN} "Programe de închis"
	LangString CPro_CloseWinamp_Welcome_Text  ${LANG_ROMANIAN} "Programe care trebuie închise înainte de continuarea instalãrii"	
	LangString CPro_CloseWinamp_Heading ${LANG_ROMANIAN} "Închideþi toate programele din listã înainte de a continua instalarea..."
	LangString CPro_CloseWinamp_Searching ${LANG_ROMANIAN} "Cãutare programe... Vã rugãm, aºteptaþi..."
	LangString CPro_CloseWinamp_EndSearch ${LANG_ROMANIAN} "Cãutare programe finalizatã."
	LangString CPro_CloseWinamp_EndMonitor ${LANG_ROMANIAN} "Închidere monitor procese active... Vã rugãm, aºteptaþi..."
	LangString CPro_CloseWinamp_NoPrograms ${LANG_ROMANIAN} "Asistentul nu a gãsit nici un program care trebuie închis."
	LangString CPro_CloseWinamp_ColHeadings1 ${LANG_ROMANIAN} "Program"
	LangString CPro_CloseWinamp_ColHeadings2 ${LANG_ROMANIAN} "Proces"
	LangString CPro_CloseWinamp_Autoclosesilent ${LANG_ROMANIAN} "Închiderea programului a eºuat!"
	LangString CPro_CloseWinamp_MenuItem1 ${LANG_ROMANIAN} "Close"
	LangString CPro_CloseWinamp_MenuItem2 ${LANG_ROMANIAN} "Copy list"
	
; Menu Start
	LangString CPro_MenuStart1 ${LANG_ROMANIAN} "Dezinstalare ${CPRO_NAME}"
	LangString CPro_MenuStart2 ${LANG_ROMANIAN} "Noutãþi"
	LangString CPro_MenuStart3 ${LANG_ROMANIAN} "Mai multe interfeþe ºi gadgeturi ${CPRO_NAME}!"

	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_ROMANIAN} "Bun venit la asistentul pentru instalare a $(^NameDA)"
	LangString CPro_Widget_Welcome_Text ${LANG_ROMANIAN} "Acest asistent vã va ghida în procesul de instalare a $(^NameDA).$\r$\n$\r$\nAveþi nevoie, cel puþin, de Winamp ${CPRO_WINAMP_VERSION} ºi de ${CPRO_NAME} ${CPRO_VERSION} pentru ca aceastã versiune a ${CPRO_WIDGET_NAME} sã funcþioneze!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_ROMANIAN} "Instalare ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}"
	LangString CPro_Widget_Name_Text ${LANG_ROMANIAN} "Gadget ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} pentru ${CPRO_NAME}${CPRO_CRS}"
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_ROMANIAN} "Bun venit la asistentul pentru dezinstalare a $(^NameDA)"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_ROMANIAN} "Acest asistent vã va ghida prin procesul de dezinstalare a $(^NameDA).$\r$\n$\r$\n$_CLICK"

; Installer sections
	LangString CPro_Widget_Files ${LANG_ROMANIAN} "${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} pentru ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_ROMANIAN} "Fiºiere necesare pentru funcþionarea ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION}."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_ROMANIAN} "Instalare ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} finalizatã"
	LangString CPro_Widget_FinishPage_2 ${LANG_ROMANIAN} "Asistentul a finalizat instalarea ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}. Puteþi începe sã folosiþi noul gadget ${CPRO_WIDGET_NAME} pentru ${CPRO_NAME} în Winamp."
	LangString CPro_Widget_FinishPage_3 ${LANG_ROMANIAN} "Dacã vã place ${CPRO_WIDGET_NAME} ºi doriþi sã sprijiniþi dezvolarea ulterioarã, vã rugãm sã faceþi donaþii pentru proiect."
	LangString CPro_Widget_FinishPage_4 ${LANG_ROMANIAN} "Acþiuni dupã terminarea instalãrii:"
	LangString CPro_Widget_FinishPage_5 ${LANG_ROMANIAN} "Explorare paginã ${CPRO_NAME} ºi descãrcare interfeþe ºi gadgeturi"
	LangString CPro_Widget_FinishPage_6 ${LANG_ROMANIAN} "Reîncãrcare ${CPRO_NAME} ºi deschidere în Winamp"
	LangString CPro_Widget_FinishPage_7 ${LANG_ROMANIAN} "Terminare"	
	
; UnFinish Page	
	LangString CPro_Widget_UnFinishPage_1 ${LANG_ROMANIAN} "Finalizare dezinstalare gadget ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} pentru  ${CPRO_NAME}${CPRO_CRS}"
	LangString CPro_Widget_UnFinishPage_2 ${LANG_ROMANIAN} "Gadgetul ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} pentru ${CPRO_NAME}${CPRO_CRS} s-a dezinstalat de pe computerul Dvs."
	LangString CPro_Widget_UnFinishPage_3 ${LANG_ROMANIAN} "Faceþi clic pe $(CPro_Widget_FinishPage_7) pentru a închide asistentul"
	LangString CPro_Widget_UnFinishPage_4 ${LANG_ROMANIAN} "Reîncãrcare ${CPRO_NAME} dacã Winamp este deschis"