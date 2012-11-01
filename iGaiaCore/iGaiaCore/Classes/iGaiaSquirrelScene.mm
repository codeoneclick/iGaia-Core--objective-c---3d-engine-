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
#import "iGaiaSettings.h"

SQInteger sq_createCamera(HSQUIRRELVM vm);
SQInteger sq_createShape3d(HSQUIRRELVM vm);
SQInteger sq_createSkyDome(HSQUIRRELVM vm);
SQInteger sq_createOcean(HSQUIRRELVM vm);

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
    [_m_commonWrapper registerClass:@"SceneWrapper"];
    [_m_commonWrapper registerFunction:sq_createShape3d withName:@"createShape3d" forClass:@"SceneWrapper"];
    [_m_commonWrapper registerFunction:sq_createCamera withName:@"createCamera" forClass:@"SceneWrapper"];
}

SQInteger sq_createCamera(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if (numArgs >= 2)
    {
        SQFloat fov = [[iGaiaSquirrelCommon sharedInstance] retriveFloatValueWithIndex:2];
        SQFloat near = [[iGaiaSquirrelCommon sharedInstance] retriveFloatValueWithIndex:3];
        SQFloat far = [[iGaiaSquirrelCommon sharedInstance] retriveFloatValueWithIndex:4];

        CGRect viewport = [iGaiaSettings retriveFrameRect];
        iGaiaCamera* camera = [[iGaiaStageMgr sharedInstance] createCameraWithFov:fov withNear:near withFar:far forScreenWidth:viewport.size.width forScreenHeight:viewport.size.height];
        sq_pushuserpointer(vm, (__bridge SQUserPointer)camera);
        return YES;
    }
    iGaiaLog(@"Script call args NULL.");
    return NO;
}

SQInteger sq_createShape3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if (numArgs >= 2)
    {
        const SQChar* f_name = [[iGaiaSquirrelCommon sharedInstance] retriveStringValueWithIndex:2];
        iGaiaShape3d* shape3d = [[iGaiaStageMgr sharedInstance] createShape3dWithFileName:[NSString stringWithCString:f_name encoding:NSUTF8StringEncoding]];
        sq_pushuserpointer(vm, (__bridge SQUserPointer)shape3d);
        return YES;
    }
    iGaiaLog(@"Script call args NULL.");
    return NO;
}


@end
