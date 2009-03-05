;###########################################################################################
;###########################################################################################
;#
;#									      ClassicPro Widget Installer         
;#								         Copyright (c) 2009 by Pawe³ Porwisz                                   
;#
;###########################################################################################
;###########################################################################################

;Definitions
	!define CPRO_WIDGET_SOURCEPATH "..\.."
	!define CPRO_WIDGET_NAME "BrowserPro"
	!define CPRO_WIDGET_VERSION "2.0"
	!define CPRO_WIDGET_REVISION "0"
	!define CPRO_WIDGET_BUILD "0"
	!define CPRO_WIDGET_XMLFILENAME "browserpro.xml"
	!define CPRO_WIDGET_DATA_FOLDERNAME "BrowserPro"
	!define CPRO_WIDGET_NSISFILENAME "cpro-widget-BrowserPro.nsi"	
	!define CPRO_WIDGET_PAYPAL_LINK "https://www.paypal.com/uk/cgi-bin/webscr?cmd=_flow&SESSION=lbtyhrWugcvcf_QcrMnTrArKKiT3DcYJbH-_gFqC8-fXZNwJ4ibp2UbTunS&dispatch=5885d80a13c0db1fa798f5a5f5ae42e779d4b5655493f6171509c5b2ec019b86"
	!define CPRO_WINAMP_VERSION "5.55"
	!define CPRO_NAME "ClassicPro"
	!define CPRO_CRS "©"	
	!define CPRO_VERSION "1.1"
	!define CPRO_WIDGET_BT "http://cpro.skinconsortium.com"
	!define CPRO_WIDGET_WEB_PAGE "http://cpro.skinconsortium.com"
	!define CPRO_WIDGET_HELP_LINK "http://forums.skinconsortium.com/index.php?page=Board&boardID=56"
	!define CPRO_WIDGET_AUTHOR "Skin Consortium"
	!define CPRO_WIDGET_COMPANY "Skin Consortium"
	!define CPRO_WIDGET_COPYRIGHT "Copyright (c) 2005-2009"	
	!define CPRO_WIDGET_UNINSTALLER "Uninstall (${CPRO_WIDGET_NAME})"	
	!define CPRO_WIDGET_OUTFILE_PATH "C:\Users\Pieter\Desktop"	; change to compile properly	
	
;###########################################################################################
;#											CONFIGURATION
;###########################################################################################

	Name "$(CPro_Widget_Name_Text)"
	OutFile "${CPRO_WIDGET_OUTFILE_PATH}\cpro-widget-${CPRO_WIDGET_NAME}_${CPRO_WIDGET_VERSION}.exe"

	SetCompressor /SOLID lzma
	Caption "$(CPro_Widget_Caption)"
	BrandingText "${CPRO_WIDGET_BT}"

	ReserveFile "${CPRO_WIDGET_SOURCEPATH}\_installer\Plugins\Linker.dll"
	
; Plugins Dir   
	!addplugindir "${CPRO_WIDGET_SOURCEPATH}\_installer\Plugins"  
   
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
	
