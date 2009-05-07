;-------------------------------------------------
; ClassicPro Widget Installer for ClassicPro v1.1
;		by SkinConsortium
;-------------------------------------------------

;-------------------------------------------------
; Change your widget information here
;-------------------------------------------------

; The name of your widget
!define WIDGET_NAME "CoolVU"

; The current version of your widget
!define WIDGET_VERSION "1.11"

; The XML file used as entry point for your widget. Located in /Load
!define XMLFILENAME "coolvu.xml"

; The data folder of your widget. Located in /Data
!define DATA_FOLDERNAME "CoolVU"

; The filename of this installation script
!define NSISFILENAME "cpro-widget-CoolVU.nsi"

; Your ClassicPro Directory
!define SOURCEPATH "C:\Program Files\Winamp\Plugins\ClassicPro"

;----------------------------------------------------------------
; Always include this file
;----------------------------------------------------------------
!include "${SOURCEPATH}\_installer\cPro_Widget_Installer.nsh"