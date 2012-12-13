//
//  iGaiaStageFabricator.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/6/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaStageFabricator.h"

iGaiaStageFabricator::iGaiaStageFabricator(void)
{
    m_stageContainer = new iGaiaStageContainer();
}

iGaiaStageFabricator::~iGaiaStageFabricator(void)
{

}

iGaiaCamera* iGaiaStageFabricator::CreateCamera(f32 _fov, f32 _near, f32 _far, vec4 _viewport)
{
    iGaiaCamera* camera = new iGaiaCamera(_fov, _near, _far, _viewport);
    m_stageContainer->AddCamera(camera);
    return camera;
}

iGaiaLight* iGaiaStageFabricator::CreateLight(void)
{
    iGaiaLight* light = new iGaiaLight();
    m_stageContainer->AddLight(light);
    return light;
}

iGaiaShape3d* iGaiaStageFabricator::CreateShape3d(const iGaiaShape3d::iGaiaShape3dSettings& _settings)
{
    iGaiaShape3d* shape3d = new iGaiaShape3d(_settings);
    m_stageContainer->AddObject3d(shape3d);
    return shape3d;
}

iGaiaOcean* iGaiaStageFabricator::CreateOcean(const iGaiaOcean::iGaiaOceanSettings& _settings)
{
    iGaiaOcean* ocean = new iGaiaOcean(_settings);
    m_stageContainer->AddObject3d(ocean);
    return ocean;
}

iGaiaLandscape* iGaiaStageFabricator::CreateLandscape(const iGaiaLandscape::iGaiaLandscapeSettings &_settings)
{
    iGaiaLandscape* landscape = new iGaiaLandscape(_settings);
    m_stageContainer->AddObject3d(landscape);
    return landscape;
}

iGaiaSkyDome* iGaiaStageFabricator::CreateSkyDome(const iGaiaSkyDome::iGaiaSkyDomeSettings& _settings)
{
    iGaiaSkyDome* skyDome = new iGaiaSkyDome(_settings);
    m_stageContainer->AddObject3d(skyDome);
    return skyDome;
}

iGaiaParticleEmitter* iGaiaStageFabricator::CreateParticleEmitter(const iGaiaParticleEmitter::iGaiaParticleEmitterSettings& _settings)
{
    iGaiaParticleEmitter* shape3d = new iGaiaParticleEmitter(_settings);
    m_stageContainer->AddObject3d(shape3d);
    return shape3d;
}