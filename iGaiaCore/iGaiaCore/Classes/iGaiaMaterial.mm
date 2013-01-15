//
//  iGaiaMaterial.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaMaterial.h"
#import "iGaiaRenderCallback.h"
#import "iGaiaResourceMgr.h"
#import "iGaiaLogger.h"

iGaiaMaterial::iGaiaMaterial(void)
{
    m_shader = nullptr;
}

iGaiaMaterial::~iGaiaMaterial(void)
{
    
}

void iGaiaMaterial::Set_CullFaceMode(GLenum _mode)
{
    m_cullFaceMode = _mode;
}

void iGaiaMaterial::Set_BlendFunctionSource(GLenum _blendFunction)
{
    m_blendFunctionSource = _blendFunction;
}

void iGaiaMaterial::Set_BlendFunctionDestination(GLenum _blendFunction)
{
    m_blendFunctionDestination = _blendFunction;
}

void iGaiaMaterial::Set_Clipping(const vec4& _clipping)
{
    m_clipping = _clipping;
}

vec4 iGaiaMaterial::Get_Clipping(void)
{
    return m_clipping;
}

void iGaiaMaterial::Set_RenderState(iGaiaMaterial::RenderState _renderState, bool _value)
{
    m_states[_renderState] = _value;
}

void iGaiaMaterial::Set_Shader(iGaiaShader* _shader)
{
    m_shader = _shader;
}

iGaiaShader* iGaiaMaterial::Get_Shader(void)
{
    return m_shader;
}

void iGaiaMaterial::Set_Texture(iGaiaTexture *_texture, ui32 _slot)
{
    assert(_slot < iGaiaShader::iGaia_E_ShaderVertexSlotMaxValue);
    m_textures.insert(make_pair(_slot, _texture));
}

void iGaiaMaterial::Bind(void)
{
    assert(m_shader != nullptr);
    
    m_shader->Bind();

    for(ui32 i = 0; i < iGaiaShader::iGaia_E_ShaderTextureSlotMaxValue; ++i)
    {
        if(m_textures[i] != nullptr)
        {
            m_shader->Set_Texture(m_textures[i], static_cast<iGaiaShader::iGaia_E_ShaderTextureSlot>(i));
        }
    }

    if(m_states[RenderState::DepthTest])
    {
        glEnable(GL_DEPTH_TEST);
    }
    else
    {
        glDisable(GL_DEPTH_TEST);
    }


    if(m_states[RenderState::DepthMask])
    {
        glDepthMask(GL_TRUE);
    }
    else
    {
        glDepthMask(GL_FALSE);
    }

    if(m_states[RenderState::CullFace])
    {
        glEnable(GL_CULL_FACE);
        glCullFace(m_cullFaceMode);
    }
    else
    {
        glDisable(GL_CULL_FACE);
    }

    if(m_states[RenderState::Blend])
    {
        glEnable(GL_BLEND);
        glBlendFunc(m_blendFunctionSource, m_blendFunctionDestination);
    }
    else
    {
        glDisable(GL_BLEND);
    }
}

void iGaiaMaterial::Unbind(void)
{
    m_shader->Unbind();
}

