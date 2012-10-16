//
//  iGaiaScriptMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/10/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaScriptMgr.h"

@interface iGaiaScriptMgr()

@property(nonatomic, readwrite) iGaiaSquirrelCommon* m_commonWrapper;
@property(nonatomic, readwrite) iGaiaSquirrelRuntime* m_runtimeWrapper;
@property(nonatomic, readwrite) iGaiaSquirrelScene* m_sceneWrapper;
@property(nonatomic, readwrite) iGaiaSquirrelObject3d* m_object3dWrapper;

@end

@implementation iGaiaScriptMgr

@synthesize m_commonWrapper = _m_commonWrapper;
@synthesize m_runtimeWrapper = _m_runtimeWrapper;
@synthesize m_sceneWrapper = _m_sceneWrapper;
@synthesize m_object3dWrapper = _m_object3dWrapper;

- (id)init
{
    self = [super init];
    if(self)
    {
        _m_commonWrapper = [iGaiaSquirrelCommon sharedInstance];
        _m_runtimeWrapper = [[iGaiaSquirrelRuntime alloc] initWithCommonWrapper:_m_commonWrapper];
        _m_sceneWrapper = [[iGaiaSquirrelScene alloc] initWithCommonWrapper:_m_commonWrapper];
        _m_object3dWrapper = [[iGaiaSquirrelObject3d alloc] initWithCommonWrapper:_m_commonWrapper];
    }
    return self;
}


- (BOOL)loadScriptWithFileName:(NSString*)name;
{
    return [_m_commonWrapper loadScriptWithFileName:name];
}

@end

