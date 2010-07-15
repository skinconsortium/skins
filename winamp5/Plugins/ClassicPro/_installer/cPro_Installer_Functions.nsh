/*
	cPro_Installer_Functions

	Copyright (c) 2009-2010 by Pawe³ Porwisz aka Pepe
	This software is provided 'as-is', without any express or implied warranty.

	This is a header file with functions and variables
*/

Function Initialize_Variables

; Lang Dialog
	Var /GLOBAL LANG_TITLE
		StrCpy $LANG_TITLE  $(CPro_Language_Title)

; Welcome Page 		
	Var /Global Dialog
	
; Finish Page
	Var /Global Label1
	Var /Global Label1_Font
	Var /Global Label2
	Var /Global Label3
	Var /Global Label4	
	Var /Global CheckBox1
	Var /Global ACheckBox1
	Var /Global ACheckBox2
	Var /Global Control_State	
	Var /GLOBAL Button	
	Var /GLOBAL Img_Left		
	Var /GLOBAL Img_Handle_Left

	File /oname=$PLUGINSDIR\PayPal.bmp "Images\donate.bmp"
	File /oname=$PLUGINSDIR\Img_Left.bmp "Images\win.bmp"
	
; Cleanup Page
	Var /GLOBAL Cleanup_Check_StudioXnf
	Var /GLOBAL Cleanup_Check_WinampIni
	Var /GLOBAL Cleanup_Check_StudioXnf_B
	Var /GLOBAL Cleanup_Check_WinampIni_B

; Paths
	Var /Global WINAMP_INI_DIR
	Var /Global WINAMP_SKIN_DIR
	
FunctionEnd


Function CreateMutex

	System::Call "kernel32::CreateMutex(i 0, i 0, t 'cProMutex') i .r1 ?e"
	Pop $0

	${if} $0 != "0"
		MessageBox MB_OK|MB_ICONEXCLAMATION "$(CPro_Warning_CreateMutex)"
		Abort
	${EndIf}

FunctionEnd


!macro WinampINIPath UN_PREFIX

	Function ${UN_PREFIX}GetWinampIniPath

	StrCpy $WINAMP_INI_DIR $INSTDIR
	ClearErrors

	${If} ${FileExists} "$INSTDIR\paths.ini"
		ReadINIStr $0 "$INSTDIR\paths.ini" "Winamp" "inidir" ; Read paths.ini file - search for path to winamp.ini (inidir={26}\Winamp)
		${If} $0 != "" ; if entry inidir= exists
			${WordFind2X} $0 "{" "}" "E+1" $2 ;get CSIDL number (dec)
			${If} ${Errors} ;check error
				${IfNot} ${FileExists} "$0\*.*" ; There is no {CSIDL} in path. Check the path... (it can be normal path, or with %SPECIALFOLDER%)
					${WordFind2X} $0 "%" "%" "E+1" $2 ; for example: %AppData%

					${If} $2 == "WINAMP_ROOT_DIR"
						ClearErrors
						${GetRoot} "$WINAMP_INI_DIR" $3 ; default c:\, root dir of winamp installation
						${WordReplace} "$0" "%$2%" "$3" "E+1" $R0 ;Replace %WINAMP_ROOT_DIR% in path to WINAMP Installation disk ($3)
						${If} ${Errors} ;check error
							Return ;if error, return
						${Else} ;path is winamp installation disk + dir
							StrCpy $WINAMP_INI_DIR $R0
							DetailPrint "$(CPro_Account): $WINAMP_INI_DIR"
						${EndIf}

					${ElseIf} $2 == "WINAMP_PROGRAM_DIR"
						ClearErrors
						${WordReplace} "$0" "%$2%" "$WINAMP_INI_DIR" "E+1" $R0 ;Replace %WINAMP_PROGRAM_DIR% in path to WINAMP Installation DIR ($WINAMP_INI_DIR)
						${If} ${Errors} ;check error
							Return ;if error, return
						${Else} ;path is winamp installation dir
							StrCpy $WINAMP_INI_DIR $R0
							DetailPrint "$(CPro_Account): $WINAMP_INI_DIR"
						${EndIf}
					${Else}
						ClearErrors
						ReadEnvStr $R0 "$2" ;check any %SpecialDir% var
						${If} $R0 != ""
							${WordReplace} "$0" "%$2%" "$R0" "E+1" $R0 ;Replace %WINAMP_PROGRAM_DIR% in path to WINAMP Installation DIR ($WINAMP_INI_DIR)
							${If} ${Errors} ;check error
								Return ;if error, return
							${Else} ;get special folder path
								StrCpy $WINAMP_INI_DIR $R0
								DetailPrint "$(CPro_Account): $WINAMP_INI_DIR"
							${EndIf}
						${Else}
							Return ;if error, return (So, the Path is default - $INSTDIR)
						${EndIf}
					${EndIf}

				${Else} ;normal path, use it
					StrCpy $WINAMP_INI_DIR $0
					DetailPrint "$WINAMP_INI_DIR"
				${EndIf}
			${Else} ;No error, get special folder path
				System::Call "shell32::SHGetSpecialFolderPath(i $HWNDPARENT, t .r4, i $2, i0) i .r3"
				ClearErrors
				${WordReplace} "$0" "{$2}" "$4" "E+1" $R0 ;Replace {ID} in path to folder path
				${If} ${Errors} ;check error
					Return ;if error, return
				${Else} ;get special folder path
					StrCpy $WINAMP_INI_DIR $R0
					DetailPrint "$(CPro_Account): $WINAMP_INI_DIR"
				${EndIf}
			${EndIf}
		${Else} ; Entry (inidir=) in Paths.ini doeasnt exists
			DetailPrint "$(CPro_No_Account): $WINAMP_INI_DIR"
			Return
		${EndIf}
	${Else} ; File paths.ini doeasnt exists
		DetailPrint "$(CPro_No_Account): $WINAMP_INI_DIR"
		Return
	${EndIf}

FunctionEnd

!macroend

	!insertmacro WinampINIPath ""
	!insertmacro WinampINIPath "un."


!macro SharedSkinPath un
  
	Function ${un}GetWinampSkinDirectory

		ReadINIStr $R0 "$WINAMP_INI_DIR\winamp.ini" "Winamp" "SkinDir"
		${If} $R0 == ""
			StrCpy $WINAMP_SKIN_DIR "$INSTDIR\Skins"
		${Else}
			StrCpy $WINAMP_SKIN_DIR $R0
		${EndIf}
	
	FunctionEnd

!macroend

; Insert function as an installer and uninstaller function
	!insertmacro SharedSkinPath ""
	!insertmacro SharedSkinPath "un."

	
	
Function CheckWinampInstallation

	${If} ${FileExists} "$INSTDIR\winamp.exe"
		Return
	${Else}
		MessageBox MB_OK "$(CPro_Warning_No_Winamp)"
		Quit
	${EndIf}

FunctionEnd


Function CheckWinampVersion

	${GetFileVersion} "$INSTDIR\winamp.exe" $R0
	${if} $R0 != ""
		${VersionCompare} $R0 ${CPRO_WINAMP_VERSION} $R1
		${if} $R1 == "2"
			MessageBox MB_OK "$(CPro_Warning_Low_Version)"
			Quit
		${EndIf}
	${Else}
		MessageBox MB_OK "$(CPro_Warning_No_Winamp)"
		Quit
	${EndIf}

FunctionEnd


Function CheckWindows

   ${IfNot} ${AtLeastWin2000}
		MessageBox MB_OK "$(CPro_Warning_AtLeast_2000)"
		Quit
   ${EndIf}

FunctionEnd
