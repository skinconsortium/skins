;###########################################################################################
;###########################################################################################
;#
;#								   ClassicPro Widget Installer         
;#							   Copyright (c) 2009 by SkinConsortium   
;#							       NSIS script by Pawe³ Porwisz                                
;#
;###########################################################################################
;###########################################################################################

	Name "$(CPro_Widget_Name_Text)"
	OutFile "${CPRO_WIDGET_OUTFILE_PATH}ClassicPro_Widget_${CPRO_WIDGET_NAME}_${CPRO_WIDGET_VERSION}.exe"

	SetCompressor /SOLID lzma
	Caption "$(CPro_Widget_Caption)"
	BrandingText "${CPRO_WIDGET_BT}"

	ReserveFile "${CPRO_WIDGET_SOURCEPATH}\_installer\Plugins\Linker.dll"	
	
; Plugins Dir   
	!addplugindir "${CPRO_WIDGET_SOURCEPATH}\_installer\Plugins" 

;###########################################################################################
;#									  DESTINATION FOLDER
;###########################################################################################

	InstallDir "$PROGRAMFILES\Winamp"
	InstallDirRegKey "HKLM" "Software\Microsoft\Windows\CurrentVersion\Uninstall\Winamp" "UninstallString"
	RequestExecutionLevel "admin"
	XPStyle "on"

;###########################################################################################
;#									 	HEADER FILES
;###########################################################################################

	!include "MUI2.nsh"
	!include "Sections.nsh"
	!include "nsDialogs.nsh"
	
;###########################################################################################
;#									 INTERFACE SETTINGS 
;###########################################################################################

	DirText "$(CPro_DirText)"
	!define MUI_CUSTOMFUNCTION_GUIINIT My_GUIInit
	!define MUI_LANGDLL_WINDOWTITLE $LANG_TITLE
	!define MUI_LANGDLL_INFO $(CPro_Language_Text)
	!define MUI_FINISHPAGE_TITLE_3LINES
	!define MUI_WELCOMEPAGE_TITLE_3LINES
	!define MUI_WELCOMEPAGE_TITLE $(CPro_Widget_Welcome_Title)
	!define MUI_WELCOMEPAGE_TEXT $(CPro_Widget_Welcome_Text)
	!define MUI_HEADERIMAGE
	!define MUI_HEADERIMAGE_LEFT
	!define MUI_HEADERIMAGE_BITMAP "${CPRO_WIDGET_SOURCEPATH}\_installer\Images\header-widget.bmp"
	!define MUI_ABORTWARNING
	!define MUI_COMPONENTSPAGE_SMALLDESC
	!define MUI_ICON "${CPRO_WIDGET_SOURCEPATH}\_installer\Images\widget.ico"
	!define MUI_COMPONENTSPAGE_CHECKBITMAP "${NSISDIR}\Contrib\Graphics\Checks\modern.bmp"
	!define MUI_WELCOMEFINISHPAGE_BITMAP "${CPRO_WIDGET_SOURCEPATH}\_installer\Images\widget-side.bmp"
	!define MUI_UNICON "${CPRO_WIDGET_SOURCEPATH}\_installer\Images\widget.ico"
	!define MUI_UNCOMPONENTSPAGE_CHECKBITMAP "${NSISDIR}\Contrib\Graphics\Checks\modern.bmp"
	!define MUI_UNWELCOMEFINISHPAGE_BITMAP "${CPRO_WIDGET_SOURCEPATH}\_installer\Images\widget-side.bmp"
	
; Installer pages	
	!insertmacro MUI_PAGE_WELCOME
	!if ${CPRO_WIDGET_SHOW_COMPONENTS_PAGE} == "1"
		!insertmacro MUI_PAGE_COMPONENTS
	!endif	
	!insertmacro MUI_PAGE_DIRECTORY
	!insertmacro MUI_PAGE_INSTFILES
	Page custom CreateFinishPage CheckFinishPage ""

