//
//  iGaiaSquirrelScene.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaSquirrelScene.h"
#import "iGaiaStageMgr.h"
#import "iGaiaLogger.h"

SQInteger sq_createShape3d(HSQUIRRELVM vm);

@interface iGaiaSquirrelScene()

@property(nonatomic, assign) iGaiaSquirrelCommon* m_commonWrapper;

@end


@implementation iGaiaSquirrelScene

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
    [_m_commonWrapper registerClass:@"Scene"];
    [_m_commonWrapper registerFunction:sq_createShape3d withName:@"createShape3d" forClass:@"Scene"];
}

SQInteger sq_createShape3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if (numArgs >= 2)
    {
        if(sq_gettype(vm, 2) == OT_STRING)
        {
            const SQChar* f_name;
            sq_tostring(vm, 2);
            sq_getstring(vm, 2, &f_name);
            iGaiaShape3d* shape3d = [[iGaiaStageMgr sharedInstance] createShape3dWithFileName:[NSString stringWithCString:f_name encoding:NSUTF8StringEncoding]];
            sq_pushuserpointer(vm, (__bridge SQUserPointer)shape3d);
            return YES;
        }
        else
        {
            iGaiaLog(@"Script arg index :%i incorrect.", 2);
            return NO;
        }
    }
    iGaiaLog(@"Script call args are empty.")
    return NO;
}


@end
