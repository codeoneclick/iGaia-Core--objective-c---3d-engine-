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
}

iGaiaResourceMgr::~iGaiaResourceMgr(void)
{

}

iGaiaShader* iGaiaResourceMgr::Get_Shader(string const& _vsName, string const& _fsName)
{
    return m_shaderMgr->Get_Shader(_vsName, _fsName);
}

iGaiaTexture* iGaiaResourceMgr::Get_Texture(const string& _name)
{
    return m_textureMgr->Get_Texture(_name);
}

iGaiaMesh* iGaiaResourceMgr::Get_Mesh(const string& _name)
{
    return m_meshMgr->Get_Mesh(_name);
}