; Uninstaller pages	
	!define MUI_CUSTOMFUNCTION_UNGUIINIT un.My_GUIInit
	!define MUI_WELCOMEPAGE_TITLE_3LINES
	!define MUI_WELCOMEPAGE_TITLE $(CPro_Widget_Un_Welcome_Title)
	!define MUI_WELCOMEPAGE_TEXT $(CPro_Widget_Un_Welcome_Text)
	!insertmacro MUI_UNPAGE_WELCOME
	!insertmacro MUI_UNPAGE_CONFIRM	
	!insertmacro MUI_UNPAGE_INSTFILES
	UninstPage Custom un.un_CreateFinishPage un.un_CheckFinishPage ""
	
	!define MUI_UNHEADERIMAGE
	!define MUI_UNHEADERIMAGE_BITMAP "${CPRO_WIDGET_SOURCEPATH}\_installer\Images\header-widget.bmp"
	!define MUI_UNABORTWARNING
	!define MUI_UNCOMPONENTSPAGE_SMALLDESC
	
	
;###########################################################################################
;#									INSTALLER  LANGUAGE
;###########################################################################################

	!define MUI_LANGDLL_ALLLANGUAGES
	!insertmacro MUI_RESERVEFILE_LANGDLL
	
; Language: English (1033), [ANSI], ${LANG_ENGLISH}
	!insertmacro MUI_LANGUAGE "English" 		
	!include "${CPRO_WIDGET_SOURCEPATH}\_installer\Languages\cPro_en_us.nsh"

; Language: German (1031), [1252], ${LANG_GERMAN}
	!insertmacro MUI_LANGUAGE "German"			
	!include "${CPRO_WIDGET_SOURCEPATH}\_installer\Languages\cPro_de_de.nsh"
	
; Language: French (1036), [1252], ${LANG_FRENCH}	
	!insertmacro MUI_LANGUAGE "French"			
	!include "${CPRO_WIDGET_SOURCEPATH}\_installer\Languages\cPro_fr_fr.nsh"	
		
; Language: Polish (1045), [1250], ${LANG_POLISH}	
	!insertmacro MUI_LANGUAGE "Polish"			
	!include "${CPRO_WIDGET_SOURCEPATH}\_installer\Languages\cPro_pl_pl.nsh"

; Language: Brazilian Portuguese (1046), [1252], ${LANG_PORTUGUESE_BRAZILIAN}
	!insertmacro MUI_LANGUAGE "PortugueseBR"
	!include "${CPRO_WIDGET_SOURCEPATH}\_installer\Languages\cPro_pt_br.nsh"

; Language: Romanian (1048), [1250], ${LANG_ROMANIAN}
	!insertmacro MUI_LANGUAGE "Romanian"		
	!include "${CPRO_WIDGET_SOURCEPATH}\_installer\Languages\cPro_ro_ro.nsh"
	
; Language: Russian (1049), [1251], ${LANG_RUSSIAN}
	!insertmacro MUI_LANGUAGE "Russian"			
	!include "${CPRO_WIDGET_SOURCEPATH}\_installer\Languages\cPro_ru_ru.nsh"
	
; Language: Turkish (1055), [1254], ${LANG_TURKISH}	
	!insertmacro MUI_LANGUAGE "Turkish"			
	!include "${CPRO_WIDGET_SOURCEPATH}\_installer\Languages\cPro_tr_tr.nsh"
	
; Language: Danish (1030), [1252], ${LANG_DANISH}	
	!insertmacro MUI_LANGUAGE "Danish"			
	!include "${CPRO_WIDGET_SOURCEPATH}\_installer\Languages\cPro_da_dk.nsh"	
	
; Language: Spanish International (3082), [1252], ${LANG_SPANISH_INTERNATIONAL}
	; !insertmacro MUI_LANGUAGE "SpanishInternational"			
	; !include "${CPRO_WIDGET_SOURCEPATH}\_installer\Languages\cPro_es_us.nsh"

