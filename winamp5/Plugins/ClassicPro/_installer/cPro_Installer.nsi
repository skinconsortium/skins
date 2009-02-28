;###########################################################################################
;###########################################################################################
;#
;#										      ClassicPro Installer         
;#									   Copyright (c) 2009 by Pawe³ Porwisz                                   
;#
;###########################################################################################
;###########################################################################################

;Definitions
	!define CPRO_SOURCEPATH "ClassicPro"
	!define CPRO_NAME "ClassicPro"
	!define CPRO_CRS "©"
	!define CPRO_VERSION "1.1"
	!define CPRO_REVISION "0"
	!define CPRO_BUILD "0"
	!define /Date CPRO_DATE "%Y-%m-%d"
	!define CPRO_BT "http://cpro.skinconsortium.com"
	!define CPRO_WEB_PAGE "http://cpro.skinconsortium.com/"
	!define CPRO_AUTHOR "Skin Consortium"
	!define CPRO_COMPANY "Skin Consortium"
	!define CPRO_COPYRIGHT "Copyright (c) 2005-2009"	
;	!define CPRO_HELP_LINK "http://cpro.skinconsortium.com/"
	!define CPRO_UNINSTALLER "Uninstall ClassicPro"	
	!define CPRO_WINAMP_VERSION "5.55"
	!define CPRO_WINAMP_SKINS "C:\Program Files\Winamp\Skins"
	!define CPRO_WINAMP_SYSTEM "C:\Program Files\Winamp\System"	
;Unselect when release version
	;!define CPRO_BETA "- Beta"
	
;###########################################################################################
;#											CONFIGURATION
;###########################################################################################

	!ifdef CPRO_BETA
; Beta stage	
		Name "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION} ${CPRO_BETA}"
		OutFile "..\..\${CPRO_NAME}_${CPRO_VERSION}_(${CPRO_DATE}).exe"
	!else
; Release
		Name "${CPRO_NAME}${CPRO_CRS} v${CPRO_VERSION}"
		OutFile "..\..\${CPRO_NAME}_${CPRO_VERSION}.exe"		
	!endif

	SetCompressor /SOLID lzma
	Caption "$(CPro_Caption)"
	BrandingText "${CPRO_BT}"
	
	;ReserveFile "Plugins\Linker.dll"
	
; Plugins Dir   
	!addplugindir "Plugins"  
   
;###########################################################################################
;#										    DESTINATION FOLDER
;###########################################################################################

	InstallDir "$PROGRAMFILES\Winamp"
	InstallDirRegKey "HKLM" "Software\Microsoft\Windows\CurrentVersion\Uninstall\Winamp" "UninstallString"
	RequestExecutionLevel "admin"
	XPStyle "on"

;###########################################################################################
;#										  	HEADER FILES
;###########################################################################################

	!include "MUI2.nsh"
	!include "Sections.nsh"
	!include "nsDialogs.nsh"
;	!include "LogicLib.nsh"	
	
;###########################################################################################
;#										    INTERFACE SETTINGS 
;###########################################################################################

	DirText "$(CPro_DirText)"
	!define MUI_CUSTOMFUNCTION_GUIINIT onGUIInit
	!define MUI_LANGDLL_WINDOWTITLE $(Language_Title)
	!define MUI_LANGDLL_INFO $(Language_Text)
	!define MUI_FINISHPAGE_TITLE_3LINES
	!define MUI_WELCOMEPAGE_TITLE_3LINES
	!define MUI_WELCOMEPAGE_TITLE $(Welcome_Title)
	!define MUI_WELCOMEPAGE_TEXT $(Welcome_Text)
	!define MUI_HEADERIMAGE_RIGHT
	!define MUI_HEADERIMAGE
	!define MUI_HEADERIMAGE_BITMAP "Images\header.bmp"
	!define MUI_ABORTWARNING
	!define MUI_COMPONENTSPAGE_SMALLDESC
	!define MUI_ICON "Images\icon.ico"
	!define MUI_COMPONENTSPAGE_CHECKBITMAP "${NSISDIR}\Contrib\Graphics\Checks\modern.bmp"
	!define MUI_WELCOMEFINISHPAGE_BITMAP "Images\win.bmp"
	!define MUI_UNICON "Images\icon.ico" ;"${NSISDIR}\Contrib\Graphics\Icons\arrow-uninstall.ico"
	!define MUI_UNCOMPONENTSPAGE_CHECKBITMAP "${NSISDIR}\Contrib\Graphics\Checks\modern.bmp"
	!define MUI_UNWELCOMEFINISHPAGE_BITMAP "Images\win.bmp"
	
