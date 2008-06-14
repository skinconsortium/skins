; ClassicPro Installer

;--------------------------------
; Define Sourcedirectory here

; source path of pjn123
!define SOURCEPATH "C:\Program Files\Winamp\Plugins\classicPro\"


;--------------------------------
;Include Modern UI

  !include "MUI.nsh"

;--------------------------------
;General

  ;Name and file
  Name "ClassicPro© v1.04"
  OutFile "ClassicPro_1.04_beta2.exe"

	; The default installation directory
	InstallDir $PROGRAMFILES\Winamp

	; detect winamp path from uninstall string if available
	InstallDirRegKey HKLM \
                 "Software\Microsoft\Windows\CurrentVersion\Uninstall\Winamp" \
                 "UninstallString"

	; The text to prompt the user to enter a directory
	DirText "Please select your Winamp path below (you will be able to proceed when Winamp is detected):"


Function .onInit
        # the plugins dir is automatically deleted when the installer exits
        InitPluginsDir
        File /oname=$PLUGINSDIR\splash.bmp "${SOURCEPATH}\_installer\logo.bmp"
        advsplash::show 1000 600 400 0x04025C $PLUGINSDIR\splash
        Pop $0 

        Delete $PLUGINSDIR\splash.bmp
FunctionEnd


;--------------------------------
;Interface Settings
  !define MUI_TEXT_WELCOME_INFO_TEXT "This wizard will guide you through the installation of $(^NameDA).$\r$\n$\r$\nIt is recommended that you close Winamp before starting Setup. This will make it possible to update all relevant Winamp files.$\n$\nYou'll at least need Winamp 5.53 for this version of ClassicPro to work!$\r$\n$\r$\n$_CLICK"

  !define MUI_WELCOMEFINISHPAGE_BITMAP "${SOURCEPATH}\_installer\win.bmp"
  !define MUI_UNWELCOMEFINISHPAGE_BITMAP "${SOURCEPATH}\_installer\win.bmp"

  !define MUI_FINISHPAGE_RUN "$INSTDIR\Skins\cPro__Bento.wal"
  !define MUI_FINISHPAGE_RUN_TEXT "Open the bundled ClassicPro© skin in Winamp"
  !define MUI_FINISHPAGE_RUN_FUNCTION "LaunchLink"

  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_RIGHT
  !define MUI_HEADERIMAGE_BITMAP "${SOURCEPATH}\_installer\header.bmp"

  !define MUI_ABORTWARNING

  !define MUI_ICON "${SOURCEPATH}\_installer\icon.ico"
  !define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\arrow-uninstall.ico"

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