; Language: Italian (1040), [1252], ${LANG_ITALIAN}	
	; !insertmacro MUI_LANGUAGE "Italian"			
	; !include "${CPRO_WIDGET_SOURCEPATH}\_installer\Languages\cPro_it_it.nsh"

; Language: Dutch (1043), [1252], ${LANG_DUTCH}	
	; !insertmacro MUI_LANGUAGE "Dutch"			
	; !include "${CPRO_WIDGET_SOURCEPATH}\_installer\Languages\cPro_nl_nl.nsh"
	
; Language: Chinese (Simplified) (2052), [936], ${LANG_SIMPCHINESE}
	; !insertmacro MUI_LANGUAGE "SimpChinese"		
	; !include "${CPRO_WIDGET_SOURCEPATH}\_installer\Languages\cPro_zh_cn.nsh"
	
; Language: Chinese (Traditional) (1028), [950], ${LANG_TRADCHINESE}
	; !insertmacro MUI_LANGUAGE "TradChinese"		
	; !include "${CPRO_WIDGET_SOURCEPATH}\_installer\Languages\cPro_zh_tw.nsh"
	
; Language: Swedish (1053), [1252], ${LANG_SWEDISH}	
	; !insertmacro MUI_LANGUAGE "Swedish"			
	; !include "${CPRO_WIDGET_SOURCEPATH}\_installer\Languages\cPro_sv_se.nsh"

; Language: Japanese (1041), [932], ${LANG_JAPANESE}	
	; !insertmacro MUI_LANGUAGE "Japanese"			
	; !include "${CPRO_WIDGET_SOURCEPATH}\_installer\Languages\cPro_ja_jp.nsh"

; Language: Korean (1042), [949], ${LANG_KOREAN}	
	; !insertmacro MUI_LANGUAGE "Korean"			
	; !include "${CPRO_WIDGET_SOURCEPATH}\_installer\Languages\cPro_ko_kr.nsh"
	

;###########################################################################################
;#										VERSION INFORMATION
;###########################################################################################

		VIProductVersion "${CPRO_WIDGET_VERSION}.${CPRO_WIDGET_REVISION}.${CPRO_WIDGET_BUILD}"
		VIAddVersionKey "ProductName" "${CPRO_WIDGET_NAME}"
		VIAddVersionKey "ProductVersion" "${CPRO_WIDGET_VERSION}"		
		VIAddVersionKey "Comments" "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}, ${CPRO_WIDGET_WEB_PAGE}"
		VIAddVersionKey "CompanyName" "${CPRO_WIDGET_COMPANY}"
		VIAddVersionKey "LegalCopyright" "${CPRO_WIDGET_COPYRIGHT}, ${CPRO_WIDGET_AUTHOR}"
		VIAddVersionKey "FileDescription" "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}"
		VIAddVersionKey "FileVersion" "${CPRO_WIDGET_VERSION}"		
	
Function .onInit

; Language
	Var /GLOBAL LANG_TITLE
		StrCpy $LANG_TITLE  $(CPro_Language_Title)
	!insertmacro MUI_LANGDLL_DISPLAY
	InitPluginsDir
	
	Var /Global Dialog
	
; Finish Page Variables
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

	File /oname=$PLUGINSDIR\PayPal.bmp "${CPRO_WIDGET_SOURCEPATH}\_installer\Images\donate.bmp"
	File /oname=$PLUGINSDIR\Img_Left.bmp "${CPRO_WIDGET_SOURCEPATH}\_installer\Images\widget-side.bmp"
	
FunctionEnd

Function My_GUIInit

	FindWindow $0 "#32770" "" $HWNDPARENT
	GetDlgItem $0 $HWNDPARENT 1028
	EnableWindow $0 1
	Linker::link /NOUNLOAD $0 "${CPRO_WIDGET_BT}"

