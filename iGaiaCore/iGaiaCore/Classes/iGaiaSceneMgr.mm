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
        [self bindSquirrel];
    }
    return self;
}

- (void)bindSquirrel
{
    [[iGaiaSquirrelMgr sharedInstance] registerTable:@"igaia"];
    [[iGaiaSquirrelMgr sharedInstance] registerClass:@"Scene"];
    [[iGaiaSquirrelMgr sharedInstance] registerFunction:sq_createShape3d withName:@"createShape3d" forClass:@"Scene"];
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
}

SQInteger sq_createShape3d(HSQUIRRELVM vm)
{
    const SQChar* value_01;
    SQInteger nargs = sq_gettop(vm);
    SQObjectType type = sq_gettype(vm, 2);

    if (nargs >= 2 && sq_gettype(vm, 2) == OT_STRING)
    {
        sq_tostring(vm, 2);
        sq_getstring(vm, -1, &value_01);
        sq_poptop(vm);
    }
    else if(nargs >= 2 && sq_gettype(vm, 2) == OT_USERPOINTER)
    {
        iGaiaShape3d* shape3d = nil;
        SQUserPointer ptr;
        sq_getuserpointer(vm, 2, &ptr);
        shape3d = (__bridge iGaiaShape3d*)ptr;
    }
    else
    {
        return 0;
    }
	NSString* name = [[NSString alloc] initWithUTF8String:value_01];
    iGaiaShape3d* shape3d = [[iGaiaSceneMgr sharedInstance] createShape3dWithFileName:name];
    sq_pushuserpointer(vm, (__bridge SQUserPointer)shape3d);
    return 1;
}

@end