; Installer pages	
	!insertmacro MUI_PAGE_WELCOME
	!insertmacro MUI_PAGE_LICENSE "..\License.txt" ;_installer\License\CPro_License_EN.rtf"
	!insertmacro MUI_PAGE_COMPONENTS
	!insertmacro MUI_PAGE_DIRECTORY
	!insertmacro MUI_PAGE_INSTFILES
	Page custom CreateFinishPage CheckFinishPage ""

;Uninstaller pages	
	!define MUI_WELCOMEPAGE_TITLE_3LINES
	!define MUI_WELCOMEPAGE_TITLE $(Un_Welcome_Title)
	!define MUI_WELCOMEPAGE_TEXT $(Un_Welcome_Text)
	!insertmacro MUI_UNPAGE_WELCOME
	!insertmacro MUI_UNPAGE_CONFIRM	
	!insertmacro MUI_UNPAGE_INSTFILES
	!insertmacro MUI_UNPAGE_FINISH
	!define MUI_UNHEADERIMAGE
	!define MUI_UNHEADERIMAGE_BITMAP "Images\header.bmp"
	!define MUI_UNABORTWARNING
	!define MUI_UNCOMPONENTSPAGE_SMALLDESC	
	
;###########################################################################################
;#											INSTALLER  LANGUAGE
;###########################################################################################

	!define MUI_LANGDLL_ALLLANGUAGES
	!insertmacro MUI_RESERVEFILE_LANGDLL
	
;Language: English (1033), [ANSI], ${LANG_ENGLISH}
	!insertmacro MUI_LANGUAGE "English" 		
	!include "Languages\CPRO_Lang_ENG.nsh"

;Language: German (1031), [1252], ${LANG_GERMAN}
	!insertmacro MUI_LANGUAGE "German"			
	!include "Languages\CPRO_Lang_DEU.nsh"
	
;Language: Spanish International (3082), [1252], ${LANG_SPANISH_INTERNATIONAL}
	!insertmacro MUI_LANGUAGE "SpanishInternational"			
	!include "Languages\CPRO_Lang_SPI.nsh"

;Language: French (1036), [1252], ${LANG_FRENCH}	
	!insertmacro MUI_LANGUAGE "French"			
	!include "Languages\CPRO_Lang_FRA.nsh"	
	
;Language: Italian (1040), [1252], ${LANG_ITALIAN}	
	!insertmacro MUI_LANGUAGE "Italian"			
	!include "Languages\CPRO_Lang_ITA.nsh"

;Language: Dutch (1043), [1252], ${LANG_DUTCH}	
	!insertmacro MUI_LANGUAGE "Dutch"			
	!include "Languages\CPRO_Lang_DUT.nsh"

;Language: Polish (1045), [1250], ${LANG_POLISH}	
	!insertmacro MUI_LANGUAGE "Polish"			
	!include "Languages\CPRO_Lang_POL.nsh"

;Language: Brazilian Portuguese (1046), [1252], ${LANG_PORTUGUESE_BRAZILIAN}
	!insertmacro MUI_LANGUAGE "PortugueseBR"
	!include "Languages\CPRO_Lang_POB.nsh"

;Language: Romanian (1048), [1250], ${LANG_ROMANIAN}
	!insertmacro MUI_LANGUAGE "Romanian"		
	!include "Languages\CPRO_Lang_ROM.nsh"
	
;Language: Russian (1049), [1251], ${LANG_RUSSIAN}
	!insertmacro MUI_LANGUAGE "Russian"			
	!include "Languages\CPRO_Lang_RUS.nsh"
	
;Language: Chinese (Simplified) (2052), [936], ${LANG_SIMPCHINESE}
	!insertmacro MUI_LANGUAGE "SimpChinese"		
	!include "Languages\CPRO_Lang_SCH.nsh"
	
;Language: Chinese (Traditional) (1028), [950], ${LANG_TRADCHINESE}
	!insertmacro MUI_LANGUAGE "TradChinese"		
	!include "Languages\CPRO_Lang_TCH.nsh"
	
;Language: Swedish (1053), [1252], ${LANG_SWEDISH}	
	!insertmacro MUI_LANGUAGE "Swedish"			
	!include "Languages\CPRO_Lang_SWE.nsh"

;Language: Turkish (1055), [1254], ${LANG_TURKISH}	
	!insertmacro MUI_LANGUAGE "Turkish"			
	!include "Languages\CPRO_Lang_TUR.nsh"

