//
//  iGaiaParticleEmitter.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaObject3d.h"

struct iGaiaParticle
{
    glm::vec3 m_position;
    glm::vec3 m_velocity;
    glm::vec2 m_size;
    glm::u8vec4 m_color;
    float m_lifetime;
};

@interface iGaiaParticleEmitter : iGaiaObject3d

- (id)initWithNumParticles:(NSUInteger)numParticles withSize:(const glm::vec2&)size withLifetime:(float)lifetime;

@end