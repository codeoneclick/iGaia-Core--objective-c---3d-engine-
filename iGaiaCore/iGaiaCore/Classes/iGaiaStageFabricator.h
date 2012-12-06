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
    iGaiaOcean* CreateOcean(f32 _width, f32 _height, f32 _altitude);
    iGaiaSkyDome* CreateSkyDome(void);
    iGaiaShape3d* CreateShape3d(const iGaiaShape3d::iGaiaShape3dSettings& _settings);
    iGaiaParticleEmitter* CreateParticleEmitter(void);
};

#endif