;###########################################################################################
;#										    INTERFACE SETTINGS 
;###########################################################################################

	DirText "$(CPro_DirText)"
	!define MUI_CUSTOMFUNCTION_GUIINIT onGUIInit
	!define MUI_LANGDLL_WINDOWTITLE $(CPro_Language_Title)
	!define MUI_LANGDLL_INFO $(CPro_Language_Text)
	!define MUI_FINISHPAGE_TITLE_3LINES
	!define MUI_WELCOMEPAGE_TITLE_3LINES
	!define MUI_WELCOMEPAGE_TITLE $(CPro_Widget_Welcome_Title)
	!define MUI_WELCOMEPAGE_TEXT $(CPro_Widget_Welcome_Text)
	!define MUI_HEADERIMAGE_RIGHT
	!define MUI_HEADERIMAGE
	!define MUI_HEADERIMAGE_BITMAP "${CPRO_WIDGET_SOURCEPATH}\_installer\Images\header.bmp"
	!define MUI_ABORTWARNING
	!define MUI_COMPONENTSPAGE_SMALLDESC
	!define MUI_ICON "${CPRO_WIDGET_SOURCEPATH}\_installer\Images\widget.ico"
	!define MUI_COMPONENTSPAGE_CHECKBITMAP "${NSISDIR}\Contrib\Graphics\Checks\modern.bmp"
	!define MUI_WELCOMEFINISHPAGE_BITMAP "${CPRO_WIDGET_SOURCEPATH}\_installer\Images\win.bmp"
	!define MUI_UNICON "${CPRO_WIDGET_SOURCEPATH}\_installer\Images\widget.ico"
	!define MUI_UNCOMPONENTSPAGE_CHECKBITMAP "${NSISDIR}\Contrib\Graphics\Checks\modern.bmp"
	!define MUI_UNWELCOMEFINISHPAGE_BITMAP "${CPRO_WIDGET_SOURCEPATH}\_installer\Images\win.bmp"
	
; Installer pages	
	!insertmacro MUI_PAGE_WELCOME
;	!insertmacro MUI_PAGE_LICENSE "${CPRO_WIDGET_SOURCEPATH}\License.txt" ;_installer\License\CPro_en_us_License.rtf"
	!insertmacro MUI_PAGE_COMPONENTS
	!insertmacro MUI_PAGE_DIRECTORY
	!insertmacro MUI_PAGE_INSTFILES
	Page custom CreateFinishPage CheckFinishPage ""

;Uninstaller pages	
	!define MUI_WELCOMEPAGE_TITLE_3LINES
	!define MUI_WELCOMEPAGE_TITLE $(CPro_Widget_Un_Welcome_Title)
	!define MUI_WELCOMEPAGE_TEXT $(CPro_Widget_Un_Welcome_Text)
	!insertmacro MUI_UNPAGE_WELCOME
	!insertmacro MUI_UNPAGE_CONFIRM	
	!insertmacro MUI_UNPAGE_INSTFILES
	!insertmacro MUI_UNPAGE_FINISH
	!define MUI_UNHEADERIMAGE
	!define MUI_UNHEADERIMAGE_BITMAP "${CPRO_WIDGET_SOURCEPATH}\_installer\Images\header.bmp"
	!define MUI_UNABORTWARNING
	!define MUI_UNCOMPONENTSPAGE_SMALLDESC	
	
;###########################################################################################
;#											INSTALLER  LANGUAGE
;###########################################################################################

	!define MUI_LANGDLL_ALLLANGUAGES
	!insertmacro MUI_RESERVEFILE_LANGDLL
	
;Language: English (1033), [ANSI], ${LANG_ENGLISH}
	!insertmacro MUI_LANGUAGE "English" 		
	!include "..\..\_installer\Languages\cPro_en_us.nsh"

;Language: German (1031), [1252], ${LANG_GERMAN}
	!insertmacro MUI_LANGUAGE "German"			
	!include "..\..\_installer\Languages\cPro_de_de.nsh"
	
;Language: Spanish International (3082), [1252], ${LANG_SPANISH_INTERNATIONAL}
	!insertmacro MUI_LANGUAGE "SpanishInternational"			
	!include "..\..\_installer\Languages\cPro_es_us.nsh"

;Language: French (1036), [1252], ${LANG_FRENCH}	
	!insertmacro MUI_LANGUAGE "French"			
	!include "..\..\_installer\Languages\cPro_fr_fr.nsh"	
	
;Language: Italian (1040), [1252], ${LANG_ITALIAN}	
	!insertmacro MUI_LANGUAGE "Italian"			
	!include "..\..\_installer\Languages\cPro_it_it.nsh"

