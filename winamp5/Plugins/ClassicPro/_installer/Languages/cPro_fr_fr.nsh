;###########################################################################################

; Lang:				French
; LangID			1036
; Last udpdated:	10.03.2009
; Author:			Veekee (for Todae)
; Email:			veekee@todae.fr

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
	LangString CPro_Language_Title ${LANG_FRENCH} "Langue du programme d'installation"
	LangString CPro_Un_Language_Title ${LANG_FRENCH} "Uninstaller language"	
	LangString CPro_Language_Text ${LANG_FRENCH} "Veuillez sélectionner une langue :"

; First Page of Installer
	LangString CPro_Welcome_Title ${LANG_FRENCH} "Bienvenue dans l'assistant d'installation de $(^NameDA)"
	LangString CPro_Welcome_Text ${LANG_FRENCH} "Cet assistant va vous guider pour installer $(^NameDA).$\r$\n$\r$\nIl est recommandé de fermer Winamp avant de démarrer cette installation, afin de mettre à jour les fichiers nécessaires.$\n$\nVous devez utiliser au moins Winamp ${CPRO_WINAMP_VERSION} pour cette version de ${CPRO_NAME} !$\r$\n$\r$\n$_CLICK"

; Installer Header
	!if ${CPRO_BUILD_TYPE} == "BETA"
; Beta stage	
		LangString CPro_Caption ${LANG_FRENCH} "Installation de ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME}"
	!else if ${CPRO_BUILD_TYPE} == "NIGHTLY"
; Alpha stage	
		LangString CPro_Caption ${LANG_FRENCH} "Installation de ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BUILD_NAME} (${CPRO_DATE})"		
	!else
; Release
		LangString CPro_Caption ${LANG_FRENCH} "Installation de ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION}"		
	!endif
	
; Installation type	
	LangString CPro_Full ${LANG_FRENCH} "Complète"
	LangString CPro_Minimal ${LANG_FRENCH} "Minimale"
	
; Installer sections
	LangString CPro_CProFiles ${LANG_FRENCH} "Moteur ${CPRO_NAME}"
	LangString CPro_wBrowserPro ${LANG_FRENCH} "NavigateurPro"
	LangString CPro_wAlbumArt ${LANG_FRENCH} "AlbumArt"
	LangString CPro_WidgetsSection ${LANG_FRENCH} "Gadgets"
	LangString CPro_CProCustom ${LANG_FRENCH} "Composants"
	LangString CPro_cPlaylistPro ${LANG_FRENCH} "Recherche dans les listes"
		
; Installer sections descriptions	
	LangString CPro_Desc_CProFiles ${LANG_FRENCH} "Cela installer tous les fichiers nécessaire au bon fonctionnement de ${CPRO_NAME}."
	LangString CPro_Desc_wBrowserPro ${LANG_FRENCH} "NavigateurPro est un gadget qui activera la navigation automatique vers des sitespopulaires, ainsi qu'explorer le dossier en cours de lecture."
	LangString CPro_Desc_wAlbumArt ${LANG_FRENCH} "AlbumArt est un gadget qui affiche une grande jaquette, ainsi que des informations sur le fichier en cours de lecture."
	LangString CPro_Desc_WidgetsSection ${LANG_FRENCH} "Les skins ${CPRO_NAME} supportent les gadget et vous pouvez en trouver ici certains que nous avont décider d'inclure dans cette installation."
	LangString CPro_Desc_CProCustom ${LANG_FRENCH} "Composants optionnels pour ${CPRO_NAME}."
	LangString CPro_Desc_cPlaylistPro ${LANG_FRENCH} "Ajoute un champ de recherche au dessus de la liste de lecture pour des recherches simplifiées."

; Direcory Text	
	LangString CPro_DirText ${LANG_FRENCH} "Veuillez sélectionner le dossier de Winamp (vous pourrez continuer lorsque Winamp sera détecté) :"

