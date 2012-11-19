//
//  iGaiaSquirrelRuntime.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaSquirrelRuntime.h"

SQInteger sq_import(HSQUIRRELVM vm);

iGaiaSquirrelRuntime::iGaiaSquirrelRuntime(iGaiaSquirrelCommon* _commonWrapper)
{
    m_commonWrapper = _commonWrapper;
    Bind();
}

iGaiaSquirrelRuntime::~iGaiaSquirrelRuntime(void)
{
    
}

void iGaiaSquirrelRuntime::Bind(void)
{
    m_commonWrapper->RegisterClass("Runtime");
    m_commonWrapper->RegisterFunction(sq_import, "import", "Runtime");
}

void iGaiaSquirrelRuntime::sq_OnUpdate(void)
{
    iGaiaSquirrelCommon::SharedInstance()->CallFunction("onUpdate", nullptr, 0);
}


SQInteger sq_import(HSQUIRRELVM vm)
{
    SQInteger nargs = sq_gettop(vm);
    for(SQInteger n = 1; n <= nargs; n++)
    {
    	if (sq_gettype(vm, n) == OT_STRING)
        {
    		const SQChar *f_name;
            sq_tostring(vm, n);
            sq_getstring(vm, -1, &f_name);
            sq_poptop(vm);
            iGaiaSquirrelCommon::SharedInstance()->LoadScript(f_name);
    	}
    }
	return 0;
}
