#include "ScriptObjectService.h"
#include <api/script/objects/rootobjcontroller.h>
#include "SClassicProFlex.h"
#include "SClassicProFile.h"

ScriptObjectController *script_root=0;
ClassicProFlexScriptController classicProFlexController;
ClassicProFileScriptController classicProFileController;

ScriptObjectController *ScriptObjectService::getController(int n)
{
	if (n == 0)
		return &classicProFlexController;
	if (n == 1)
		return &classicProFileController;
	return 0;
}


void ScriptObjectService::onRegisterClasses(ScriptObjectController *rootController)
{
	script_root = rootController;
}



#define CBCLASS ScriptObjectService
START_DISPATCH;
  CB(GETCONTROLLER, getController);
  VCB(ONREGISTER,   onRegisterClasses);
END_DISPATCH;
#undef CBCLASS
