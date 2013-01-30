//
//  iGaiaSceneGraph.cpp
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/24/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#include "iGaiaSceneGraph.h"

iGaiaSceneGraph::iGaiaSceneGraph(void)
{
    m_camera = nullptr;
    m_light = nullptr;
    
    m_ocean = nullptr;
    m_landscape = nullptr;
    m_skyDome = nullptr;
}

iGaiaSceneGraph::~iGaiaSceneGraph(void)
{
    
}

void iGaiaSceneGraph::Set_Camera(iGaiaCamera* _camera)
{
    if(m_camera != nullptr)
    {
        m_camera->ListenUpdateMgr(false);
    }
    
    m_camera = _camera;
    m_camera->Set_UpdateMgr(m_updateMgr);
    m_camera->ListenUpdateMgr(true);
    
    for(set<iGaiaShape3d*>::iterator iterator = m_shapes3d.begin(); iterator != m_shapes3d.end(); ++iterator)
    {
        iGaiaShape3d* shape3d = *iterator;
        shape3d->Set_Camera(m_camera);
    }
    
    for(set<iGaiaParticleEmitter*>::iterator iterator = m_particleEmitters.begin(); iterator != m_particleEmitters.end(); ++iterator)
    {
        iGaiaParticleEmitter* particleEmitter = *iterator;
        particleEmitter->Set_Camera(m_camera);
    }
    
    if(m_ocean != nullptr)
    {
        m_ocean->Set_Camera(m_camera);
    }
    
    if(m_skyDome != nullptr)
    {
        m_skyDome->Set_Camera(m_camera);
    }
}

void iGaiaSceneGraph::Set_Light(iGaiaLight* _light)
{
    m_light = _light;
    
    for(set<iGaiaShape3d*>::iterator iterator = m_shapes3d.begin(); iterator != m_shapes3d.end(); ++iterator)
    {
        iGaiaShape3d* shape3d = *iterator;
        shape3d->Set_Light(m_light);
    }
    
    for(set<iGaiaParticleEmitter*>::iterator iterator = m_particleEmitters.begin(); iterator != m_particleEmitters.end(); ++iterator)
    {
        iGaiaParticleEmitter* particleEmitter = *iterator;
        particleEmitter->Set_Light(m_light);
    }
    
    if(m_ocean != nullptr)
    {
        m_ocean->Set_Light(m_light);
    }
    
    if(m_skyDome != nullptr)
    {
        m_skyDome->Set_Light(m_light);
    }
}

void iGaiaSceneGraph::PushShape3d(iGaiaShape3d* _shape3d)
{
    set<iGaiaShape3d*>::iterator iterator = m_shapes3d.find(_shape3d);
    if(iterator != m_shapes3d.end())
    {
        // TODO : log
        return;
    }
    
    iGaiaShape3d* shape3d = _shape3d;
    m_shapes3d.insert(shape3d);
    
    if(m_ocean != nullptr)
    {
        shape3d->Set_Clipping(vec4(0.0f, 1.0f, 0.0f, m_ocean->Get_Altitude()));
    }
    
    shape3d->Set_Camera(m_camera);
    shape3d->Set_Light(m_light);
    shape3d->Set_UpdateMgr(m_updateMgr);
    shape3d->Set_RenderMgr(m_renderMgr);
    shape3d->ListenUpdateMgr(true);
    shape3d->ListenRenderMgr(true);
}

