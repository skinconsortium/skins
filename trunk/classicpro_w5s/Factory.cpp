#include "Factory.h"
#include "api.h"
#include "ScriptObjectService.h"

ScriptObjectService svc;
static const char serviceName[] = "ClassicPro::Flex";

// {78A10A55-C644-4a99-8EE9-71710DDDE32F}
static const GUID classicProFlexSvcGuid = 
{ 0x78a10a55, 0xc644, 0x4a99, { 0x8e, 0xe9, 0x71, 0x71, 0xd, 0xdd, 0xe3, 0x2f } };


FOURCC Factory::GetServiceType()
{
	return svc.getServiceType();
}

const char *Factory::GetServiceName()
{
	return serviceName;
}

GUID Factory::GetGUID()
{
	return classicProFlexSvcGuid;
}

void *Factory::GetInterface(int global_lock)
{
//	if (global_lock)
//		WASABI_API_SVC->service_lock(this, (void *)ifc);
	return &svc;
}

int Factory::SupportNonLockingInterface()
{
	return 1;
}

int Factory::ReleaseInterface(void *ifc)
{
	//WASABI_API_SVC->service_unlock(ifc);
	return 1;
}

const char *Factory::GetTestString()
{
	return 0;
}

int Factory::ServiceNotify(int msg, int param1, int param2)
{
	return 1;
}

#define CBCLASS Factory
START_DISPATCH;
CB(WASERVICEFACTORY_GETSERVICETYPE, GetServiceType)
CB(WASERVICEFACTORY_GETSERVICENAME, GetServiceName)
CB(WASERVICEFACTORY_GETGUID, GetGUID)
CB(WASERVICEFACTORY_GETINTERFACE, GetInterface)
CB(WASERVICEFACTORY_SUPPORTNONLOCKINGGETINTERFACE, SupportNonLockingInterface) 
CB(WASERVICEFACTORY_RELEASEINTERFACE, ReleaseInterface)
CB(WASERVICEFACTORY_GETTESTSTRING, GetTestString)
CB(WASERVICEFACTORY_SERVICENOTIFY, ServiceNotify)
END_DISPATCH;
#undef CBCLASS