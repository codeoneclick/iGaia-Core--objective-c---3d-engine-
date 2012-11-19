//
//  iGaiaParticleMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaParticleMgr.h"
#include "iGaiaStageMgr.h"
#include "iGaiaLogger.h"

iGaiaParticleMgr::iGaiaParticleMgr(void)
{

}

iGaiaParticleMgr::~iGaiaParticleMgr(void)
{
    
}

inline void iGaiaParticleMgr::Set_Camera(iGaiaCamera *_camera)
{
    m_camera = _camera;
}

void iGaiaParticleMgr::LoadParticleEmitterFromFile(const string& _name)
{
    //[[iGaiaStageMgr sharedInstance].m_scriptMgr loadScriptWithFileName:name];
}

iGaiaParticleEmitter* iGaiaParticleMgr::CreateParticleEmitter(const string& _name)
{
    if(m_settings.find(_name) == m_settings.end())
    {
        iGaiaLog(@"Cannot create emitter with name: %s", _name.c_str());
        return nullptr;
    }
    iGaiaParticleEmitterSettings* settings = m_settings.find(_name)->second;
    iGaiaParticleEmitter* emitter = new iGaiaParticleEmitter(settings);
    emitter->Set_Camera(m_camera);
    m_listeners.insert(emitter);
    return emitter;
}

void iGaiaParticleMgr::RemoveParticleEmitter(iGaiaParticleEmitter* _emitter)
{
    m_listeners.erase(_emitter);
}
    
void iGaiaParticleMgr::PushParticleEmitterSettings(iGaiaParticleEmitterSettings* settings, const string& _name)
{
    m_settings[_name] = settings;
}

void iGaiaParticleMgr::OnUpdate(void)
{
    for(iGaiaParticleEmitter* emitter : m_listeners)
    {
        emitter->OnUpdate();
    }
}