void iGaiaSceneGraph::Set_Ocean(iGaiaOcean* _ocean)
{
    if(m_ocean != nullptr)
    {
        m_ocean->ListenUpdateMgr(false);
        m_ocean->ListenRenderMgr(false);
        m_ocean = nullptr;
    }
    
    m_ocean = _ocean;
    
    m_camera->Set_Altitude(m_ocean->Get_Altitude());
    
    for(set<iGaiaShape3d*>::iterator iterator = m_shapes3d.begin(); iterator != m_shapes3d.end(); ++iterator)
    {
        iGaiaShape3d* shape3d = *iterator;
        shape3d->Set_Clipping(vec4(0.0f, 1.0f, 0.0f, m_ocean->Get_Altitude()));
    }
    
    if(m_landscape != nullptr)
    {
        m_landscape->Set_Clipping(vec4(0.0f, 1.0f, 0.0f, m_ocean->Get_Altitude()));
        //m_ocean->Set_HeightmapTexture(m_landscape->Get_HeightmapTexture());
    }
    
    m_ocean->Set_Camera(m_camera);
    m_ocean->Set_Light(m_light);
    m_ocean->Set_ReflectionTexture(m_renderMgr->Get_TextureFromWorldSpaceRenderMode(iGaiaMaterial::iGaia_E_RenderModeWorldSpaceReflection));
    m_ocean->Set_RefractionTexture(m_renderMgr->Get_TextureFromWorldSpaceRenderMode(iGaiaMaterial::iGaia_E_RenderModeWorldSpaceRefraction));
    m_ocean->Set_UpdateMgr(m_updateMgr);
    m_ocean->Set_RenderMgr(m_renderMgr);
    m_ocean->ListenUpdateMgr(true);
    m_ocean->ListenRenderMgr(true);
}

void iGaiaSceneGraph::Set_Landscape(iGaiaLandscape *_landscape)
{
    if(m_landscape != nullptr)
    {
        m_landscape->ListenUpdateMgr(false);
        m_landscape->ListenRenderMgr(false);
        m_landscape = nullptr;
    }
    
    m_landscape = _landscape;
    
    if(m_ocean != nullptr)
    {
        m_landscape->Set_Clipping(vec4(0.0f, 1.0f, 0.0f, m_ocean->Get_Altitude()));
        //m_ocean->Set_HeightmapTexture(m_landscape->Get_HeightmapTexture());
    }
    
    m_landscape->Set_Camera(m_camera);
    m_landscape->Set_Light(m_light);
    m_landscape->Set_UpdateMgr(m_updateMgr);
    m_landscape->Set_RenderMgr(m_renderMgr);
    m_landscape->ListenUpdateMgr(true);
    m_landscape->ListenRenderMgr(true);
}

void iGaiaSceneGraph::Set_SkyDome(iGaiaSkyDome* _skyDome)
{
    if(m_skyDome != nullptr)
    {
        m_skyDome->ListenUpdateMgr(false);
        m_skyDome->ListenRenderMgr(false);
        m_skyDome = nullptr;
    }
    
    m_skyDome = _skyDome;
    m_skyDome->Set_Camera(m_camera);
    m_skyDome->Set_Light(m_light);
    m_skyDome->Set_UpdateMgr(m_updateMgr);
    m_skyDome->Set_RenderMgr(m_renderMgr);
    m_skyDome->ListenUpdateMgr(true);
    m_skyDome->ListenRenderMgr(true);
}

void iGaiaSceneGraph::PushParticleEmitter(iGaiaParticleEmitter* _particleEmitter)
{
    set<iGaiaParticleEmitter*>::iterator iterator = m_particleEmitters.find(_particleEmitter);
    if(iterator != m_particleEmitters.end())
    {
        // TODO : log
        return;
    }
    
    iGaiaParticleEmitter* particleEmitter = _particleEmitter;
    m_particleEmitters.insert(particleEmitter);
    particleEmitter->Set_Camera(m_camera);
    particleEmitter->Set_Light(m_light);
    particleEmitter->Set_UpdateMgr(m_updateMgr);
    particleEmitter->Set_RenderMgr(m_renderMgr);
    particleEmitter->ListenUpdateMgr(true);
    particleEmitter->ListenRenderMgr(true);
}

void iGaiaSceneGraph::PopShape3d(iGaiaShape3d* _shape3d)
{
    iGaiaShape3d* shape3d = _shape3d;
    shape3d->ListenUpdateMgr(false);
    shape3d->ListenRenderMgr(false);
    m_shapes3d.erase(shape3d);
}

void iGaiaSceneGraph::PopParticleEmitter(iGaiaParticleEmitter* _particleEmitter)
{
    iGaiaParticleEmitter* particleEmitter = _particleEmitter;
    particleEmitter->ListenUpdateMgr(false);
    particleEmitter->ListenRenderMgr(false);
    m_particleEmitters.erase(particleEmitter);
}