;Language: Japanese (1041), [932], ${LANG_JAPANESE}	
	!insertmacro MUI_LANGUAGE "Japanese"			
	!include "Languages\CPRO_Lang_JAP.nsh"

;Language: Korean (1042), [949], ${LANG_KOREAN}	
	!insertmacro MUI_LANGUAGE "Korean"			
	!include "Languages\CPRO_Lang_KOR.nsh"
	
;###########################################################################################
;#											VERSION INFORMATION
;###########################################################################################

	!ifdef CPRO_BETA
; Beta stage	
		VIProductVersion "${CPRO_VERSION}.${CPRO_REVISION}.${CPRO_BUILD}"
		VIAddVersionKey "ProductName" "${CPRO_NAME} ${CPRO_BETA}"
		VIAddVersionKey "ProductVersion" "${CPRO_VERSION}"	
		VIAddVersionKey "Comments" "${CPRO_NAME} v${CPRO_VERSION} ${CPRO_BETA}, ${CPRO_WEB_PAGE}"
		VIAddVersionKey "CompanyName" "${CPRO_COMPANY}"
		VIAddVersionKey "LegalCopyright" "${CPRO_COPYRIGHT}, ${CPRO_AUTHOR}"
		VIAddVersionKey "FileDescription" "${CPRO_NAME} v${CPRO_VERSION} ${CPRO_BETA}"
		VIAddVersionKey "FileVersion" "${CPRO_VERSION}"	
	!else
; Release
		VIProductVersion "${CPRO_VERSION}.${CPRO_REVISION}.${CPRO_BUILD}"
		VIAddVersionKey "ProductName" "${CPRO_NAME}"
		VIAddVersionKey "ProductVersion" "${CPRO_VERSION}"		
		VIAddVersionKey "Comments" "${CPRO_NAME} v${CPRO_VERSION}, ${CPRO_WEB_PAGE}"
		VIAddVersionKey "CompanyName" "${CPRO_COMPANY}"
		VIAddVersionKey "LegalCopyright" "${CPRO_COPYRIGHT}, ${CPRO_AUTHOR}"
		VIAddVersionKey "FileDescription" "${CPRO_NAME} v${CPRO_VERSION}"
		VIAddVersionKey "FileVersion" "${CPRO_VERSION}"		
	!endif
		
Function .onInit

;Language
	Var /GLOBAL Lang_TITLE
		StrCpy $Lang_TITLE  $(LANGUAGE_TITLE)
	!insertmacro MUI_LANGDLL_DISPLAY
   
	InitPluginsDir

	File /oname=$PLUGINSDIR\splash.bmp "Images\logo.bmp"
	advsplash::show 1000 600 400 0x04025C $PLUGINSDIR\splash
	Pop $0 
	Delete "$PLUGINSDIR\splash.bmp"
		
; Finish Page  Variables
	Var /Global Dialog
	Var /Global Label1
	Var /Global Label1_Font
	Var /Global Label2
	Var /Global Label3
	Var /Global Label4	
	Var /Global CheckBox1
	Var /Global CheckBox2	
	Var /Global Checkbox_State	
	Var /GLOBAL Button	
	Var /GLOBAL Img_Left		
	Var /GLOBAL Img_Handle_Left
	
	File /oname=$PLUGINSDIR\PayPal.bmp "Images\donate.bmp"
	File /oname=$PLUGINSDIR\Img_Left.bmp "Images\win.bmp"
	
FunctionEnd

Function onGUIInit

	FindWindow $0 "#32770" "" $HWNDPARENT
	GetDlgItem $0 $HWNDPARENT 1028
	EnableWindow $0 1
	Linker::link /NOUNLOAD $0 "${CPRO_BT}"

FunctionEnd

Function .onGUIEnd

	Linker::Unload

FunctionEnd

Function .onVerifyInstDir

!ifndef WINAMP_AUTOINSTALL
	IfFileExists $INSTDIR\Winamp.exe Good
		Abort
	Good:
!endif ; WINAMP_AUTOINSTALL

FunctionEnd

Function CreateFinishPage

    LockWindow on
    GetDlgItem $0 $HWNDPARENT 1028
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1256
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1045
    ShowWindow $0 ${SW_NORMAL}
    LockWindow off

    nsDialogs::Create /NOUNLOAD 1044
	Pop $Dialog
	
	${If} $Dialog == error
		Abort
	${EndIf}
	
    SetCtlColors $Dialog "" "0xFFFFFF"

	
