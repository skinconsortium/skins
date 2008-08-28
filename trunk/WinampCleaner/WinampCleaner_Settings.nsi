; WinampCleaner_Settings

;--------------------------------
; Define Sourcedirectory here

; source path of pjn123
!define SOURCEPATH "C:\Program Files\Winamp\trunk\WinampCleaner\"


;--------------------------------
;Include Modern UI

  !include "MUI.nsh"

;--------------------------------
;General

  ;Name and file
  Name "WinampCleaner: Settings"
  OutFile "WinampCleaner_Settings_1.00.exe"


;--------------------------------
;Interface Settings
  !define MUI_TEXT_WELCOME_INFO_TEXT "This wizard will guide you through the installation of $(^NameDA).$\r$\n$\r$\nIt is recommended that you close Winamp before starting Setup. This will make it possible to update all relevant Winamp files.$\n$\nYou'll at least need Winamp 5.54 for this version of ClassicPro to work!$\r$\n$\r$\n$_CLICK"

  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_RIGHT
  !define MUI_HEADERIMAGE_BITMAP "${SOURCEPATH}\header.bmp"

  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_LICENSE "${SOURCEPATH}\License.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_INSTFILES
  ;!insertmacro MUI_PAGE_FINISH


  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  ;!insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "Clean Winamp Settings" cleanwinampset
	SetShellVarContext current
	RMDir /r $APPDATA\Winamp
	;MessageBox MB_OK $APPDATA
SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_cleanwinampset ${LANG_ENGLISH} "BrowserPro is a widget that will enable your browser to auto navigate to pupular websites and explore the playing directory."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${cleanwinampset} $(DESC_cleanwinampset)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

