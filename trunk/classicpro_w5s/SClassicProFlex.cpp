#include "api.h"
#include "SClassicProFlex.h"
#include <api/script/objects/c_script/c_guiobject.h>

extern ScriptObjectController *script_root;
extern ClassicProFlexScriptController classicProFlexController;

// {686FA9C9-5CE5-4d35-8BAF-A0FF1C59E525}
static const GUID classicProFlexGuid = 
{ 0x686fa9c9, 0x5ce5, 0x4d35, { 0x8b, 0xaf, 0xa0, 0xff, 0x1c, 0x59, 0xe5, 0x25 } };


// -- Functions table -------------------------------------
function_descriptor_struct ClassicProFlexScriptController::exportedFunction[] = {
	{L"getVersion",								0, (void*)SClassicProFlex::script_vcpu_getEngineVersion },
	{L"getEngineName",							0, (void*)SClassicProFlex::script_vcpu_getEngineName },
	{L"getSkinVersion",							0, (void*)SClassicProFlex::script_vcpu_getSkinVersion },
	{L"appearance_normal_usePlayPauseButton",	0, (void*)SClassicProFlex::script_vcpu_appearance_normal_usePlayPauseButton},
	{L"appearance_shade_usePlayPauseButton",	0, (void*)SClassicProFlex::script_vcpu_appearance_shade_usePlayPauseButton },
	{L"appearance_getGlowButtonFadeOutSpeed",	0, (void*)SClassicProFlex::script_vcpu_appearance_getGlowButtonFadeOutSpeed},
	{L"appearance_getGlowButtonFadeInSpeed",	0, (void*)SClassicProFlex::script_vcpu_appearance_getGlowButtonFadeInSpeed },
	{L"appearance_getGlowButtonType",			0, (void*)SClassicProFlex::script_vcpu_appearance_getGlowButtonType },
	{L"applyStyle",								2, (void*)SClassicProFlex::script_vcpu_applyStyle },
};
// --------------------------------------------------------


int SClassicProFlex::numSOs = 0;
ClassicProParser* SClassicProFlex::classicProParser = 0;

const wchar_t *ClassicProFlexScriptController::getClassName() {
	return L"ClassicProFlex";
}

const wchar_t *ClassicProFlexScriptController::getAncestorClassName() {
  return L"Object";
}

ScriptObjectController *ClassicProFlexScriptController::getAncestorController() 
{
	return script_root; 
}

ScriptObject *ClassicProFlexScriptController::instantiate() {
  SClassicProFlex *xd = new SClassicProFlex;
  ASSERT(xd != NULL);
  return xd->getScriptObject();
}

void ClassicProFlexScriptController::destroy(ScriptObject *o) {
  SClassicProFlex *xd = static_cast<SClassicProFlex *>(o->vcpu_getInterface(classicProFlexGuid));
  ASSERT(xd != NULL);
  delete xd;
}

void *ClassicProFlexScriptController::encapsulate(ScriptObject *o) {
  return NULL; 
}

void ClassicProFlexScriptController::deencapsulate(void *o) {
}

int ClassicProFlexScriptController::getNumFunctions() {
  return sizeof(exportedFunction) / sizeof(function_descriptor_struct); 
}

const function_descriptor_struct *ClassicProFlexScriptController::getExportedFunctions() {
  return exportedFunction;                                                        
}

GUID ClassicProFlexScriptController::getClassGuid() {
	return classicProFlexGuid;
}

SClassicProFlex::SClassicProFlex()
{
	getScriptObject()->vcpu_setInterface(classicProFlexGuid, static_cast<SClassicProFlex *>(this));
	getScriptObject()->vcpu_setClassName(L"ClassicPro");
	getScriptObject()->vcpu_setController(&classicProFlexController);

	// We're counting the loaded scriptObjects in order to determine when we load/destroy the classicpro.xml parser object
	// the big pro of this is that we do not need the skincallback stuff and do only load anything of a skin w/ a SClassicProFlex
	// scriptObject is loaded.
	numSOs++;
	if (numSOs == 1)
	{
		classicProParser = new ClassicProParser();
	}
}

SClassicProFlex::~SClassicProFlex()
{
	numSOs--;
	if (numSOs == 0)
	{
		delete classicProParser;
		classicProParser = 0;
	}
}

scriptVar SClassicProFlex::script_vcpu_getEngineVersion(SCRIPT_FUNCTION_PARAMS, ScriptObject *o) {
	SCRIPT_FUNCTION_INIT;
	SClassicProFlex *classicProFlex = static_cast<SClassicProFlex *>(o->vcpu_getInterface(classicProFlexGuid));
	if (classicProFlex)
	{
		return MAKE_SCRIPT_FLOAT(CPRO_VERSION);
	}
	RETURN_SCRIPT_VOID;
}

