;###########################################################################################

; Lang:				Turkish
; LangID			1055
; Last udpdated:	24.07.2010
; Author:			Mertcan Kaya (MerTcaN)/Ali Sarýoðlu
; Email:			mertcan.kaya@gmail.com/alsau@mynet.com

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
	LangString CPro_Language_Title		${LANG_TURKISH} "Kurulum dili"
	LangString CPro_Un_Language_Title	${LANG_TURKISH} "Uninstaller language"	
	LangString CPro_Language_Text		${LANG_TURKISH} "Lütfen bir dil seçin:"

; First Page of Installer
	LangString CPro_Welcome_Title	${LANG_TURKISH} "$(^NameDA) Kurulum Sihirbazý'na hoþ geldiniz"
	LangString CPro_Welcome_Text	${LANG_TURKISH} "Bu sihirbaz, $(^NameDA) kurulumu boyunca size rehberlik edecek.$\r$\n$\r$\nKurulumu baþlatmadan önce Winamp'ý kapatmanýz önerilir. Böylece Winamp ile ilgili tüm dosyalar sorunsuz güncelleþtirilebilir.$\n$\n${CPRO_NAME}'nun bu sürümü doðru bir þekilde çalýþabilmesi için, Winamp ${CPRO_WINAMP_SHORT_VERSION} veya daha yüksek bir sürümü bilgisayarýnýzda kurulu olmalýdýr!$\r$\n$\r$\n$_CLICK"

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
	LangString CPro_Full		${LANG_TURKISH} "Tam"
	LangString CPro_Minimal		${LANG_TURKISH} "En Az"
	
; Installer sections
	LangString CPro_CProFiles		${LANG_TURKISH} "${CPRO_NAME} Motoru"
	LangString CPro_wBrowserPro		${LANG_TURKISH} "BrowserPro"
	LangString CPro_wAlbumArt		${LANG_TURKISH} "Þimdi Yürütülüyor"
	LangString CPro_WidgetsSection	${LANG_TURKISH} "Widgetler"
	LangString CPro_CProCustom		${LANG_TURKISH} "Bileþenler"
	LangString CPro_cPlaylistPro	${LANG_TURKISH} "Çalma Listeleri"
		
; Installer sections descriptions	
	LangString CPro_Desc_CProFiles			${LANG_TURKISH} "${CPRO_NAME}'nun çalýþabilmesi için gerekli temel dosyalarý içerir."
	LangString CPro_Desc_wBrowserPro		${LANG_TURKISH} "BrowserPro, widget olarak adlandýrýlan, popüler web siteleri için otomatikman dolaþma ve yürütme dizinine gözatma olanaðý saðlar."
	LangString CPro_Desc_wAlbumArt			${LANG_TURKISH} "Þimdi Yürütülülüyor (Albüm Kapak Resmi sekmesi), büyük bir cd kapak resmini içeren ve yürütülen dosya hakkýnda bilgiler gösteren bir widgetdir."
	LangString CPro_Desc_WidgetsSection		${LANG_TURKISH} "${CPRO_NAME} dýþ görünümleri için widget desteði ve bazý yararlý widget bileþenleri içerir."
	LangString CPro_Desc_CProCustom			${LANG_TURKISH} "${CPRO_NAME}'nun isteðe baðlý yüklenebilecek bileþenleri."
	LangString CPro_Desc_cPlaylistPro		${LANG_TURKISH} "Çalma listesinin baþýna, kolay aramalar yapabilmeniz için bir arama kutusu ekler."

; Directory Text	
	LangString CPro_DirText ${LANG_TURKISH} "Lütfen Winamp'ýn kurulu olduðu konumu seçin. (Winamp otomatik olarak algýlandýðýnda ilerleyebilirsiniz):"

