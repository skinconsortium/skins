;###########################################################################################

; Lang:				Polish
; LangID			1045
; Last udpdated:	03.05.2009
; Author:			Pawe³ Porwisz
; Email:			pawelporwisz@gmail.com

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
	LangString CPro_Language_Title ${LANG_POLISH} "Jêzyk instalatora"
	LangString CPro_Un_Language_Title ${LANG_POLISH} "Jêzyk deinstalatora"	
	LangString CPro_Language_Text ${LANG_POLISH} "Proszê wybraæ jêzyk:"
 
; First Page of Installer
	LangString CPro_Welcome_Title ${LANG_POLISH} "Witam w kreatorze instalacji $(^NameDA)"
	LangString CPro_Welcome_Text ${LANG_POLISH} "Ten kreator pomo¿e Ci zainstalowaæ $(^NameDA).$\r$\n$\r$\nPrzed rozpoczêciem instalacji zalecane jest zamkniêcie Winampa. Pozwoli to na uaktualnienie niezbêdnych plików programu Winamp.$\n$\nDo prawid³owej pracy tej wersji ${CPRO_NAME} musisz mieæ zainstalowanego Winampa w wersji ${CPRO_WINAMP_VERSION} lub nowszego!$\r$\n$\r$\n$_CLICK"

; Installer Header
	!if ${CPRO_BUILD_TYPE} == "BETA"
; Beta stage	
		LangString CPro_Caption ${LANG_POLISH} "Instalacja ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME}"
	!else if ${CPRO_BUILD_TYPE} == "NIGHTLY"
; Alpha stage	
		LangString CPro_Caption ${LANG_POLISH} "Instalacja ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME} (${CPRO_DATE})"		
	!else
; Release
		LangString CPro_Caption ${LANG_POLISH} "Instalacja ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION}"		
	!endif
	
; Installation type
	LangString CPro_Full ${LANG_POLISH} "Pe³na"
	LangString CPro_Minimal ${LANG_POLISH} "Minimalna"
	
; Installer sections	
	LangString CPro_CProFiles ${LANG_POLISH} "Silnik ${CPRO_NAME}"
	LangString CPro_wBrowserPro ${LANG_POLISH} "Przegl¹darka BrowserPro"
	LangString CPro_wAlbumArt ${LANG_POLISH} "Now Playing (Teraz odtwarzane)"
	LangString CPro_WidgetsSection ${LANG_POLISH} "Wid¿ety"
	LangString CPro_CProCustom ${LANG_POLISH} "Sk³adniki"
	LangString CPro_cPlaylistPro ${LANG_POLISH} "Przeszukiwanie listy odtwarzania"
	
; Installer sections descriptions	
	LangString CPro_Desc_CProFiles ${LANG_POLISH} "Instalacja wszystkich plików niezbêdnych do pracy ${CPRO_NAME}."
	LangString CPro_Desc_wBrowserPro ${LANG_POLISH} "BrowserPro jest wid¿etem umo¿liwiaj¹cym nawigacje do popularnych witryn i katalogu odtwarzanego utworu."
	LangString CPro_Desc_wAlbumArt ${LANG_POLISH} "Now Playing jest wid¿etem, który wyœwietla du¿e ok³adki albumów oraz informacje o odtwarzanym utworze."
	LangString CPro_Desc_WidgetsSection ${LANG_POLISH} "Skórki ${CPRO_NAME} obs³uguj¹ wid¿ety. Te rozprowadzane z instalatorem ${CPRO_NAME}, znajdziesz w tej sekcji."
	LangString CPro_Desc_CProCustom ${LANG_POLISH} "Opcjonalne komponenty dla ${CPRO_NAME}."
	LangString CPro_Desc_cPlaylistPro ${LANG_POLISH} "Dodaje pole wyszukiwania nad list¹ odtwarzania, do ³atwego jej przeszukiwania."

; Direcory Text
	LangString CPro_DirText ${LANG_POLISH} "Wybierz œcie¿kê dostêpu do Winampa (mo¿liwa bedzie kontynuacja, gdy instalator wykryje zainstalowanego Winampa):"