; Cleanup Page	
	LangString CPro_CleanupPage_Title ${LANG_FRENCH} "Winamp Cleanup"
	LangString CPro_CleanupPage_Subtitle ${LANG_FRENCH} "Cleanup some Winamp Preferences."
	LangString CPro_CleanupPage_Caption0 ${LANG_FRENCH} "Using the options on this page will remove some Winamp Configuration files which may not work across different versions of both Winamp and ${CPRO_NAME}."
	LangString CPro_CleanupPage_Caption1 ${LANG_FRENCH} "If you have problems getting ${CPRO_NAME} to run properly you can reinstall ${CPRO_NAME} at any time and use this page to solve your problems."
	LangString CPro_CleanupPage_Caption2 ${LANG_FRENCH} "NOTE: It's perfectly ok, these files will be rebuilt by Winamp."
	LangString CPro_CleanupPage_Caption3 ${LANG_FRENCH} "The reinstall with these options should be used only if you are experiencing difficulties using ${CPRO_NAME} with Winamp."
	LangString CPro_CleanupPage_Caption4 ${LANG_FRENCH} "Thank you for your understanding."
	LangString CPro_CleanupPage_Footer ${LANG_FRENCH} "If you are still having problems using ${CPRO_NAME},"
	LangString CPro_CleanupPage_TSLink ${LANG_FRENCH} "Ask for free support in the Skin Consortium Forums."
	LangString CPro_CleanupPage_StudioXnf ${LANG_FRENCH} "Delete Skin Configuration (studio.xnf)"
	LangString CPro_CleanupPage_StudioXnf_Desc ${LANG_FRENCH} "Deletes skin-specific settings like: window positions, active tabs, current windowmode, ..."
	LangString CPro_CleanupPage_WinampIni ${LANG_FRENCH} "Delete Winamp Configuration (winamp.ini)"
	LangString CPro_CleanupPage_WinampIni_Desc ${LANG_FRENCH} "Deletes winamp-specific settings like: current skin, advanced title formatting, current language, ..."

; Finish Page
	LangString CPro_FinishPage_1 ${LANG_FRENCH} "Installation de ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} terminée"
	LangString CPro_FinishPage_2 ${LANG_FRENCH} "L'assistant a terminé l'installation de ${CPRO_NAME} v${CPRO_VERSION}. Vous pouvez désormais utiliser les skins et les gadgets de ${CPRO_NAME} dans Winamp."
	LangString CPro_FinishPage_3 ${LANG_FRENCH} "Si vous aimez ${CPRO_NAME} et souhaitez aider le développement futur du produit, vous pouvez faire une donation au projet."
	LangString CPro_FinishPage_4 ${LANG_FRENCH} "Que voulez-vous faire ?"
	LangString CPro_FinishPage_5 ${LANG_FRENCH} "Afficher le site de ${CPRO_NAME} pour plus de skins / gadgets"
	LangString CPro_FinishPage_6 ${LANG_FRENCH} "Open Winamp with the default ${CPRO_NAME} skin now"
	LangString CPro_FinishPage_7 ${LANG_FRENCH} "Terminer"
	
; First Page of Uninstaller
	LangString CPro_Un_Welcome_Title ${LANG_FRENCH} "Bienvenue dans l'assistant de désinstallation de $(^NameDA)"
	LangString CPro_Un_Welcome_Text ${LANG_FRENCH} "Cet assistant va vous guider pour désinstaller $(^NameDA).$\r$\n$\r$\nAvant de lancer la désinstallation, vérifiez que ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} n'est pas démarré.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_FRENCH} "Mise à jour du fichier de configuration the winamp.ini..."
	LangString CPro_Account ${LANG_FRENCH} "Paramètres multi-utilisateurs"
	LangString CPro_No_Account ${LANG_FRENCH} "Pas de paramètres multi-utilisateurs"
	LangString CPro_Winamp_Path ${LANG_FRENCH} "Veuillez spécifier le dossier du fichier de configuration de Winamp..."	

; Close all instances of Winamp
	LangString CPro_CloseWinamp_Welcome_Title ${LANG_FRENCH} "Programs to close"
	LangString CPro_CloseWinamp_Welcome_Text  ${LANG_FRENCH} "Programs, that must be closed before continuing installation"	
	LangString CPro_CloseWinamp_Heading ${LANG_FRENCH} "Close all programs from the list before continuing installation..."
	LangString CPro_CloseWinamp_Searching ${LANG_FRENCH} "Searching programs, please wait..."
	LangString CPro_CloseWinamp_EndSearch ${LANG_FRENCH} "Searching programs finished..."
	LangString CPro_CloseWinamp_EndMonitor ${LANG_FRENCH} "Closing active process monitor, please wait..."
	LangString CPro_CloseWinamp_NoPrograms ${LANG_FRENCH} "Installer didn't find any programs to close"
	LangString CPro_CloseWinamp_ColHeadings1 ${LANG_FRENCH} "Application"
	LangString CPro_CloseWinamp_ColHeadings2 ${LANG_FRENCH} "Process"
	LangString CPro_CloseWinamp_Autoclosesilent ${LANG_FRENCH} "Closing program failed"

