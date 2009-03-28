; Komodo Installer

;--------------------------------
; Define Sourcedirectory here

; source path of pjn123
!define SOURCEPATH "C:\Program Files\Winamp\Skins\Komodo\"


;--------------------------------
;Include Modern UI

  !include "MUI.nsh"

;--------------------------------
;General

  ;Name and file
  Name "Komodo v0.13"
  
  ;RELEASE  
  OutFile "Komodo_0.13.exe"

  ;BETA STAGE  
  !define /date DATE "%Y-%m-%d"
  ;OutFile "Komodo_0.12_(${DATE}).exe"

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
  !define MUI_TEXT_WELCOME_INFO_TEXT "This wizard will guide you through the installation of $(^NameDA).$\r$\n$\r$\nIt is recommended that you close Winamp before starting Setup. This will make it possible to update all relevant Winamp files.$\n$\nYou'll at least need Winamp 5.551 for this version of Komodo to work!$\r$\n$\r$\n$_CLICK"

  !define MUI_WELCOMEFINISHPAGE_BITMAP "${SOURCEPATH}\_installer\win.bmp"
  !define MUI_UNWELCOMEFINISHPAGE_BITMAP "${SOURCEPATH}\_installer\win.bmp"

  !define MUI_FINISHPAGE_RUN "$INSTDIR\Winamp.exe"
  !define MUI_FINISHPAGE_RUN_TEXT "Open Komodo in Winamp now?"
  !define MUI_FINISHPAGE_RUN_FUNCTION "LaunchLink"

  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_RIGHT
  !define MUI_HEADERIMAGE_BITMAP "${SOURCEPATH}\_installer\header.bmp"

  !define MUI_ABORTWARNING

  !define MUI_ICON "${SOURCEPATH}\_installer\icon.ico"
  !define MUI_UNICON "${SOURCEPATH}\_installer\icon.ico"

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "${SOURCEPATH}\License.txt"
  ;!insertmacro MUI_PAGE_COMPONENTS
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