; Left Image
	${NSD_CreateBitmap} 0u 0u 109u 193u ""
	Pop $Img_Left
	${NSD_SetImage} $Img_Left $PLUGINSDIR\Img_Left.bmp $Img_Handle_Left
	
;First label
	${NSD_CreateLabel} 115u 20u 63% 30u "$(FinishPage_1)"
	Pop $Label1
	${NSD_AddStyle} $Label1 ${WS_VISIBLE}|${WS_CHILD}|${WS_CLIPSIBLINGS}
	CreateFont $Label1_Font "TAHOMA" "14" "700"
	SendMessage $Label1 ${WM_SETFONT} $Label1_Font 0	
    SetCtlColors $Label1 "0x000000" "TRANSPARENT"
	
; Second label
	${NSD_CreateLabel} 115u 60u 63% 30u "$(FinishPage_2)"
	Pop $Label2
	${NSD_AddStyle} $Label2 ${WS_VISIBLE}|${WS_CHILD}|${WS_CLIPSIBLINGS}
    SetCtlColors $Label2 "0x000000" "TRANSPARENT"	
	
;Button	
	${NSD_CreateButton} 115u 100u 58 35 ""
	Pop $Button
	${NSD_AddStyle} $Button "${BS_BITMAP}" 
	System::Call 'user32::LoadImage(i 0, t "$PLUGINSDIR\PayPal.bmp", i ${IMAGE_BITMAP}, i 0, i 0, i ${LR_CREATEDIBSECTION}|${LR_LOADFROMFILE}) i.s' 
	Pop $1 
	SendMessage $Button ${BM_SETIMAGE} ${IMAGE_BITMAP} $1
	${NSD_OnClick} $Button Button_Click		
	
;	VAR /Global Link 
;	${NSD_CreateLink} 115u 90u 58 35 "http://www.winamp.com" 
;	Pop $LINK 
;	${NSD_OnClick} $LINK MyLink
;	SetCtlColors $LINK "0X111111" "0x111111"  ;${MUI_BGCOLOR}

; Third label
	${NSD_CreateLabel} 160u 100u 50% 30u "$(FinishPage_3)"
	Pop $Label3
	${NSD_AddStyle} $Label3 ${WS_VISIBLE}|${WS_CHILD}|${WS_CLIPSIBLINGS}
    SetCtlColors $Label3 "0x000000" "TRANSPARENT"

; Fourth label
	${NSD_CreateLabel} 115u 150u 63% 10u "$(FinishPage_4)"
	Pop $Label4
	${NSD_AddStyle} $Label4 ${WS_VISIBLE}|${WS_CHILD}|${WS_CLIPSIBLINGS}
    SetCtlColors $Label4 "0x000000" "TRANSPARENT"	

; CheckBox 1
	${NSD_CreateCheckBox} 115u 160u 65% 10u "$(FinishPage_5)"
	Pop $CheckBox1
    SetCtlColors $CheckBox1 "0x000000" "0xFFFFFF"
	
; CheckBox 2
	${NSD_CreateCheckBox} 115u 173u 65% 10u "$(FinishPage_6)"
	Pop $CheckBox2	
    SetCtlColors $CheckBox2 "0x000000" "0xFFFFFF"	
	
	${NSD_Check} $CheckBox1
	${NSD_Check} $CheckBox2	

	GetDlgItem $R0 $HWNDPARENT 1
	SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(FinishPage_7)"
	
	nsDialogs::Show
	${NSD_FreeImage} $Img_Handle_Left

FunctionEnd

;Function MyLink
 
;  ExecShell "open" "http://www.winamp.com" 
  
;FunctionEnd


Function Button_Click

	Pop $0
	ExecShell "open" "$(FinishPage_8)"

FunctionEnd

Function CheckFinishPage

	${NSD_GetState} $CheckBox1 $Checkbox_State
	${If} $Checkbox_State = ${BST_CHECKED}
		ExecShell "open" "${CPRO_WEB_PAGE}"
	${EndIf}
	
	${NSD_GetState} $CheckBox2 $Checkbox_State
	${If} $Checkbox_State = ${BST_CHECKED}
		ExecShell "" "$INSTDIR\Skins\cPro__Bento.wal"
	${EndIf}
	
FunctionEnd
	

;###########################################################################################
;#											INSTALLER  SECTIONS 
;###########################################################################################

Section "$(CProFiles)" "Sec_CProFiles"

	!ifdef WINAMP_AUTOINSTALL
		Call MakeSureIGotWinamp
	!endif

	SectionIn RO
