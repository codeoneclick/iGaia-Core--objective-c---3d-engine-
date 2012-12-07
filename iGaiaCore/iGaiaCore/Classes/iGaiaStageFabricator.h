//
//  iGaiaStageFabricator.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/6/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaStageFabricatorClass
#define iGaiaStageFabricatorClass

#include "iGaiaStageContainer.h"

class iGaiaStageFabricator
{
private:
    iGaiaStageContainer* m_stageContainer;
protected:

public:
    iGaiaStageFabricator(void);
    ~iGaiaStageFabricator(void);

    iGaiaCamera* CreateCamera(f32 _fov, f32 _near, f32 _far, vec4 _viewport);
    iGaiaLight* CreateLight(void);

    iGaiaOcean* CreateOcean(const iGaiaOcean::iGaiaOceanSettings& _settings);
    iGaiaSkyDome* CreateSkyDome(const iGaiaSkyDome::iGaiaSkyDomeSettings& _settings);
    iGaiaShape3d* CreateShape3d(const iGaiaShape3d::iGaiaShape3dSettings& _settings);
    iGaiaParticleEmitter* CreateParticleEmitter(const iGaiaParticleEmitter::iGaiaParticleEmitterSettings& _settings);
};

#endif