FunctionEnd

Function .onGUIEnd

	Linker::Unload

FunctionEnd

Function .onVerifyInstDir

	IfFileExists $INSTDIR\Winamp.exe Good
		Abort
	Good:

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

	${NSD_CreateBitmap} 0u 0u 109u 193u ""
	Pop $Img_Left
	${NSD_SetImage} $Img_Left $PLUGINSDIR\Img_Left.bmp $Img_Handle_Left
	
	${NSD_CreateLabel} 115u 20u 63% 30u "$(CPro_Widget_FinishPage_1)"
	Pop $Label1
	${NSD_AddStyle} $Label1 ${WS_VISIBLE}|${WS_CHILD}|${WS_CLIPSIBLINGS}
	CreateFont $Label1_Font "TAHOMA" "13" "700"
	SendMessage $Label1 ${WM_SETFONT} $Label1_Font 0	
    SetCtlColors $Label1 "0x000000" "TRANSPARENT"
	
	${NSD_CreateLabel} 115u 60u 63% 30u "$(CPro_Widget_FinishPage_2)"
	Pop $Label2
	${NSD_AddStyle} $Label2 ${WS_VISIBLE}|${WS_CHILD}|${WS_CLIPSIBLINGS}
    SetCtlColors $Label2 "0x000000" "TRANSPARENT"	
	
	${NSD_CreateButton} 115u 100u 58 35 ""
	Pop $Button
	${NSD_AddStyle} $Button "${BS_BITMAP}" 
	System::Call 'user32::LoadImage(i 0, t "$PLUGINSDIR\PayPal.bmp", i ${IMAGE_BITMAP}, i 0, i 0, i ${LR_CREATEDIBSECTION}|${LR_LOADFROMFILE}) i.s' 
	Pop $1 
	SendMessage $Button ${BM_SETIMAGE} ${IMAGE_BITMAP} $1
	${NSD_OnClick} $Button Button_Click		

	${NSD_CreateLabel} 160u 100u 50% 30u "$(CPro_Widget_FinishPage_3)"
	Pop $Label3
	${NSD_AddStyle} $Label3 ${WS_VISIBLE}|${WS_CHILD}|${WS_CLIPSIBLINGS}
    SetCtlColors $Label3 "0x000000" "TRANSPARENT"

	${NSD_CreateLabel} 115u 148u 63% 10u "$(CPro_Widget_FinishPage_4)"
	Pop $Label4
	${NSD_AddStyle} $Label4 ${WS_VISIBLE}|${WS_CHILD}|${WS_CLIPSIBLINGS}
    SetCtlColors $Label4 "0x000000" "TRANSPARENT"	

	${NSD_CreateCheckBox} 115u 160u 65% 10u "$(CPro_Widget_FinishPage_6)"
	Pop $CheckBox1
	${NSD_Check} $CheckBox1
	SetCtlColors $CheckBox1 "0x000000" "0xFFFFFF"
	
	${NSD_CreateCheckBox} 115u 170u 65% 16u "$(CPro_Widget_FinishPage_5)"
	Pop $CheckBox2	
	${NSD_Check} $CheckBox2		
    SetCtlColors $CheckBox2 "0x000000" "0xFFFFFF"	

	GetDlgItem $R0 $HWNDPARENT 1
	SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(CPro_Widget_FinishPage_7)"
	
	nsDialogs::Show
	${NSD_FreeImage} $Img_Handle_Left

FunctionEnd

Function Button_Click

	Pop $0
	ExecShell "open" "${CPRO_WIDGET_PAYPAL_LINK}"

FunctionEnd

