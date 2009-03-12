;###########################################################################################

; Lang:			Turkish
; LangID			1055
; Last udpdated:		12.03.2009
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
	LangString CPro_Language_Text ${LANG_TURKISH} "Lütfen bir dil seçin:"

; First Page of Installer
	LangString CPro_Welcome_Title ${LANG_TURKISH} "$(^NameDA) Kurulum Sihirbazý'na hoþ geldiniz"
	LangString CPro_Welcome_Text ${LANG_TURKISH} "Bu sihirbaz size $(^NameDA) kurulumu boyunca rehberlik edecek.$\r$\n$\r$\nKurulumu baþlatmadan önce Winamp'ý kapatmanýz önerilir. Böylece Winamp ile ilgili tüm dosyalar sorunsuz güncelleþtirilebilir.$\n$\n${CPRO_NAME}'nun bu sürümü doðru bir þekilde çalýþabilmesi için, Winamp ${CPRO_WINAMP_VERSION} veya daha yüksek bir sürümü bilgisayarýnýzda kurulu olmalýdýr!$\r$\n$\r$\n$_CLICK"

; Installer Header
	!ifdef CPRO_BETA
; Beta stage	
		LangString CPro_Caption ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BETA} Kur"
	!else
; Release
		LangString CPro_Caption ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} Kur"
	!endif
	
; Installation type	
	LangString CPro_Full ${LANG_TURKISH} "Tam"
	LangString CPro_Minimal ${LANG_TURKISH} "En Az"
	
; Installer sections
	LangString CPro_CProFiles ${LANG_TURKISH} "ClassicPro Motoru"
	LangString CPro_wBrowserPro ${LANG_TURKISH} "BrowserPro"
	LangString CPro_wAlbumArt ${LANG_TURKISH} "Þimdi Yürütülüyor"
	LangString CPro_WidgetsSection ${LANG_TURKISH} "Widgetler"
	LangString CPro_CProCustom ${LANG_TURKISH} "Bileþenler"
	LangString CPro_cPlaylistPro ${LANG_TURKISH} "Çalma Listeleri"
		
; Installer sections descriptions	
	LangString CPro_Desc_CProFiles ${LANG_TURKISH} "ClassicPro'nun çalýþabilmesi için gerekli temel dosyalarý içerir."
	LangString CPro_Desc_wBrowserPro ${LANG_TURKISH} "BrowserPro, widget olarak adlandýrýlan, popüler web siteleri için otomatikman dolaþma ve yürütme dizinine gözatma olanaðý saðlar."
	LangString CPro_Desc_wAlbumArt ${LANG_TURKISH} "Þimdi Yürütülülüyor (Albüm Kapak Resmi sekmesi), büyük bir cd kapak resmini içeren ve yürütülen dosya hakkýnda bilgiler gösteren bir widgetdir."
	LangString CPro_Desc_WidgetsSection ${LANG_TURKISH} "ClassicPro dýþ görünümleri için widget desteði ve bazý yararlý widget bileþenleri içerir."
	LangString CPro_Desc_CProCustom ${LANG_TURKISH} "ClassicPro'nun isteðe baðlý yüklenebilecek bileþenleri."
	LangString CPro_Desc_cPlaylistPro ${LANG_TURKISH} "Çalma listesinin baþýna, kolay aramalar yapabilmeniz için bir arama kutusu ekler."

; Directory Text	
	LangString CPro_DirText ${LANG_TURKISH} "Lütfen Winamp'ýn kurulu olduðu konumu seçin. (Winamp otomatik olarak algýlandýðýnda ilerleyebilirsiniz):"

; Finish Page	
	LangString CPro_FinishPage_1 ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} kurulumu tamamlandý"
	LangString CPro_FinishPage_2 ${LANG_TURKISH} "${CPRO_NAME} v${CPRO_VERSION} kurulum iþlemi tamamlandý. v${CPRO_VERSION}. Winamp'ý þimdi baþlatarak ${CPRO_NAME} dýþ görünüm ve widgestlerini kullanmaya baþlayabilirsiniz."
	LangString CPro_FinishPage_3 ${LANG_TURKISH} "Eðer ${CPRO_NAME}'yu beðendiyseniz, geliþtirilmesine katký saðlamak için bu projeye lütfen para baðýþý yapýn!"
	LangString CPro_FinishPage_4 ${LANG_TURKISH} "Þimdi ne yapmak istiyorsunuz?"
	LangString CPro_FinishPage_5 ${LANG_TURKISH} "Daha fazla ${CPRO_NAME} widget ve dýþ görünümleri için web sayfamýzý ziyaret edin."
	LangString CPro_FinishPage_6 ${LANG_TURKISH} "${CPRO_NAME}'yu varsayýlan dýþ görünüm olarak þimdi aç"
	LangString CPro_FinishPage_7 ${LANG_TURKISH} "Bitir"	
	
