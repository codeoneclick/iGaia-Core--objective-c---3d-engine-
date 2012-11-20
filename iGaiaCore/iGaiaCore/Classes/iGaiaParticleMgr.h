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
    iGaiaCamera* m_camera;
    iGaiaLight* m_light;
    set<iGaiaParticleEmitter*> m_listeners;
    map<string, iGaiaParticleEmitterSettings*> m_settings;
protected:

public:
    iGaiaParticleMgr(void);
    ~iGaiaParticleMgr(void);

    void Set_Camera(iGaiaCamera* _camera);
    void Set_Light(iGaiaLight* _light);

    void LoadParticleEmitterFromFile(const string& _name);
    iGaiaParticleEmitter* CreateParticleEmitter(const string& _name);
    void RemoveParticleEmitter(iGaiaParticleEmitter* _emitter);
    void PushParticleEmitterSettings(iGaiaParticleEmitterSettings* settings, const string& _name);

    void OnUpdate(void);
};

#endif