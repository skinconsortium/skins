;###########################################################################################

; Lang:				Turkish
; LangID			1055
; Last udpdated:		27.05.2009
; Author:			Ali Sarýoðlu
; Email:			alsau@mynet.com

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
	LangString CPro_Language_Title ${LANG_TURKISH} "Kurulum dili"
	LangString CPro_Un_Language_Title ${LANG_TURKISH} "Kaldýrma dili"	
	LangString CPro_Language_Text ${LANG_TURKISH} "Lütfen bir dil seçin:"

; First Page of Installer
	LangString CPro_Welcome_Title ${LANG_TURKISH} "$(^NameDA) Kurulum Sihirbazý'na hoþ geldiniz"
	LangString CPro_Welcome_Text ${LANG_TURKISH} "Bu sihirbaz size $(^NameDA) kurulumu boyunca rehberlik edecek.$\r$\n$\r$\nKurulumu baþlatmadan önce Winamp'ý kapatmanýz önerilir. Böylece Winamp ile ilgili tüm dosyalar sorunsuz güncelleþtirilebilir.$\n$\n${CPRO_NAME}'nun bu sürümü doðru bir þekilde çalýþabilmesi için, Winamp ${CPRO_WINAMP_VERSION} veya daha yüksek bir sürümü bilgisayarýnýzda kurulu olmalýdýr!$\r$\n$\r$\n$_CLICK"

; Installer Header
	!if ${CPRO_BUILD_TYPE} == "BETA"
; Beta stage	
		LangString CPro_Caption ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME} Kur"
	!else if ${CPRO_BUILD_TYPE} == "NIGHTLY"
; Alpha stage	
		LangString CPro_Caption ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME} (${CPRO_DATE}) Kur"		
	!else
; Release
		LangString CPro_Caption ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} Kur"		
	!endif
	
; Installation type	
	LangString CPro_Full ${LANG_TURKISH} "Tam"
	LangString CPro_Minimal ${LANG_TURKISH} "En Az"
	
; Installer sections
	LangString CPro_CProFiles ${LANG_TURKISH} "${CPRO_NAME} Motoru"
	LangString CPro_wBrowserPro ${LANG_TURKISH} "BrowserPro"
	LangString CPro_wAlbumArt ${LANG_TURKISH} "Þimdi Yürütülüyor"
	LangString CPro_WidgetsSection ${LANG_TURKISH} "Widgetler"
	LangString CPro_CProCustom ${LANG_TURKISH} "Bileþenler"
	LangString CPro_cPlaylistPro ${LANG_TURKISH} "Çalma Listesi Arama"
		
; Installer sections descriptions	
	LangString CPro_Desc_CProFiles ${LANG_TURKISH} "Bu, ${CPRO_NAME}'nun çalýþabilmesi için gereken tüm dosyalarý kuracaktýr."
	LangString CPro_Desc_wBrowserPro ${LANG_TURKISH} "BrowserPro, tarayýcýnýzla popüler web siteleri için otomatik dolaþma ve yürütme dizinine gözatma olanaðýný saðlayan bir widget'ýr."
	LangString CPro_Desc_wAlbumArt ${LANG_TURKISH} "Þimdi Yürütülülüyor, yürütülen dosyanýn büyük bir cd kapak resmini ve bu dosya hakkýnda bilgiler gösteren bir widget'týr."
	LangString CPro_Desc_WidgetsSection ${LANG_TURKISH} "${CPRO_NAME} dýþ görünümleri için widget desteði ve burda bu kurucuyla birlikte paketlemeyi kararlaþtýrdýðýmýzdan bazýlarýný içerir."
	LangString CPro_Desc_CProCustom ${LANG_TURKISH} "${CPRO_NAME} için isteðe baðlý bileþenler."
	LangString CPro_Desc_cPlaylistPro ${LANG_TURKISH} "Çalma listesinin baþýna, kolay aramalar yapabilmeniz için bir arama kutusu ekler."

; Directory Text	
	LangString CPro_DirText ${LANG_TURKISH} "Lütfen aþaðýdan Winamp'ýn kurulu olduðu konumu seçin (Winamp algýlandýðýnda ilerleyebilirsiniz):"