Section "Komodo Engine" komodoFiles

	!ifdef WINAMP_AUTOINSTALL
		Call MakeSureIGotWinamp
	!endif
	
	SectionIn RO    ; required

	SetOutPath $INSTDIR\Skins\Komodo
	File "${SOURCEPATH}\*.xml"
	File "${SOURCEPATH}\*.jpg"
	File "${SOURCEPATH}\*.png"
	File "${SOURCEPATH}\*.maki"

	;SetOutPath $INSTDIR\Skins\Komodo\_installer
	;File "${SOURCEPATH}\_installer\*.ico"
	;File "${SOURCEPATH}\_installer\*.nsi"
	;File "${SOURCEPATH}\_installer\*.bmp"
	
	SetOutPath $INSTDIR\Skins\Komodo\engine
	File "${SOURCEPATH}\engine\*.xml"
	
	SetOutPath $INSTDIR\Skins\Komodo\engine\gfx
	File "${SOURCEPATH}\engine\gfx\*.png"
	SetOutPath $INSTDIR\Skins\Komodo\engine\gfx\standardframe
	File "${SOURCEPATH}\engine\gfx\standardframe\*.png"
	SetOutPath $INSTDIR\Skins\Komodo\engine\gfx\standardframe\window
	File "${SOURCEPATH}\engine\gfx\standardframe\window\*.png"

	SetOutPath $INSTDIR\Skins\Komodo\engine\player
	File "${SOURCEPATH}\engine\player\*.png"
	File "${SOURCEPATH}\engine\player\*.ttf"

	SetOutPath $INSTDIR\Skins\Komodo\engine\scripts
	;File "${SOURCEPATH}\engine\scripts\*.m"
	File "${SOURCEPATH}\engine\scripts\*.maki"
	;File "${SOURCEPATH}\engine\scripts\*.bat"
	File "${SOURCEPATH}\engine\scripts\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\updatemanager
	;File "${SOURCEPATH}\engine\updatemanager\*.m"
	File "${SOURCEPATH}\engine\updatemanager\*.maki"
	File "${SOURCEPATH}\engine\updatemanager\*.xml"
	;File "${SOURCEPATH}\engine\updatemanager\*.psd"

	SetOutPath $INSTDIR\Skins\Komodo\engine\wasabi
	File "${SOURCEPATH}\engine\wasabi\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\wasabi\standardframe
	;File "${SOURCEPATH}\engine\wasabi\standardframe\*.m"
	File "${SOURCEPATH}\engine\wasabi\standardframe\*.maki"
	File "${SOURCEPATH}\engine\wasabi\standardframe\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\window
	File "${SOURCEPATH}\engine\window\*.png"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xml
	File "${SOURCEPATH}\engine\xml\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui
	File "${SOURCEPATH}\engine\xui\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\CoverShow
	;File "${SOURCEPATH}\engine\xui\CoverShow\*.m"
	File "${SOURCEPATH}\engine\xui\CoverShow\*.maki"
	File "${SOURCEPATH}\engine\xui\CoverShow\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\CustomBG
	;File "${SOURCEPATH}\engine\xui\CustomBG\*.m"
	File "${SOURCEPATH}\engine\xui\CustomBG\*.maki"
	File "${SOURCEPATH}\engine\xui\CustomBG\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\customButton
	;File "${SOURCEPATH}\engine\xui\customButton\*.m"
	File "${SOURCEPATH}\engine\xui\customButton\*.maki"
	File "${SOURCEPATH}\engine\xui\customButton\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\FadeText
	;File "${SOURCEPATH}\engine\xui\FadeText\*.m"
	File "${SOURCEPATH}\engine\xui\FadeText\*.maki"
	File "${SOURCEPATH}\engine\xui\FadeText\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\fileSelect
	;File "${SOURCEPATH}\engine\xui\fileSelect\*.m"
	File "${SOURCEPATH}\engine\xui\fileSelect\*.maki"
	File "${SOURCEPATH}\engine\xui\fileSelect\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\NowPlaying
	;File "${SOURCEPATH}\engine\xui\NowPlaying\*.m"
	File "${SOURCEPATH}\engine\xui\NowPlaying\*.maki"
	File "${SOURCEPATH}\engine\xui\NowPlaying\*.xml"
	File "${SOURCEPATH}\engine\xui\NowPlaying\*.png"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\playlistPlus
	;File "${SOURCEPATH}\engine\xui\playlistPlus\*.m"
	File "${SOURCEPATH}\engine\xui\playlistPlus\*.maki"
	File "${SOURCEPATH}\engine\xui\playlistPlus\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\ratings
	;File "${SOURCEPATH}\engine\xui\ratings\*.m"
	File "${SOURCEPATH}\engine\xui\ratings\*.maki"
	File "${SOURCEPATH}\engine\xui\ratings\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\VisAnim
	;File "${SOURCEPATH}\engine\xui\VisAnim\*.m"
	File "${SOURCEPATH}\engine\xui\VisAnim\*.maki"
	File "${SOURCEPATH}\engine\xui\VisAnim\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\optional
	File "${SOURCEPATH}\optional\*.png"
	File "${SOURCEPATH}\optional\*.xml"
	
	SetOutPath $INSTDIR\Skins
	File "${SOURCEPATH}\_installer\Komodo2.wal"

	IfFileExists "$INSTDIR\winamp.ini:komtrial.xml" SecondInstall
		SetOutPath $INSTDIR
		File "${SOURCEPATH}\_installer\simpleTrial.exe"
		
    	ExecWait "$INSTDIR\simpleTrial.exe -o:winamp.ini:komtrial.xml"
  	SecondInstall:
  	
  	Delete "$INSTDIR\simpleTrial.exe"
	 
	;Create uninstaller
	WriteUninstaller "$INSTDIR\Uninstall Komodo.exe"
	
  	
SectionEnd


;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_komodoFiles ${LANG_ENGLISH} "This will install all the files that Komodo needs to work."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${komodoFiles} $(DESC_komodoFiles)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  RMDir /r "$INSTDIR\Skins\Komodo"
  Delete "$INSTDIR\Skins\Komodo2.exe"

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
  ExecShell "" "$INSTDIR\Winamp.exe"
FunctionEnd