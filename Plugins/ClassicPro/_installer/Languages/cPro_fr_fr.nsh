;###########################################################################################

; Lang:			French
; LangID			1036
; Last udpdated:		07.03.2009
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
	LangString Language_Title ${LANG_FRENCH} "Langue du programme d'installation"
	LangString Language_Text ${LANG_FRENCH} "Veuillez sélectionner une langue :"

; First Page of Installer
	LangString Welcome_Title ${LANG_FRENCH} "Bienvenue dans l'assistant d'installation de $(^NameDA)"
	LangString Welcome_Text ${LANG_FRENCH} "Cet assistant va vous guider pour installer $(^NameDA).$\r$\n$\r$\nIl est recommandé de fermer Winamp avant de démarrer cette installation, afin de mettre à jour les fichiers nécessaires.$\n$\nVous devez utiliser au moins Winamp ${CPRO_WINAMP_VERSION} pour cette version de ${CPRO_NAME} !$\r$\n$\r$\n$_CLICK"

; Installer Header
	!ifdef CPRO_BETA
; Beta stage	
		LangString CPro_Caption ${LANG_FRENCH} "Installation de ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BETA}"
	!else
; Release
		LangString CPro_Caption ${LANG_FRENCH} "Installation de ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION}"
	!endif
	
; Installation type	
	LangString CPro_Full ${LANG_FRENCH} "Complète"
	LangString CPro_Minimal ${LANG_FRENCH} "Minimale"
	
; Installer sections
	LangString CProFiles ${LANG_FRENCH} "Moteur ClassicPro"
	LangString wBrowserPro ${LANG_FRENCH} "NavigateurPro v2.0"
	LangString wAlbumArt ${LANG_FRENCH} "AlbumArt v1.1"
	LangString WidgetsSection ${LANG_FRENCH} "Gadgets"
	LangString CProCustom ${LANG_FRENCH} "Composants"
	LangString cPlaylistPro ${LANG_FRENCH} "Recherche dans les listes"
		
; Installer sections descriptions	
	LangString Desc_CProFiles ${LANG_FRENCH} "Cela installer tous les fichiers nécessaire au bon fonctionnement de ClassicPro."
	LangString Desc_wBrowserPro ${LANG_FRENCH} "NavigateurPro est un gadget qui activera la navigation automatique vers des sitespopulaires, ainsi qu'explorer le dossier en cours de lecture."
	LangString Desc_wAlbumArt ${LANG_FRENCH} "AlbumArt est un gadget qui affiche une grande jaquette, ainsi que des informations sur le fichier en cours de lecture."
	LangString Desc_WidgetsSection ${LANG_FRENCH} "Les skins ClassicPro supportent les gadget et vous pouvez en trouver ici certains que nous avont décider d'inclure dans cette installation."
	LangString Desc_CProCustom ${LANG_FRENCH} "Composants optionnels pour ClassicPro."
	LangString Desc_cPlaylistPro ${LANG_FRENCH} "Ajoute un champ de recherche au dessus de la liste de lecture pour des recherches simplifiées."

; Direcory Text	
	LangString CPro_DirText ${LANG_FRENCH} "Veuillez sélectionner le dossier de Winamp (vous pourrez continuer lorsque Winamp sera détecté) :"

; Finish Page	
	LangString FinishPage_1 ${LANG_FRENCH} "Installation de ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} terminée"
	LangString FinishPage_2 ${LANG_FRENCH} "L'assistant a terminé l'installation de ${CPRO_NAME} v${CPRO_VERSION}. Vous pouvez désormais utiliser les skins et les gadgets de ${CPRO_NAME} dans Winamp."
	LangString FinishPage_3 ${LANG_FRENCH} "Si vous aimez ${CPRO_NAME} et souhaitez aider le développement futur du produit, vous pouvez faire une donation au projet."
	LangString FinishPage_4 ${LANG_FRENCH} "Que voulez-vous faire ?"
	LangString FinishPage_5 ${LANG_FRENCH} "Aller à la page d'accueil pour obtenir plus de skins et de gadgets ${CPRO_NAME}"
	LangString FinishPage_6 ${LANG_FRENCH} "Ouvrir le skin ${CPRO_NAME} par défaut"
	LangString FinishPage_7 ${LANG_FRENCH} "Terminer"	
	LangString FinishPage_8 ${LANG_FRENCH} "https://www.paypal.com/uk/cgi-bin/webscr?cmd=_flow&SESSION=8h5vlcm9CV3GH2N6PEu7syhffIV0c0JgJ4QZ2FUWaJRiYKCliUrjeMQMtZS&dispatch=5885d80a13c0db1fa798f5a5f5ae42e71cf8ee1e360382336fe24cc0d575d12c"
	
; First Page of Uninstaller
	LangString Un_Welcome_Title ${LANG_FRENCH} "Bienvenue dans l'assistant de désinstallation de $(^NameDA)"
	LangString Un_Welcome_Text ${LANG_FRENCH} "Cet assistant va vous guider pour désinstaller $(^NameDA).$\r$\n$\r$\nAvant de lancer la désinstallation, vérifiez que ${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} n'est pas démarré.$\r$\n$\r$\n$_CLICK"

; Installation
	LangString CPro_Ini ${LANG_FRENCH} "Mise à jour du fichier de configuration the winamp.ini..."
	LangString CPro_Account ${LANG_FRENCH} "Paramètres multi-utilisateurs"
	LangString CPro_No_Account ${LANG_FRENCH} "Pas de paramètres multi-utilisateurs"
	LangString CPro_Winamp_Path ${LANG_FRENCH} "Veuillez spécifier le dossier du fichier de configuration de Winamp..."	

; Close all instances of Winamp
	LangString CPro_Running_Winamp ${LANG_FRENCH} "Winamp est en cours d'utilisation !"
	LangString CPro_Close_Winamp  ${LANG_FRENCH} "Avant de continuer, vous devez fermer toutes les instances de Winamp !"
	LangString CPro_Closing_Winamp ${LANG_FRENCH} "        Fermeture de Winamp (winamp.exe)..."
	LangString CPro_No_More_Winamp ${LANG_FRENCH} "        OK. Toutes les instances de Winamp sont fermées..."  
	LangString CPro_No_Winamp ${LANG_FRENCH} "OK. Aucune instance de Winamp ne fonctionne..."
	LangString CPro_Check_Winamp ${LANG_FRENCH} "Vérification de l'état de Winamp..."

; Menu Start
	LangString CPro_MenuStart1 ${LANG_FRENCH} "Désinstallation de ${CPRO_NAME}"
	LangString CPro_MenuStart2 ${LANG_FRENCH} "Quoi de neuf ?"
	LangString CPro_MenuStart3 ${LANG_FRENCH} "Obtenir plus de skins et de gadgets ${CPRO_NAME} !"	
		