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
}

iGaiaSquirrelRuntime::~iGaiaSquirrelRuntime(void)
{
    
}

void iGaiaSquirrelRuntime::Bind(void)
{
    [_m_commonWrapper registerClass:@"Runtime"];
    [_m_commonWrapper registerFunction:sq_import withName:@"import" forClass:@"Runtime"];
}

@interface iGaiaSquirrelRuntime()

@property(nonatomic, assign) iGaiaSquirrelCommon* m_commonWrapper;

@end

@implementation iGaiaSquirrelRuntime

@synthesize m_commonWrapper = _m_commonWrapper;

- (id)initWithCommonWrapper:(iGaiaSquirrelCommon *)commonWrapper
{
    self = [super init];
    if(self)
    {
        _m_commonWrapper = commonWrapper;
        [self bind];
    }
    return self;
}

- (void)bind
{
    [_m_commonWrapper registerClass:@"Runtime"];
    [_m_commonWrapper registerFunction:sq_import withName:@"import" forClass:@"Runtime"];
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
            [[iGaiaSquirrelCommon sharedInstance] loadScriptWithFileName:[NSString stringWithCString:f_name encoding:NSUTF8StringEncoding]];
    	}
    }
	return 0;
}

- (void)sq_onUpdate
{
    [[iGaiaSquirrelCommon sharedInstance] callFunctionWithName:@"onUpdate" withParams:nil withCount:0];
}

@end
