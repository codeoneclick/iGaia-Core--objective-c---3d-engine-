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
private:
    
    struct iGaiaParticle
    {
        vec3 m_position;
        vec3 m_velocity;
        vec2 m_size;
        u8vec4 m_color;
        f32 m_timestamp;
    };
    iGaiaSettingsProvider::ParticleEmitterSettings m_settings;
    iGaiaParticle* m_particles;
    f32 m_lastEmittTimestamp;
    f32 m_lastParticleEmittTime;
    
    void CreateParticle(ui32 _index);

    void Bind_Receiver(ui32 _mode);
    void Unbind_Receiver(ui32 _mode);
    void Draw_Receiver(ui32 _mode);

    void Update_Receiver(f32 _deltaTime);
    
protected:
    
public:
    iGaiaParticleEmitter(iGaiaResourceMgr* _resourceMgr, iGaiaSettingsProvider::ParticleEmitterSettings const& _settings);
    ~iGaiaParticleEmitter(void);
};

#endif