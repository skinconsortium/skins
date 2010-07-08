;###########################################################################################

; Lang:				Russian
; LangID			1049
; Last udpdated:	16.05.2009
; Author:			NickMikh
; Email:			nickmikh@gmail.com

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
	LangString CPro_Language_Title ${LANG_RUSSIAN} "Язык инсталлятора"
	LangString CPro_Un_Language_Title ${LANG_RUSSIAN} "Язык деинсталлятора"	
	LangString CPro_Language_Text ${LANG_RUSSIAN} "Пожалуйста выберите язык:"

; First Page of Installer
	LangString CPro_Welcome_Title ${LANG_RUSSIAN} "Добро пожаловать в мастер установки аддона $(^NameDA)"
	LangString CPro_Welcome_Text ${LANG_RUSSIAN} "Этот мастер проведет вас через процедуру установки аддона $(^NameDA).$\r$\n$\r$\nРекомендуем вам закрыть Winamp перед началом установки. Возможно придется обновлять все соответствующие файлы Winamp.$\n$\nВам как минимум требуется Winamp версии ${CPRO_WINAMP_VERSION} для работы текущей версии ${CPRO_NAME}!$\r$\n$\r$\n$_CLICK"

; Installer Header
	!if ${CPRO_BUILD_TYPE} == "BETA"
; Beta stage	
		LangString CPro_Caption ${LANG_RUSSIAN} "Установка аддона ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME}"
	!else if ${CPRO_BUILD_TYPE} == "NIGHTLY"
; Alpha stage	
		LangString CPro_Caption ${LANG_RUSSIAN} "Установка аддона${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME} (${CPRO_DATE})"		
	!else
; Release
		LangString CPro_Caption ${LANG_RUSSIAN} "Установка ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION}"		
	!endif
	
; Installation type	
	LangString CPro_Full ${LANG_RUSSIAN} "Полная"
	LangString CPro_Minimal ${LANG_RUSSIAN} "Минимальная"
	
; Installer sections
	LangString CPro_CProFiles ${LANG_RUSSIAN} "Процессор аддона ${CPRO_NAME}"
	LangString CPro_wBrowserPro ${LANG_RUSSIAN} "BrowserPro"
	LangString CPro_wAlbumArt ${LANG_RUSSIAN} "Now Playing"
	LangString CPro_WidgetsSection ${LANG_RUSSIAN} "Дополнения"
	LangString CPro_CProCustom ${LANG_RUSSIAN} "Компоненты"
	LangString CPro_cPlaylistPro ${LANG_RUSSIAN} "Поиск по списку воспроизведения"
		
; Installer sections descriptions	
	LangString CPro_Desc_CProFiles ${LANG_RUSSIAN} "Сейчас будут установлены все файлы, необходимые для работы."
	LangString CPro_Desc_wBrowserPro ${LANG_RUSSIAN} "BrowserPro это дополнение, которое позволит вашему браузеру автоматически переходить на популярные веб сайты и просматривать папки воспроизведения."
	LangString CPro_Desc_wAlbumArt ${LANG_RUSSIAN} "Now Playing это дополнение, показывающее польшую обложку альбома и информацию о проигрываемом файле."
	LangString CPro_Desc_WidgetsSection ${LANG_RUSSIAN} "Основные дополнения аддона ${CPRO_NAME}, которые мы решили включить в установку."
	LangString CPro_Desc_CProCustom ${LANG_RUSSIAN} "Необязательные компоненты аддона ${CPRO_NAME}."
	LangString CPro_Desc_cPlaylistPro ${LANG_RUSSIAN} "Добавьте панель поиска над вашим списком воспроизведения для быстрого поиска."

; Direcory Text	
	LangString CPro_DirText ${LANG_RUSSIAN} "Введите пожалуйста путь к Winamp (вы сможете продолжить, когда Winamp будет найден):"

