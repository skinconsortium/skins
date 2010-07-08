/*
	cPro_Installer_Version

	Copyright (c) 2009-2010 by Pawe³ Porwisz aka Pepe
	This software is provided 'as-is', without any express or implied warranty.

	This is a header file with version informations
*/

	!define CPRO_REVISION "0"
	!define CPRO_BUILD "0"
	!define CPRO_WINAMP_VERSION "5.5.5.0"	
	
;###########################################################################################
;	VERSION INFORMATION
;###########################################################################################

	!if ${CPRO_BUILD_TYPE} == "BETA"
; Beta stage	
		VIProductVersion "${CPRO_VERSION}.${CPRO_REVISION}.${CPRO_BUILD}"
		VIAddVersionKey "ProductName" "${CPRO_NAME} ${CPRO_BUILD_NAME}"
		VIAddVersionKey "ProductVersion" "${CPRO_VERSION}"	
		VIAddVersionKey "Comments" "${CPRO_NAME} v${CPRO_VERSION} ${CPRO_BUILD_NAME}, ${CPRO_WEB_PAGE}"
		VIAddVersionKey "CompanyName" "${CPRO_COMPANY}"
		VIAddVersionKey "LegalCopyright" "${CPRO_COPYRIGHT}, ${CPRO_AUTHOR}"
		VIAddVersionKey "FileDescription" "${CPRO_NAME} v${CPRO_VERSION} ${CPRO_BUILD_NAME} (${CPRO_BUILD_TYPE})"
		VIAddVersionKey "FileVersion" "${CPRO_VERSION}"
	!else if ${CPRO_BUILD_TYPE} == "NIGHTLY"
; Alpha stage	
		VIProductVersion "${CPRO_VERSION}.${CPRO_REVISION}.${CPRO_BUILD}"
		VIAddVersionKey "ProductName" "${CPRO_NAME} ${CPRO_BUILD_NAME}"
		VIAddVersionKey "ProductVersion" "${CPRO_VERSION}"	
		VIAddVersionKey "Comments" "${CPRO_NAME} v${CPRO_VERSION} ${CPRO_BUILD_NAME}, ${CPRO_WEB_PAGE}"
		VIAddVersionKey "CompanyName" "${CPRO_COMPANY}"
		VIAddVersionKey "LegalCopyright" "${CPRO_COPYRIGHT}, ${CPRO_AUTHOR}"
		VIAddVersionKey "FileDescription" "${CPRO_NAME} v${CPRO_VERSION} ${CPRO_BUILD_NAME} (${CPRO_BUILD_TYPE})"
		VIAddVersionKey "FileVersion" "${CPRO_VERSION}"
	!else
; Release
		VIProductVersion "${CPRO_VERSION}.${CPRO_REVISION}.${CPRO_BUILD}"
		VIAddVersionKey "ProductName" "${CPRO_NAME}"
		VIAddVersionKey "ProductVersion" "${CPRO_VERSION}"		
		VIAddVersionKey "Comments" "${CPRO_NAME} v${CPRO_VERSION}, ${CPRO_WEB_PAGE}"
		VIAddVersionKey "CompanyName" "${CPRO_COMPANY}"
		VIAddVersionKey "LegalCopyright" "${CPRO_COPYRIGHT}, ${CPRO_AUTHOR}"
		VIAddVersionKey "FileDescription" "${CPRO_NAME} v${CPRO_VERSION}"
		VIAddVersionKey "FileVersion" "${CPRO_VERSION}"		
	!endif
	