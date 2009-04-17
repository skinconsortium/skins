#include "api.h"
#include "SClassicProFile.h"
#include <strsafe.h>
#include <shlwapi.h>
#include "global.h"
// #include <Wasabi/api/script/slist.h"
#include <nu/AutoChar.h>
#include <api/script/objects/c_script/c_list.h>

extern ScriptObjectController *script_root;
extern ClassicProFileScriptController classicProFileController;

// {9D822FF4-9F86-4c7a-8CEB-3C02FE20D5A5}
static const GUID classicProFileGuid = 
{ 0x9d822ff4, 0x9f86, 0x4c7a, { 0x8c, 0xeb, 0x3c, 0x2, 0xfe, 0x20, 0xd5, 0xa5 } };




// -- Functions table -------------------------------------
function_descriptor_struct ClassicProFileScriptController::exportedFunction[] = {
	{L"createFile",								1, (void*)SClassicProFile::script_vcpu_createFile },
	{L"closeFile",								1, (void*)SClassicProFile::script_vcpu_closeFile },
	{L"writeFile",								2, (void*)SClassicProFile::script_vcpu_writeFile },
	{L"findFiles",								3, (void*)SClassicProFile::script_vcpu_findFiles },
	{L"exploreFile",							2, (void*)SClassicProFile::script_vcpu_exploreFile },
	{L"openFile",								2, (void*)SClassicProFile::script_vcpu_openFile },
	{L"printFile",								2, (void*)SClassicProFile::script_vcpu_printFile },
	{L"editFile",								2, (void*)SClassicProFile::script_vcpu_editFile },
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
	HANDLE fh = CreateFileW(filename.data.sdata, GENERIC_WRITE, 0, 0, CREATE_ALWAYS, 0, 0);
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

scriptVar SClassicProFile::script_vcpu_findFiles(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar path, scriptVar mask, scriptVar returnValues)
{
	SCRIPT_FUNCTION_INIT;
	ScriptObject* listSO = (returnValues.data.odata);
	// Somehow we get nullcalls on startup - get rid of em safely!
	if (listSO == NULL)
		return MAKE_SCRIPT_INT(-1);

	wchar_t dirmask[MAX_PATH];
	PathCombineW(dirmask, path.data.sdata, mask.data.sdata);
	WIN32_FIND_DATAW find;
	HANDLE hFind = FindFirstFileW(dirmask, &find);
	int results = 0;
	C_List lst(listSO);
	if (hFind != INVALID_HANDLE_VALUE)
	{
		do
		{
			lst.addItem(MAKE_SCRIPT_STRING(find.cFileName));
			results++;
		}
		while (FindNextFileW(hFind, &find));
		FindClose(hFind);
	}
	return MAKE_SCRIPT_INT(results);
}

scriptVar SClassicProFile::script_vcpu_openFile(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar filename, scriptVar params)
{
	SCRIPT_FUNCTION_INIT;
	int results = (int)ShellExecuteW(NULL, L"open", filename.data.sdata, params.data.sdata, NULL, SW_SHOWNORMAL);
	return MAKE_SCRIPT_INT(results);
}

scriptVar SClassicProFile::script_vcpu_exploreFile(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar filename, scriptVar params)
{
	SCRIPT_FUNCTION_INIT;
	int results = (int)ShellExecuteW(NULL, L"explore", filename.data.sdata, params.data.sdata, NULL, SW_SHOWNORMAL);
	return MAKE_SCRIPT_INT(results);
}

scriptVar SClassicProFile::script_vcpu_editFile(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar filename, scriptVar params)
{
	SCRIPT_FUNCTION_INIT;
	int results = (int)ShellExecuteW(NULL, L"edit", filename.data.sdata, params.data.sdata, NULL, SW_SHOWNORMAL);
	return MAKE_SCRIPT_INT(results);
}

scriptVar SClassicProFile::script_vcpu_printFile(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar filename, scriptVar params)
{
	SCRIPT_FUNCTION_INIT;
	int results = (int)ShellExecuteW(NULL, L"print", filename.data.sdata, params.data.sdata, NULL, SW_SHOWNORMAL);
	return MAKE_SCRIPT_INT(results);
}