; Cleanup Page
	LangString CPro_CleanupPage_Title ${LANG_POLISH} "Usuwanie ustawieñ Winampa"
	LangString CPro_CleanupPage_Subtitle ${LANG_POLISH} "Usuñ niektóre preferencje Winampa."
	LangString CPro_CleanupPage_Caption0 ${LANG_POLISH} "Dziêki opcjom znajduj¹cym siê na tej stronie, usuniesz niektóre pliki konfiguracyjne Winampa, który z powodu ró¿nych wersji móg³ nie dzia³aæ prawid³owo z okreœlon¹ wersj¹ ${CPRO_NAME}."
	LangString CPro_CleanupPage_Caption1 ${LANG_POLISH} "Jeœli masz problemy z poprawnym dzia³aniem ${CPRO_NAME}, mo¿esz w ka¿dym momencie ponownie zainstalowaæ ${CPRO_NAME} i u¿yæ tej strony do rozwi¹zania tych problemów."
	LangString CPro_CleanupPage_Caption2 ${LANG_POLISH} "UWAGA: Nie ma siê czego obawiaæ, zostan¹ one automatycznie odtworzone przez Winampa."
	LangString CPro_CleanupPage_Caption3 ${LANG_POLISH} "Opcji tych jednak powinieneœ u¿ywaæ tylko wtedy, gdy masz problemy z u¿ywaniem ${CPRO_NAME} z Winampem."
	LangString CPro_CleanupPage_Caption4 ${LANG_POLISH} "Dziêkujemy za wyrozumia³oœæ."
	LangString CPro_CleanupPage_Footer ${LANG_POLISH} "Jeœli wci¹¿ masz problemy z u¿ywaniem ${CPRO_NAME},"
	LangString CPro_CleanupPage_TSLink ${LANG_POLISH} "poproœ o bezp³atne wsparcie techniczne na forum Skin Consortium."
	LangString CPro_CleanupPage_StudioXnf ${LANG_POLISH} "Usuñ plik konfiguracyjny skórki (studio.xnf)"
	LangString CPro_CleanupPage_StudioXnf_Desc ${LANG_POLISH} "Usuwa ustawienia skórki, takie jak: pozycja okna, aktywne zak³adki, bie¿¹cy tryb okna, ..."
	LangString CPro_CleanupPage_WinampIni ${LANG_POLISH} "Usuñ plik konfiguracyjny Winampa (winamp.ini)"
	LangString CPro_CleanupPage_WinampIni_Desc ${LANG_POLISH} "Usuwa ustawienia Winampa, takie jak: bie¿¹ca skórka, zaawans. form. tytu³ów, bie¿¹cy jêzyk, ..."

; Finish Page
	LangString CPro_FinishPage_1 ${LANG_POLISH} "Zakoñczono instalacjê ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION}"
	LangString CPro_FinishPage_2 ${LANG_POLISH} "Kreator instalacji zakoñczy³ instalowanie ${CPRO_NAME} v${CPRO_VERSION}. Mo¿esz zacz¹æ u¿ywaæ skórek i wid¿etów ${CPRO_NAME} w Winampie."
	LangString CPro_FinishPage_3 ${LANG_POLISH} "Jeœli podoba ci siê ${CPRO_NAME} i chcesz wspomóc dalszy rozwój projektu, wesprzyj nas dowoln¹ kwot¹."
	LangString CPro_FinishPage_4 ${LANG_POLISH} "Co chcesz teraz zrobiæ?"
	LangString CPro_FinishPage_5 ${LANG_POLISH} "Pobierz wiêcej skórek i wid¿etów ze strony ${CPRO_NAME}"
	LangString CPro_FinishPage_6 ${LANG_POLISH} "Otwórz Winampa z domyœln¹ skórk¹ ${CPRO_NAME}"
	LangString CPro_FinishPage_7 ${LANG_POLISH} "Zakoñcz"
	LangString CPro_FinishPage_8 ${LANG_POLISH} "Otwórz Winampa z bie¿¹c¹ skórk¹"	

; First Page of Uninstaller
	LangString CPro_Un_Welcome_Title ${LANG_POLISH} "Witam w kreatorze dezinstalacji $(^NameDA)"
	LangString CPro_Un_Welcome_Text ${LANG_POLISH} "Ten kreator pomo¿e Ci odinstalowaæ $(^NameDA).$\r$\n$\r$\nPrzed rozpoczêciem dezinstalacji, upewnij siê, ¿e ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION} nie jest uruchomiony.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_POLISH} "Aktualizacja pliku konfiguracyjnego winamp.ini..."
	LangString CPro_Account ${LANG_POLISH} "Konta wielu u¿ytkowników"
	LangString CPro_No_Account ${LANG_POLISH} "Brak obs³ugi kont wielu u¿ytkowników"
	LangString CPro_Winamp_Path ${LANG_POLISH} "Okreœlanie œcie¿ki do pliku konfiguracyjnego Winampa..."