; Cleanup Page	
	LangString CPro_CleanupPage_Title ${LANG_TURKISH} "Winamp Temizleme"
	LangString CPro_CleanupPage_Subtitle ${LANG_TURKISH} "Bazý Winamp Tercihlerini temizle."
	LangString CPro_CleanupPage_Caption0 ${LANG_TURKISH} "Bu sayfadaki seçenekleri kullanmak Winamp ve ${CPRO_NAME} programlarýnýn ikisinin de farklý sürümleriyle birlikte karþýlýklý çalýþmayabilen bazý Winamp Yapýlandýrma dosyalarýný silecek."
	LangString CPro_CleanupPage_Caption1 ${LANG_TURKISH} "${CPRO_NAME}'nun çalýþmasýnda sorunlar yaþýyorsanýz ${CPRO_NAME}'yu istediðiniz zaman yeniden kurabilirsiniz ve sorunlarýnýzý çözmek için bu sayfayý kullanabilirsiniz."
	LangString CPro_CleanupPage_Caption2 ${LANG_TURKISH} "NOT: Bu tamamen olaðandýr, bu dosyalar Winamp tarafýndan yeniden yapýlanýcaktýr."
	LangString CPro_CleanupPage_Caption3 ${LANG_TURKISH} "Bu seçeneklerle yeniden kurulumu yalnýzca Winamp'ý ${CPRO_NAME} ile birlikte kullanýrken zorluklar yaþýyorsanýz kullanmalýsýnýz."
	LangString CPro_CleanupPage_Caption4 ${LANG_TURKISH} "Anlayýþýnýz için teþekkür ederiz."
	LangString CPro_CleanupPage_Footer ${LANG_TURKISH} "Eðer ${CPRO_NAME} kullanýrken sorun yaþamaya devam ediyorsanýz,"
	LangString CPro_CleanupPage_TSLink ${LANG_TURKISH} "Skin Consortium Forumlarý'nda ücretsiz destek isteyebilirsiniz."
	LangString CPro_CleanupPage_StudioXnf ${LANG_TURKISH} "Dýþ Görünüm Yapýlandýrmasý'ný sil (studio.xnf)"
	LangString CPro_CleanupPage_StudioXnf_Desc ${LANG_TURKISH} "Dýþ görünme özgü ayarlarý siler. Örneðin: pencere konumlarý, etkin sekmeler, geçerli pencere durumu, ..."
	LangString CPro_CleanupPage_WinampIni ${LANG_TURKISH} "Winamp Yapýlandýrmasý'ný sil (winamp.ini)"
	LangString CPro_CleanupPage_WinampIni_Desc ${LANG_TURKISH} "Winamp'a özgü ayarlarý siler. Örneðin: geçerli dýþ görünüm, ileri baþlýk biçimleme, geçerli dil, ..."

; Finish Page	
	LangString CPro_FinishPage_1 ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} kurulumu tamamlandý"
	LangString CPro_FinishPage_2 ${LANG_TURKISH} "${CPRO_NAME} v${CPRO_VERSION} kurulum iþlemi tamamlandý. v${CPRO_VERSION}. Winamp'ý þimdi baþlatarak ${CPRO_NAME} dýþ görünüm ve widgestlerini kullanmaya baþlayabilirsiniz."
	LangString CPro_FinishPage_3 ${LANG_TURKISH} "Eðer ${CPRO_NAME}'yu beðendiyseniz ve ürünün ileriki geliþtirmelerine katký saðlamak isterseniz lütfen bu projeye baðýþý yapýn!"
	LangString CPro_FinishPage_4 ${LANG_TURKISH} "Þimdi ne yapmak istersiniz?"
	LangString CPro_FinishPage_5 ${LANG_TURKISH} "Daha fazla ${CPRO_NAME} widget ve dýþ görünümleri için web sayfamýzý ziyaret edin."
	LangString CPro_FinishPage_6 ${LANG_TURKISH} "Þimdi Winamp'ý varsayýlan ${CPRO_NAME} dýþ görünümüyle aç"
	LangString CPro_FinishPage_7 ${LANG_TURKISH} "Bitir"	
	
; First Page of Uninstaller
	LangString CPro_Un_Welcome_Title ${LANG_TURKISH} "$(^NameDA) Kaldýrma Sahirbazý'na hoþ geldiniz"
	LangString CPro_Un_Welcome_Text ${LANG_TURKISH} "Bu sihirbaz size $(^NameDA) programýný kaldýrma iþlemi boyunca rehberlik edecek.$\r$\n$\r$\nKaldýrma iþlemine baþlamadan önce, ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} programýnýn çalýþmadýðýndan emin olun.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_TURKISH} "Winamp.ini yapýlandýrma dosyasý güncelleþtiriliyor..."
	LangString CPro_Account ${LANG_TURKISH} "Çoklu-kullanýcý ayarlarý"
	LangString CPro_No_Account ${LANG_TURKISH} "Çoklu-kullanýcý ayarlarý yok"
	LangString CPro_Winamp_Path ${LANG_TURKISH} "Winamp yapýlandýrma dosyasýnýn yolu belirleniyor..."	

