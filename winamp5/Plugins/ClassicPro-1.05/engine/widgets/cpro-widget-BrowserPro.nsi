;-------------------------------------------------
; ClassicPro Widget Installer for ClassicPro v1.03
;		by SkinConsortium
;-------------------------------------------------

;-------------------------------------------------
; Change your widget information here
;-------------------------------------------------
!define SOURCEPATH "C:\Program Files\Winamp\Plugins\classicPro\"
!define XMLFILENAME "browserpro.xml"
!define DATA_FOLDERNAME "BrowserPro"
!define NSISFILENAME "cpro-widget-BrowserPro.nsi"
!define WIDGET_VERSION "0.9"
!define WIDGET_NAME "BrowserPro"


;----------------------------------------------------------------
;DONT CHANGE ANYTHING BELOW THIS LINE (UNLESS YOU KNOW WHAT YOUR DOING ;)
;----------------------------------------------------------------

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
  !define MUI_FINISHPAGE_RUN_TEXT "Open Winamp now"
  !define MUI_FINISHPAGE_RUN_FUNCTION "LaunchLink"

  !define MUI_ABORTWARNING

  !define MUI_ICON "${SOURCEPATH}\_installer\widget.ico"
  !define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\arrow2-uninstall.ico"

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
;Uninstaller Section

Section "Uninstall"

	Delete "$INSTDIR\Load\${XMLFILENAME}"
	Delete "$INSTDIR\${NSISFILENAME}"
	
	Delete "$INSTDIR\Data\${DATA_FOLDERNAME}\icons\*.*"
	RMDir "$INSTDIR\Data\${DATA_FOLDERNAME}\icons\"
	
	Delete "$INSTDIR\Data\${DATA_FOLDERNAME}\*.*"
	RMDir "$INSTDIR\Data\${DATA_FOLDERNAME}"
	Delete "$INSTDIR\${WIDGET_UNINSTALL_NAME}"


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

Function LaunchLink
  ExecShell "" "$INSTDIR\winamp.exe"
FunctionEnd