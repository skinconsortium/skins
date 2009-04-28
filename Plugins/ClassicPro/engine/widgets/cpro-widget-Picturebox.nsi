;-------------------------------------------------
; ClassicPro Widget Installer for ClassicPro v1.1
;		by SkinConsortium
;-------------------------------------------------

;-------------------------------------------------
; Change your widget information here
;-------------------------------------------------

; The name of your widget
!define WIDGET_NAME "Picturebox"

; The current version of your widget
!define WIDGET_VERSION "0.93"

; The XML file used as entry point for your widget. Located in /Load
!define XMLFILENAME "picturebox.xml"

; The data folder of your widget. Located in /Data
!define DATA_FOLDERNAME "Picturebox"

; The filename of this installation script
!define NSISFILENAME "cpro-widget-Picturebox.nsi"

; Your ClassicPro Directory
!define SOURCEPATH "C:\Program Files\Winamp\Plugins\ClassicPro"

;----------------------------------------------------------------
; Always include this file
;----------------------------------------------------------------
!include "${SOURCEPATH}\_installer\cPro_Widget_Installer.nsh"