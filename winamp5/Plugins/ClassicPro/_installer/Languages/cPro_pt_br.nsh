;###########################################################################################

; Lang:			PortugueseBR
; LangID			1046
; Last udpdated:		09.03.2009
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
	LangString CPro_Language_Text ${LANG_PORTUGUESE_BRAZILIAN} "Por favor selecione um idioma:"

; First Page of Installer
	LangString CPro_Welcome_Title ${LANG_PORTUGUESE_BRAZILIAN} "Bem-vindo ao Instalador do $(^NameDA)"
	LangString CPro_Welcome_Text ${LANG_PORTUGUESE_BRAZILIAN} "O Instalador o guiará na instalação do $(^NameDA).$\r$\n$\r$\nÉ recomendado que você feche o Winamp antes de iniciar a instalação. Assim facilitará a possivel atualização de todos os arquivos relevante do Winamp.$\n$\nVocê precisa ter a ultima versão, o Winamp ${CPRO_WINAMP_VERSION} para que o ${CPRO_NAME} trabalhe perfeitamente!$\r$\n$\r$\n$_CLICK"

; Installer Header
	!ifdef CPRO_BETA
; Beta stage	
		LangString CPro_Caption ${LANG_PORTUGUESE_BRAZILIAN} "Instalador do ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BETA}"
	!else
; Release
		LangString CPro_Caption ${LANG_PORTUGUESE_BRAZILIAN} "Instalador do ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION}"
	!endif
	
; Installation type	
	LangString CPro_Full ${LANG_PORTUGUESE_BRAZILIAN} "Completa"
	LangString CPro_Minimal ${LANG_PORTUGUESE_BRAZILIAN} "Mínima"
	
; Installer sections
	LangString CPro_CProFiles ${LANG_PORTUGUESE_BRAZILIAN} "ClassicPro Engine"
	LangString CPro_wBrowserPro ${LANG_PORTUGUESE_BRAZILIAN} "BrowserPro"
	LangString CPro_wAlbumArt ${LANG_PORTUGUESE_BRAZILIAN} "Reproduzindo Agora"
	LangString CPro_WidgetsSection ${LANG_PORTUGUESE_BRAZILIAN} "Widgets"
	LangString CPro_CProCustom ${LANG_PORTUGUESE_BRAZILIAN} "Componentes"
	LangString CPro_cPlaylistPro ${LANG_PORTUGUESE_BRAZILIAN} "Buscar na Playlist"
		
; Installer sections descriptions	
	LangString CPro_Desc_CProFiles ${LANG_PORTUGUESE_BRAZILIAN} "Esta opção instala todos os arquivos necessários do ClassicPro."
	LangString CPro_Desc_wBrowserPro ${LANG_PORTUGUESE_BRAZILIAN} "BrowserPro é um widget que habilitará seu browser a auto navegar em sites e explorar o diretórios."
	LangString CPro_Desc_wAlbumArt ${LANG_PORTUGUESE_BRAZILIAN} "Reproduzindo Agora é um widget que mostra capa do cd e informação do arquivo em reprodução."
	LangString CPro_Desc_WidgetsSection ${LANG_PORTUGUESE_BRAZILIAN} "Skins ClassicPro suporta widgets e aqui você encontrará alguns que estão no pacote."
	LangString CPro_Desc_CProCustom ${LANG_PORTUGUESE_BRAZILIAN} "Componentes Opcionais para o ClassicPro."
	LangString CPro_Desc_cPlaylistPro ${LANG_PORTUGUESE_BRAZILIAN} "Adicionar um campo de busca em sua playlist."

; Direcory Text	
	LangString CPro_DirText ${LANG_PORTUGUESE_BRAZILIAN} "Por favor selecione abaixo caminho do Winamp (você poderá continuar quando o Winamp for encontrado):"