; Cleanup Page	
	LangString CPro_CleanupPage_Title ${LANG_RUSSIAN} "Очистка Winamp"
	LangString CPro_CleanupPage_Subtitle ${LANG_RUSSIAN} "Очистка некоторых параметров Winamp."
	LangString CPro_CleanupPage_Caption0 ${LANG_RUSSIAN} "Использование параметров данной страницы удалит файлы конфигурации Winamp, из-за которых могут не работать Winamp и ${CPRO_NAME}."
	LangString CPro_CleanupPage_Caption1 ${LANG_RUSSIAN} "Если у вас возникли пробемы с работой аддона ${CPRO_NAME} вы можете переустановить ${CPRO_NAME} и использовать эти настройки для их решения."
	LangString CPro_CleanupPage_Caption2 ${LANG_RUSSIAN} "ПРИМЕЧАНИЕ: Это абсоютно безопасно, Winamp пересоздаст эти файлы."
	LangString CPro_CleanupPage_Caption3 ${LANG_RUSSIAN} "Переустановку с этими параметрами следует проводить только, если возникают проблемы с использованием аддона ${CPRO_NAME} и Winamp."
	LangString CPro_CleanupPage_Caption4 ${LANG_RUSSIAN} "Спасибо за понимание."
	LangString CPro_CleanupPage_Footer ${LANG_RUSSIAN} "Если у вас еще остались проблемы с аддоном ${CPRO_NAME},"
	LangString CPro_CleanupPage_TSLink ${LANG_RUSSIAN} "Обратитесь за бесплатной поддержкой на форум Skin Consortium."
	LangString CPro_CleanupPage_StudioXnf ${LANG_RUSSIAN} "Удалите файл параметров Обложек (studio.xnf)"
	LangString CPro_CleanupPage_StudioXnf_Desc ${LANG_RUSSIAN} "Удаляет параметры Обложек такие, как положение окон, активные вкладки, текущий режим, ..."
	LangString CPro_CleanupPage_WinampIni ${LANG_RUSSIAN} "Удалите установки Winamp (winamp.ini)"
	LangString CPro_CleanupPage_WinampIni_Desc ${LANG_RUSSIAN} "Удаляет параметры Winamp такие, как текущая облока, текущий язык, ..."

; Finish Page	
	LangString CPro_FinishPage_1 ${LANG_RUSSIAN} "Установка аддона ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} завершена."
	LangString CPro_FinishPage_2 ${LANG_RUSSIAN} "Мастер установки закончил установку аддона ${CPRO_NAME} v${CPRO_VERSION}. Вы можете начать пользоваться обложками и дополнениями аддона ${CPRO_NAME} в Winamp."
	LangString CPro_FinishPage_3 ${LANG_RUSSIAN} "Если вам понравился аддон ${CPRO_NAME} и вы хотите развития продукта, пожалуйста поддержите проект материально."
	LangString CPro_FinishPage_4 ${LANG_RUSSIAN} "Что вы хотите сделать далее?"
	LangString CPro_FinishPage_5 ${LANG_RUSSIAN} "Найти больше обложек и дополнений аддона ${CPRO_NAME} на сайте"
	LangString CPro_FinishPage_6 ${LANG_RUSSIAN} "Открыть Winamp с обложкой аддона ${CPRO_NAME} по умолчанию"
	LangString CPro_FinishPage_7 ${LANG_RUSSIAN} "Завершить"	
	LangString CPro_FinishPage_8 ${LANG_RUSSIAN} "Открыть Winamp с текущей обложкой"
	LangString CPro_FinishPage_9 ${LANG_RUSSIAN} "Do not open Winamp at all"
	
; First Page of Uninstaller
	LangString CPro_Un_Welcome_Title ${LANG_RUSSIAN} "Добро пожаловать в мастер удаления $(^NameDA)"
	LangString CPro_Un_Welcome_Text ${LANG_RUSSIAN} "Этот мастер проведет вас через процедуру удаления $(^NameDA).$\r$\n$\r$\nПеред началом удаления убедитесь, что аддон ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} не работает.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_RUSSIAN} "Обновление файла установок winamp.ini..."
	LangString CPro_Account ${LANG_RUSSIAN} "Установки всех пользователей"
	LangString CPro_No_Account ${LANG_RUSSIAN} "Установки одного пользователя"
	LangString CPro_Winamp_Path ${LANG_RUSSIAN} "Нахождение файла установок Winamp..."	
	LangString CPro_Warning_CreateMutex		${LANG_RUSSIAN}	"${CPRO_NAME} v${CPRO_VERSION} installer is already running."
	LangString CPro_Warning_No_Winamp		${LANG_RUSSIAN} "Winamp wasn't detected on this system.$\r$\nPlease install latest Winamp version from Winamp.com,$\r$\nbefore you can install ${CPRO_NAME} v${CPRO_VERSION}.$\r$\nInstallation will be aborted."
	LangString CPro_Warning_Low_Version		${LANG_RUSSIAN} "${CPRO_NAME} v${CPRO_VERSION} requires at least Winamp ${CPRO_WINAMP_VERSION} or above.$\r$\n$\nPlease update your Winamp version first (You have installed: $R0).$\r$\nInstallation will be aborted."
	LangString CPro_Warning_AtLeast_2000	${LANG_RUSSIAN} "Sorry, your system is not supported. ${CPRO_NAME} v${CPRO_VERSION} only runs on Windows 2000 or newer.$\r$\nInstallation will be aborted."