;Language: Dutch (1043), [1252], ${LANG_DUTCH}	
	!insertmacro MUI_LANGUAGE "Dutch"			
	!include "..\..\_installer\Languages\cPro_nl_nl.nsh"
	
;Language: Polish (1045), [1250], ${LANG_POLISH}	
	!insertmacro MUI_LANGUAGE "Polish"			
	!include "..\..\_installer\Languages\cPro_pl_pl.nsh"

;Language: Brazilian Portuguese (1046), [1252], ${LANG_PORTUGUESE_BRAZILIAN}
	!insertmacro MUI_LANGUAGE "PortugueseBR"
	!include "..\..\_installer\Languages\cPro_pt_br.nsh"

;Language: Romanian (1048), [1250], ${LANG_ROMANIAN}
	!insertmacro MUI_LANGUAGE "Romanian"		
	!include "..\..\_installer\Languages\cPro_ro_ro.nsh"
	
;Language: Russian (1049), [1251], ${LANG_RUSSIAN}
	!insertmacro MUI_LANGUAGE "Russian"			
	!include "..\..\_installer\Languages\cPro_ru_ru.nsh"
	
;Language: Chinese (Simplified) (2052), [936], ${LANG_SIMPCHINESE}
	!insertmacro MUI_LANGUAGE "SimpChinese"		
	!include "..\..\_installer\Languages\cPro_zh_cn.nsh"
	
;Language: Chinese (Traditional) (1028), [950], ${LANG_TRADCHINESE}
	!insertmacro MUI_LANGUAGE "TradChinese"		
	!include "..\..\_installer\Languages\cPro_zh_tw.nsh"
	
;Language: Swedish (1053), [1252], ${LANG_SWEDISH}	
	!insertmacro MUI_LANGUAGE "Swedish"			
	!include "..\..\_installer\Languages\cPro_sv_se.nsh"

;Language: Turkish (1055), [1254], ${LANG_TURKISH}	
	!insertmacro MUI_LANGUAGE "Turkish"			
	!include "..\..\_installer\Languages\cPro_tr_tr.nsh"

;Language: Japanese (1041), [932], ${LANG_JAPANESE}	
	!insertmacro MUI_LANGUAGE "Japanese"			
	!include "..\..\_installer\Languages\cPro_ja_jp.nsh"

;Language: Korean (1042), [949], ${LANG_KOREAN}	
	!insertmacro MUI_LANGUAGE "Korean"			
	!include "..\..\_installer\Languages\cPro_ko_kr.nsh"
	
;###########################################################################################
;#											VERSION INFORMATION
;###########################################################################################

		VIProductVersion "${CPRO_WIDGET_VERSION}.${CPRO_WIDGET_REVISION}.${CPRO_WIDGET_BUILD}"
		VIAddVersionKey "ProductName" "${CPRO_WIDGET_NAME}"
		VIAddVersionKey "ProductVersion" "${CPRO_WIDGET_VERSION}"		
		VIAddVersionKey "Comments" "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}, ${CPRO_WIDGET_WEB_PAGE}"
		VIAddVersionKey "CompanyName" "${CPRO_WIDGET_COMPANY}"
		VIAddVersionKey "LegalCopyright" "${CPRO_WIDGET_COPYRIGHT}, ${CPRO_WIDGET_AUTHOR}"
		VIAddVersionKey "FileDescription" "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}"
		VIAddVersionKey "FileVersion" "${CPRO_WIDGET_VERSION}"		
		
 Var /GLOBAL MultiPath
 
