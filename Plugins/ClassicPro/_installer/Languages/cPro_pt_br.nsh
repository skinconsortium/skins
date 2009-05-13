;###########################################################################################

; Lang:				PortugueseBR
; LangID			1046
; Last udpdated:	09.03.2009
; Author:			Anderson Silva (candiba)
; Email:			candiba@gmail.com

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
	LangString CPro_Language_Title ${LANG_PORTUGUESE_BRAZILIAN} "Idioma do Instalador"
	LangString CPro_Un_Language_Title ${LANG_PORTUGUESE_BRAZILIAN} "Uninstaller language"	
	LangString CPro_Language_Text ${LANG_PORTUGUESE_BRAZILIAN} "Por favor selecione um idioma:"

; First Page of Installer
	LangString CPro_Welcome_Title ${LANG_PORTUGUESE_BRAZILIAN} "Bem-vindo ao Instalador do $(^NameDA)"
	LangString CPro_Welcome_Text ${LANG_PORTUGUESE_BRAZILIAN} "O Instalador o guiará na instalação do $(^NameDA).$\r$\n$\r$\nÉ recomendado que você feche o Winamp antes de iniciar a instalação. Assim facilitará a possivel atualização de todos os arquivos relevante do Winamp.$\n$\nVocê precisa ter a ultima versão, o Winamp ${CPRO_WINAMP_VERSION} para que o ${CPRO_NAME} trabalhe perfeitamente!$\r$\n$\r$\n$_CLICK"

; Installer Header
	!if ${CPRO_BUILD_TYPE} == "BETA"
; Beta stage	
		LangString CPro_Caption ${LANG_PORTUGUESE_BRAZILIAN} "Instalador do ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME}"
	!else if ${CPRO_BUILD_TYPE} == "NIGHTLY"
; Alpha stage	
		LangString CPro_Caption ${LANG_PORTUGUESE_BRAZILIAN} "Instalador do ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME} (${CPRO_DATE})"		
	!else
; Release
		LangString CPro_Caption ${LANG_PORTUGUESE_BRAZILIAN} "Instalador do ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION}"		
	!endif
	
; Installation type	
	LangString CPro_Full ${LANG_PORTUGUESE_BRAZILIAN} "Completa"
	LangString CPro_Minimal ${LANG_PORTUGUESE_BRAZILIAN} "Mínima"
	
; Installer sections
	LangString CPro_CProFiles ${LANG_PORTUGUESE_BRAZILIAN} "${CPRO_NAME} Engine"
	LangString CPro_wBrowserPro ${LANG_PORTUGUESE_BRAZILIAN} "BrowserPro"
	LangString CPro_wAlbumArt ${LANG_PORTUGUESE_BRAZILIAN} "Reproduzindo Agora"
	LangString CPro_WidgetsSection ${LANG_PORTUGUESE_BRAZILIAN} "Widgets"
	LangString CPro_CProCustom ${LANG_PORTUGUESE_BRAZILIAN} "Componentes"
	LangString CPro_cPlaylistPro ${LANG_PORTUGUESE_BRAZILIAN} "Buscar na Playlist"
		
; Installer sections descriptions	
	LangString CPro_Desc_CProFiles ${LANG_PORTUGUESE_BRAZILIAN} "Esta opção instala todos os arquivos necessários do ${CPRO_NAME}."
	LangString CPro_Desc_wBrowserPro ${LANG_PORTUGUESE_BRAZILIAN} "BrowserPro é um widget que habilitará seu browser a auto navegar em sites e explorar o diretórios."
	LangString CPro_Desc_wAlbumArt ${LANG_PORTUGUESE_BRAZILIAN} "Reproduzindo Agora é um widget que mostra capa do cd e informação do arquivo em reprodução."
	LangString CPro_Desc_WidgetsSection ${LANG_PORTUGUESE_BRAZILIAN} "Skins ${CPRO_NAME} suporta widgets e aqui você encontrará alguns que estão no pacote."
	LangString CPro_Desc_CProCustom ${LANG_PORTUGUESE_BRAZILIAN} "Componentes Opcionais para o ${CPRO_NAME}."
	LangString CPro_Desc_cPlaylistPro ${LANG_PORTUGUESE_BRAZILIAN} "Adicionar um campo de busca em sua playlist."

; Direcory Text	
	LangString CPro_DirText ${LANG_PORTUGUESE_BRAZILIAN} "Por favor selecione abaixo caminho do Winamp (você poderá continuar quando o Winamp for encontrado):"