Section "Dummy Section" SecDummy

	!ifdef WINAMP_AUTOINSTALL
	  Call MakeSureIGotWinamp
	!endif

  SetOutPath $INSTDIR\Plugins\classicPro
  File "${SOURCEPATH}\*.txt"

  SetOutPath $INSTDIR\Plugins\classicPro\_installer
  File "${SOURCEPATH}\_installer\*.nsi"
  File "${SOURCEPATH}\_installer\icon.ico"
  File "${SOURCEPATH}\_installer\widget.ico"
  File "${SOURCEPATH}\_installer\logo.bmp"
  File "${SOURCEPATH}\_installer\header.bmp"
  File "${SOURCEPATH}\_installer\win.bmp"
  
  SetOutPath $INSTDIR\Plugins\classicPro\engine
  File "${SOURCEPATH}\engine\*.xml"

  SetOutPath $INSTDIR\Plugins\classicPro\engine\scripts
  File "${SOURCEPATH}\engine\scripts\*.m"
  File "${SOURCEPATH}\engine\scripts\*.maki"

  SetOutPath $INSTDIR\Plugins\classicPro\engine\scripts\attribs
  File "${SOURCEPATH}\engine\scripts\attribs\*.m"

  SetOutPath $INSTDIR\Plugins\classicPro\engine\xml
  File "${SOURCEPATH}\engine\xml\*.xml"

  SetOutPath $INSTDIR\Plugins\classicPro\engine\image
  File "${SOURCEPATH}\engine\image\*.png"

  SetOutPath $INSTDIR\Plugins\classicPro\engine\homepage
  File "${SOURCEPATH}\engine\homepage\*.htm"

  SetOutPath $INSTDIR\Plugins\classicPro\engine\xui
  File "${SOURCEPATH}\engine\xui\*.xml"

  SetOutPath $INSTDIR\Plugins\classicPro\engine\xui\CentroSUI
  File "${SOURCEPATH}\engine\xui\CentroSUI\*.xml"
  File "${SOURCEPATH}\engine\xui\CentroSUI\*.png"

  SetOutPath $INSTDIR\Plugins\classicPro\engine\xui\CentroSUI\scripts
  File "${SOURCEPATH}\engine\xui\CentroSUI\scripts\*.m"
  File "${SOURCEPATH}\engine\xui\CentroSUI\scripts\*.maki"

  SetOutPath $INSTDIR\Plugins\classicPro\engine\xui\updateSystem
  File "${SOURCEPATH}\engine\xui\updateSystem\*.xml"
  File "${SOURCEPATH}\engine\xui\updateSystem\*.m"
  File "${SOURCEPATH}\engine\xui\updateSystem\*.maki"

  SetOutPath $INSTDIR\Plugins\classicPro\engine\xui\editbox
  File "${SOURCEPATH}\engine\xui\editbox\*.xml"

  SetOutPath $INSTDIR\Plugins\classicPro\engine\xui\historyeditbox
  File "${SOURCEPATH}\engine\xui\historyeditbox\*.xml"
  File "${SOURCEPATH}\engine\xui\historyeditbox\*.m"
  File "${SOURCEPATH}\engine\xui\historyeditbox\*.maki"

  SetOutPath $INSTDIR\Plugins\classicPro\engine\xui\SC-ProgressGrid
  File "${SOURCEPATH}\engine\xui\SC-ProgressGrid\*.xml"
  File "${SOURCEPATH}\engine\xui\SC-ProgressGrid\*.m"
  File "${SOURCEPATH}\engine\xui\SC-ProgressGrid\*.maki"

  SetOutPath $INSTDIR\Plugins\classicPro\engine\xui\AlbumArt
  File "${SOURCEPATH}\engine\xui\AlbumArt\*.xml"
  File "${SOURCEPATH}\engine\xui\AlbumArt\*.m"
  File "${SOURCEPATH}\engine\xui\AlbumArt\*.maki"

  SetOutPath $INSTDIR\Plugins\classicPro\engine\xui\SC-Channels
  File "${SOURCEPATH}\engine\xui\SC-Channels\*.xml"
  File "${SOURCEPATH}\engine\xui\SC-Channels\*.m"
  File "${SOURCEPATH}\engine\xui\SC-Channels\*.maki"

  SetOutPath $INSTDIR\Plugins\classicPro\engine\xui\Ratings
  File "${SOURCEPATH}\engine\xui\Ratings\*.xml"
  File "${SOURCEPATH}\engine\xui\Ratings\*.m"
  File "${SOURCEPATH}\engine\xui\Ratings\*.maki"

  SetOutPath $INSTDIR\Plugins\classicPro\engine\xui\ModernSongticker
  File "${SOURCEPATH}\engine\xui\ModernSongticker\*.xml"
  File "${SOURCEPATH}\engine\xui\ModernSongticker\*.txt"
  File "${SOURCEPATH}\engine\xui\ModernSongticker\*.m"
  File "${SOURCEPATH}\engine\xui\ModernSongticker\*.maki"


  SetOutPath "$INSTDIR\Skins"
  File "C:\Program Files\Winamp\Skins\cPro__Bento.wal"

  RMDir /r "$INSTDIR\Skins\cPro - Big Bento\" 
  RMDir /r "$INSTDIR\Skins\cPro - Bento\" 
  RMDir /r "$INSTDIR\Skins\cPro_Bento\" 
 
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall ClassicPro.exe"

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

  Delete "$INSTDIR\Uninstall ClassicPro.exe"
  RMDir "$INSTDIR\Plugins\classicPro"

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
  ExecShell "" "$INSTDIR\Skins\cPro__Bento.wal"
FunctionEnd