; Finish Page	
	LangString CPro_FinishPage_1 ${LANG_PORTUGUESE_BRAZILIAN} "Instalação do ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} finalizada."
	LangString CPro_FinishPage_2 ${LANG_PORTUGUESE_BRAZILIAN} "O instalador finalizou a instalação do ${CPRO_NAME} v${CPRO_VERSION}. Você pode usar as Skins ${CPRO_NAME} e widgets no Winamp."
	LangString CPro_FinishPage_3 ${LANG_PORTUGUESE_BRAZILIAN} "Se você gostou do ${CPRO_NAME} e gostaria de ajudar no desenvolvimento futuro do produto por favor faça uma doação."
	LangString CPro_FinishPage_4 ${LANG_PORTUGUESE_BRAZILIAN} "O que deseja fazer agora?"
	LangString CPro_FinishPage_5 ${LANG_PORTUGUESE_BRAZILIAN} "Ir para nossa homepage e adquirir mais Skins ${CPRO_NAME} e widgets."
	LangString CPro_FinishPage_6 ${LANG_PORTUGUESE_BRAZILIAN} "Abrir a Skin ${CPRO_NAME} padrão agora"
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
	LangString CPro_Running_Winamp ${LANG_PORTUGUESE_BRAZILIAN} "O Winamp está em execução!"
	LangString CPro_Close_Winamp  ${LANG_PORTUGUESE_BRAZILIAN} "Antes de continuar, você deve encerrar todas as instâncias do Winamp!"	
	LangString CPro_Closing_Winamp ${LANG_PORTUGUESE_BRAZILIAN} "        Fechando o Winamp (winamp.exe)..."
	LangString CPro_No_More_Winamp ${LANG_PORTUGUESE_BRAZILIAN} "        OK. Todas as instâncias do Winamp foram encerradas..."  
	LangString CPro_No_Winamp ${LANG_PORTUGUESE_BRAZILIAN} "OK. Nenhuma instância do Winamp em execução..."
	LangString CPro_Check_Winamp ${LANG_PORTUGUESE_BRAZILIAN} "Checando se o Winamp está em execução..."

; Menu Start
	LangString CPro_MenuStart1 ${LANG_PORTUGUESE_BRAZILIAN} "Desinstalar ${CPRO_NAME}"
	LangString CPro_MenuStart2 ${LANG_PORTUGUESE_BRAZILIAN} "Novidades"
	LangString CPro_MenuStart3 ${LANG_PORTUGUESE_BRAZILIAN} "Baixar Skins ${CPRO_NAME} e widgets!"	
	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_PORTUGUESE_BRAZILIAN} "Bem-vindo ao Instalador do $(^NameDA)"
	LangString CPro_Widget_Welcome_Text ${LANG_PORTUGUESE_BRAZILIAN} "O Instalador o guiará na instalação do $(^NameDA).$\r$\n$\r$\nÉ recomendado que você feche o Winamp antes de iniciar a instalação. Assim facilitará a possivel atualização de todos os arquivos relevante do Winamp.$\n$\nVocê precisa ter a ultima versão, o Winamp ${CPRO_WINAMP_VERSION} e ${CPRO_NAME} ${CPRO_VERSION} para que esta versão do ${CPRO_WIDGET_NAME} funcione!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_PORTUGUESE_BRAZILIAN} "Instalador do ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}"	
	LangString CPro_Widget_Name_Text ${LANG_PORTUGUESE_BRAZILIAN} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget para Skin ClassicPro©"		
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_PORTUGUESE_BRAZILIAN} "Bem-vindo ao Desinstalador do $(^NameDA)"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_PORTUGUESE_BRAZILIAN} "O Desinstalador o guiará na desinstalação do $(^NameDA).$\r$\n$\r$\nAntes de iniciar a desinstalação, tenha certeza que o ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} não está em execução.$\r$\n$\r$\n$_CLICK"
	
; Installer sections
	LangString CPro_Widget_Files ${LANG_PORTUGUESE_BRAZILIAN} "${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} para ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_PORTUGUESE_BRAZILIAN} "Será instalado todo os arquivos necessários para que o ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} trabalhe perfeitamente."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_PORTUGUESE_BRAZILIAN} "Instalação finalizada do ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}"
	LangString CPro_Widget_FinishPage_2 ${LANG_PORTUGUESE_BRAZILIAN} "O Instalador finalizadou a instalaçao do ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}. Você pode agora usar o novo widget ${CPRO_WIDGET_NAME} para Skins ${CPRO_NAME} no Winamp."
	LangString CPro_Widget_FinishPage_3 ${LANG_PORTUGUESE_BRAZILIAN} "Se você gostou do ${CPRO_WIDGET_NAME} ae gostaria de ajudar no desenvolvimento futuro do produto por favor faça uma doação."
	LangString CPro_Widget_FinishPage_4 ${LANG_PORTUGUESE_BRAZILIAN} "O que deseja fazer agora?"
	LangString CPro_Widget_FinishPage_5 ${LANG_PORTUGUESE_BRAZILIAN} "Ir para nossa homepage e adquirir mais Skins ${CPRO_NAME} e widgets"
	LangString CPro_Widget_FinishPage_6 ${LANG_PORTUGUESE_BRAZILIAN} "Abrir Skin ${CPRO_NAME} padrão agora"
	LangString CPro_Widget_FinishPage_7 ${LANG_PORTUGUESE_BRAZILIAN} "Finalizar"		