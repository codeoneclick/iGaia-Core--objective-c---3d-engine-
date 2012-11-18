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
#include "iGaiaParticleEmitterSettings.h"

class iGaiaParticleEmitter : public iGaiaObject3d
{
private:
    struct iGaiaParticle
    {
        vec3 m_position;
        vec3 m_velocity;
        vec2 m_size;
        u8vec4 m_color;
        f32 m_timestamp;
    };
    iGaiaParticleEmitterSettings* m_settings;
    iGaiaParticle* m_particles;
    f32 m_lastEmittTimestamp;
    f32 m_lastParticleEmittTime;
    
    void CreateParticle(ui32 _index);
protected:
    
public:
    iGaiaParticleEmitter(iGaiaParticleEmitterSettings* _settings);
    ~iGaiaParticleEmitter(void);
    
    void OnUpdate(void);
    
    void OnLoad(iGaiaResource* _resource);
    
    ui32 Get_Priority(void);
    
    void OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    
    void OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
};

#endif