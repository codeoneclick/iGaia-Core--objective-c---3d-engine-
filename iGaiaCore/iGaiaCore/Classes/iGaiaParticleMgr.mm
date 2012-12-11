//
//  iGaiaParticleMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaParticleMgr.h"
#include "iGaiaLogger.h"
#include "iGaiaParser_ParticleEmitterSettings.h"

iGaiaParticleMgr::iGaiaParticleMgr(void)
{

}

iGaiaParticleMgr::~iGaiaParticleMgr(void)
{
    
}

iGaiaParticleEmitter::iGaiaParticleEmitterSettings iGaiaParticleMgr::Get_ParticleEmitterSettings(const string& _name)
{
    iGaiaParticleEmitter::iGaiaParticleEmitterSettings settings;
    if(m_settings.find(_name) != m_settings.end())
    {
        settings = m_settings.find(_name)->second;
    }
    else
    {
        iGaiaParser_ParticleEmitterSettings* parser = new iGaiaParser_ParticleEmitterSettings();
        settings = parser->Get_Settings(_name);
        m_settings[_name] = settings;
        delete parser;
    }
    return settings;
}