Function CheckFinishPage

	${NSD_GetState} $CheckBox2 $Checkbox_State
	${If} $Checkbox_State = ${BST_CHECKED}
		ExecShell "open" "${CPRO_WIDGET_WEB_PAGE}"
	${EndIf}
	
	${NSD_GetState} $CheckBox1 $Checkbox_State
	${If} $Checkbox_State = ${BST_CHECKED}
		Push $5
		FindWindow $5 "Winamp v1.x"
		IntCmp $5 0 NoWinamp
		; TODO (mpdeimos) maybe include a loop for refreshing skin again!
			SendMessage $5 0x0111 40291 0
			GoTo RefreshDone
		NoWinamp:
			ExecShell "open" "$INSTDIR\winamp.exe"
		RefreshDone:
		Pop $5
	${EndIf}
	
FunctionEnd

;###########################################################################################
;#									INSTALLER  SECTIONS 
;###########################################################################################

	ShowInstDetails "show"
	
Section "$(CPro_Widget_Files)" "CPro_Widget_Sec_Files"

	SectionIn RO

	SetOutPath "$INSTDIR\Plugins\classicPro\engine\widgets\Load"
		File "${CPRO_WIDGET_SOURCEPATH}\engine\widgets\Load\${CPRO_WIDGET_XMLFILENAME}"
 
	SetOutPath "$INSTDIR\Plugins\classicPro\engine\widgets\Data\${CPRO_WIDGET_DATA_FOLDERNAME}"
		File /nonfatal "${CPRO_WIDGET_SOURCEPATH}\engine\widgets\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\*.m"
		File /nonfatal "${CPRO_WIDGET_SOURCEPATH}\engine\widgets\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\*.maki"
		File /nonfatal "${CPRO_WIDGET_SOURCEPATH}\engine\widgets\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\*.xml"
		File /nonfatal "${CPRO_WIDGET_SOURCEPATH}\engine\widgets\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\*.png"
		File /nonfatal "${CPRO_WIDGET_SOURCEPATH}\engine\widgets\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\*.jpg"

	SetOutPath "$INSTDIR\Plugins\classicPro\engine\widgets\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\icons"
		File /nonfatal "${CPRO_WIDGET_SOURCEPATH}\engine\widgets\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\icons\*.png"

	SetOutPath "$INSTDIR\Plugins\classicPro\engine\widgets"
		File /nonfatal "${CPRO_WIDGET_SOURCEPATH}\engine\widgets\${CPRO_WIDGET_NSISFILENAME}"


SectionEnd


Section "-Leave"

; Create uninstaller
	WriteUninstaller "$INSTDIR\Plugins\classicPro\engine\widgets\${CPRO_WIDGET_UNINSTALLER}"

	SetAutoClose false
	
SectionEnd

;###########################################################################################
;#								INSTALLER DESCRIPTIONS SECTION 
;###########################################################################################

	!if ${CPRO_WIDGET_SHOW_COMPONENTS_PAGE} == "1"
		!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
			!insertmacro MUI_DESCRIPTION_TEXT ${CPro_Widget_Sec_Files} $(CPro_Widget_Desc_Files)
		!insertmacro MUI_FUNCTION_DESCRIPTION_END
	!endif
	
;###########################################################################################
;#										UNINSTALLER
;###########################################################################################

	ShowUninstDetails "show"

Function un.onInit

; Language
	StrCpy $LANG_TITLE $(CPro_Un_Language_Title)
	!insertmacro MUI_UNGETLANGUAGE
	InitPluginsDir
	
	Var /Global un_Dialog
	
; Finish Page Variables
	Var /Global un_Label1
	Var /Global un_Label1_Font
	Var /Global un_Label2
	Var /Global un_Label4	
	Var /Global un_CheckBox1
	Var /Global un_Checkbox_State	
	Var /GLOBAL un_Img_Left		
	Var /GLOBAL un_Img_Handle_Left

	File /oname=$PLUGINSDIR\Img_Left.bmp "${CPRO_WIDGET_SOURCEPATH}\_installer\Images\widget-side.bmp"
	
FunctionEnd