; Cleanup Page	
	LangString CPro_CleanupPage_Title			${LANG_TURKISH} "Winamp Temizliði"
	LangString CPro_CleanupPage_Subtitle		${LANG_TURKISH} "Bazý Winamp Tercihleri için temizlik"
	LangString CPro_CleanupPage_Caption0		${LANG_TURKISH} "Bu sayfadaki seçenekleri kullanarak Winamp ve ${CPRO_NAME}'nun farklý sürümlerinin çalýþmama gibi sorunlarý olmasý durumunda bazý Winamp yapýlandýrma dosyalarýný kaldýrabilirsiniz."
	LangString CPro_CleanupPage_Caption1		${LANG_TURKISH} "Eðer ${CPRO_NAME}'yu çalýþtýrdýðýnda herhangi bir sorunla karþýlaþýrsanýz ${CPRO_NAME}'yu yeniden kurarak ve bu sayfadaki ayarlarý kullanarak sorunlarý çözebilirsiniz."
	LangString CPro_CleanupPage_Caption2		${LANG_TURKISH} "NOT: Belirtilen dosyalarý sorunsuzca silebilirsiniz. Winamp bunlarý otomatikman oluþturur."
	LangString CPro_CleanupPage_Caption3		${LANG_TURKISH} "${CPRO_NAME}'yu Winamp ile kullanýrken bir zorlukla karþýlaþýrsanýz bu ayarlarý kullanýn."
	LangString CPro_CleanupPage_Caption4		${LANG_TURKISH} "Anlayýþýnýz için teþekkür ederiz."
	LangString CPro_CleanupPage_Footer			${LANG_TURKISH} "${CPRO_NAME}'yu kullanýrken harhangi bir sorunla karþýrsanýz,"
	LangString CPro_CleanupPage_TSLink			${LANG_TURKISH} "Skin Consortium forum sayfalarýna gözatýn."
	LangString CPro_CleanupPage_StudioXnf		${LANG_TURKISH} "Dýþ Görünüm Yapýlandýrma Dosyasýný Sil (studio.xnf)"
	LangString CPro_CleanupPage_StudioXnf_Desc	${LANG_TURKISH} "Yapýlandýrýlmýþ dýþ görünüm ayarlarýný siler: pencere konumlarý, etkin sekmeler, geçerli pencere, ..."
	LangString CPro_CleanupPage_WinampIni		${LANG_TURKISH} "Winamp Yapýlandýrma Dosyasýný Sil (winamp.ini)"
	LangString CPro_CleanupPage_WinampIni_Desc	${LANG_TURKISH} "Yapýlandýrýlmýþ winamp ayarlarýný siler: geçerli dýþ görünüm, geliþmiþ baþlýk biçimlendirme, etkin dil, ..."

; Finish Page	
	LangString CPro_FinishPage_1 ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} kurulumu tamamlandý"
	LangString CPro_FinishPage_2 ${LANG_TURKISH} "${CPRO_NAME} v${CPRO_VERSION} kurulum iþlemi tamamlandý. Winamp'ý þimdi baþlatarak, ${CPRO_NAME} dýþ görünümü ve widgetlerini kullanmaya baþlayabilirsiniz."
	LangString CPro_FinishPage_3 ${LANG_TURKISH} "Eðer ${CPRO_NAME}'yu beðendiyseniz, geliþtirilmesine katký saðlamak için bu projeye lütfen para baðýþý yapýn!"
	LangString CPro_FinishPage_4 ${LANG_TURKISH} "Bitir"
	LangString CPro_FinishPage_5 ${LANG_TURKISH} "Þimdi ne yapmak istiyorsunuz?"
	LangString CPro_FinishPage_6 ${LANG_TURKISH} "Daha fazla ${CPRO_NAME} widget ve dýþ görünümleri için web sayfamýzý ziyaret edin."
	LangString CPro_FinishPage_7 ${LANG_TURKISH} "Winamp'ý çalýþtýr"
	LangString CPro_FinishPage_8 ${LANG_TURKISH} "ClassicPro'yu varsayýlan dýþgörünüm olarak ayarla"	
	