; Close all instances of Winamp
	LangString CPro_CloseWinamp_Welcome_Title ${LANG_POLISH} "Programy do zamkniêcia"
	LangString CPro_CloseWinamp_Welcome_Text  ${LANG_POLISH} "Programy, które musz¹ byæ zamkniête przed kontynuowaniem instalacji"	
	LangString CPro_CloseWinamp_Heading ${LANG_POLISH} "Przed kontynuacj¹ instalacji zamknij wszystkie programy z poni¿szej listy..."
	LangString CPro_CloseWinamp_Searching ${LANG_POLISH} "Trwa wyszukiwanie programów, proszê czekaæ..."
	LangString CPro_CloseWinamp_EndSearch ${LANG_POLISH} "Zakoñczono wyszukiwanie programów..."
	LangString CPro_CloseWinamp_EndMonitor ${LANG_POLISH} "Trwa zamykanie monitora aktywnych procesów, proszê czekaæ..."
	LangString CPro_CloseWinamp_NoPrograms ${LANG_POLISH} "Instalator nie znalaz³ programów, które wymagaj¹ zamkniêcia"
	LangString CPro_CloseWinamp_ColHeadings1 ${LANG_POLISH} "Aplikacja"
	LangString CPro_CloseWinamp_ColHeadings2 ${LANG_POLISH} "Proces"
	LangString CPro_CloseWinamp_Autoclosesilent ${LANG_POLISH} "Nie uda³o siê zamkn¹æ programu"

; Menu Start
	LangString CPro_MenuStart1 ${LANG_POLISH} "Odinstaluj ${CPRO_NAME}"
	LangString CPro_MenuStart2 ${LANG_POLISH} "Co nowego"
	LangString CPro_MenuStart3 ${LANG_POLISH} "Pobierz wiêcej skórek i wid¿etów ${CPRO_NAME}!"	

	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_POLISH} "Witam w kreatorze instalacji $(^NameDA)"
	LangString CPro_Widget_Welcome_Text ${LANG_POLISH} "Ten kreator pomo¿e Ci zainstalowaæ $(^NameDA).$\r$\n$\r$\nDo prawid³owej pracy tej wersji ${CPRO_WIDGET_NAME} musisz mieæ zainstalowanego Winampa w wersji ${CPRO_WINAMP_VERSION} lub nowszego oraz ${CPRO_NAME} ${CPRO_VERSION}!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_POLISH} "Instalacja ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}"	
	LangString CPro_Widget_Name_Text ${LANG_POLISH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} dla ${CPRO_NAME}${CPRO_CRS}"		
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_POLISH} "Witam w kreatorze dezinstalacji $(^NameDA)"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_POLISH} "Ten kreator pomo¿e Ci odinstalowaæ $(^NameDA).$\r$\n$\r$\n$_CLICK"

; Installer sections
	LangString CPro_Widget_Files ${LANG_POLISH} "${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} dla ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_POLISH} "Instalacja wszystkich plików niezbêdnych do pracy ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION}."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_POLISH} "Zakoñczono instalacjê ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}"
	LangString CPro_Widget_FinishPage_2 ${LANG_POLISH} "Kreator instalacji zakoñczy³ instalowanie ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}. Mo¿esz zacz¹æ u¿ywaæ swojego nowego wid¿etu ${CPRO_WIDGET_NAME} dla ${CPRO_NAME} w Winampie."
	LangString CPro_Widget_FinishPage_3 ${LANG_POLISH} "Jeœli podoba ci siê ${CPRO_WIDGET_NAME} i chcesz wspomóc dalszy rozwój projektu, wesprzyj nas dowoln¹ kwot¹."
	LangString CPro_Widget_FinishPage_4 ${LANG_POLISH} "Co chcesz teraz zrobiæ?"
	LangString CPro_Widget_FinishPage_5 ${LANG_POLISH} "Pobierz wiêcej wid¿etów ze strony ${CPRO_NAME}"
	LangString CPro_Widget_FinishPage_6 ${LANG_POLISH} "Odœwie¿ skórkê ${CPRO_NAME} lub uruchom Winampa"
	LangString CPro_Widget_FinishPage_7 ${LANG_POLISH} "Zakoñcz"	
	
; UnFinish Page	
	LangString CPro_Widget_UnFinishPage_1 ${LANG_POLISH} "Koñczenie pracy kreatora dezinstalacji wid¿etu ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} dla ${CPRO_NAME}${CPRO_CRS}"
	LangString CPro_Widget_UnFinishPage_2 ${LANG_POLISH} "Wid¿et ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} dla ${CPRO_NAME}${CPRO_CRS} zosta³ odinstalowany z tego komputera."
	LangString CPro_Widget_UnFinishPage_3 ${LANG_POLISH} "Kliknij przycisk $(CPro_Widget_FinishPage_7), aby zamkn¹æ kreatora"
	LangString CPro_Widget_UnFinishPage_4 ${LANG_POLISH} "Odœwie¿ skórkê ${CPRO_NAME}, jeœli Winamp jest uruchomiony"