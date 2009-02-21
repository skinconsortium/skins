#include "ScriptObjectService.h"
#include <api/script/objects/rootobjcontroller.h>
#include "SClassicProFlex.h"

ScriptObjectController *script_root=0;
ClassicProFlexScriptController classicProFlexController;

ScriptObjectController *ScriptObjectService::getController(int n)
{
	if (n == 0)
		return &classicProFlexController;
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