!macro SharedPath un
  
	Function ${un}MultiUser_Path

		IfFileExists "$INSTDIR\paths.ini" 0 No_PathINI
			ReadINIStr $R0 "$INSTDIR\paths.ini" "Winamp" "inidir"
			StrCpy $0 $R0 4     ; first 4 characters  (  {26}  )
			StrCpy $1 $R0 "" 5  ; the rest 
	
			StrCmp $0 "{26}" 0 No_26
				StrCpy $MultiPath $APPDATA\$1
				DetailPrint "$(CPro_Account): $MultiPath"
				GoTo End
			No_26:
			StrCpy $MultiPath $INSTDIR
			DetailPrint "$(CPro_No_Account): $MultiPath" 
			GoTo End
		No_PathINI:
			StrCpy $MultiPath $INSTDIR
			DetailPrint "$(CPro_No_Account): $MultiPath"
		End:	

	FunctionEnd

!macroend

; Insert function as an installer and uninstaller function.
	!insertmacro SharedPath ""
	!insertmacro SharedPath "un."
	
!macro SharedWinamp un
  
Function ${un}CloseWinamp

	Push $5
	FindWindow $5 "Winamp v1.x"
	IntCmp $5 0 NoWinamp
		DetailPrint "$(CPro_Running_Winamp)"
		MessageBox MB_OK|MB_ICONEXCLAMATION "$(CPro_Close_Winamp)"  
		loop:
			FindWindow $5 "Winamp v1.x"
			IntCmp $5 0 NoMoreWinampToKill
			DetailPrint "$(CPro_Closing_Winamp)"			
				SendMessage $5 16 0 0
				Sleep 100
				Goto loop
			NoMoreWinampToKill:
				DetailPrint "$(CPro_No_More_Winamp)"
				GoTo AllKilled
	NoWinamp:	
		DetailPrint "$(CPro_No_Winamp)"
	AllKilled:	
	Pop $5

FunctionEnd

!macroend

; Insert function as an installer and uninstaller function.
!insertmacro SharedWinamp ""
!insertmacro SharedWinamp "un."
	
	
	
Function .onInit

;Language
	!insertmacro MUI_LANGDLL_DISPLAY
   
	InitPluginsDir

;	File /oname=$PLUGINSDIR\splash.bmp "Images\logo.bmp"
;	advsplash::show 1000 600 400 0x04025C $PLUGINSDIR\splash
;	Pop $0 
;	Delete "$PLUGINSDIR\splash.bmp"
		
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
	
	File /oname=$PLUGINSDIR\PayPal.bmp "${CPRO_WIDGET_SOURCEPATH}\_installer\Images\donate.bmp"
	File /oname=$PLUGINSDIR\Img_Left.bmp "${CPRO_WIDGET_SOURCEPATH}\_installer\Images\win.bmp"
	
FunctionEnd

Function onGUIInit

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

	
; Left Image
	${NSD_CreateBitmap} 0u 0u 109u 193u ""
	Pop $Img_Left
	${NSD_SetImage} $Img_Left $PLUGINSDIR\Img_Left.bmp $Img_Handle_Left
	
;First label
	${NSD_CreateLabel} 115u 20u 63% 30u "$(CPro_Widget_FinishPage_1)"
	Pop $Label1
	${NSD_AddStyle} $Label1 ${WS_VISIBLE}|${WS_CHILD}|${WS_CLIPSIBLINGS}
	CreateFont $Label1_Font "TAHOMA" "14" "700"
	SendMessage $Label1 ${WM_SETFONT} $Label1_Font 0	
    SetCtlColors $Label1 "0x000000" "TRANSPARENT"
	
; Second label
	${NSD_CreateLabel} 115u 60u 63% 30u "$(CPro_Widget_FinishPage_2)"
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

; Third label
	${NSD_CreateLabel} 160u 100u 50% 30u "$(CPro_Widget_FinishPage_3)"
	Pop $Label3
	${NSD_AddStyle} $Label3 ${WS_VISIBLE}|${WS_CHILD}|${WS_CLIPSIBLINGS}
    SetCtlColors $Label3 "0x000000" "TRANSPARENT"

; Fourth label
	${NSD_CreateLabel} 115u 150u 63% 10u "$(CPro_Widget_FinishPage_4)"
	Pop $Label4
	${NSD_AddStyle} $Label4 ${WS_VISIBLE}|${WS_CHILD}|${WS_CLIPSIBLINGS}
    SetCtlColors $Label4 "0x000000" "TRANSPARENT"	

