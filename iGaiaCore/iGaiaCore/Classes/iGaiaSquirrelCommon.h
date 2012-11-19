//
//  iGaiaSquirrelCommon.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaSquirrelCommonClass
#define iGaiaSquirrelCommonClass

#include "iGaiaCommon.h"
#include <squirrel.h>

class iGaiaSquirrelCommon
{
private:
    HSQUIRRELVM m_squireel_vm;
    SQBool PopFloatArray(SQFloat* _value, const string& _name, i32 _index);
protected:
    
public:
    iGaiaSquirrelCommon(void);
    ~iGaiaSquirrelCommon(void);
    
    static iGaiaSquirrelCommon* SharedInstance(void);
    
    void RegisterTable(const string& _name);
    void RegisterClass(const string& _name);
    void RegisterFunction(SQFUNCTION _function, const string& _functionName, const string& _className);
    
    bool LoadScript(const string& _name);
    
    bool CallFunction(const string& _name, SQFloat* _params, ui32 _count);

    void PopVector2d(SQFloat* _x, SQFloat* _y, i32 _index);
    void PopVector3d(SQFloat* _x, SQFloat* _y, SQFloat* _z, i32 _index);
    void PopVector4d(SQFloat* _x, SQFloat* _y, SQFloat* _z, SQFloat* _w, i32 _index);

    void PushVecto3d(SQFloat _x, SQFloat _y, SQFloat _z);

    SQFloat PopFloat(i32 _index);
    const SQChar* PopString(i32 _index);
    SQInteger PopInteger(i32 _index);
    SQUserPointer PopUserData(i32 _index);
};

#endif

