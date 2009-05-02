

!include "MUI.nsh"

;Name and file
Name "${WIDGET_NAME} widget for ClassicPro©"
OutFile "cpro-widget-${WIDGET_NAME}-${WIDGET_VERSION}.exe"
!define WIDGET_UNINSTALL_NAME "Uninstall (${WIDGET_NAME}).exe"


; The default installation directory
	InstallDir $PROGRAMFILES\Winamp

	; detect winamp path from uninstall string if available
	InstallDirRegKey HKLM \
                 "Software\Microsoft\Windows\CurrentVersion\Uninstall\Winamp" \
                 "UninstallString"

	; The text to prompt the user to enter a directory
	DirText "Please select your Winamp path below (you will be able to proceed when Winamp is detected):"


;--------------------------------
;Interface Settings

  !define MUI_FINISHPAGE_RUN "$INSTDIR\winamp.exe"
  !define MUI_FINISHPAGE_RUN_TEXT "Reload ClassicPro or open Winamp now"
  !define MUI_FINISHPAGE_RUN_FUNCTION "LaunchLink"

  !define MUI_UNFINISHPAGE_RUN "$INSTDIR\winamp.exe"
  !define MUI_UNFINISHPAGE_RUN_TEXT "Reload ClassicPro or open Winamp now"
  !define MUI_UNFINISHPAGE_RUN_FUNCTION "LaunchLink"

  !define MUI_ABORTWARNING

  !define MUI_ICON "${SOURCEPATH}\_installer\Images\widget.ico"
  !define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\orange-uninstall.ico"
  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_LEFT
  !define MUI_HEADERIMAGE_BITMAP "${SOURCEPATH}\_installer\Images\header-widget.bmp"

;--------------------------------
;Pages

;	!insertmacro MUI_PAGE_WELCOME
;	!insertmacro MUI_PAGE_LICENSE "${SOURCEPATH}\License.txt"
;	!insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH


  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "Dummy Section" SecDummy

	!ifdef WINAMP_AUTOINSTALL
	  Call MakeSureIGotWinamp
	!endif

	SetOutPath "$INSTDIR\Plugins\classicPro\engine\widgets\Load"
	File "${SOURCEPATH}\engine\widgets\Load\${XMLFILENAME}"
 
	SetOutPath "$INSTDIR\Plugins\classicPro\engine\widgets\Data\${DATA_FOLDERNAME}"
	File /nonfatal "${SOURCEPATH}\engine\widgets\Data\${DATA_FOLDERNAME}\*.m"
	File /nonfatal "${SOURCEPATH}\engine\widgets\Data\${DATA_FOLDERNAME}\*.maki"
	File /nonfatal "${SOURCEPATH}\engine\widgets\Data\${DATA_FOLDERNAME}\*.xml"
	File /nonfatal "${SOURCEPATH}\engine\widgets\Data\${DATA_FOLDERNAME}\*.png"
	File /nonfatal "${SOURCEPATH}\engine\widgets\Data\${DATA_FOLDERNAME}\*.jpg"

	SetOutPath "$INSTDIR\Plugins\classicPro\engine\widgets\Data\${DATA_FOLDERNAME}\icons"
	File /nonfatal "${SOURCEPATH}\engine\widgets\Data\${DATA_FOLDERNAME}\icons\*.png"

	SetOutPath "$INSTDIR\Plugins\classicPro\engine\widgets"
	File /nonfatal "${SOURCEPATH}\engine\widgets\${NSISFILENAME}"

	;Create uninstaller
	WriteUninstaller "$INSTDIR\Plugins\classicPro\engine\widgets\${WIDGET_UNINSTALL_NAME}"

SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecDummy ${LANG_ENGLISH} "A test section."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
; Reload Winamp

Function LaunchLink
;  ExecShell "" "$INSTDIR\winamp.exe"
; (mpdeimos) now we just reload winamp or open it if not already done!

	Push $5
	FindWindow $5 "Winamp v1.x"
	IntCmp $5 0 NoWinamp
		; MessageBox MB_OK|MB_ICONEXCLAMATION "$(CPro_Close_Winamp)" 
		; TODO (mpdeimos) maybe include a loop for refreshing skin again!
		;loop:
		;	FindWindow $5 "Winamp v1.x"
		;	IntCmp $5 0 NoMoreWinampToKill
		;	DetailPrint "$(CPro_Closing_Winamp)"			
				SendMessage $5 0x0111 40291 0
		;		Sleep 100
		;		Goto loop
		;	NoMoreWinampToKill:
		;		DetailPrint "$(CPro_No_More_Winamp)"
				GoTo RefreshDone
	NoWinamp:	
		ExecShell "" "$INSTDIR\winamp.exe"
	RefreshDone:	
	Pop $5

FunctionEnd

Function un.LaunchLink

	Push $5
	FindWindow $5 "Winamp v1.x"
	IntCmp $5 0 RefreshDone		
		SendMessage $5 0x0111 40291 0
	RefreshDone:
	Pop $5

FunctionEnd

;--------------------------------
;Uninstaller Section

Section "Uninstall"

	Delete "$INSTDIR\Load\${XMLFILENAME}"
	Delete "$INSTDIR\${NSISFILENAME}"
	
	Delete "$INSTDIR\Data\${DATA_FOLDERNAME}\icons\*.*"
	RMDir "$INSTDIR\Data\${DATA_FOLDERNAME}\icons\"
	
	Delete "$INSTDIR\Data\${DATA_FOLDERNAME}\*.*"
	RMDir "$INSTDIR\Data\${DATA_FOLDERNAME}"
	Delete "$INSTDIR\${WIDGET_UNINSTALL_NAME}"

	; TODO (mpdeimos) we should make this an option and move to finishonclick
	call un.LaunchLink

SectionEnd


;--------------------------------
;Make sure you have Winamp

Function .onVerifyInstDir

!ifndef WINAMP_AUTOINSTALL

  ;Check for Winamp installation

  IfFileExists $INSTDIR\Winamp.exe Good
    Abort
  Good:

!endif ; WINAMP_AUTOINSTALL

FunctionEnd