; Menu Start
	LangString CPro_MenuStart1 ${LANG_FRENCH} "Désinstallation de ${CPRO_NAME}"
	LangString CPro_MenuStart2 ${LANG_FRENCH} "Quoi de neuf ?"
	LangString CPro_MenuStart3 ${LANG_FRENCH} "Obtenir plus de skins et de gadgets ${CPRO_NAME} !"	

	
; CPro :: Widgets

; First Page of Installer
	LangString CPro_Widget_Welcome_Title ${LANG_FRENCH} "Welcome to the $(^NameDA) Setup Wizard"
	LangString CPro_Widget_Welcome_Text ${LANG_FRENCH} "This wizard will guide you through the installation of $(^NameDA).$\r$\n$\r$\nYou'll at least need Winamp ${CPRO_WINAMP_VERSION} and ${CPRO_NAME} ${CPRO_VERSION} for this version of ${CPRO_WIDGET_NAME} to work!$\r$\n$\r$\n$_CLICK"

	LangString CPro_Widget_Caption ${LANG_FRENCH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} Setup"	
	LangString CPro_Widget_Name_Text ${LANG_FRENCH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS}"		
	
; First Page of Uninstaller
	LangString CPro_Widget_Un_Welcome_Title ${LANG_FRENCH} "Welcome to the $(^NameDA) Uninstall Wizard"
	LangString CPro_Widget_Un_Welcome_Text ${LANG_FRENCH} "This wizard will guide you through the uninstallation of $(^NameDA).$\r$\n$\r$\n$_CLICK"

; Installer sections
	LangString CPro_Widget_Files ${LANG_FRENCH} "${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} for ${CPRO_NAME}${CPRO_CRS} ${CPRO_VERSION}"
		
; Installer sections descriptions	
	LangString CPro_Widget_Desc_Files ${LANG_FRENCH} "This will install all the files that ${CPRO_WIDGET_NAME} ${CPRO_WIDGET_VERSION} needs to work."

; Finish Page	
	LangString CPro_Widget_FinishPage_1 ${LANG_FRENCH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} installation finished"
	LangString CPro_Widget_FinishPage_2 ${LANG_FRENCH} "The setup wizard has finished installing ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}. You can now start using your new ${CPRO_WIDGET_NAME} widget for ${CPRO_NAME} in Winamp."
	LangString CPro_Widget_FinishPage_3 ${LANG_FRENCH} "If you like ${CPRO_WIDGET_NAME} and would like to help future development of the product please donate to the project."
	LangString CPro_Widget_FinishPage_4 ${LANG_FRENCH} "What do you want to do now?"
	LangString CPro_Widget_FinishPage_5 ${LANG_FRENCH} "Go to our homepage to get more ${CPRO_NAME} widgets"
	LangString CPro_Widget_FinishPage_6 ${LANG_FRENCH} "Reload ${CPRO_NAME} or open Winamp now"
	LangString CPro_Widget_FinishPage_7 ${LANG_FRENCH} "Finish"	
	
; UnFinish Page	
	LangString CPro_Widget_UnFinishPage_1 ${LANG_FRENCH} "Completing the ${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS} Uninstall Wizard"
	LangString CPro_Widget_UnFinishPage_2 ${LANG_FRENCH} "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION} widget for ${CPRO_NAME}${CPRO_CRS} has been uninstalled from your computer."
	LangString CPro_Widget_UnFinishPage_3 ${LANG_FRENCH} "Click $(CPro_Widget_FinishPage_7) to close this wizard"
	LangString CPro_Widget_UnFinishPage_4 ${LANG_FRENCH} "Reload ${CPRO_NAME} if Winamp is running"