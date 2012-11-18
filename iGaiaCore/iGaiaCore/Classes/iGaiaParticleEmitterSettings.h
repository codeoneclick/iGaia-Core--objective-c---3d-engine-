//
//  iGaiaParticleEmitterSettings.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/25/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaParticleEmitterSettingsClass
#define iGaiaParticleEmitterSettingsClass

#include "iGaiaCommon.h"

struct iGaiaParticleEmitterSettings
{
    ui32 m_numParticles;
    string m_textureName;

    f32 m_duration;
    f32 m_durationRandomness;

    f32 m_velocitySensitivity;

    f32 m_minHorizontalVelocity;
    f32 m_maxHorizontalVelocity;

    f32 m_minVerticalVelocity;
    f32 m_maxVerticalVelocity;

    f32 m_endVelocity;

    vec3 m_gravity;

    u8vec4 m_startColor;
    u8vec4 m_endColor;

    vec2 m_startSize;
    vec2 m_endSize;

    f32 m_minParticleEmittInterval;
    f32 m_maxParticleEmittInterval;
};

#endif