; CheckBox 1
	${NSD_CreateCheckBox} 115u 160u 65% 10u "$(CPro_Widget_FinishPage_5)"
	Pop $CheckBox1
    SetCtlColors $CheckBox1 "0x000000" "0xFFFFFF"
	
; CheckBox 2
	${NSD_CreateCheckBox} 115u 173u 65% 10u "$(CPro_Widget_FinishPage_6)"
	Pop $CheckBox2	
    SetCtlColors $CheckBox2 "0x000000" "0xFFFFFF"	
	
	${NSD_Check} $CheckBox1
	${NSD_Check} $CheckBox2	

	GetDlgItem $R0 $HWNDPARENT 1
	SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(CPro_Widget_FinishPage_7)"
	
	nsDialogs::Show
	${NSD_FreeImage} $Img_Handle_Left

FunctionEnd

Function Button_Click

	Pop $0
	ExecShell "open" "${CPro_Widget_PayPal_Link}"

FunctionEnd

Function CheckFinishPage

	${NSD_GetState} $CheckBox1 $Checkbox_State
	${If} $Checkbox_State = ${BST_CHECKED}
		ExecShell "open" "${CPRO_WIDGET_WEB_PAGE}"
	${EndIf}
	
	${NSD_GetState} $CheckBox2 $Checkbox_State
	${If} $Checkbox_State = ${BST_CHECKED}
		ExecShell "open" "$INSTDIR\winamp.exe"
		
	${EndIf}
	
FunctionEnd
	

;###########################################################################################
;#											INSTALLER  SECTIONS 
;###########################################################################################

Section "-Pre"

	DetailPrint "$(CPro_Winamp_Path)"
		Call MultiUser_Path

	DetailPrint "$(CPro_Check_Winamp)"
		Call CloseWinamp
		
SectionEnd

Section "$(CPro_Widget_Files)" "CPro_Widget_Sec_Files"

	SectionIn RO
	
	SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets\Load"
		File "Load\${CPRO_WIDGET_XMLFILENAME}"
 
	SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets\Data\${CPRO_WIDGET_DATA_FOLDERNAME}"
		File "Data\${CPRO_WIDGET_DATA_FOLDERNAME}\*.m"
		File "Data\${CPRO_WIDGET_DATA_FOLDERNAME}\*.maki"
		File "Data\${CPRO_WIDGET_DATA_FOLDERNAME}\*.xml"
		File "Data\${CPRO_WIDGET_DATA_FOLDERNAME}\*.mi"

	SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\icons"
		File "Data\${CPRO_WIDGET_DATA_FOLDERNAME}\icons\*.png"

	SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\source"
		File "Data\${CPRO_WIDGET_DATA_FOLDERNAME}\source\*.xml"			

	SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets"
		File "${CPRO_WIDGET_NSISFILENAME}"

	DetailPrint "$(CPro_Ini)"
		WriteINIStr "$MultiPath\winamp.ini" "Winamp" "skin" "cPro__Bento.wal"
		FlushINI "$MultiPath\winamp.ini"

SectionEnd

Section "-Leave"

