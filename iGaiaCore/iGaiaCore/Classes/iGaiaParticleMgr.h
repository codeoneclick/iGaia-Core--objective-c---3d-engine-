//
//  iGaiaParticleMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaParticleMgrClass
#define iGaiaParticleMgrClass

#include "iGaiaParticleEmitter.h"

class iGaiaParticleMgr
{
private:
    
    map<string, iGaiaParticleEmitter::iGaiaParticleEmitterSettings> m_settings;
    
protected:

public:
    
    iGaiaParticleMgr(void);
    ~iGaiaParticleMgr(void);

    iGaiaParticleEmitter::iGaiaParticleEmitterSettings Get_ParticleEmitterSettings(const string& _name);
    
};

#endif