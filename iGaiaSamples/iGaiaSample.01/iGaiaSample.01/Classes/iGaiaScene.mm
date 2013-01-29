//
//  iGaiaScene.m
//  iGaiaSample.01
//
//  Created by Sergey Sergeev on 12/17/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaScene.h"
#include "iGaiaSettings_iOS.h"
#include "iGaiaLogger.h"
#include "iGaiaCollider.h"

iGaiaScene::iGaiaScene(void)
{
}

iGaiaScene::~iGaiaScene(void)
{

}

void iGaiaScene::Load(iGaiaRoot* _root)
{
    m_camera = _root->CreateCamera(45.0f, 0.1f, 1000.0f, vec4(0.0f, 0.0f, [iGaiaSettings_iOS Get_Size].width, [iGaiaSettings_iOS Get_Size].height));
    
    m_characterController = new iGaiaCharacterController(_root->Get_GestureRecognizer());

    ConnectGestureRecognizerCallback();
    _root->Get_GestureRecognizer()->AddEventListener(&m_gestureRecognizerCallback, iGaiaGestureRecognizerType::GestureRecognizerTap);

    _root->Set_Camera(m_camera);
    m_camera->Set_Position(vec3(0.0f, 0.0f, 0.0f));
    m_camera->Set_LookAt(vec3(16.0f, 0.0f, 32.0f));

    m_light = _root->CreateLight();
    _root->Set_Light(m_light);

    iGaiaShape3d::iGaiaShape3dSettings settingsBuilding_01 = iGaiaResourceMgr::SharedInstance()->Get_Shape3dSettings("building_01.xml");
    m_shape3d = _root->CreateShape3d(settingsBuilding_01);
    _root->PushShape3d(m_shape3d);
    m_shape3d->Set_Position(vec3(16.0f, 0.0f, 32.0f));

    iGaiaSkyDome::iGaiaSkyDomeSettings settingsSkyDome = iGaiaResourceMgr::SharedInstance()->Get_SkyDomeSettings("skydome.xml");
    iGaiaSkyDome* skydome = _root->CreateSkyDome(settingsSkyDome);
    _root->Set_SkyDome(skydome);

    iGaiaLandscape::iGaiaLandscapeSettings settingsLanscape = iGaiaResourceMgr::SharedInstance()->Get_LandscapeSettings("landscape.xml");
    m_landscape = _root->CreateLandscape(settingsLanscape);
    _root->Set_Landscape(m_landscape);

    iGaiaOcean::iGaiaOceanSettings settingsOcean = iGaiaResourceMgr::SharedInstance()->Get_OceanSettings("ocean.xml");
    iGaiaOcean* ocean = _root->CreateOcean(settingsOcean);
    _root->Set_Ocean(ocean);

    //iGaiaSharedFacade::SharedInstance()->Get_SoundMgr()->CreateMusic("music_02", "mp3", "music");
    //iGaiaSharedFacade::SharedInstance()->Get_SoundMgr()->PlayMusic("music", 5);

    iGaiaParticleEmitter::iGaiaParticleEmitterSettings settings_particle = iGaiaResourceMgr::SharedInstance()->Get_ParticleEmitterSettings("particle_emitter_fire.xml");

    iGaiaParticleEmitter* emitter = _root->CreateParticleEmitter(settings_particle);
    _root->PushParticleEmitter(emitter);
    emitter->Set_Position(vec3(16.0f, 4.0f, 32.0f));

    m_characterController->Set_Camera(m_camera);
    m_characterController->Set_Heightmap(m_landscape->Get_HeightmapData(), m_landscape->Get_Width(), m_landscape->Get_Height(), m_landscape->Get_ScaleFactor());
}

iGaiaCharacterController* iGaiaScene::Get_CharacterController(void)
{
    return m_characterController;
}

void iGaiaScene::TapGestureRecognizerReceiver(const vec2 &_point)
{
    iGaiaCollider collider(m_shape3d);
    CGRect viewport = [iGaiaSettings_iOS Get_Frame];
     
    if(collider.Collide(m_camera->Get_ProjectionMatrix(), m_camera->Get_ViewMatrix(), vec4(0.0f, 0.0f, viewport.size.width, viewport.size.height), _point))
    {
        iGaiaLog("Collide point on shape : x - %f, y - %f, z - %f", collider.Get_CollidePoint().x, collider.Get_CollidePoint().y, collider.Get_CollidePoint().z);
    }
}
