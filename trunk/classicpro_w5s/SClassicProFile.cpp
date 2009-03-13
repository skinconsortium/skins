#include "api.h"
#include "SClassicProFile.h"
#include <nu/AutoChar.h>
#include <api/script/objects/c_script/c_guiobject.h>

extern ScriptObjectController *script_root;
extern ClassicProFileScriptController classicProFileController;

// {9D822FF4-9F86-4c7a-8CEB-3C02FE20D5A5}
static const GUID classicProFileGuid = 
{ 0x9d822ff4, 0x9f86, 0x4c7a, { 0x8c, 0xeb, 0x3c, 0x2, 0xfe, 0x20, 0xd5, 0xa5 } };




// -- Functions table -------------------------------------
function_descriptor_struct ClassicProFileScriptController::exportedFunction[] = {
	{L"createFile",								1, (void*)SClassicProFile::script_vcpu_createFile },
	{L"closeFile",								1, (void*)SClassicProFile::script_vcpu_closeFile },
	{L"writeFile",								1, (void*)SClassicProFile::script_vcpu_writeFile },
};
// --------------------------------------------------------


int SClassicProFile::numSOs = 0;

const wchar_t *ClassicProFileScriptController::getClassName() {
	return L"ClassicProFile";
}

const wchar_t *ClassicProFileScriptController::getAncestorClassName() {
  return L"Object";
}

ScriptObjectController *ClassicProFileScriptController::getAncestorController() 
{
	return script_root; 
}

ScriptObject *ClassicProFileScriptController::instantiate() {
  SClassicProFile *xd = new SClassicProFile;
  ASSERT(xd != NULL);
  return xd->getScriptObject();
}

void ClassicProFileScriptController::destroy(ScriptObject *o) {
  SClassicProFile *xd = static_cast<SClassicProFile *>(o->vcpu_getInterface(classicProFileGuid));
  ASSERT(xd != NULL);
  delete xd;
}

void *ClassicProFileScriptController::encapsulate(ScriptObject *o) {
  return NULL; 
}

void ClassicProFileScriptController::deencapsulate(void *o) {
}

int ClassicProFileScriptController::getNumFunctions() {
  return sizeof(exportedFunction) / sizeof(function_descriptor_struct); 
}

const function_descriptor_struct *ClassicProFileScriptController::getExportedFunctions() {
  return exportedFunction;                                                        
}

GUID ClassicProFileScriptController::getClassGuid() {
	return classicProFileGuid;
}

SClassicProFile::SClassicProFile()
{
	getScriptObject()->vcpu_setInterface(classicProFileGuid, static_cast<SClassicProFile *>(this));
	getScriptObject()->vcpu_setClassName(L"ClassicProFile");
	getScriptObject()->vcpu_setController(&classicProFileController);

	// We're counting the loaded scriptObjects in order to determine when we load/destroy the classicpro.xml parser object
	// the big pro of this is that we do not need the skincallback stuff and do only load anything of a skin w/ a SClassicProFile
	// scriptObject is loaded.
	numSOs++;
	if (numSOs == 1)
	{
		//classicProParser = new ClassicProParser();
	}
}

SClassicProFile::~SClassicProFile()
{
	numSOs--;
	if (numSOs == 0)
	{
		//delete classicProParser;
		//classicProParser = 0;
	}
}

scriptVar SClassicProFile::script_vcpu_createFile(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar filename) {
	SCRIPT_FUNCTION_INIT;
	HANDLE fh = CreateFileW(filename.data.sdata, GENERIC_WRITE, 0, 0, CREATE_NEW, 0, 0);
	return MAKE_SCRIPT_INT((int)fh);
}

scriptVar SClassicProFile::script_vcpu_closeFile(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar filehandle) {
	SCRIPT_FUNCTION_INIT;
	int ret = CloseHandle((void*)filehandle.data.idata);
	return MAKE_SCRIPT_BOOLEAN(ret);
}

scriptVar SClassicProFile::script_vcpu_writeFile(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar filehandle, scriptVar content) {
	SCRIPT_FUNCTION_INIT;
	DWORD writtenBytes;
	wchar_t BOM = 0xFEFF;
	int ret = WriteFile((void*)filehandle.data.idata, AutoChar(content.data.sdata), sizeof(char)*wcslen(content.data.sdata), &writtenBytes, NULL);
	return MAKE_SCRIPT_BOOLEAN(ret);
}