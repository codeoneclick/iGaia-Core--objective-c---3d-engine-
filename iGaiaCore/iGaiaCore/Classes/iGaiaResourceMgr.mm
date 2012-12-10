//
//  iGaiaResourceMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaResourceMgr.h"

iGaiaResourceMgr::iGaiaResourceMgr(void)
{
    m_textureMgr = new iGaiaTextureMgr();
    m_meshMgr = new iGaiaMeshMgr();
    m_shaderMgr = new iGaiaShaderMgr();
    m_particleMgr = new iGaiaParticleMgr();
}

iGaiaResourceMgr::~iGaiaResourceMgr(void)
{

}

iGaiaResourceMgr* iGaiaResourceMgr::SharedInstance(void)
{
    static iGaiaResourceMgr *instance = nullptr;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        instance = new iGaiaResourceMgr();
    });
    return instance;
}

iGaiaShader* iGaiaResourceMgr::Get_Shader(iGaiaShader::iGaia_E_Shader _shader)
{
    return m_shaderMgr->Get_Shader(_shader);
}

iGaiaTexture* iGaiaResourceMgr::Get_Texture(const string& _name)
{
    return m_textureMgr->Get_Texture(_name);
}

iGaiaMesh* iGaiaResourceMgr::Get_Mesh(const string& _name)
{
    return m_meshMgr->Get_Mesh(_name);
}

iGaiaParticleEmitter::iGaiaParticleEmitterSettings iGaiaResourceMgr::Get_ParticleEmitterSettings(const string& _name)
{
    return m_particleMgr->Get_ParticleEmitterSettings(_name);
}


