//
//  iGaiaSquirrelCommon.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaCommon.h"
#include <squirrel.h>

class iGaiaSquirrelCommon
{
private:
    HSQUIRRELVM m_squireel_vm;
protected:
    
public:
    iGaiaSquirrelCommon(void);
    ~iGaiaSquirrelCommon(void);
    
    static iGaiaSquirrelCommon* SharedInstance(void);
    
    void RegisterTable(const string& _name);
    void RegisterClass(const string& _name);
    void RegisterFunction(const string& _name);
    
    bool LoadScript(const string& _name);
    
    bool CallFunction(SQFUNCTION _function, const string& _name, SQFloat* _params, ui32 _count);

    void PopVector2d(SQFloat* _x, SQFloat* _y);
    void PopVector3d(SQFloat* _x, SQFloat* _y, SQFloat* _z);
    void PopVector4d(SQFloat* _x, SQFloat* _y, SQFloat* _z, SQFloat* _w);

    void PushVecto3d(SQFloat _x, SQFloat _y, SQFloat _z);

    SQFloat PopFloat(i32 _index);
    const SQChar* PopString(i32 _index);
    SQInteger PopInteger(i32 _index);
    SQUserPointer PopUserData(i32 _index);
};