Function un.My_GUIInit

	FindWindow $0 "#32770" "" $HWNDPARENT
	GetDlgItem $0 $HWNDPARENT 1028
	EnableWindow $0 1
	Linker::link /NOUNLOAD $0 "${CPRO_WIDGET_BT}"

FunctionEnd

Function un.onGUIEnd

	Linker::Unload

FunctionEnd

Function un.un_CreateFinishPage

    LockWindow on
    GetDlgItem $0 $HWNDPARENT 1028
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1256
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1045
    ShowWindow $0 ${SW_NORMAL}
    LockWindow off

    nsDialogs::Create /NOUNLOAD 1044
	Pop $un_Dialog
	
	${If} $un_Dialog == error
		Abort
	${EndIf}
	
    SetCtlColors $un_Dialog "" "0xFFFFFF"

	${NSD_CreateBitmap} 0u 0u 109u 193u ""
	Pop $un_Img_Left
	${NSD_SetImage} $un_Img_Left $PLUGINSDIR\Img_Left.bmp $un_Img_Handle_Left
	
	${NSD_CreateLabel} 115u 20u 63% 50u "$(CPro_Widget_UnFinishPage_1)"
	Pop $un_Label1
	${NSD_AddStyle} $un_Label1 ${WS_VISIBLE}|${WS_CHILD}|${WS_CLIPSIBLINGS}
	CreateFont $un_Label1_Font "TAHOMA" "13" "700"
	SendMessage $un_Label1 ${WM_SETFONT} $un_Label1_Font 0	
    SetCtlColors $un_Label1 "0x000000" "TRANSPARENT"
	
	${NSD_CreateLabel} 115u 80u 53% 30u "$(CPro_Widget_UnFinishPage_2)"
	Pop $un_Label2
	${NSD_AddStyle} $un_Label2 ${WS_VISIBLE}|${WS_CHILD}|${WS_CLIPSIBLINGS}
    SetCtlColors $un_Label2 "0x000000" "TRANSPARENT"	
	
	${NSD_CreateLabel} 115u 110u 63% 10u "$(CPro_Widget_UnFinishPage_3)"
	Pop $un_Label4
	${NSD_AddStyle} $un_Label4 ${WS_VISIBLE}|${WS_CHILD}|${WS_CLIPSIBLINGS}
    SetCtlColors $un_Label4 "0x000000" "TRANSPARENT"	

	${NSD_CreateCheckBox} 115u 160u 65% 10u "$(CPro_Widget_UnFinishPage_4)"
	Pop $un_CheckBox1
	${NSD_Check} $un_CheckBox1
	SetCtlColors $un_CheckBox1 "0x000000" "0xFFFFFF"
	
	GetDlgItem $R0 $HWNDPARENT 1
	SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(CPro_Widget_FinishPage_7)"
	
	nsDialogs::Show
	${NSD_FreeImage} $un_Img_Handle_Left

FunctionEnd

Function un.un_CheckFinishPage

	${NSD_GetState} $un_CheckBox1 $un_Checkbox_State
	${If} $un_Checkbox_State = ${BST_CHECKED}
		Push $5
		FindWindow $5 "Winamp v1.x"
		IntCmp $5 0 RefreshDone
			SendMessage $5 0x0111 40291 0
		RefreshDone:
		Pop $5
	${EndIf}
	
FunctionEnd

Section "Uninstall"

	Delete "$INSTDIR\Load\${CPRO_WIDGET_XMLFILENAME}"
	Delete "$INSTDIR\${CPRO_WIDGET_NSISFILENAME}"
	
	Delete "$INSTDIR\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\icons\*.*"
	RMDir "$INSTDIR\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\icons\"
	
	Delete "$INSTDIR\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\*.*"
	RMDir "$INSTDIR\Data\${CPRO_WIDGET_DATA_FOLDERNAME}"
	Delete "$INSTDIR\${CPRO_WIDGET_UNINSTALLER}"

SectionEnd