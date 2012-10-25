//
//  iGaiaParticleEmitterSettings.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/25/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <glm/glm.hpp>
#import <glm/gtc/type_precision.hpp>
#import <glm/gtc/matrix_transform.hpp>

@protocol iGaiaParticleEmitterSettings <NSObject>

@property(nonatomic, readonly) NSUInteger m_numParticles;

@property(nonatomic, readonly) NSString* m_textureName;

@property(nonatomic, readonly) float m_duration;
@property(nonatomic, readonly) float m_durationRandomness;

@property(nonatomic, readonly) float m_velocitySensitivity;

@property(nonatomic, readonly) float m_minHorizontalVelocity;
@property(nonatomic, readonly) float m_maxHorizontalVelocity;

@property(nonatomic, readonly) float m_minVerticalVelocity;
@property(nonatomic, readonly) float m_maxVerticalVelocity;

@property(nonatomic, readonly) float m_endVelocity;

@property(nonatomic, readonly) glm::vec3 m_gravity;

@property(nonatomic, readonly) glm::u8vec4 m_startColor;
@property(nonatomic, readonly) glm::u8vec4 m_endColor;

@property(nonatomic, readonly) glm::vec2 m_startSize;
@property(nonatomic, readonly) glm::vec2 m_endSize;

@property(nonatomic, readonly) float m_minParticleEmittInterval;
@property(nonatomic, readonly) float m_maxParticleEmittInterval;

@end
