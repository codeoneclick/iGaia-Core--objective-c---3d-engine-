//
//  iGaiaShaderComposite.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaShaderMgr.h"
#include "iGaiaLoader_GLSL.h"

iGaiaShaderMgr::iGaiaShaderMgr(void)
{

}

iGaiaShaderMgr::~iGaiaShaderMgr(void)
{

}

iGaiaShader* iGaiaShaderMgr::Get_Shader(string const& _vsName, string const& _fsName)
{
    string shaderKey(_vsName);
    shaderKey.append(_fsName);

    iGaiaShader* shader = nullptr;
    
    if(m_shadersContainer.find(shaderKey) == m_shadersContainer.end())
    {
        iGaiaLoader_GLSL loader;
        shader = loader.LoadShader(_vsName, _fsName);
        m_shadersContainer.insert(make_pair(shaderKey, shader));
    }
    else
    {
        shader = m_shadersContainer.find(shaderKey)->second;
    }
    return shader;
}

