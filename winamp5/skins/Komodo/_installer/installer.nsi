; Komodo Installer

;--------------------------------
; Define Sourcedirectory here

!define SOURCEPATH "C:\Program Files\Winamp\Skins\Komodo\"

; This create locked or unlocked installer

;!define UNLOCK

;--------------------------------
;Include Modern UI

  !include "MUI.nsh"

;--------------------------------
;General

  ;Name and file
  Name "Komodo RC1"
  
  ;RELEASE
  !ifdef UNLOCK
  	OutFile "Komodo_RC1_UNLOCKED.exe"
  !else
  	OutFile "Komodo_RC1.exe"
  !endif

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


Var WINAMP_INI_DIR
Var WINAMP_INI_PATH

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
	File "${SOURCEPATH}\engine\updatemanager\*.maki"
	File "${SOURCEPATH}\engine\updatemanager\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\wasabi
	File "${SOURCEPATH}\engine\wasabi\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\wasabi\standardframe
	File "${SOURCEPATH}\engine\wasabi\standardframe\*.maki"
	File "${SOURCEPATH}\engine\wasabi\standardframe\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\window
	File "${SOURCEPATH}\engine\window\*.png"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xml
	File "${SOURCEPATH}\engine\xml\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui
	File "${SOURCEPATH}\engine\xui\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\CoverShow
	File "${SOURCEPATH}\engine\xui\CoverShow\*.maki"
	File "${SOURCEPATH}\engine\xui\CoverShow\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\CustomBG
	File "${SOURCEPATH}\engine\xui\CustomBG\*.maki"
	File "${SOURCEPATH}\engine\xui\CustomBG\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\customButton
	File "${SOURCEPATH}\engine\xui\customButton\*.maki"
	File "${SOURCEPATH}\engine\xui\customButton\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\FadeText
	File "${SOURCEPATH}\engine\xui\FadeText\*.maki"
	File "${SOURCEPATH}\engine\xui\FadeText\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\fileSelect
	File "${SOURCEPATH}\engine\xui\fileSelect\*.maki"
	File "${SOURCEPATH}\engine\xui\fileSelect\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\NowPlaying
	File "${SOURCEPATH}\engine\xui\NowPlaying\*.maki"
	File "${SOURCEPATH}\engine\xui\NowPlaying\*.xml"
	File "${SOURCEPATH}\engine\xui\NowPlaying\*.png"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\playlistPlus
	File "${SOURCEPATH}\engine\xui\playlistPlus\*.maki"
	File "${SOURCEPATH}\engine\xui\playlistPlus\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\ratings
	File "${SOURCEPATH}\engine\xui\ratings\*.maki"
	File "${SOURCEPATH}\engine\xui\ratings\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\engine\xui\VisAnim
	File "${SOURCEPATH}\engine\xui\VisAnim\*.maki"
	File "${SOURCEPATH}\engine\xui\VisAnim\*.xml"

	SetOutPath $INSTDIR\Skins\Komodo\optional
	File "${SOURCEPATH}\optional\*.png"
	File "${SOURCEPATH}\optional\*.xml"
	
	SetFileAttributes $INSTDIR\Skins\Komodo\engine HIDDEN|READONLY
	
	;Call GetWinampIniPath
	
	;MessageBox MB_OK $WINAMP_INI_DIR

	!ifdef UNLOCK
		SetOutPath $INSTDIR\Plugins
		File "${SOURCEPATH}\_installer\st.exe"
		
		
		ExecWait "$INSTDIR\Plugins\st.exe -o:kt.ini -u"
		SetFileAttributes $INSTDIR\Plugins\kt.ini HIDDEN|SYSTEM
	!else
		IfFileExists "$INSTDIR\Plugins\kt.ini" SecondInstall
			SetOutPath $INSTDIR\Plugins
			File "${SOURCEPATH}\_installer\st.exe"
			
	    	ExecWait "$INSTDIR\Plugins\st.exe -o:kt.ini -c"
	    	SetFileAttributes $INSTDIR\Plugins\kt.ini HIDDEN|SYSTEM
	  	SecondInstall:
  	!endif
  	
  	Delete "$INSTDIR\Plugins\st.exe"
	 
	;Create uninstaller
	WriteUninstaller "$INSTDIR\Uninstall Komodo.exe"
	
  	
SectionEnd

Section "Komodo-XP.wal" komodoXPFiles
	SetOutPath $INSTDIR\Skins
	File "${SOURCEPATH}\_installer\Komodo-XP.wal"
SectionEnd


;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_komodoFiles ${LANG_ENGLISH} "This will install all the files that Komodo needs to work."
  LangString DESC_komodoXPFiles ${LANG_ENGLISH} "This will install the alternate XP themed skin."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${komodoFiles} $(DESC_komodoFiles)
  !insertmacro MUI_DESCRIPTION_TEXT ${komodoXPFiles} $(DESC_komodoXPFiles)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  RMDir /r "$INSTDIR\Skins\Komodo"
  Delete "$INSTDIR\Skins\Komodo-XP.wal"
  Delete "$INSTDIR\Uninstall Komodo.exe"

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
	Call GetWinampIniPath

	WriteINIStr $WINAMP_INI_DIR\winamp.ini Winamp Skin Komodo
	ExecShell "" "$INSTDIR\Winamp.exe"
FunctionEnd

;--------------------------------
; Starting with Winamp 5.11, the Winamp installation can be for all users, or with multi-user settings.
; Machine (all users) installation keeps the settings in $WINAMP_DIR\Winamp.ini
; Multi-user installation has file $WINAMP_DIR\paths.ini, with the following 
;     [Winamp]
;     inidir={26}\Winamp5.51
; .. where {26} resolves to "C:\Documents and Settings\USERNAME\Application Data" (google CSIDL_APPDATA)
; Then Winamp.ini is in that directory
; See also: http://forums.winamp.com/showthread.php?s=&threadid=226675&highlight=multi+user+paths.ini
;--------------------------------
Function GetWinampIniPath

  ; If winamp.ini is in the same directory as winamp.exe, 
  ; then we are dealing with computer-wide installation.

  StrCpy $WINAMP_INI_DIR    $INSTDIR
  StrCpy $WINAMP_INI_PATH   $WINAMP_INI_DIR\Winamp.ini
  

  ; If paths.ini exists and is in the same directory as winamp.exe, 
  ; then we are dealing with multi-user installation.
  
  IfFileExists "$INSTDIR\paths.ini"   +1   file_not_found
  
  ; Read paths.ini to find out where user-specific Winamp.ini is installed.

  ReadINIStr $0 $INSTDIR\paths.ini   Winamp  inidir
  ReadINIStr $1 $INSTDIR\paths.ini   Winamp  inifile
  
  StrCmp $0 "" paths_ini_empty
  StrCpy $2 $0 4
  StrCmp $2 "{26}"   +1   no_replace
  StrCpy $2 $0 "" 4
  ExpandEnvStrings $0 "%APPDATA%$2"

no_replace:
  StrCpy $WINAMP_INI_DIR    $0
  
  StrCpy $WINAMP_INI_PATH   $WINAMP_INI_DIR\Winamp.ini
  StrCmp $1 "" done
  ExpandEnvStrings $0 $1
  StrCpy $WINAMP_INI_PATH   $WINAMP_INI_DIR\$0


paths_ini_empty:
  Goto done

file_not_found:
  Goto done

done:
FunctionEnd