; First Page of Uninstaller
	LangString CPro_Un_Welcome_Title	${LANG_TURKISH} "$(^NameDA) Kaldýrma Sahirbazý'na Hoþ Geldiniz"
	LangString CPro_Un_Welcome_Text		${LANG_TURKISH} "Bu sihirbaz, $(^NameDA) programýný kaldýrma iþlemi boyunca size rehberlik edecek.$\r$\n$\r$\nKaldýrma iþlemine baþlamadan önce, ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} çalýþýr durumda olduðundan emin olun.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini				${LANG_TURKISH} "Winamp.ini yapýlandýrma dosyasý güncelleþtiriliyor..."
	LangString CPro_Account			${LANG_TURKISH} "Çoklu-kullanýcý ayarlarý"
	LangString CPro_No_Account		${LANG_TURKISH} "Çoklu-kullanýcý ayarlarý yok"
	LangString CPro_Winamp_Path		${LANG_TURKISH} "Winamp yapýlandýrma dosyasýnýn yolu belirleniyor..."	

; Warnings
	LangString CPro_Warning_CreateMutex		${LANG_TURKISH}	"${CPRO_NAME} v${CPRO_VERSION} kurucusu zaten çalýþmakta."
	LangString CPro_Warning_No_Winamp		${LANG_TURKISH} "Winamp sisteminizde algýlanmadý.$\r$\nLütfen, {CPRO_NAME} v${CPRO_VERSION} kurulumundan önce$\r$\nWinamp.com'dan Winamp'ýn son sürümünü yükleyin.$\r$\nKurulum bitirilmeden durdurulacaktýr."
	LangString CPro_Warning_Low_Version		${LANG_TURKISH} "${CPRO_NAME} v${CPRO_VERSION} en azýndan Winamp ${CPRO_WINAMP_VERSION} ya da üzerini gerektirmektedir.$\r$\nLütfen önce Winamp sürümünüzü güncelleyin (Kurulu olan: $R0).$\r$\nKurulum bitirilmeden durdurulacaktýr."
	LangString CPro_Warning_AtLeast_2000	${LANG_TURKISH} "Üzgünüz, sisteminiz desteklenmemekte. ${CPRO_NAME} v${CPRO_VERSION} yalnýzca Windows 2000 ya da daha yenisinde çalýþýr.$\r$\nKurulum bitirilmeden durdurulacaktýr."

; Close all instances of Winamp
	LangString CPro_CloseWinamp_Welcome_Title		${LANG_TURKISH} "Program kapatma"
	LangString CPro_CloseWinamp_Welcome_Text		${LANG_TURKISH} "Kuruluma devam etmeden önce kapatýlmasý gereken programlar."	
	LangString CPro_CloseWinamp_Heading				${LANG_TURKISH} "Kuruluma devam etmeden önce, aþaðýda listelenen programlar kapatýlacak."
	LangString CPro_CloseWinamp_Searching			${LANG_TURKISH} "tamamlandý, lütfen bekleyin..."
	LangString CPro_CloseWinamp_EndSearch			${LANG_TURKISH} "Arama iþlemi tamamlandý..."
	LangString CPro_CloseWinamp_EndMonitor			${LANG_TURKISH} "Etkin iþlemler kapatýlýyor, lütfen bekleyin..."
	LangString CPro_CloseWinamp_NoPrograms			${LANG_TURKISH} "Kur, kapatýlmasý gereken herhangi bir program bulamadý"
	LangString CPro_CloseWinamp_ColHeadings1		${LANG_TURKISH} "Uygulama"
	LangString CPro_CloseWinamp_ColHeadings2		${LANG_TURKISH} "Yansýma Adý"
	LangString CPro_CloseWinamp_Autoclosesilent		${LANG_TURKISH} "Program kapatýlýrken hata oluþtu"
	LangString CPro_CloseWinamp_MenuItem1			${LANG_TURKISH} "Kapat"
	LangString CPro_CloseWinamp_MenuItem2			${LANG_TURKISH} "Listeyi kopyala"
	
