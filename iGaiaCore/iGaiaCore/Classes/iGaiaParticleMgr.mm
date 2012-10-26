//
//  iGaiaParticleMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaParticleMgr.h"
#import "iGaiaParticleEmitterSettings.h"
#import "iGaiaStageMgr.h"
#import "iGaiaLogger.h"

@interface iGaiaParticleMgr()

@property(nonatomic, strong) NSMutableSet* m_listeners;
@property(nonatomic, strong) NSMutableDictionary* m_settings;

@end

@implementation iGaiaParticleMgr

- (id)init
{
    self = [super init];
    if(self)
    {
        _m_listeners = [NSMutableSet new];
        _m_settings = [NSMutableDictionary new];
    }
    return self;
}

- (void)setM_camera:(iGaiaCamera *)m_camera
{
    _m_camera = m_camera;
    for(iGaiaParticleEmitter* emitter in _m_listeners)
    {
        emitter.m_camera = _m_camera;
    }
}

- (void)loadParticleEmitterFromFile:(NSString*)name;
{
    [[iGaiaStageMgr sharedInstance].m_scriptMgr loadScriptWithFileName:name];
}

- (iGaiaParticleEmitter*)createParticleEmitterWithName:(NSString*)name;
{
    id<iGaiaParticleEmitterSettings> settings = [_m_settings objectForKey:name];
    if(settings == nil)
    {
        iGaiaLog(@"Cannot create emitter with name: %@", name);
        return nil;
    }
    iGaiaParticleEmitter* emitter = [[iGaiaParticleEmitter alloc] initWithSettings:settings];
    emitter.m_camera = _m_camera;
    [_m_listeners addObject:emitter];
    return emitter;
}

- (void)createParticleEmitterSettings:(id<iGaiaParticleEmitterSettings>)settings forKey:(NSString*)key;
{
    [_m_settings setObject:settings forKey:key];
}

- (void)removeParticleEmitter:(iGaiaParticleEmitter *)emitter
{
    [_m_listeners removeObject:emitter];
}

- (void)onUpdate
{
    for(iGaiaParticleEmitter* emitter in _m_listeners)
    {
        [emitter onUpdate];
    }
}

@end
