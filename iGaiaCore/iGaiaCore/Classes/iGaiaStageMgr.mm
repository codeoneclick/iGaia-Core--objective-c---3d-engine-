//
//  iGaiaStageMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaStageMgr.h"
#import "iGaiaLoop.h"
#import "iGaiaScriptMgr.h"
#import "iGaiaSquirrelBindWrapper.h"
#import "iGaiaRenderMgr.h"
#import "iGaiaInputMgr.h"

@interface iGaiaStageMgr()<iGaiaLoopCallback>

@property(nonatomic, strong) NSMutableSet* m_listeners;
@property(nonatomic, strong) iGaiaCamera* m_camera;
@property(nonatomic, strong) iGaiaLight* m_light;
@property(nonatomic, strong) iGaiaOcean* m_ocean;

@property(nonatomic, strong) iGaiaSquirrelBindWrapper* m_squirrel;

@end

@implementation iGaiaStageMgr

@synthesize m_listeners = _m_listeners;
@synthesize m_camera = _m_camera;
@synthesize m_light = _m_light;
@synthesize m_ocean = _m_ocean;
@synthesize m_squirrel = _m_squirrel;

+ (iGaiaStageMgr *)sharedInstance
{
    static iGaiaStageMgr *_shared = nil;
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
        [[iGaiaInputMgr sharedInstance] setResponderForView:[iGaiaRenderMgr sharedInstance].m_glView];
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
    
    _m_ocean = [[iGaiaOcean alloc] initWithWidth:witdh withHeight:height withAltitude:altitude];
    _m_ocean.m_camera = _m_camera;
    _m_ocean.m_reflectionTexture = [[iGaiaRenderMgr sharedInstance] retriveTextureFromWorldSpaceRenderMode:E_RENDER_MODE_WORLD_SPACE_REFLECTION];
    _m_ocean.m_refractionTexture = [[iGaiaRenderMgr sharedInstance] retriveTextureFromWorldSpaceRenderMode:E_RENDER_MODE_WORLD_SPACE_REFRACTION];
    [_m_listeners addObject:_m_ocean];
    return _m_ocean;
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
