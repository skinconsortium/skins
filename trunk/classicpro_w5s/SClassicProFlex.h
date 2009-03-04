#ifndef __SCLSSICPRO_FLEX_H
#define __SCLSSICPRO_FLEX_H

#include <api/script/objcontroller.h>
#include <api/script/objcontroller.h>
#include <api/script/objects/rootobj.h>
#include "ClassicProParser.h"

class ClassicProFlexScriptController : public ScriptObjectControllerI 
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

class SClassicProFlex : public RootObjectInstance {
public:
  SClassicProFlex();
  ~SClassicProFlex();
private:
  static int numSOs;
  static ClassicProParser* classicProParser;
public:
  static scriptVar script_vcpu_getEngineVersion(SCRIPT_FUNCTION_PARAMS, ScriptObject *o);
  static scriptVar script_vcpu_getEngineName(SCRIPT_FUNCTION_PARAMS, ScriptObject *o);
  static scriptVar script_vcpu_getSkinVersion(SCRIPT_FUNCTION_PARAMS, ScriptObject *o);
  static scriptVar script_vcpu_appearance_normal_usePlayPauseButton(SCRIPT_FUNCTION_PARAMS, ScriptObject *o);
  static scriptVar script_vcpu_appearance_shade_usePlayPauseButton(SCRIPT_FUNCTION_PARAMS, ScriptObject *o);
  static scriptVar script_vcpu_appearance_getGlowButtonFadeInSpeed(SCRIPT_FUNCTION_PARAMS, ScriptObject *o);
  static scriptVar script_vcpu_appearance_getGlowButtonFadeOutSpeed(SCRIPT_FUNCTION_PARAMS, ScriptObject *o);
  static scriptVar script_vcpu_appearance_getGlowButtonType(SCRIPT_FUNCTION_PARAMS, ScriptObject *o);
  static scriptVar script_vcpu_applyStyle(SCRIPT_FUNCTION_PARAMS, ScriptObject *o, scriptVar guiObj, scriptVar styleId);
};

#endif