; First Page of Uninstaller
	LangString CPro_Un_Welcome_Title ${LANG_TURKISH} "$(^NameDA) Kaldýrma Sahirbazý'na hoþ geldiðiniz"
	LangString CPro_Un_Welcome_Text ${LANG_TURKISH} "Bu sihirbaz size $(^NameDA) programýný kaldýrma iþlemi boyunca rehberlik edecek.$\r$\n$\r$\nKaldýrma iþlemine baþlamadan önce, ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} çalýþýr durumda olduðundan emin olun.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_TURKISH} "Winamp.ini yapýlandýrma dosyasý güncelleþtiriliyor..."
	LangString CPro_Account ${LANG_TURKISH} "Çoklu-kullanýcý ayarlarý"
	LangString CPro_No_Account ${LANG_TURKISH} "Çoklu-kullanýcý ayarlarý yok"
	LangString CPro_Winamp_Path ${LANG_TURKISH} "Winamp yapýlandýrma dosyasýnýn yolu belirleniyor..."	

; Close all instances of Winamp
	LangString CPro_Running_Winamp ${LANG_TURKISH} "Winamp çalýþýyor!"
	LangString CPro_Close_Winamp  ${LANG_TURKISH} "Devam etmeden önce Winamp'ý kapatmalýsýnýz"	
	LangString CPro_Closing_Winamp ${LANG_TURKISH} "        Winamp (winamp.exe) kapatýlýyor..."
	LangString CPro_No_More_Winamp ${LANG_TURKISH} "        Tamam. Winamp kapatýldý..."  
	LangString CPro_No_Winamp ${LANG_TURKISH} "Hayýr. Çalýþan Winamp yok..."
	LangString CPro_Check_Winamp ${LANG_TURKISH} "Winamp çalýþýr durumda mý denetleniyor..."

; Menu Start
	LangString CPro_MenuStart1 ${LANG_TURKISH} "${CPRO_NAME} Kaldýr"
	LangString CPro_MenuStart2 ${LANG_TURKISH} "Neler Yeni"
	LangString CPro_MenuStart3 ${LANG_TURKISH} "Daha fazla ${CPRO_NAME} widget ve dýþ görünümleri edinin!"	
	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_TURKISH} "$(^NameDA) Kurulum Sihirbazý'na hoþ geldiniz"
	LangString CPro_Widget_Welcome_Text ${LANG_TURKISH} "Bu sihirbaz size $(^NameDA) kurulumu boyunca rehberlik edecek.$\r$\n$\r$\nKurulumu baþlatmadan önce Winamp'ý kapatmanýz önerilir. Böylece Winamp ile ilgili tüm dosyalar sorunsuz güncelleþtirilebilir.$\n$\n${CPRO_WIDGET_NAME} programýnýn bu sürümü doðru bir þekilde çalýþabilmesi için, Winamp ${CPRO_WINAMP_VERSION} veya daha yüksek bir sürümü ve ${CPRO_NAME} ${CPRO_VERSION} bilgisayarýnýzda kurulu olmalýdýr!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_TURKISH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Kur"	
	LangString CPro_Widget_Name_Text ${LANG_TURKISH} "ClassicPro© için ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widgeti"		
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_TURKISH} "$(^NameDA) Kaldýrma Sahirbazý'na hoþ geldiðiniz"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_TURKISH} "Bu sihirbaz size $(^NameDA) programýný kaldýrma iþlemi boyunca rehberlik edecek.$\r$\n$\r$\nKaldýrma iþlemine baþlamadan önce, ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} çalýþýr durumda olmadýðýndan emin olun.$\r$\n$\r$\n$_CLICK"
	
; Installer sections
	LangString CPro_Widget_Files ${LANG_TURKISH} "${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION} için ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_TURKISH} "Bu, gerekli olan tüm ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} dosyalarýný yükleyecek."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_TURKISH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} kurulum tamamlandý"
	LangString CPro_Widget_FinishPage_2 ${LANG_TURKISH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} kurulum iþlemi tamamlandý. Winamp'ý þimdi baþlatarak ${CPRO_NAME} için yeni ${CPRO_WIDGET_NAME} widgetinizi kullanabilirsiniz."
	LangString CPro_Widget_FinishPage_3 ${LANG_TURKISH} "Eðer ${CPRO_WIDGET_NAME} widgetini beðendiyseniz, geliþtirilmesine katký saðlamak için bu projeye lütfen para baðýþý yapýn!"
	LangString CPro_Widget_FinishPage_4 ${LANG_TURKISH} "Þimdi ne yapmak istiyorsunuz?"
	LangString CPro_Widget_FinishPage_5 ${LANG_TURKISH} "Daha fazla ${CPRO_NAME} widget ve dýþ görünümleri için web sayfamýzý ziyaret edin."
	LangString CPro_Widget_FinishPage_6 ${LANG_TURKISH} "${CPRO_NAME}'yu varsayýlan dýþ görünüm olarak þimdi aç"
	LangString CPro_Widget_FinishPage_7 ${LANG_TURKISH} "Bitir"		