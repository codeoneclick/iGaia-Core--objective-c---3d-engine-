//
//  iGaiaStageMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaStageMgr.h"
#import "iGaiaLoop.h"
#import "iGaiaLogger.h"
#import "iGaiaCommon.h"

@interface iGaiaStageMgr()<iGaiaLoopCallback>

@property(nonatomic, strong) NSMutableSet* m_listeners;
@property(nonatomic, strong) iGaiaCamera* m_camera;
@property(nonatomic, strong) iGaiaLight* m_light;
@property(nonatomic, strong) iGaiaOcean* m_ocean;

@property(nonatomic, readwrite) iGaiaRenderMgr* m_renderMgr;
@property(nonatomic, readwrite) iGaiaScriptMgr* m_scriptMgr;
@property(nonatomic, readwrite) iGaiaTouchMgr* m_touchMgr;
@property(nonatomic, readwrite) iGaiaParticleMgr* m_particleMgr;


@end

@implementation iGaiaStageMgr

@synthesize m_listeners = _m_listeners;
@synthesize m_camera = _m_camera;
@synthesize m_light = _m_light;
@synthesize m_ocean = _m_ocean;

@synthesize m_renderMgr= _m_renderMgr;
@synthesize m_scriptMgr = _m_scriptMgr;
@synthesize m_touchMgr = _m_touchMgr;
@synthesize m_particleMgr = _m_particleMgr;

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
        _m_listeners = [NSMutableSet new];

        [[iGaiaLoop sharedInstance] addEventListener:self];

        _m_renderMgr = [iGaiaRenderMgr new];
        _m_touchMgr = [iGaiaTouchMgr new];
        _m_touchMgr.m_operationView = _m_renderMgr.m_glView;
        _m_scriptMgr = [iGaiaScriptMgr new];
        _m_particleMgr = [iGaiaParticleMgr new];
        _m_soundMgr = [iGaiaSoundMgr new];
    }
    return self;
}

- (iGaiaCamera*)createCameraWithFov:(float)fov withNear:(float)near withFar:(float)far forScreenWidth:(NSUInteger)width forScreenHeight:(NSUInteger)height
{
    _m_camera = [[iGaiaCamera alloc] initWithFov:fov withNear:near withFar:far forScreenWidth:width forScreenHeight:height];
    
    for(iGaiaObject3d* object3d in _m_listeners)
    {
        object3d.m_camera = _m_camera;
    }
    
    _m_particleMgr.m_camera = _m_camera;
    
    _m_touchMgr.m_crosser.m_camera = _m_camera;
    return _m_camera;
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
    [_m_touchMgr.m_crosser addEventListener:shape3d];
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
    _m_ocean.m_reflectionTexture = [_m_renderMgr retriveTextureFromWorldSpaceRenderMode:E_RENDER_MODE_WORLD_SPACE_REFLECTION];
    _m_ocean.m_refractionTexture = [_m_renderMgr retriveTextureFromWorldSpaceRenderMode:E_RENDER_MODE_WORLD_SPACE_REFRACTION];
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
    [_m_camera.m_frustum onUpdate];
    
    for(id<iGaiaUpdateCallback> listener in _m_listeners)
    {
        [listener onUpdate];
    }
    
    [_m_particleMgr onUpdate];
}

@end
