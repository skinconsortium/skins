;###########################################################################################

; Lang:			Russian
; LangID			1049
; Last udpdated:		24.02.2009
; Author:			x
; Email:			x@x

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
	LangString CPro_Language_Title ${LANG_RUSSIAN} "Язык установки"
	LangString CPro_Language_Text ${LANG_RUSSIAN} "Пожалуйста выберите язык:"

; First Page of Installer
	LangString CPro_Welcome_Title ${LANG_RUSSIAN} "Добро пожаловать в мастер установки $(^NameDA)"
	LangString CPro_Welcome_Text ${LANG_RUSSIAN} "Этот мастер проведет вас через процедуру установки $(^NameDA).$\r$\n$\r$\nРекомендуем вам закрыть Winamp перед началом установки. Возможно придется обновлять все соответствующие файлы Winamp.$\n$\nВам как минимум требуется Winamp версии ${CPRO_WINAMP_VERSION} для работы текущей версии ${CPRO_NAME}!$\r$\n$\r$\n$_CLICK"

; Installer Header
	!ifdef CPRO_BETA
; Beta stage	
		LangString CPro_Caption ${LANG_RUSSIAN} "Установка ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BETA}"
	!else
; Release
		LangString CPro_Caption ${LANG_RUSSIAN} "Установка ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION}"
	!endif
	
; Installation type	
	LangString CPro_Full ${LANG_RUSSIAN} "Полная"
	LangString CPro_Minimal ${LANG_RUSSIAN} "Минимальная"
	
; Installer sections
	LangString CPro_CProFiles ${LANG_RUSSIAN} "Процессор ClassicPro"
	LangString CPro_wBrowserPro ${LANG_RUSSIAN} "BrowserPro"
	LangString CPro_wAlbumArt ${LANG_RUSSIAN} "Now Playing"
	LangString CPro_WidgetsSection ${LANG_RUSSIAN} "Дополнения"
	LangString CPro_CProCustom ${LANG_RUSSIAN} "Компоненты"
	LangString CPro_cPlaylistPro ${LANG_RUSSIAN} "Поиск по списку воспроизведения"
		
; Installer sections descriptions	
	LangString CPro_Desc_CProFiles ${LANG_RUSSIAN} "Сейчас будут установлены все файлы, необходимые для работы."
	LangString CPro_Desc_wBrowserPro ${LANG_RUSSIAN} "BrowserPro это дополнение, которое позволит вашему браузеру автоматически переходить на популярные веб сайты и просматривать папки воспроизведения."
	LangString CPro_Desc_wAlbumArt ${LANG_RUSSIAN} "Now Playing это дополнение, показывающее польшую обложку альбома и информацию о проигрываемом файле."
	LangString CPro_Desc_WidgetsSection ${LANG_RUSSIAN} "Основные дополнения ClassicPro, которые мы решили включить в установку."
	LangString CPro_Desc_CProCustom ${LANG_RUSSIAN} "Необязательные компоненты ClassicPro."
	LangString CPro_Desc_cPlaylistPro ${LANG_RUSSIAN} "Добавьте панель поиска над вашим списком воспроизведения для быстрого поиска."

; Direcory Text	
	LangString CPro_DirText ${LANG_RUSSIAN} "Введите пожалуйста путь к Winamp (вы сможете продолжить, когда Winamp будет найден):"

; Finish Page	
	LangString CPro_FinishPage_1 ${LANG_RUSSIAN} "Установка ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} завершена"
	LangString CPro_FinishPage_2 ${LANG_RUSSIAN} "Мастер установки закончил установку ${CPRO_NAME} v${CPRO_VERSION}. Вы можете начать пользоваться обложками и дополнениями ${CPRO_NAME} в Winamp."
	LangString CPro_FinishPage_3 ${LANG_RUSSIAN} "Если вам понравился ${CPRO_NAME} и вы хотите развития продукта, пожалуйста поддержите проект материально."
	LangString CPro_FinishPage_4 ${LANG_RUSSIAN} "Что вы теперь хотите сделать?"
	LangString CPro_FinishPage_5 ${LANG_RUSSIAN} "Найти больше обложек и дополнений ${CPRO_NAME} на сайте"
	LangString CPro_FinishPage_6 ${LANG_RUSSIAN} "Открыть обложку ${CPRO_NAME} по умолчанию"
	LangString CPro_FinishPage_7 ${LANG_RUSSIAN} "Завершить"	
	
