//
//  iGaiaParticleMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaParticleMgr.h"

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

- (iGaiaParticleEmitter*)createParticleEmitterWithNumParticles:(NSUInteger)numParticles
{
    iGaiaParticleEmitter* emitter = [[iGaiaParticleEmitter alloc] initWithNumParticles:numParticles withSize:glm::vec2(0.0f, 0.0f) withLifetime:0];
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