; Close all instances of Winamp
	LangString CPro_CloseWinamp_Welcome_Title ${LANG_TURKISH} "Kapatýlacak programlar"
	LangString CPro_CloseWinamp_Welcome_Text  ${LANG_TURKISH} "Kurulumun sürdürülmesi için kapatýlmasý gereken programlar"	
	LangString CPro_CloseWinamp_Heading ${LANG_TURKISH} "Kurulumu sürdürmeden önce listedeki tüm programlarý kapat..."
	LangString CPro_CloseWinamp_Searching ${LANG_TURKISH} "Programlar aranýyor, lütfen bekleyin..."
	LangString CPro_CloseWinamp_EndSearch ${LANG_TURKISH} "Program aramasý bitti..."
	LangString CPro_CloseWinamp_EndMonitor ${LANG_TURKISH} "Etkin iþlem görüntü birimi kapatýlýyor, lütfen bekleyin..."
	LangString CPro_CloseWinamp_NoPrograms ${LANG_TURKISH} "Kurulum kapatmak için hiçbir program bulamadý"
	LangString CPro_CloseWinamp_ColHeadings1 ${LANG_TURKISH} "Uygulama"
	LangString CPro_CloseWinamp_ColHeadings2 ${LANG_TURKISH} "Ýþlem"
	LangString CPro_CloseWinamp_Autoclosesilent ${LANG_TURKISH} "Program kapatma baþarýsýz"

; Menu Start
	LangString CPro_MenuStart1 ${LANG_TURKISH} "${CPRO_NAME} Kaldýr"
	LangString CPro_MenuStart2 ${LANG_TURKISH} "Neler Yeni"
	LangString CPro_MenuStart3 ${LANG_TURKISH} "Daha fazla ${CPRO_NAME} widget ve dýþ görünümler edinin!"	

	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_TURKISH} "$(^NameDA) Kurulum Sihirbazý'na hoþ geldiniz"
	LangString CPro_Widget_Welcome_Text ${LANG_TURKISH} "Bu sihirbaz size $(^NameDA) kurulumu boyunca rehberlik edecek.$\r$\n$\r$\n{CPRO_WIDGET_NAME} widget'ýnýn bu sürümü doðru bir þekilde çalýþabilmesi için, Winamp ${CPRO_WINAMP_VERSION} ve ${CPRO_NAME} ${CPRO_VERSION} veya daha yüksek bir sürümü bilgisayarýnýzda kurulu olmalýdýr!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_TURKISH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Kur"	
	LangString CPro_Widget_Name_Text ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} için ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget'ý"		
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_TURKISH} "$(^NameDA) Kaldýrma Sahirbazý'na hoþ geldiniz"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_TURKISH} "Bu sihirbaz size $(^NameDA) widget'ýný kaldýrma iþlemi boyunca rehberlik edecek.$\r$\n$\r$\n$_CLICK"

; Installer sections
	LangString CPro_Widget_Files ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION} için ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_TURKISH} "Bu, ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} widget'ýnýn çalýþabilmesi için gereken tüm dosyalarý kuracaktýr."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_TURKISH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} kurulumu tamamlandý"
	LangString CPro_Widget_FinishPage_2 ${LANG_TURKISH} "Kurulum sihirbazý, ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} kurulumunu tamamlandý. Winamp'ýnýzdaki ${CPRO_NAME} için olan yeni ${CPRO_WIDGET_NAME} widget'ýnýzý kullanmaya baþlýyabilirsiniz."
	LangString CPro_Widget_FinishPage_3 ${LANG_TURKISH} "Eðer ${CPRO_WIDGET_NAME} widget'ýný beðendiyseniz ve ürünün ileriki geliþtirmelerine katký saðlamak isterseniz lütfen bu projeye baðýþý yapýn!"
	LangString CPro_Widget_FinishPage_4 ${LANG_TURKISH} "Þimdi ne yapmak istersiniz?"
	LangString CPro_Widget_FinishPage_5 ${LANG_TURKISH} "Daha fazla ${CPRO_NAME} widget'ý edinmek için anasayfamýza gidin"
	LangString CPro_Widget_FinishPage_6 ${LANG_TURKISH} "${CPRO_NAME} programýný yeniden yükle ya da þimdi Winamp'ý aç"
	LangString CPro_Widget_FinishPage_7 ${LANG_TURKISH} "Bitir"	
	
; UnFinish Page	
	LangString CPro_Widget_UnFinishPage_1 ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} için olan ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget'ýnýn Kaldýrma Sihirbazý'ný tamamlandýrma"
	LangString CPro_Widget_UnFinishPage_2 ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} için olan ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget'ý bilgisayarýnýzdan kaldýrýldý."
	LangString CPro_Widget_UnFinishPage_3 ${LANG_TURKISH} "Bu sihirbazý kapatmak için $(CPro_Widget_FinishPage_7) týklayýn"
	LangString CPro_Widget_UnFinishPage_4 ${LANG_TURKISH} "Winamp çalýþýyorsa ${CPRO_NAME} programýný yeniden yükleyin"