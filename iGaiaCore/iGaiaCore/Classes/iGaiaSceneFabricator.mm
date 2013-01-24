//
//  iGaiaSceneFabricator.cpp
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/24/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#include "iGaiaSceneFabricator.h"

iGaiaSceneFabricator::iGaiaSceneFabricator(void)
{
    m_sceneContainer = new iGaiaSceneContainer();
}

iGaiaSceneFabricator::~iGaiaSceneFabricator(void)
{
    
}

iGaiaCamera* iGaiaSceneFabricator::CreateCamera(f32 _fov, f32 _near, f32 _far, vec4 _viewport)
{
    iGaiaCamera* camera = new iGaiaCamera(_fov, _near, _far, _viewport);
    m_sceneContainer->AddCamera(camera);
    return camera;
}

iGaiaLight* iGaiaSceneFabricator::CreateLight(void)
{
    iGaiaLight* light = new iGaiaLight();
    m_sceneContainer->AddLight(light);
    return light;
}

iGaiaNavigationHelper* iGaiaSceneFabricator::CreateNavigationHelper(f32 _moveForwardSpeed, f32 _moveBackwardSpeed, f32 _strafeSpeed, f32 _steerSpeed)
{
    iGaiaNavigationHelper* navigationHelper = new iGaiaNavigationHelper(_moveForwardSpeed, _moveBackwardSpeed, _strafeSpeed, _steerSpeed);
    return navigationHelper;
}

iGaiaShape3d* iGaiaSceneFabricator::CreateShape3d(const iGaiaShape3d::iGaiaShape3dSettings& _settings)
{
    iGaiaShape3d* shape3d = new iGaiaShape3d(_settings);
    m_sceneContainer->AddObject3d(shape3d);
    return shape3d;
}

iGaiaOcean* iGaiaSceneFabricator::CreateOcean(const iGaiaOcean::iGaiaOceanSettings& _settings)
{
    iGaiaOcean* ocean = new iGaiaOcean(_settings);
    m_sceneContainer->AddObject3d(ocean);
    return ocean;
}

iGaiaLandscape* iGaiaSceneFabricator::CreateLandscape(const iGaiaLandscape::iGaiaLandscapeSettings &_settings)
{
    iGaiaLandscape* landscape = new iGaiaLandscape(_settings);
    m_sceneContainer->AddObject3d(landscape);
    return landscape;
}

iGaiaSkyDome* iGaiaSceneFabricator::CreateSkyDome(const iGaiaSkyDome::iGaiaSkyDomeSettings& _settings)
{
    iGaiaSkyDome* skyDome = new iGaiaSkyDome(_settings);
    m_sceneContainer->AddObject3d(skyDome);
    return skyDome;
}

iGaiaParticleEmitter* iGaiaSceneFabricator::CreateParticleEmitter(const iGaiaParticleEmitter::iGaiaParticleEmitterSettings& _settings)
{
    iGaiaParticleEmitter* shape3d = new iGaiaParticleEmitter(_settings);
    m_sceneContainer->AddObject3d(shape3d);
    return shape3d;
}


