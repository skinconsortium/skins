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
	
; Sekcje instalatora	
	LangString CProFiles ${LANG_POLISH} "Silnik ClassicPro"
	LangString wBrowserPro ${LANG_POLISH} "Przegl¹darka BrowserPro v2.0"
	LangString wAlbumArt ${LANG_POLISH} "Ok³adki albumów AlbumArt v1.1"
	LangString WidgetsSection ${LANG_POLISH} "Wid¿ety"
	LangString CProCustom ${LANG_POLISH} "Sk³adniki"
	LangString cPlaylistPro ${LANG_POLISH} "Przeszukiwanie listy odtwarzania"
	
; Opisy sekcji instalatora	
	LangString Desc_CProFiles ${LANG_POLISH} "PL This will install all the files that ClassicPro needs to work."
	LangString Desc_wBrowserPro ${LANG_POLISH} "PL BrowserPro is a widget that will enable your browser to auto navigate to popular websites and explore the playing directory."
	LangString Desc_wAlbumArt ${LANG_POLISH} "PL AlbumArt is a widget that shows a big cd cover and information about the playing file."
	LangString Desc_WidgetsSection ${LANG_POLISH} "PL ClassicPro skins support widgets and here you'll find some of them that we decided to bundle with this installer."
	LangString Desc_CProCustom ${LANG_POLISH} "PL Optional components for ClassicPro."
	LangString Desc_cPlaylistPro ${LANG_POLISH} "PL Add a search box above your playlist for easy searches in your playlist."

; Tekst wyboru katalogu
	LangString CPro_DirText ${LANG_POLISH} "Wybierz œcie¿kê dostêpu do Winampa (bêdziesz móg³ kontynuowaæ, gdy instalator wykryje zainstalowanego Winampa):"
	
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
