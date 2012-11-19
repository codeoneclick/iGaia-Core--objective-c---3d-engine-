//
//  iGaiaSquirrelParticleMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/16/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
/*
#import "iGaiaSquirrelParticleMgr.h"
#import "iGaiaStageMgr.h"
#import "iGaiaLogger.h"

SQInteger sq_createParticleEmmiter(HSQUIRRELVM vm);

@interface iGaiaSquirrelParticleMgr()

@property(nonatomic, assign) iGaiaSquirrelCommon* m_commonWrapper;

@end

@implementation iGaiaSquirrelParticleMgr

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
    [_m_commonWrapper registerClass:@"ParticleMgrWrapper"];
    //[_m_commonWrapper registerFunction:sq_createShape3d withName:@"createShape3d" forClass:@"Scene"];
    //[_m_commonWrapper registerFunction:sq_createCamera withName:@"createCamera" forClass:@"Scene"];
}

SQInteger sq_createParticleEmmiter(HSQUIRRELVM vm)
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
*/