; Menu Start
	LangString CPro_MenuStart1 ${LANG_TURKISH} "${CPRO_NAME} Kaldýr"
	LangString CPro_MenuStart2 ${LANG_TURKISH} "Neler Yeni"
	LangString CPro_MenuStart3 ${LANG_TURKISH} "Daha fazla ${CPRO_NAME} widget ve dýþ görünümleri edinin!"	

	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title	${LANG_TURKISH} "$(^NameDA) Kur Sihirbazýna Hoþ Geldiniz"
	LangString CPro_Widget_Welcome_Text		${LANG_TURKISH} "Bu sihirbaz $(^NameDA) kurulumu boyunca size rehberlik edecek.$\r$\n$\r$\n${CPRO_WIDGET_NAME} eklentisi doðru bir þekilde çalýþabilmesi için, Winamp ${CPRO_WINAMP_SHORT_VERSION} veya daha yüksek bir sürümü ve ${CPRO_NAME} ${CPRO_VERSION} bilgisayarýnzda yüklü olmasý gereklidir!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption		${LANG_TURKISH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Kur"	
	LangString CPro_Widget_Name_Text	${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} için ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} "		
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title	${LANG_TURKISH} "$(^NameDA) Kaldýr Sihirbazýna Hoþ gelndiniz"
	LangString CPro_Widget_Un_Welcome_Text	${LANG_TURKISH} "Bu sihirbaz size $(^NameDA) witgetini kaldýrma iþlemi boyunca size rehberlik edecek.$\r$\n$\r$\n$_CLICK"

; Installer sections
	LangString CPro_Widget_Files ${LANG_TURKISH} "${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} - ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_TURKISH} "Bu, ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} için gerekli tüm dosyalarý yükleyecek."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_TURKISH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} kurulumu tamamlandý."
	LangString CPro_Widget_FinishPage_2 ${LANG_TURKISH} "Bu sihirbaz ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widgetini kurma iþlemini tamamladý. ${CPRO_NAME} için ${CPRO_WIDGET_NAME} widgetini kullanmak için Winamp'ý yeniden baþlatýn."
	LangString CPro_Widget_FinishPage_3 ${LANG_TURKISH} "Eðer bu ${CPRO_WIDGET_NAME} widgeti beðendiyseniz ve bu ürünün geliþtirilmesini istiyorsanýz lütfen bu projeye para baðýþý yapýn."
	LangString CPro_Widget_FinishPage_4 ${LANG_TURKISH} "Þimdi ne yapmak istiyorsunuz?"
	LangString CPro_Widget_FinishPage_5 ${LANG_TURKISH} "Daha fazla ${CPRO_NAME} widgeti için web sayfamýzý ziyaret edin"
	LangString CPro_Widget_FinishPage_6 ${LANG_TURKISH} "${CPRO_NAME}'yu tekrar etkinleþtirin veya Winamp'ý yeniden baþlatýn"
	LangString CPro_Widget_FinishPage_7 ${LANG_TURKISH} "Bitti"	
	
; UnFinish Page	
	LangString CPro_Widget_UnFinishPage_1 ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} widgeti  ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} kaldýrýlýyor"
	LangString CPro_Widget_UnFinishPage_2 ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} widgeti ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} baþrýyla kaldýrýldý."
	LangString CPro_Widget_UnFinishPage_3 ${LANG_TURKISH} "Bu sihirbazý kapatmak için $(CPro_Widget_FinishPage_7) týklatýn"
	LangString CPro_Widget_UnFinishPage_4 ${LANG_TURKISH} "Eðer Winamp çalýþýyorsa ${CPRO_NAME}'yu tekrar etkinleþtirin"