; Close all instances of Winamp
	LangString CPro_CloseWinamp_Welcome_Title ${LANG_RUSSIAN} "Завершение работы программ"
	LangString CPro_CloseWinamp_Welcome_Text  ${LANG_RUSSIAN} "Программы, которые следует закрыть перед установкой"	
	LangString CPro_CloseWinamp_Heading ${LANG_RUSSIAN} "Закройте все программы из списка перед установкой..."
	LangString CPro_CloseWinamp_Searching ${LANG_RUSSIAN} "Идет поиск программ, пожалуйста подождите..."
	LangString CPro_CloseWinamp_EndSearch ${LANG_RUSSIAN} "Поиск программ завершен..."
	LangString CPro_CloseWinamp_EndMonitor ${LANG_RUSSIAN} "Идет закрытие программы поиска активных процессов, пожалуйста подождите..."
	LangString CPro_CloseWinamp_NoPrograms ${LANG_RUSSIAN} "Программ, которые следует закрыть, не найдено"
	LangString CPro_CloseWinamp_ColHeadings1 ${LANG_RUSSIAN} "Приложение"
	LangString CPro_CloseWinamp_ColHeadings2 ${LANG_RUSSIAN} "Процесс"
	LangString CPro_CloseWinamp_Autoclosesilent ${LANG_RUSSIAN} "Не удалось закрыть программу"
	LangString CPro_CloseWinamp_MenuItem1 ${LANG_RUSSIAN} "Close"
	LangString CPro_CloseWinamp_MenuItem2 ${LANG_RUSSIAN} "Copy list"
	
; Menu Start
	LangString CPro_MenuStart1 ${LANG_RUSSIAN} "Удалить аддон ${CPRO_NAME}"
	LangString CPro_MenuStart2 ${LANG_RUSSIAN} "Что нового"
	LangString CPro_MenuStart3 ${LANG_RUSSIAN} "Найти еще обложки и дополнения к аддону ${CPRO_NAME}!"	

	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_RUSSIAN} "Добро пожаловать. Вы устанавливаете $(^NameDA)"
	LangString CPro_Widget_Welcome_Text ${LANG_RUSSIAN} "С помощью этого мастера вы сможете установить $(^NameDA).$\r$\n$\r$\nДля работы компонента $\"${CPRO_WIDGET_NAME}$\" потребуется Winamp ${CPRO_WINAMP_VERSION} и аддон ${CPRO_NAME} ${CPRO_VERSION}!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_RUSSIAN} "Установщик ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}"	
	LangString CPro_Widget_Name_Text ${LANG_RUSSIAN} "дополнение ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}"		
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_RUSSIAN} "Добро пожаловать. Вы удаляете $(^NameDA)"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_RUSSIAN} "С помощью этого мастера вы сможете удалить $(^NameDA).$\r$\n$\r$\n$_CLICK"

; Installer sections
	LangString CPro_Widget_Files ${LANG_RUSSIAN} "${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} для ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_RUSSIAN} "Сейчас будут установлены файлы, необходимые для работы ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION}."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_RUSSIAN} "Установка ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} завершена"
	LangString CPro_Widget_FinishPage_2 ${LANG_RUSSIAN} "Мастер закончил установку ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}. Теперь вы можете пользоваться вашим новым дополнением ${CPRO_WIDGET_NAME} для аддона ${CPRO_NAME} в Winamp."
	LangString CPro_Widget_FinishPage_3 ${LANG_RUSSIAN} "Если вам понравился ${CPRO_WIDGET_NAME} и вы хотите развития продукта, пожалуйста поддержите проект материально."
	LangString CPro_Widget_FinishPage_4 ${LANG_RUSSIAN} "Что вы хотите сделать далее?"
	LangString CPro_Widget_FinishPage_5 ${LANG_RUSSIAN} "Найти больше дополнений для аддона ${CPRO_NAME} на сайте"
	LangString CPro_Widget_FinishPage_6 ${LANG_RUSSIAN} "Перезагрузить аддон ${CPRO_NAME} или открыть Winamp сейчас"
	LangString CPro_Widget_FinishPage_7 ${LANG_RUSSIAN} "Завершить"	
	
; UnFinish Page	
	LangString CPro_Widget_UnFinishPage_1 ${LANG_RUSSIAN} "Завершение работы мастера удаления дополнения ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} для аддона ${CPRO_NAME}${CPRO_CRS}"
	LangString CPro_Widget_UnFinishPage_2 ${LANG_RUSSIAN} "Дополнение ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} для аддона ${CPRO_NAME}${CPRO_CRS} было успешно удалено с вашего компьютера."
	LangString CPro_Widget_UnFinishPage_3 ${LANG_RUSSIAN} "Нажмите $(CPro_Widget_FinishPage_7) для завершения работы мастера"
	LangString CPro_Widget_UnFinishPage_4 ${LANG_RUSSIAN} "Перезагрузите аддон ${CPRO_NAME} если работает Winamp"