scriptVar SClassicProFlex::script_vcpu_getEngineName(SCRIPT_FUNCTION_PARAMS, ScriptObject *o) {
	SCRIPT_FUNCTION_INIT;
	SClassicProFlex *classicProFlex = static_cast<SClassicProFlex *>(o->vcpu_getInterface(classicProFlexGuid));
	if (classicProFlex)
	{
		return MAKE_SCRIPT_STRING(classicProParser->engineName);
	}
	RETURN_SCRIPT_VOID;
}

scriptVar SClassicProFlex::script_vcpu_getSkinVersion(SCRIPT_FUNCTION_PARAMS, ScriptObject *o) {
	SCRIPT_FUNCTION_INIT;
	SClassicProFlex *classicProFlex = static_cast<SClassicProFlex *>(o->vcpu_getInterface(classicProFlexGuid));
	if (classicProFlex)
	{
		return MAKE_SCRIPT_FLOAT(classicProParser->skinVersion);
	}
	RETURN_SCRIPT_VOID;
}

scriptVar SClassicProFlex::script_vcpu_appearance_normal_usePlayPauseButton(SCRIPT_FUNCTION_PARAMS, ScriptObject *o) {
	SCRIPT_FUNCTION_INIT;
	SClassicProFlex *classicProFlex = static_cast<SClassicProFlex *>(o->vcpu_getInterface(classicProFlexGuid));
	if (classicProFlex)
	{
		return MAKE_SCRIPT_BOOLEAN(classicProParser->appearance_normal_usePlayPauseButton);
	}
	RETURN_SCRIPT_VOID;
}


scriptVar SClassicProFlex::script_vcpu_appearance_shade_usePlayPauseButton(SCRIPT_FUNCTION_PARAMS, ScriptObject *o) {
	SCRIPT_FUNCTION_INIT;
	SClassicProFlex *classicProFlex = static_cast<SClassicProFlex *>(o->vcpu_getInterface(classicProFlexGuid));
	if (classicProFlex)
	{
		return MAKE_SCRIPT_BOOLEAN(classicProParser->appearance_shade_usePlayPauseButton);
	}
	RETURN_SCRIPT_VOID;
}

scriptVar SClassicProFlex::script_vcpu_appearance_getGlowButtonFadeInSpeed(SCRIPT_FUNCTION_PARAMS, ScriptObject *o) {
	SCRIPT_FUNCTION_INIT;
	SClassicProFlex *classicProFlex = static_cast<SClassicProFlex *>(o->vcpu_getInterface(classicProFlexGuid));
	if (classicProFlex)
	{
		return MAKE_SCRIPT_FLOAT(classicProParser->appearance_glowButtonFadeInSpeed);
	}
	RETURN_SCRIPT_VOID;
}

scriptVar SClassicProFlex::script_vcpu_appearance_getGlowButtonFadeOutSpeed(SCRIPT_FUNCTION_PARAMS, ScriptObject *o) {
	SCRIPT_FUNCTION_INIT;
	SClassicProFlex *classicProFlex = static_cast<SClassicProFlex *>(o->vcpu_getInterface(classicProFlexGuid));
	if (classicProFlex)
	{
		return MAKE_SCRIPT_FLOAT(classicProParser->appearance_glowButtonFadeOutSpeed);
	}
	RETURN_SCRIPT_VOID;
}

scriptVar SClassicProFlex::script_vcpu_appearance_getGlowButtonType(SCRIPT_FUNCTION_PARAMS, ScriptObject *o) {
	SCRIPT_FUNCTION_INIT;
	SClassicProFlex *classicProFlex = static_cast<SClassicProFlex *>(o->vcpu_getInterface(classicProFlexGuid));
	if (classicProFlex)
	{
		return MAKE_SCRIPT_STRING(classicProParser->appearance_glowButtonType);
	}
	RETURN_SCRIPT_VOID;
}

scriptVar SClassicProFlex::script_vcpu_applyStyle(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar guiObj, scriptVar styleId)
{
	SCRIPT_FUNCTION_INIT;
	SClassicProFlex *classicProFlex = static_cast<SClassicProFlex *>(o->vcpu_getInterface(classicProFlexGuid));
	if (classicProFlex)
	{
		for (int i = 0; i < classicProParser->xmlStyles.getNumItems(); i++)
		{
			if (!WCSICMP(classicProParser->xmlStyles.enumItem(i)->id, styleId.data.sdata))
			{
				XmlStyle* style = classicProParser->xmlStyles.enumItem(i);
				C_GuiObject guiObject(guiObj.data.odata);
				for (int j = 0; j < style->tags.getNumItems(); j++)
				{
					guiObject.setXmlParam(style->tags.enumItem(j)->param, style->tags.enumItem(j)->value);
				}
				RETURN_SCRIPT_VOID;
			}
		}
	}
	RETURN_SCRIPT_VOID;
}