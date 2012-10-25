//
//  iGaiaParticleMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaParticleMgr.h"
#import "iGaiaParticleEmitterSettings.h"

@interface iGaiaParticleEmitterSettings : NSObject<iGaiaParticleEmitterSettings>

@property(nonatomic, readwrite) NSUInteger m_numParticles;

@property(nonatomic, readwrite) NSString* m_textureName;

@property(nonatomic, readwrite) float m_duration;
@property(nonatomic, readwrite) float m_durationRandomness;

@property(nonatomic, readwrite) float m_velocitySensitivity;

@property(nonatomic, readwrite) float m_minHorizontalVelocity;
@property(nonatomic, readwrite) float m_maxHorizontalVelocity;

@property(nonatomic, readwrite) float m_minVerticalVelocity;
@property(nonatomic, readwrite) float m_maxVerticalVelocity;

@property(nonatomic, readwrite) float m_endVelocity;

@property(nonatomic, readwrite) glm::vec3 m_gravity;

@property(nonatomic, readwrite) glm::u8vec4 m_startColor;
@property(nonatomic, readwrite) glm::u8vec4 m_endColor;

@property(nonatomic, readwrite) glm::vec2 m_startSize;
@property(nonatomic, readwrite) glm::vec2 m_endSize;

@property(nonatomic, readwrite) float m_minParticleEmittInterval;
@property(nonatomic, readwrite) float m_maxParticleEmittInterval;

@end

@implementation iGaiaParticleEmitterSettings


@end

@interface iGaiaParticleMgr()

@property(nonatomic, strong) NSMutableSet* m_listeners;

@end

@implementation iGaiaParticleMgr

@synthesize m_listeners = _m_listeners;
@synthesize m_camera = _m_camera;

- (id)init
{
    self = [super init];
    if(self)
    {
        _m_listeners = [NSMutableSet new];
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

- (iGaiaParticleEmitter*)createParticleEmitterFromFile:(NSString*)name;
{
    iGaiaParticleEmitterSettings* settings = [iGaiaParticleEmitterSettings new];

    settings.m_numParticles = 64;

    settings.m_startSize = glm::vec2(0.1f, 0.1f);
    settings.m_endSize = glm::vec2(2.0f, 2.0f);

    settings.m_velocitySensitivity = 1.0f;
    settings.m_endVelocity = 1.0f;

    settings.m_duration = 2000.0f;
    settings.m_durationRandomness = 1.0f;

    settings.m_minHorizontalVelocity = 0.0f;
    settings.m_maxHorizontalVelocity = 0.00015f;

    settings.m_minVerticalVelocity = 0.0001f;
    settings.m_maxVerticalVelocity = 0.0003f;

    settings.m_gravity = glm::vec3(0.0f, 0.00015f, 0.0f);

    settings.m_startColor = glm::u8vec4(0, 0, 255, 255);
    settings.m_endColor = glm::u8vec4(255 , 0, 0, 0);

    settings.m_minParticleEmittInterval = 66;
    settings.m_maxParticleEmittInterval = 133;

    iGaiaParticleEmitter* emitter = [[iGaiaParticleEmitter alloc] initWithSettings:settings];
    emitter.m_camera = _m_camera;
    [_m_listeners addObject:emitter];
    return emitter;
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
