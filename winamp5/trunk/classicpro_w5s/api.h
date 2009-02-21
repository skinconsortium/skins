#pragma once

#include <api/service/api_service.h>
extern api_service *serviceManager;
#define WASABI_API_SVC serviceManager

#include <api/script/api_maki.h>
#define WASABI_API_MAKI makiApi

#include <api/syscb/api_syscb.h>
#define WASABI_API_SYSCB sysCallbackApi

#include <api/application/api_application.h>
#define WASABI_API_APP applicationApi

#include <api/skin/api_skin.h>
#define WASABI_API_SKIN skinApi
/*
#include <api/xml/api_xmlreadercallback.h>
#define WASABI_API_XML xmlReaderCallbackApi*/