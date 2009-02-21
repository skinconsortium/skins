; ClassicPro Installer


;--------------------------------
; Define Sourcedirectory here


; source path of pjn123
!define SOURCEPATH "C:\Program Files (x86)\Winamp\Plugins\ClassicPro\"

; source path of martin.deimos
;!define SOURCEPATH "C:\Program Files\Winamp\Plugins\ClassicPro\"




;--------------------------------
;Include Modern UI


  !include "MUI.nsh"


;--------------------------------
;General


  ;Name and file
  Name "ClassicPro© v1.1"
  
  ;RELEASE  
  ;OutFile "ClassicPro_1.1.exe"


  ;BETA STAGE  
  !define /date DATE "%Y-%m-%d"
  OutFile "ClassicPro_1.1_(${DATE}).exe"


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
  !define MUI_TEXT_WELCOME_INFO_TEXT "This wizard will guide you through the installation of $(^NameDA).$\r$\n$\r$\nIt is recommended that you close Winamp before starting Setup. This will make it possible to update all relevant Winamp files.$\n$\nYou'll at least need Winamp 5.55 for this version of ClassicPro to work!$\r$\n$\r$\n$_CLICK"


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
  ;!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\arrow2-uninstall.ico"
  !define MUI_UNICON "${SOURCEPATH}\_installer\icon.ico"



;--------------------------------
;Pages


  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "${SOURCEPATH}\License.txt"
  !insertmacro MUI_PAGE_COMPONENTS
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




Section "ClassicPro Engine" cproFiles


	!ifdef WINAMP_AUTOINSTALL
	  Call MakeSureIGotWinamp
	!endif


  SectionIn RO    ; required


  SetOutPath $INSTDIR\Plugins\ClassicPro
  File "${SOURCEPATH}\*.txt"


  SetOutPath $INSTDIR\Plugins\ClassicPro\_installer
  File "${SOURCEPATH}\_installer\*.nsi"
  File "${SOURCEPATH}\_installer\icon.ico"
  File "${SOURCEPATH}\_installer\widget.ico"
  File "${SOURCEPATH}\_installer\logo.bmp"
  File "${SOURCEPATH}\_installer\header.bmp"
  File "${SOURCEPATH}\_installer\win.bmp"
  
  SetOutPath $INSTDIR\Plugins\ClassicPro\engine
  File "${SOURCEPATH}\engine\*.xml"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\scripts
  File "${SOURCEPATH}\engine\scripts\*.m"
  File "${SOURCEPATH}\engine\scripts\*.maki"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\scripts\attribs
  File "${SOURCEPATH}\engine\scripts\attribs\*.m"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\scripts\lib
  File "${SOURCEPATH}\engine\scripts\lib\*.mi"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xml
  File "${SOURCEPATH}\engine\xml\*.xml"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\image
  File "${SOURCEPATH}\engine\image\*.png"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui
  File "${SOURCEPATH}\engine\xui\*.xml"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\AlbumArt
  File "${SOURCEPATH}\engine\xui\AlbumArt\*.xml"
  File "${SOURCEPATH}\engine\xui\AlbumArt\*.m"
  File "${SOURCEPATH}\engine\xui\AlbumArt\*.maki"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\CentroSUI
  File "${SOURCEPATH}\engine\xui\CentroSUI\*.xml"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\CentroSUI\scripts
  File "${SOURCEPATH}\engine\xui\CentroSUI\scripts\*.m"
  File "${SOURCEPATH}\engine\xui\CentroSUI\scripts\*.maki"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\CproTabs
  File "${SOURCEPATH}\engine\xui\CproTabs\*.xml"
  File "${SOURCEPATH}\engine\xui\CproTabs\*.m"
  File "${SOURCEPATH}\engine\xui\CproTabs\*.maki"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\editbox
  File "${SOURCEPATH}\engine\xui\editbox\*.xml"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\FadeText
  File "${SOURCEPATH}\engine\xui\FadeText\*.xml"
  File "${SOURCEPATH}\engine\xui\FadeText\*.m"
  File "${SOURCEPATH}\engine\xui\FadeText\*.maki"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\historyeditbox
  File "${SOURCEPATH}\engine\xui\historyeditbox\*.xml"
  File "${SOURCEPATH}\engine\xui\historyeditbox\*.m"
  File "${SOURCEPATH}\engine\xui\historyeditbox\*.maki"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\ModernSongticker
  File "${SOURCEPATH}\engine\xui\ModernSongticker\*.xml"
  File "${SOURCEPATH}\engine\xui\ModernSongticker\*.txt"
  File "${SOURCEPATH}\engine\xui\ModernSongticker\*.m"
  File "${SOURCEPATH}\engine\xui\ModernSongticker\*.maki"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\PlaylistPro
  File "${SOURCEPATH}\engine\xui\PlaylistPro\alt\*.xml"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\Ratings
  File "${SOURCEPATH}\engine\xui\Ratings\*.xml"
  File "${SOURCEPATH}\engine\xui\Ratings\*.m"
  File "${SOURCEPATH}\engine\xui\Ratings\*.maki"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\SC-Channels
  File "${SOURCEPATH}\engine\xui\SC-Channels\*.xml"
  File "${SOURCEPATH}\engine\xui\SC-Channels\*.m"
  File "${SOURCEPATH}\engine\xui\SC-Channels\*.maki"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\SC-ProgressGrid
  File "${SOURCEPATH}\engine\xui\SC-ProgressGrid\*.xml"
  File "${SOURCEPATH}\engine\xui\SC-ProgressGrid\*.m"
  File "${SOURCEPATH}\engine\xui\SC-ProgressGrid\*.maki"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\updateSystem
  File "${SOURCEPATH}\engine\xui\updateSystem\*.xml"
  File "${SOURCEPATH}\engine\xui\updateSystem\*.m"
  File "${SOURCEPATH}\engine\xui\updateSystem\*.maki"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\WasabiButton
  File "${SOURCEPATH}\engine\xui\WasabiButton\*.xml"
  File "${SOURCEPATH}\engine\xui\WasabiButton\*.m"
  File "${SOURCEPATH}\engine\xui\WasabiButton\*.maki"




	; ======= cPro::One =======
  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\one\scripts
  File "${SOURCEPATH}\engine\one\scripts\*.m"
  File "${SOURCEPATH}\engine\one\scripts\*.maki"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\one\scripts\attribs
  File "${SOURCEPATH}\engine\one\scripts\attribs\*.m"


  SetOutPath $INSTDIR\Plugins\ClassicPro\engine\one\xml
  File "${SOURCEPATH}\engine\one\xml\*.xml"
 
  
  


  SetOutPath "$INSTDIR\Skins"
  File "C:\Program Files (x86)\Winamp\Skins\Cpro__Bento.wal"


  RMDir /r "$INSTDIR\Skins\cPro - Big Bento\" 
  RMDir /r "$INSTDIR\Skins\cPro - Bento\" 
  RMDir /r "$INSTDIR\Skins\cPro_Bento\" 
 
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall ClassicPro.exe"