; Cleanup Page	
	LangString CPro_CleanupPage_Title ${LANG_PORTUGUESE_BRAZILIAN} "Winamp Cleanup"
	LangString CPro_CleanupPage_Subtitle ${LANG_PORTUGUESE_BRAZILIAN} "Cleanup some Winamp Preferences."
	LangString CPro_CleanupPage_Caption0 ${LANG_PORTUGUESE_BRAZILIAN} "Using the options on this page will remove some Winamp Configuration files which may not work across different versions of both Winamp and ${CPRO_NAME}."
	LangString CPro_CleanupPage_Caption1 ${LANG_PORTUGUESE_BRAZILIAN} "If you have problems getting ${CPRO_NAME} to run properly you can reinstall ${CPRO_NAME} at any time and use this page to solve your problems."
	LangString CPro_CleanupPage_Caption2 ${LANG_PORTUGUESE_BRAZILIAN} "NOTE: It's perfectly ok, these files will be rebuilt by Winamp."
	LangString CPro_CleanupPage_Caption3 ${LANG_PORTUGUESE_BRAZILIAN} "The reinstall with these options should be used only if you are experiencing difficulties using ${CPRO_NAME} with Winamp."
	LangString CPro_CleanupPage_Caption4 ${LANG_PORTUGUESE_BRAZILIAN} "Thank you for your understanding."
	LangString CPro_CleanupPage_Footer ${LANG_PORTUGUESE_BRAZILIAN} "If you are still having problems using ${CPRO_NAME},"
	LangString CPro_CleanupPage_TSLink ${LANG_PORTUGUESE_BRAZILIAN} "Ask for free support in the Skin Consortium Forums."
	LangString CPro_CleanupPage_StudioXnf ${LANG_PORTUGUESE_BRAZILIAN} "Delete Skin Configuration (studio.xnf)"
	LangString CPro_CleanupPage_StudioXnf_Desc ${LANG_PORTUGUESE_BRAZILIAN} "Deletes skin-specific settings like: window positions, active tabs, current windowmode, ..."
	LangString CPro_CleanupPage_WinampIni ${LANG_PORTUGUESE_BRAZILIAN} "Delete Winamp Configuration (winamp.ini)"
	LangString CPro_CleanupPage_WinampIni_Desc ${LANG_PORTUGUESE_BRAZILIAN} "Deletes winamp-specific settings like: current skin, advanced title formatting, current language, ..."

; Finish Page	
	LangString CPro_FinishPage_1 ${LANG_PORTUGUESE_BRAZILIAN} "Instalação do ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} finalizada."
	LangString CPro_FinishPage_2 ${LANG_PORTUGUESE_BRAZILIAN} "O instalador finalizou a instalação do ${CPRO_NAME} v${CPRO_VERSION}. Você pode usar as Skins ${CPRO_NAME} e widgets no Winamp."
	LangString CPro_FinishPage_3 ${LANG_PORTUGUESE_BRAZILIAN} "Se você gostou do ${CPRO_NAME} e gostaria de ajudar no desenvolvimento futuro do produto por favor faça uma doação."
	LangString CPro_FinishPage_4 ${LANG_PORTUGUESE_BRAZILIAN} "O que deseja fazer agora?"
	LangString CPro_FinishPage_5 ${LANG_PORTUGUESE_BRAZILIAN} "Ir para nossa homepage e adquirir mais Skins ${CPRO_NAME} e widgets."
	LangString CPro_FinishPage_6 ${LANG_PORTUGUESE_BRAZILIAN} "Open Winamp with the default ${CPRO_NAME} skin now"
	LangString CPro_FinishPage_7 ${LANG_PORTUGUESE_BRAZILIAN} "Finalzar"	
	
; First Page of Uninstaller
	LangString CPro_Un_Welcome_Title ${LANG_PORTUGUESE_BRAZILIAN} "Bem-vindo ao Desinstalador do $(^NameDA)"
	LangString CPro_Un_Welcome_Text ${LANG_PORTUGUESE_BRAZILIAN} "O Desinstalador o guiará na desinstalação do $(^NameDA).$\r$\n$\r$\nAntes de iniciar a desinstalação, tenha certeza que o ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} não está em execução.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_PORTUGUESE_BRAZILIAN} "Atualizando o winamp.ini arquivo de configuração..."
	LangString CPro_Account ${LANG_PORTUGUESE_BRAZILIAN} "Configurações Multi-usuário"
	LangString CPro_No_Account ${LANG_PORTUGUESE_BRAZILIAN} "Sem configurações Multi-usuário"
	LangString CPro_Winamp_Path ${LANG_PORTUGUESE_BRAZILIAN} "Especificando o caminho do arquivo de configuração do Winamp..."	