;Main directory	
	SetOutPath $INSTDIR\Plugins\ClassicPro
		File "..\*.txt"
;Installer
	SetOutPath $INSTDIR\Plugins\ClassicPro\_installer
		File "cPro_Installer.nsi"
	SetOutPath $INSTDIR\Plugins\ClassicPro\_installer\Images
		File "images\*.*"	
	SetOutPath $INSTDIR\Plugins\ClassicPro\_installer\Languages
		File "Languages\*.*"
	SetOutPath $INSTDIR\Plugins\ClassicPro\_installer\Plugins
		File "Plugins\*.*"	
;CPro engine		
	SetOutPath $INSTDIR\Plugins\ClassicPro\engine
		File "..\engine\*.xml"
;CPro engine	 - Image		
	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\image
		File "..\engine\image\*.png"
;CPro engine	 - cPro::One
	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\one\scripts
		File "..\engine\one\scripts\*.m"
		File "..\engine\one\scripts\*.maki"
	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\one\scripts\attribs
		File "..\engine\one\scripts\attribs\*.m"
	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\one\xml
		File "..\engine\one\xml\*.xml"
;CPro engine	 - Scripts
	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\scripts
		File "..\engine\scripts\*.m"
		File "..\engine\scripts\*.maki"
	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\scripts\attribs
		File "..\engine\scripts\attribs\*.m"
	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\scripts\lib
		File "..\engine\scripts\lib\*.mi"
;CPro engine	 - xml
	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xml
		File "..\engine\xml\*.xml"
;CPro engine	 - xui
	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui
		File "..\engine\xui\*.xml"

	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\AlbumArt
		File "..\engine\xui\AlbumArt\*.xml"
		File "..\engine\xui\AlbumArt\*.m"
		File "..\engine\xui\AlbumArt\*.maki"

	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\CentroSUI
		File "..\engine\xui\CentroSUI\*.xml"
	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\CentroSUI\scripts
		File "..\engine\xui\CentroSUI\scripts\*.m"
		File "..\engine\xui\CentroSUI\scripts\*.maki"

	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\CproTabs
		File "..\engine\xui\CproTabs\*.xml"
		File "..\engine\xui\CproTabs\*.m"
		File "..\engine\xui\CproTabs\*.maki"

	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\editbox
		File "..\engine\xui\editbox\*.xml"

	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\FadeText
		File "..\engine\xui\FadeText\*.xml"
		File "..\engine\xui\FadeText\*.m"
		File "..\engine\xui\FadeText\*.maki"

	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\historyeditbox
		File "..\engine\xui\historyeditbox\*.xml"
		File "..\engine\xui\historyeditbox\*.m"
		File "..\engine\xui\historyeditbox\*.maki"

	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\ModernSongticker
		File "..\engine\xui\ModernSongticker\*.xml"
		File "..\engine\xui\ModernSongticker\*.txt"
		File "..\engine\xui\ModernSongticker\*.m"
		File "..\engine\xui\ModernSongticker\*.maki"

	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\Ratings
		File "..\engine\xui\Ratings\*.xml"
		File "..\engine\xui\Ratings\*.m"
		File "..\engine\xui\Ratings\*.maki"

	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\SC-Channels
		File "..\engine\xui\SC-Channels\*.xml"
		File "..\engine\xui\SC-Channels\*.m"
		File "..\engine\xui\SC-Channels\*.maki"

	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\SC-ProgressGrid
		File "..\engine\xui\SC-ProgressGrid\*.xml"
		File "..\engine\xui\SC-ProgressGrid\*.m"
		File "..\engine\xui\SC-ProgressGrid\*.maki"

	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\updateSystem
		File "..\engine\xui\updateSystem\*.xml"
		File "..\engine\xui\updateSystem\*.m"
		File "..\engine\xui\updateSystem\*.maki"

	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\WasabiButton
		File "..\engine\xui\WasabiButton\*.xml"
		File "..\engine\xui\WasabiButton\*.m"
		File "..\engine\xui\WasabiButton\*.maki"

; cPro::Flex
;	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\flex\scripts
;		File /nonfatal "..\engine\flex\scripts\*.m"
;		File /nonfatal "..\engine\flex\scripts\*.maki"

;	SetOutPath $INSTDIR\Plugins\ClassicPro\engine\flex\xml
;		File /nonfatal "..\engine\flex\xml\*.xml"