SectionEnd


SectionGroup "Components" cprocustom
	Section "Playlist Search" cPlaylistPro
		SetOutPath $INSTDIR\Plugins\ClassicPro\engine\xui\PlaylistPro
		File "${SOURCEPATH}\engine\xui\PlaylistPro\*.xml"
		File "${SOURCEPATH}\engine\xui\PlaylistPro\*.m"
		File "${SOURCEPATH}\engine\xui\PlaylistPro\*.maki"
	SectionEnd
SectionGroupEnd


SectionGroup "Widgets" WidgetsSection
Section "BrowserPro v2.0" wBrowserPro


	SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets\Load"
	File "${SOURCEPATH}\engine\widgets\Load\browserpro.xml"
 
	SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets\Data\BrowserPro"
	Delete "${SOURCEPATH}\engine\widgets\Data\BrowserPro\*.xml"
	File "${SOURCEPATH}\engine\widgets\Data\BrowserPro\*.m"
	File "${SOURCEPATH}\engine\widgets\Data\BrowserPro\*.maki"
	File "${SOURCEPATH}\engine\widgets\Data\BrowserPro\*.xml"
	File "${SOURCEPATH}\engine\widgets\Data\BrowserPro\*.mi"

	SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets\Data\BrowserPro\source"
	File "${SOURCEPATH}\engine\widgets\Data\BrowserPro\source\*.xml"

	SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets\Data\BrowserPro\icons"
	File "${SOURCEPATH}\engine\widgets\Data\BrowserPro\icons\*.png"


	SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets"
	File /nonfatal "${SOURCEPATH}\engine\widgets\cpro-widget-BrowserPro.nsi"


SectionEnd


Section "Now Playing v1.1" wAlbumArt
	SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets\Load"
	File "${SOURCEPATH}\engine\widgets\Load\nowplaying.xml"


	SetOutPath "$INSTDIR\Plugins\ClassicPro\engine\widgets\Data\NowPlaying"
	File "${SOURCEPATH}\engine\widgets\Data\NowPlaying\*.xml"
	File "${SOURCEPATH}\engine\widgets\Data\NowPlaying\*.m"
	File "${SOURCEPATH}\engine\widgets\Data\NowPlaying\*.maki"
	File "${SOURCEPATH}\engine\widgets\Data\NowPlaying\*.png"
SectionEnd




SectionGroupEnd


;--------------------------------
;Descriptions


  ;Language strings
  LangString DESC_cproFiles ${LANG_ENGLISH} "This will install all the files that ClassicPro needs to work."
  LangString DESC_wBrowserPro ${LANG_ENGLISH} "BrowserPro is a widget that will enable your browser to auto navigate to popular websites and explore the playing directory."
  LangString DESC_wAlbumArt ${LANG_ENGLISH} "AlbumArt is a widget that shows a big cd cover and information about the playing file."
  LangString DESC_Widget ${LANG_ENGLISH} "ClassicPro skins support widgets and here you'll find some of them that we decided to bundle with this installer."
  LangString DESC_cprocustom ${LANG_ENGLISH} "Optional components for ClassicPro."
  LangString DESC_cPlaylistPro ${LANG_ENGLISH} "Add a search box above your playlist for easy searches in your playlist."


  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${cproFiles} $(DESC_cproFiles)
    !insertmacro MUI_DESCRIPTION_TEXT ${wBrowserPro} $(DESC_wBrowserPro)
    !insertmacro MUI_DESCRIPTION_TEXT ${wAlbumArt} $(DESC_wAlbumArt)
    !insertmacro MUI_DESCRIPTION_TEXT ${WidgetsSection} $(DESC_Widget)
    !insertmacro MUI_DESCRIPTION_TEXT ${cprocustom} $(DESC_cprocustom)
    !insertmacro MUI_DESCRIPTION_TEXT ${cPlaylistPro} $(DESC_cPlaylistPro)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END


;--------------------------------
;Uninstaller Section


Section "Uninstall"


  RMDir /r "$INSTDIR\Plugins\ClassicPro"


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
  ExecShell "" "$INSTDIR\Skins\Cpro__Bento.wal"
FunctionEnd