; Close all instances of Winamp
	LangString CPro_CloseWinamp_Welcome_Title ${LANG_PORTUGUESE_BRAZILIAN} "Programs to close"
	LangString CPro_CloseWinamp_Welcome_Text  ${LANG_PORTUGUESE_BRAZILIAN} "Programs, that must be closed before continuing installation"	
	LangString CPro_CloseWinamp_Heading ${LANG_PORTUGUESE_BRAZILIAN} "Close all programs from the list before continuing installation..."
	LangString CPro_CloseWinamp_Searching ${LANG_PORTUGUESE_BRAZILIAN} "Searching programs, please wait..."
	LangString CPro_CloseWinamp_EndSearch ${LANG_PORTUGUESE_BRAZILIAN} "Searching programs finished..."
	LangString CPro_CloseWinamp_EndMonitor ${LANG_PORTUGUESE_BRAZILIAN} "Closing active process monitor, please wait..."
	LangString CPro_CloseWinamp_NoPrograms ${LANG_PORTUGUESE_BRAZILIAN} "Installer didn't find any programs to close"
	LangString CPro_CloseWinamp_ColHeadings1 ${LANG_PORTUGUESE_BRAZILIAN} "Application"
	LangString CPro_CloseWinamp_ColHeadings2 ${LANG_PORTUGUESE_BRAZILIAN} "Process"
	LangString CPro_CloseWinamp_Autoclosesilent ${LANG_PORTUGUESE_BRAZILIAN} "Closing program failed"

; Menu Start
	LangString CPro_MenuStart1 ${LANG_PORTUGUESE_BRAZILIAN} "Desinstalar ${CPRO_NAME}"
	LangString CPro_MenuStart2 ${LANG_PORTUGUESE_BRAZILIAN} "Novidades"
	LangString CPro_MenuStart3 ${LANG_PORTUGUESE_BRAZILIAN} "Baixar Skins ${CPRO_NAME} e widgets!"	

	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_PORTUGUESE_BRAZILIAN} "Welcome to the $(^NameDA) Setup Wizard"
	LangString CPro_Widget_Welcome_Text ${LANG_PORTUGUESE_BRAZILIAN} "This wizard will guide you through the installation of $(^NameDA).$\r$\n$\r$\nYou'll at least need Winamp ${CPRO_WINAMP_VERSION} and ${CPRO_NAME} ${CPRO_VERSION} for this version of ${CPRO_WIDGET_NAME} to work!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_PORTUGUESE_BRAZILIAN} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Setup"	
	LangString CPro_Widget_Name_Text ${LANG_PORTUGUESE_BRAZILIAN} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS}"		
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_PORTUGUESE_BRAZILIAN} "Welcome to the $(^NameDA) Uninstall Wizard"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_PORTUGUESE_BRAZILIAN} "This wizard will guide you through the uninstallation of $(^NameDA).$\r$\n$\r$\n$_CLICK"

; Installer sections
	LangString CPro_Widget_Files ${LANG_PORTUGUESE_BRAZILIAN} "${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} for ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_PORTUGUESE_BRAZILIAN} "This will install all the files that ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} needs to work."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_PORTUGUESE_BRAZILIAN} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} installation finished"
	LangString CPro_Widget_FinishPage_2 ${LANG_PORTUGUESE_BRAZILIAN} "The setup wizard has finished installing ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}. You can now start using your new ${CPRO_WIDGET_NAME} widget for ${CPRO_NAME} in Winamp."
	LangString CPro_Widget_FinishPage_3 ${LANG_PORTUGUESE_BRAZILIAN} "If you like ${CPRO_WIDGET_NAME} and would like to help future development of the product please donate to the project."
	LangString CPro_Widget_FinishPage_4 ${LANG_PORTUGUESE_BRAZILIAN} "What do you want to do now?"
	LangString CPro_Widget_FinishPage_5 ${LANG_PORTUGUESE_BRAZILIAN} "Go to our homepage to get more ${CPRO_NAME} widgets"
	LangString CPro_Widget_FinishPage_6 ${LANG_PORTUGUESE_BRAZILIAN} "Reload ${CPRO_NAME} or open Winamp now"
	LangString CPro_Widget_FinishPage_7 ${LANG_PORTUGUESE_BRAZILIAN} "Finish"	
	
; UnFinish Page	
	LangString CPro_Widget_UnFinishPage_1 ${LANG_PORTUGUESE_BRAZILIAN} "Completing the ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS} Uninstall Wizard"
	LangString CPro_Widget_UnFinishPage_2 ${LANG_PORTUGUESE_BRAZILIAN} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS} has been uninstalled from your computer."
	LangString CPro_Widget_UnFinishPage_3 ${LANG_PORTUGUESE_BRAZILIAN} "Click $(CPro_Widget_FinishPage_7) to close this wizard"
	LangString CPro_Widget_UnFinishPage_4 ${LANG_PORTUGUESE_BRAZILIAN} "Reload ${CPRO_NAME} if Winamp is running"