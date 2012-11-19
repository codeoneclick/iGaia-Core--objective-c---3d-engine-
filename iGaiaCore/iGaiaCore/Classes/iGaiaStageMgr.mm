//
//  iGaiaStageMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaStageMgr.h"
#import "iGaiaLogger.h"

iGaiaStageMgr::iGaiaStageMgr(void)
{
    [[iGaiaiOSGameLoop SharedInstance] AddEventListener:this];

    m_renderMgr = new iGaiaRenderMgr();
    m_touchMgr = new iGaiaTouchMgr(); //[iGaiaTouchMgr new];
    m_touchMgr->Set_OperationView(m_renderMgr->Get_GLView());
    m_scriptMgr = new iGaiaScriptMgr();
    m_particleMgr = new iGaiaParticleMgr();
    m_soundMgr = new iGaiaSoundMgr();
}

iGaiaStageMgr::~iGaiaStageMgr(void)
{
    
}

iGaiaStageMgr* iGaiaStageMgr::SharedInstance(void)
{
    static iGaiaStageMgr *instance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        instance = new iGaiaStageMgr();
    });
    return instance;
}


iGaiaRenderMgr* iGaiaStageMgr::Get_RenderMgr(void)
{
    return m_renderMgr;
}

iGaiaScriptMgr* iGaiaStageMgr::Get_ScriptMgr(void)
{
    return m_scriptMgr;
}

iGaiaTouchMgr* iGaiaStageMgr::Get_TouchMgr(void)
{
    return m_touchMgr;
}

iGaiaParticleMgr* iGaiaStageMgr::Get_ParticleMgr(void)
{
    return m_particleMgr;
}

iGaiaSoundMgr* iGaiaStageMgr::Get_SoundMgr(void)
{
    return m_soundMgr;
}

iGaiaCamera* iGaiaStageMgr::CreateCamera(f32 _fov, f32 _near, f32 _far, ui32 _width, ui32 _height)
{
    m_camera = new iGaiaCamera(_fov, _near, _far, _width, _height);

    for(iGaiaObject3d* object3d : m_listeners)
    {
        object3d->Set_Camera(m_camera);
    }
    m_particleMgr->Set_Camera(m_camera);
    m_touchMgr->Get_TouchCrosser()->Set_Camera(m_camera);
    return m_camera;
}

iGaiaLight* iGaiaStageMgr::CreateLight(void)
{
    m_light = new iGaiaLight();
    return m_light;
}

iGaiaShape3d* iGaiaStageMgr::CreateShape3d(const string& _name)
{
    iGaiaShape3d* shape3d = new iGaiaShape3d(_name);
    shape3d->Set_Camera(m_camera);
    m_listeners.insert(shape3d);
    m_touchMgr->Get_TouchCrosser()->AddEventListener(shape3d);
    return shape3d;
}

iGaiaOcean* iGaiaStageMgr::CreateOcean(f32 _width, f32 _height, f32 _altitude)
{
    for(iGaiaUpdateCallback* listener : m_listeners)
    {
        iGaiaShape3d* shape3d = static_cast<iGaiaShape3d*>(listener);
        shape3d->Set_Clipping(vec4(0.0f, 1.0f, 0.0f, _altitude));
    }
    m_camera->Set_Altitude(_altitude);

    m_ocean = new iGaiaOcean(_width, _height, _altitude);
    m_ocean->Set_Camera(m_camera);
    m_ocean->Set_ReflectionTexture(m_renderMgr->Get_TextureFromWorldSpaceRenderMode(iGaiaMaterial::iGaia_E_RenderModeWorldSpaceReflection));
    m_ocean->Set_RefractionTexture(m_renderMgr->Get_TextureFromWorldSpaceRenderMode(iGaiaMaterial::iGaia_E_RenderModeWorldSpaceRefraction));
    m_listeners.insert(m_ocean);
    return m_ocean;
}

iGaiaSkyDome* iGaiaStageMgr::CreateSkyDome(void)
{
    iGaiaSkyDome* skydome = new iGaiaSkyDome();
    skydome->Set_Camera(m_camera);
    m_listeners.insert(skydome);
    return skydome;
}

void iGaiaStageMgr::OnUpdate(void)
{
    m_camera->OnUpdate();

    for(iGaiaUpdateCallback* listener : m_listeners)
    {
        listener->OnUpdate();
    }
    m_particleMgr->OnUpdate();
}
