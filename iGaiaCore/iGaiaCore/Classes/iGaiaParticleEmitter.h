//
//  iGaiaParticleEmitter.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaParticleEmitterClass
#define iGaiaParticleEmitterClass

#include "iGaiaObject3d.h"

class iGaiaParticleEmitter : public iGaiaObject3d
{
public:

    struct iGaiaParticleEmitterSettings
    {
        vector<iGaiaObject3dShaderSettings> m_shaders;
        vector<iGaiaObject3dTextureSettings> m_textures;
        
        ui32 m_numParticles;

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

private:
    
    struct iGaiaParticle
    {
        vec3 m_position;
        vec3 m_velocity;
        vec2 m_size;
        u8vec4 m_color;
        f32 m_timestamp;
    };
    iGaiaParticleEmitterSettings m_settings;
    iGaiaParticle* m_particles;
    f32 m_lastEmittTimestamp;
    f32 m_lastParticleEmittTime;
    
    void CreateParticle(ui32 _index);
    
    ui32 OnDrawIndex(void);
    
protected:
    
public:
    iGaiaParticleEmitter(const iGaiaParticleEmitter::iGaiaParticleEmitterSettings& _settings);
    ~iGaiaParticleEmitter(void);
    
    void OnUpdate(void);
    
    void OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    
    void OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
};

#endif