; First Page of Uninstaller
	LangString CPro_Un_Welcome_Title ${LANG_RUSSIAN} "Добро пожаловать в мастер удаления $(^NameDA)"
	LangString CPro_Un_Welcome_Text ${LANG_RUSSIAN} "Этот мастер проведет вас через процедуру удаления $(^NameDA).$\r$\n$\r$\nПеред началом удаления убедитесь, что ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} не работает.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_RUSSIAN} "Обновление файла установок winamp.ini..."
	LangString CPro_Account ${LANG_RUSSIAN} "Установки всех пользователей"
	LangString CPro_No_Account ${LANG_RUSSIAN} "Установки одного пользователя"
	LangString CPro_Winamp_Path ${LANG_RUSSIAN} "Нахождение файла установок Winamp..."	

; Close all instances of Winamp
	LangString CPro_Running_Winamp ${LANG_RUSSIAN} "Winamp включен!"
	LangString CPro_Close_Winamp  ${LANG_RUSSIAN} "Перед продолжением требуется закрыть все приложения  Winamp!"	
	LangString CPro_Closing_Winamp ${LANG_RUSSIAN} "        Закрытие Winamp (winamp.exe)..."
	LangString CPro_No_More_Winamp ${LANG_RUSSIAN} "        Хорошо. Все приложения Winamp закрыты..."  
	LangString CPro_No_Winamp ${LANG_RUSSIAN} "Хорошо. Не работает ни одно приложение Winamp..."
	LangString CPro_Check_Winamp ${LANG_RUSSIAN} "Проверка, работает ли Winamp..."

; Menu Start
	LangString CPro_MenuStart1 ${LANG_RUSSIAN} "Удалить ${CPRO_NAME}"
	LangString CPro_MenuStart2 ${LANG_RUSSIAN} "Что нового"
	LangString CPro_MenuStart3 ${LANG_RUSSIAN} "Найти еще обложки и дополнения ${CPRO_NAME}!"	
	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_RUSSIAN} "Добро пожаловать в мастер установки $(^NameDA)"
	LangString CPro_Widget_Welcome_Text ${LANG_RUSSIAN} "Этот мастер проведет вас через процедуру установки $(^NameDA).$\r$\n$\r$\nРекомендуется закрыть Winamp перед началом установки. Это позволит обновить все требуемые файлы Winamp.$\n$\nВам нужен как минимум Winamp версии ${CPRO_WINAMP_VERSION} и ${CPRO_NAME} ${CPRO_VERSION} для работы этой версии ${CPRO_WIDGET_NAME}!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_RUSSIAN} "Установка ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}"	
	LangString CPro_Widget_Name_Text ${LANG_RUSSIAN} "Дополнение ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} для ClassicPro©"		
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_RUSSIAN} "Добро пожаловать в мастер удаления $(^NameDA)"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_RUSSIAN} "Этот мастер проведет вас через процедуру удаления $(^NameDA).$\r$\n$\r$\n Перед удалением убедитесь, что ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} не включен.$\r$\n$\r$\n$_CLICK"
	
; Installer sections
	LangString CPro_Widget_Files ${LANG_RUSSIAN} "${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} для ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_RUSSIAN} "Сейчас будут установлены все файлы, которые требуются для работы ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION}."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_RUSSIAN} "Установка ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} завершена"
	LangString CPro_Widget_FinishPage_2 ${LANG_RUSSIAN} "Мастер установки закончил установку ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}. Теперь вы можете начать пользоваться новым дополнением ${CPRO_WIDGET_NAME} для ${CPRO_NAME} в Winamp."
	LangString CPro_Widget_FinishPage_3 ${LANG_RUSSIAN} "Если вам нравится ${CPRO_WIDGET_NAME} и выхотите помочь развитию продукта, пожалуйста поддержите проект материально."
	LangString CPro_Widget_FinishPage_4 ${LANG_RUSSIAN} "Что вы хотите сделать?"
	LangString CPro_Widget_FinishPage_5 ${LANG_RUSSIAN} "Найти больше обложек и дополнений ${CPRO_NAME} на сайте"
	LangString CPro_Widget_FinishPage_6 ${LANG_RUSSIAN} "Открыть обложку по умолчанию ${CPRO_NAME}"
	LangString CPro_Widget_FinishPage_7 ${LANG_RUSSIAN} "Завершить"	