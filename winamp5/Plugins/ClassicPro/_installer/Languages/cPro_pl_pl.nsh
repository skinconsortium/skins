;###########################################################################################

; Lang:			Polish
; LangID			1045
; Last udpdated:		24.02.2009
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

; Wybór jêzyka
	LangString Language_Title ${LANG_POLISH} "Jêzyk instalatora"
	LangString Language_Text ${LANG_POLISH} "Proszê wybraæ jêzyk:"
 
; Pierwsza strona instalatora
	LangString Welcome_Title ${LANG_POLISH} "Witam w kreatorze instalacji $(^NameDA)"
	LangString Welcome_Text ${LANG_POLISH} "Ten kreator pomo¿e Ci zainstalowaæ $(^NameDA).$\r$\n$\r$\nPrzed rozpoczêciem instalacji zalecane jest zamkniêcie Winampa. Pozwoli to na uaktualnienie niezbêdnych plików programu Winamp.$\n$\nDo prawid³owej pracy tej wersji ${CPRO_NAME} musisz mieæ zainstalowanego Winampa w wersji ${CPRO_WINAMP_VERSION} lub nowszego!$\r$\n$\r$\n$_CLICK"

; Nag³owek instalatora
	!ifdef CPRO_BETA
; Wersja Beta
		LangString CPro_Caption ${LANG_POLISH} "Instalacja ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BETA}"
	!else
; Wersja finalna
		LangString CPro_Caption ${LANG_POLISH} "Instalacja ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION}"
	!endif
	
; Typ instalacji
	LangString CPro_Full ${LANG_POLISH} "Pe³na"
	LangString CPro_Minimal ${LANG_POLISH} "Minimalna"
	
; Sekcje instalatora	
	LangString CProFiles ${LANG_POLISH} "Silnik ClassicPro"
	LangString wBrowserPro ${LANG_POLISH} "Przegl¹darka BrowserPro v2.0"
	LangString wAlbumArt ${LANG_POLISH} "Ok³adki albumów AlbumArt v1.1"
	LangString WidgetsSection ${LANG_POLISH} "Wid¿ety"
	LangString CProCustom ${LANG_POLISH} "Sk³adniki"
	LangString cPlaylistPro ${LANG_POLISH} "Przeszukiwanie listy odtwarzania"
	
; Opisy sekcji instalatora	
	LangString Desc_CProFiles ${LANG_POLISH} "Instalacja wszystkich plików niezbêdnych do pracy ClassicPro."
	LangString Desc_wBrowserPro ${LANG_POLISH} "BrowserPro jest wid¿etem umo¿liwiaj¹cym nawigacje do popularnych witryn i katalogu odtwarzanego utworu."
	LangString Desc_wAlbumArt ${LANG_POLISH} "AlbumArt jest wid¿etem, który wyœwietla du¿e ok³adki albumów oraz informacje o odtwarzanym utworze."
	LangString Desc_WidgetsSection ${LANG_POLISH} "Skórki ClassicPro obs³uguj¹ wid¿ety. Te rozprowadzane z instalatorem ClassicPro, znajdziesz w tej sekcji."
	LangString Desc_CProCustom ${LANG_POLISH} "Opcjonalne komponenty dla ClassicPro."
	LangString Desc_cPlaylistPro ${LANG_POLISH} "Dodaje pole wyszukiwania nad list¹ odtwarzania, do ³atwego jej przeszukiwania."

; Tekst wyboru katalogu
	LangString CPro_DirText ${LANG_POLISH} "Wybierz œcie¿kê dostêpu do Winampa (mo¿liwa bedzie kontynuacja, gdy instalator wykryje zainstalowanego Winampa):"
	
; Strona koñcowa
	LangString FinishPage_1 ${LANG_POLISH} "Zakoñczono instalacjê ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION}"
	LangString FinishPage_2 ${LANG_POLISH} "Kreator instalacji zakoñczy³ instalowanie ${CPRO_NAME} v${CPRO_VERSION}. Mo¿esz zacz¹æ u¿ywaæ skórek i wid¿etów ${CPRO_NAME} w Winampie."
	LangString FinishPage_3 ${LANG_POLISH} "Jeœli podoba ci siê ${CPRO_NAME} i chcesz wspomóc dalszy rozwój projektu, wesprzyj nas dowoln¹ kwot¹."
	LangString FinishPage_4 ${LANG_POLISH} "Co chcesz teraz zrobiæ?"
	LangString FinishPage_5 ${LANG_POLISH} "Pobierz wiêcej skórek i wid¿etów ze strony ${CPRO_NAME}"
	LangString FinishPage_6 ${LANG_POLISH} "Otwórz domyœln¹ skórkê ${CPRO_NAME}"
	LangString FinishPage_7 ${LANG_POLISH} "Zakoñcz"	
	LangString FinishPage_8 ${LANG_POLISH} "https://www.paypal.com/uk/cgi-bin/webscr?cmd=_flow&SESSION=8h5vlcm9CV3GH2N6PEu7syhffIV0c0JgJ4QZ2FUWaJRiYKCliUrjeMQMtZS&dispatch=5885d80a13c0db1fa798f5a5f5ae42e71cf8ee1e360382336fe24cc0d575d12c"

; Pierwsza strona deinstalatora
	LangString Un_Welcome_Title ${LANG_POLISH} "Witam w kreatorze dezinstalacji $(^NameDA)"
	LangString Un_Welcome_Text ${LANG_POLISH} "Ten kreator pomo¿e Ci odinstalowaæ $(^NameDA).$\r$\n$\r$\nPrzed rozpoczêciem dezinstalacji, upewnij siê, ¿e ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION} nie jest uruchomiony.$\r$\n$\r$\n$_CLICK"

; Instalacja
	LangString CPro_Ini ${LANG_POLISH} "Aktualizacja pliku konfiguracyjnego winamp.ini..."
	LangString CPro_Account ${LANG_POLISH} "Konta wielu u¿ytkowników"
	LangString CPro_No_Account ${LANG_POLISH} "Brak obs³ugi kont wielu u¿ytkowników"
	LangString CPro_Winamp_Path ${LANG_POLISH} "Okreœlanie œcie¿ki do pliku konfiguracyjnego Winampa..."

; Zamknij wszystkie instancje Winampa
	LangString CPro_Running_Winamp ${LANG_POLISH} "Wykryto uruchomionego Winampa!"
	LangString CPro_Close_Winamp  ${LANG_POLISH} "Przed kontynuacj¹ instalacji musisz zamkn¹æ wszystkie instancje Winampa!"	
	LangString CPro_Closing_Winamp ${LANG_POLISH} "        Trwa zamykanie programu Winamp (winamp.exe)..."
	LangString CPro_No_More_Winamp ${LANG_POLISH} "        OK. Program Winamp zosta³ zamkniêty..."  
	LangString CPro_No_Winamp ${LANG_POLISH} "OK. Program Winamp nie jest uruchomiony..."
	LangString CPro_Check_Winamp ${LANG_POLISH} "Sprawdzanie czy Winamp jest uruchomiony..."

; Menu Start
	LangString CPro_MenuStart1 ${LANG_POLISH} "Odinstaluj ${CPRO_NAME}"
	LangString CPro_MenuStart2 ${LANG_POLISH} "Co nowego"
	LangString CPro_MenuStart3 ${LANG_POLISH} "Pobierz wiêcej skórek i wid¿etów ${CPRO_NAME}!"	
	