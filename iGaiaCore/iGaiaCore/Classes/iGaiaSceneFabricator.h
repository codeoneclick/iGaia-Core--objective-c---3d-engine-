//
//  iGaiaSceneFabricator.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/24/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaSceneFabricatorClass
#define iGaiaSceneFabricatorClass

#include "iGaiaCommon.h"
#include "iGaiaSceneContainer.h"
#include "iGaiaShape3d.h"
#include "iGaiaOcean.h"
#include "iGaiaSkyDome.h"
#include "iGaiaLandscape.h"
#include "iGaiaParticleEmitter.h"
#include "iGaiaNavigationHelper.h"

class iGaiaSceneFabricator
{
private:
    
protected:
    iGaiaSceneContainer* m_sceneContainer;
    
    iGaiaSceneFabricator(void);
    virtual ~iGaiaSceneFabricator(void);
public:
    
    iGaiaCamera* CreateCamera(f32 _fov, f32 _near, f32 _far, vec4 _viewport);
    iGaiaLight* CreateLight(void);
    iGaiaNavigationHelper* CreateNavigationHelper(f32 _moveForwardSpeed, f32 _moveBackwardSpeed, f32 _strafeSpeed, f32 _steerSpeed);
    
    iGaiaOcean* CreateOcean(const iGaiaOcean::iGaiaOceanSettings& _settings);
    iGaiaLandscape* CreateLandscape(const iGaiaLandscape::iGaiaLandscapeSettings& _settings);
    iGaiaSkyDome* CreateSkyDome(const iGaiaSkyDome::iGaiaSkyDomeSettings& _settings);
    iGaiaShape3d* CreateShape3d(const iGaiaShape3d::iGaiaShape3dSettings& _settings);
    iGaiaParticleEmitter* CreateParticleEmitter(const iGaiaParticleEmitter::iGaiaParticleEmitterSettings& _settings);
};

#endif 