; Registry entries
	WriteRegStr "HKLM" "Software\Microsoft\Windows\CurrentVersion\Uninstall\${CPRO_WIDGET_NAME}" "UninstallString" '"$INSTDIR\Plugins\ClassicPro\engine\widgets\${CPRO_WIDGET_UNINSTALLER}.exe"'
	WriteRegStr "HKLM" "Software\Microsoft\Windows\CurrentVersion\Uninstall\${CPRO_WIDGET_NAME}" "InstallLocation" "$INSTDIR\Plugins\ClassicPro\engine\widgets"
	WriteRegStr "HKLM" "Software\Microsoft\Windows\CurrentVersion\Uninstall\${CPRO_WIDGET_NAME}" "DisplayName" "${CPRO_WIDGET_NAME} v${CPRO_WIDGET_VERSION}"
	WriteRegStr "HKLM" "Software\Microsoft\Windows\CurrentVersion\Uninstall\${CPRO_WIDGET_NAME}" "DisplayIcon" "$INSTDIR\Plugins\ClassicPro\_installer\Images\widget.ico"
	WriteRegStr "HKLM" "Software\Microsoft\Windows\CurrentVersion\Uninstall\${CPRO_WIDGET_NAME}" "DisplayVersion" "${CPRO_WIDGET_VERSION}"
	WriteRegStr "HKLM" "Software\Microsoft\Windows\CurrentVersion\Uninstall\${CPRO_WIDGET_NAME}" "URLInfoAbout" "${CPRO_WIDGET_WEB_PAGE}"
	WriteRegStr "HKLM" "Software\Microsoft\Windows\CurrentVersion\Uninstall\${CPRO_WIDGET_NAME}" "HelpLink" ${CPRO_WIDGET_HELP_LINK} 
	WriteRegStr "HKLM" "Software\Microsoft\Windows\CurrentVersion\Uninstall\${CPRO_WIDGET_NAME}" "Publisher" "${CPRO_WIDGET_COMPANY}"
	WriteRegDWORD "HKLM" "Software\Microsoft\Windows\CurrentVersion\Uninstall\${CPRO_WIDGET_NAME}" "NoModify" "1"
	WriteRegDWORD "HKLM" "Software\Microsoft\Windows\CurrentVersion\Uninstall\${CPRO_WIDGET_NAME}" "NoRepair" "1"

;Create uninstaller
	WriteUninstaller "$INSTDIR\Plugins\ClassicPro\engine\widgets\${CPRO_WIDGET_UNINSTALLER}.exe"
	
	SetAutoClose false
	
SectionEnd

;###########################################################################################
;#										INSTALLER DESCRIPTIONS SECTION 
;###########################################################################################

	!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
		!insertmacro MUI_DESCRIPTION_TEXT ${CPro_Widget_Sec_Files} $(CPro_Widget_Desc_Files)
	!insertmacro MUI_FUNCTION_DESCRIPTION_END

;###########################################################################################
;#										  	UNINSTALLER
;###########################################################################################

	ShowUninstDetails "show"

Function un.onInit

	!insertmacro MUI_LANGDLL_DISPLAY
	
	DetailPrint "$(CPro_Winamp_Path)"
		Call un.MultiUser_Path	
		
	DetailPrint "$(CPro_Check_Winamp)"
		Call un.CloseWinamp
		
FunctionEnd

Section "-Un.Uninstall"

	SetAutoClose "false"

	Delete "$INSTDIR\Load\${CPRO_WIDGET_XMLFILENAME}"
 
	Delete "$INSTDIR\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\*.m"
	Delete "$INSTDIR\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\*.maki"
	Delete "$INSTDIR\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\*.xml"
	Delete "$INSTDIR\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\*.mi"
	Delete "$INSTDIR\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\icons\*.png"
	Delete "$INSTDIR\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\source\*.xml"			
	RMDir "$INSTDIR\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\icons"
	RMDir "$INSTDIR\Data\${CPRO_WIDGET_DATA_FOLDERNAME}\source"
	RMDir "$INSTDIR\Data\${CPRO_WIDGET_DATA_FOLDERNAME}"	
	
	Delete "$INSTDIR\${CPRO_WIDGET_NSISFILENAME}"	
	
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${CPRO_WIDGET_NAME}"	
	Delete /REBOOTOK "$INSTDIR\${CPRO_WIDGET_UNINSTALLER}.exe"
	
SectionEnd

;###########################################################################################
;#										CPRO WIDGETS - THE END
;###########################################################################################