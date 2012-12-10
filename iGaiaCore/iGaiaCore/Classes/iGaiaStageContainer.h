//
//  iGaiaStageContainer.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/6/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaStageContainerClass
#define iGaiaStageContainerClass

#include "iGaiaCamera.h"
#include "iGaiaLight.h"
#include "iGaiaShape3d.h"
#include "iGaiaBillboard.h"
#include "iGaiaOcean.h"
#include "iGaiaSkyDome.h"
#include "iGaiaParticleEmitter.h"

class iGaiaStageContainer
{
private:
    set<iGaiaObject3d*> m_objects3d;
    set<iGaiaCamera*> m_cameras;
    set<iGaiaLight*> m_lights;
protected:

public:
    iGaiaStageContainer(void);
    ~iGaiaStageContainer(void);

    void AddObject3d(iGaiaObject3d* _object3d);
    void RemoveObject3d(iGaiaObject3d* _object3d);

    void AddCamera(iGaiaCamera* _camera);
    void RemoveCamera(iGaiaCamera* _camera);

    void AddLight(iGaiaLight* _light);
    void RemoveLight(iGaiaLight* _light);
};

#endif
