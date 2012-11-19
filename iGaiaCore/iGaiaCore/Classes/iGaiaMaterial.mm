//
//  iGaiaMaterial.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaMaterial.h"
#import "iGaiaRenderCallback.h"
#import "iGaiaShaderComposite.h"
#import "iGaiaResourceMgr.h"
#import "iGaiaLogger.h"

iGaiaMaterial::iGaiaMaterial(void)
{
    for(ui32 i = 0; i < iGaia_E_RenderModeWorldSpaceMaxValue + iGaia_E_RenderModeScreenSpaceMaxValue; ++i)
    {
        m_shaders[i] = nullptr;
    }
    for(NSUInteger i = 0; i < iGaiaShader::iGaia_E_ShaderTextureSlotMaxValue; ++i)
    {
        m_textures[i] = nullptr;
    }

    m_states[iGaia_E_RenderStateDepthMask] = YES;
    m_states[iGaia_E_RenderStateDepthTest] = YES;
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

void iGaiaMaterial::Set_BlendFunctionDest(GLenum _blendFunction)
{
    m_blendFunctionDest = _blendFunction;
}

void iGaiaMaterial::Set_Clipping(const vec4& _clipping)
{
    m_clipping = _clipping;
}

vec4 iGaiaMaterial::Get_Clipping(void)
{
    return m_clipping;
}

void iGaiaMaterial::Set_OperatingShader(iGaiaShader* _shader)
{
    m_operatingShader = _shader;
}

iGaiaShader* iGaiaMaterial::Get_OperatingShader(void)
{
    return m_operatingShader;
}

void iGaiaMaterial::InvalidateState(iGaiaMaterial::iGaia_E_RenderState _state, bool _value)
{
    m_states[_state] = _value;
}

void iGaiaMaterial::Set_Shader(iGaiaShader::iGaia_E_Shader _shader, ui32 _mode)
{
    m_shaders[_mode] = iGaiaShaderComposite::SharedInstance()->Get_Shader(_shader);
}

void iGaiaMaterial::OnLoad(iGaiaResource *_resource)
{
    if(_resource->Get_ResourceType() == iGaiaResource::iGaia_E_ResourceTypeTexture)
    {
        iGaiaTexture* texture = static_cast<iGaiaTexture*>(_resource);
        for(ui32 i = 0; i < iGaiaShader::iGaia_E_ShaderTextureSlotMaxValue; ++i)
        {
            if(m_textures[i] != nullptr &&  m_textures[i]->Get_Name().compare(texture->Get_Name()) == 0)
            {
                texture->Set_Settings(m_textures[i]->Get_Settings());
                m_textures[i] = texture;
            }
        }
    }
}

void iGaiaMaterial::Set_Texture(iGaiaTexture *_texture, iGaiaShader::iGaia_E_ShaderTextureSlot _slot)
{
    m_textures[_slot] = _texture;
}

void iGaiaMaterial::Set_Texture(const string& _name, iGaiaShader::iGaia_E_ShaderTextureSlot _slot, iGaiaTexture::iGaia_E_TextureSettingsValue _wrap)
{
    m_textures[_slot] = static_cast<iGaiaTexture*>(iGaiaResourceMgr::SharedInstance()->LoadResourceAsync(_name, this));
    map<ui32, ui32> settings;
    settings[iGaiaTexture::iGaia_E_TextureSettingsKeyWrapMode] = _wrap;
    m_textures[_slot]->Set_Settings(settings);
}

void iGaiaMaterial::Bind(ui32 _mode)
{
    m_operatingShader =  m_shaders[_mode];
    if(m_operatingShader == nullptr)
    {
        iGaiaLog(@"State : %i not setted for current material.", _mode);
        return;
    }

    m_operatingShader->Bind();

    for(ui32 i = 0; i < iGaiaShader::iGaia_E_ShaderTextureSlotMaxValue; ++i)
    {
        if(m_textures[i] != nullptr)
        {
            m_operatingShader->Set_Texture(m_textures[i], static_cast<iGaiaShader::iGaia_E_ShaderTextureSlot>(i));
        }
    }

    if(m_states[iGaia_E_RenderStateDepthTest])
    {
        glEnable(GL_DEPTH_TEST);
    }
    else
    {
        glDisable(GL_DEPTH_TEST);
    }


    if(m_states[iGaia_E_RenderStateDepthMask])
    {
        glDepthMask(GL_TRUE);
    }
    else
    {
        glDepthMask(GL_FALSE);
    }

    if(m_states[iGaia_E_RenderStateCullMode])
    {
        glEnable(GL_CULL_FACE);
        glCullFace(m_cullFaceMode);
    }
    else
    {
        glDisable(GL_CULL_FACE);
    }

    if(m_states[iGaia_E_RenderStateBlendMode])
    {
        glEnable(GL_BLEND);
        glBlendFunc(m_blendFunctionSource, m_blendFunctionDest);
    }
    else
    {
        glDisable(GL_BLEND);
    }
}

void iGaiaMaterial::Unbind(ui32 _mode)
{
    m_operatingShader->Unbind();
}

