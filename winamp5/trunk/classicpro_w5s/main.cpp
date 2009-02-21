#include "api.h"
#include "SClassicProFlex.h"
#include "../Agave/Component/ifc_wa5component.h"
#include <api/service/waservicefactory.h>
#include "../nu/ServiceWatcher.h"
#include "Factory.h"
Factory factory;
ServiceWatcher serviceWatcher;

api_maki *WASABI_API_MAKI = 0;
api_service *WASABI_API_SVC = 0;
api_syscb *WASABI_API_SYSCB = 0;
api_skin *WASABI_API_SKIN = 0;
api_application *WASABI_API_APP = 0;

class ClassicProFlexComponent : public ifc_wa5component
{
public:
	void RegisterServices(api_service *service);
	void DeregisterServices(api_service *service);
protected:
	RECVS_DISPATCH;
};


template <class api_t>
api_t *GetService(GUID serviceGUID)
{	
	waServiceFactory *sf = WASABI_API_SVC->service_getServiceByGuid(serviceGUID);
	if (sf)
		return (api_t *)sf->getInterface();
	else
		return 0;

}

inline void ReleaseService(GUID serviceGUID, void *service)
{
	if (service)
	{
		waServiceFactory *sf = WASABI_API_SVC->service_getServiceByGuid(serviceGUID);
		if (sf)
			sf->releaseInterface(service);
	}
}

void ClassicProFlexComponent::RegisterServices(api_service *service)
{
	WASABI_API_SVC = service;
	WASABI_API_SYSCB = GetService<api_syscb>(syscbApiServiceGuid);

	serviceWatcher.WatchWith(WASABI_API_SVC);
	serviceWatcher.WatchFor(&WASABI_API_MAKI, makiApiServiceGuid);
	serviceWatcher.WatchFor(&WASABI_API_SKIN, skinApiServiceGuid);
	serviceWatcher.WatchFor(&WASABI_API_APP, applicationApiServiceGuid);
	service->service_register(&factory);

	// register for service callbacks in case any of these don't exist yet
	WASABI_API_SYSCB->syscb_registerCallback(&serviceWatcher);
}

void ClassicProFlexComponent::DeregisterServices(api_service *service)
{
	service->service_deregister(&factory);
	serviceWatcher.StopWatching();
	serviceWatcher.Clear();

	ReleaseService(makiApiServiceGuid,	WASABI_API_MAKI);
	ReleaseService(skinApiServiceGuid,	WASABI_API_SKIN);
	ReleaseService(syscbApiServiceGuid,	WASABI_API_SYSCB);
}

ClassicProFlexComponent makiTestComponent;
extern "C" __declspec(dllexport) ifc_wa5component *GetWinamp5SystemComponent()
{
	return &makiTestComponent;
}

#define CBCLASS ClassicProFlexComponent
START_DISPATCH;
VCB(API_WA5COMPONENT_REGISTERSERVICES, RegisterServices)
VCB(API_WA5COMPONENT_DEREEGISTERSERVICES, DeregisterServices)
END_DISPATCH;
#undef CBCLASS