;	SetOutPath $INSTDIR\System
;		File /nonfatal "${CPRO_WINAMP_SYSTEM}\ClassicProFlex.w5s"

;	SetOutPath "$INSTDIR\Skins\cProFlex - iFlex"
;		File /nonfatal /r "${CPRO_WINAMP_SKINS}\cProFlex - iFlex\"
;	SetOutPath "$INSTDIR\Skins\cProFlex - Xenolith"
;		File /nonfatal /r "${CPRO_WINAMP_SKINS}\cProFlex - Xenolith\"

	SetOutPath "$INSTDIR\Skins"
		File "${CPRO_WINAMP_SKINS}\cPro__Bento.wal"

	RMDir /r "$INSTDIR\Skins\cPro - Big Bento\" 
	RMDir /r "$INSTDIR\Skins\cPro - Bento\" 
	RMDir /r "$INSTDIR\Skins\cPro_Bento\" 
 
;Create uninstaller
	WriteUninstaller "$INSTDIR\${CPRO_UNINSTALLER}.exe"

SectionEnd

SectionGroup "$(CProCustom)" Sec_CProCustom

	Section "$(cPlaylistPro)" Sec_cPlaylistPro
	
		SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\PlaylistPro
			File "..\engine\xui\PlaylistPro\*.xml"
			File "..\engine\xui\PlaylistPro\*.m"
			File "..\engine\xui\PlaylistPro\*.maki"
		
	SectionEnd
	
SectionGroupEnd

SectionGroup "$(WidgetsSection)" Sec_WidgetsSection

	Section "$(wBrowserPro)" Sec_wBrowserPro

		SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets\Load"
			File "..\engine\widgets\Load\browserpro.xml"
 
		SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets\Data\BrowserPro"
			File "..\engine\widgets\Data\BrowserPro\*.m"
			File "..\engine\widgets\Data\BrowserPro\*.maki"
			File "..\engine\widgets\Data\BrowserPro\*.xml"
			File "..\engine\widgets\Data\BrowserPro\*.mi"

		SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets\Data\BrowserPro\icons"
			File "..\engine\widgets\Data\BrowserPro\icons\*.png"

		SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets\Data\BrowserPro\source"
			File "..\engine\widgets\Data\BrowserPro\source\*.xml"			

		SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets"
			File "..\engine\widgets\cpro-widget-BrowserPro.nsi"

	SectionEnd

	Section "$(wAlbumArt)" Sec_wAlbumArt

		SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets\Load"
			File "..\engine\widgets\Load\nowplaying.xml"

		SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets\Data\NowPlaying"
			File "..\engine\widgets\Data\NowPlaying\*.xml"
			File "..\engine\widgets\Data\NowPlaying\*.m"
			File "..\engine\widgets\Data\NowPlaying\*.maki"
			File "..\engine\widgets\Data\NowPlaying\*.png"
	
	SectionEnd

SectionGroupEnd


;###########################################################################################
;#										INSTALLER DESCRIPTIONS SECTION 
;###########################################################################################

	!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
		!insertmacro MUI_DESCRIPTION_TEXT ${Sec_CProFiles} $(Desc_CProFiles)
		!insertmacro MUI_DESCRIPTION_TEXT ${Sec_wBrowserPro} $(Desc_wBrowserPro)
		!insertmacro MUI_DESCRIPTION_TEXT ${Sec_wAlbumArt} $(Desc_wAlbumArt)
		!insertmacro MUI_DESCRIPTION_TEXT ${Sec_WidgetsSection} $(Desc_WidgetsSection)
		!insertmacro MUI_DESCRIPTION_TEXT ${Sec_CProCustom} $(Desc_CProCustom)
		!insertmacro MUI_DESCRIPTION_TEXT ${Sec_cPlaylistPro} $(Desc_cPlaylistPro)
	!insertmacro MUI_FUNCTION_DESCRIPTION_END

;###########################################################################################
;#										  	UNINSTALLER
;###########################################################################################

	ShowUninstDetails "show"

Function un.onInit

	!insertmacro MUI_LANGDLL_DISPLAY
	
FunctionEnd

Section "-Un.Uninstall"

	SetAutoClose "false"
	RMDir /r "$INSTDIR\Plugins\ClassicPro"
	Delete "$INSTDIR\Skins\cPro__Bento.wal"	
	Delete /REBOOTOK "$INSTDIR\${CPRO_UNINSTALLER}.exe"
	
SectionEnd

;###########################################################################################
;#										  	CPRO - THE END
;###########################################################################################