//
//  iGaiaSceneMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaSceneMgr.h"
#import "iGaiaLoop.h"
#import "iGaiaSquirrelMgr.h"
#import "iGaiaSquirrelBindWrapper.h"

@interface iGaiaSceneMgr()<iGaiaLoopCallback>

@property(nonatomic, strong) NSMutableSet* m_listeners;
@property(nonatomic, strong) iGaiaCamera* m_camera;
@property(nonatomic, strong) iGaiaLight* m_light;
@property(nonatomic, strong) iGaiaSquirrelBindWrapper* m_squirrel;

@end

@implementation iGaiaSceneMgr

@synthesize m_listeners = _m_listeners;
@synthesize m_camera = _m_camera;
@synthesize m_light = _m_light;
@synthesize m_squirrel = _m_squirrel;

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
        _m_squirrel = [iGaiaSquirrelBindWrapper new];
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
    for(id<iGaiaUpdateCallback> listener in _m_listeners)
    {
        if([listener isKindOfClass:[iGaiaShape3d class]])
        {
            iGaiaShape3d* shape3d = static_cast<iGaiaShape3d*>(listener);
            [shape3d setClipping:glm::vec4(0.0f, 1.0f, 0.0f, altitude)];
        }
    }
    _m_camera.m_altitude = altitude;
    
    iGaiaOcean* ocean = [[iGaiaOcean alloc] initWithWidth:witdh withHeight:height withAltitude:altitude];
    ocean.m_camera = _m_camera;
    [_m_listeners addObject:ocean];
    return ocean;
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
    float params[2];
    params[0] = 1.24f;
    params[1] = 0.8f;
    [_m_squirrel sq_onUpdateWith:params withCount:2];
}

@end
