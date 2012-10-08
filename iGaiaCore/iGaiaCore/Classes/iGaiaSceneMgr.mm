//
//  iGaiaSceneMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaSceneMgr.h"
#import "iGaiaLoop.h"

@interface iGaiaSceneMgr()<iGaiaLoopCallback>

@property(nonatomic, strong) NSMutableSet* m_listeners;
@property(nonatomic, strong) iGaiaCamera* m_camera;
@property(nonatomic, strong) iGaiaLight* m_light;

@end

@implementation iGaiaSceneMgr

@synthesize m_listeners = _m_listeners;
@synthesize m_camera = _m_camera;
@synthesize m_light = _m_light;

+ (iGaiaSceneMgr *)sharedInstance
{
    static iGaiaSceneMgr *_shared = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        [[iGaiaLoop sharedInstance] addEventListener:self];
        _m_listeners = [NSMutableSet new];
    }
    return self;
}

- (iGaiaCamera*)createCameraWithFov:(float)fov withNear:(float)near withFar:(float)far forScreenWidth:(NSUInteger)width forScreenHeight:(NSUInteger)height
{
    return _m_camera = [[iGaiaCamera alloc] initWithFov:fov withNear:near withFar:far forScreenWidth:width forScreenHeight:height];
}

- (iGaiaLight*)createLight
{
    return [iGaiaLight new];
}

- (iGaiaShape3d*)createShape3dWithFileName:(NSString *)name
{
    iGaiaShape3d* shape3d = [[iGaiaShape3d alloc] initWithMeshFileName:name];
    shape3d.m_camera = _m_camera;
    [_m_listeners addObject:shape3d];
    return shape3d;
}

- (iGaiaOcean*)createOceanWithWidth:(float)witdh withHeight:(float)height withAltitude:(float)altitude
{
    return nil;
}

- (iGaiaSkyDome*)createSkyDome
{
    iGaiaSkyDome* skydome = [[iGaiaSkyDome alloc] init];
    skydome.m_camera = _m_camera;
    [_m_listeners addObject:skydome];
    return skydome;
}

- (void)onUpdate
{
    [_m_camera onUpdate];
    
    for(id<iGaiaUpdateCallback> listener in _m_listeners)
    {
        [listener onUpdate];
    }
}

@end
