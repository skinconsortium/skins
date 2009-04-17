#ifndef __SCLSSICPRO_File_H
#define __SCLSSICPRO_File_H

#include <api/script/objcontroller.h>
#include <api/script/objcontroller.h>
#include <api/script/objects/rootobj.h>

class ClassicProFileScriptController : public ScriptObjectControllerI 
{
  public:

    virtual const wchar_t *getClassName();
    virtual const wchar_t *getAncestorClassName();
    virtual ScriptObjectController *getAncestorController();
    virtual int getNumFunctions();
    virtual const function_descriptor_struct *getExportedFunctions();
    virtual GUID getClassGuid();
    virtual ScriptObject *instantiate();
    virtual void destroy(ScriptObject *o);
    virtual void *encapsulate(ScriptObject *o);
    virtual void deencapsulate(void *o);

  private:

    static function_descriptor_struct exportedFunction[];
    
};

class SClassicProFile : public RootObjectInstance {
public:
  SClassicProFile();
  ~SClassicProFile();
private:
  static int numSOs;
public:
  static scriptVar script_vcpu_createFile(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar filename);
  static scriptVar script_vcpu_closeFile(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar filehandle);
  static scriptVar script_vcpu_writeFile(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar filehandle, scriptVar content);
  static scriptVar script_vcpu_findFiles(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar path, scriptVar mask, scriptVar returnValues);
  static scriptVar script_vcpu_openFile(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar filename, scriptVar params);
  static scriptVar script_vcpu_editFile(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar filename, scriptVar params);
  static scriptVar script_vcpu_printFile(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar filename, scriptVar params);
  static scriptVar script_vcpu_exploreFile(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar filename, scriptVar params);
};

#endif