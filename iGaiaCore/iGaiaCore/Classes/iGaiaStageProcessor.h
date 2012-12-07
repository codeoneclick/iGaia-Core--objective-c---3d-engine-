//
//  iGaiaStageProcessor.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/6/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaStageProcessorClass
#define iGaiaStageProcessorClass

#include "iGaiaCamera.h"
#include "iGaiaLight.h"
#include "iGaiaShape3d.h"
#include "iGaiaBillboard.h"
#include "iGaiaOcean.h"
#include "iGaiaSkyDome.h"
#include "iGaiaParticleEmitter.h"
#include "iGaiaRenderMgr.h"
#include "iGaiaUpdateMgr.h"

class iGaiaStageProcessor
{
private:
    iGaiaRenderMgr* m_renderMgr;
    iGaiaUpdateMgr* m_updateMgr;

    iGaiaCamera* m_camera;
    iGaiaLight* m_light;

    iGaiaOcean* m_ocean;
    iGaiaSkyDome* m_skyDome;

    set<iGaiaShape3d*> m_shapes3d;
    set<iGaiaParticleEmitter*> m_particleEmitters;

protected:

public:
    iGaiaStageProcessor(void);
    ~iGaiaStageProcessor(void);

    void Set_Camera(iGaiaCamera* _camera);
    void Set_Light(iGaiaLight* _light);
    void Set_Ocean(iGaiaOcean* _ocean);
    void Set_SkyDome(iGaiaSkyDome* _skyDome);

    void PushShape3d(iGaiaShape3d* _shape3d);
    void PushParticleEmitter(iGaiaParticleEmitter* _particleEmitter);

    void PopShape3d(iGaiaShape3d* _shape3d);
    void PopParticleEmitter(iGaiaParticleEmitter* _particleEmitter);
};

#endif