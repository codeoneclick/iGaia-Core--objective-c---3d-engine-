//
//  iGaiaShape3d.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaShape3d.h"
#import "iGaiaLogger.h"
#import "iGaiaResourceMgr.h"

static ui32 kiGaiaShape3dRenderPriority = 5;

iGaiaShape3d::iGaiaShape3d(const iGaiaShape3dSettings& _settings)
{
    m_mesh = iGaiaResourceMgr::SharedInstance()->Get_Mesh(_settings.m_meshName);

    for(ui32 i = 0; i < _settings.m_textures.size(); ++i)
    {
        iGaiaObject3dTextureSettings textureSettings = _settings.m_textures[i];
        Set_Texture(textureSettings.m_name, textureSettings.m_slot, textureSettings.m_wrap);
    }

    for(ui32 i = 0; i < _settings.m_shaders.size(); ++i)
    {
        iGaiaObject3dShaderSettings shaderSettings = _settings.m_shaders[i];
        Set_Shader(shaderSettings.m_shader, shaderSettings.m_mode);
    }
    
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateCullMode, true);
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateDepthMask, true);
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateDepthTest, true);
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateBlendMode, true);
    m_material->Set_CullFaceMode(GL_FRONT);
    m_material->Set_BlendFunctionSource(GL_SRC_ALPHA);
    m_material->Set_BlendFunctionDest(GL_ONE_MINUS_SRC_ALPHA);
    
    m_updateMode = iGaia_E_UpdateModeAsync;
}

iGaiaShape3d::~iGaiaShape3d(void)
{
    
}

void iGaiaShape3d::Set_Mesh(const string& _name)
{
    if(m_mesh == nullptr)
    {
         m_mesh = iGaiaResourceMgr::SharedInstance()->Get_Mesh(_name);
    }
}

void iGaiaShape3d::Set_Clipping(const glm::vec4& _clipping)
{
    m_material->Set_Clipping(_clipping);
}

void iGaiaShape3d::OnUpdate(void)
{
    iGaiaObject3d::OnUpdate();
}

void iGaiaShape3d::OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    iGaiaObject3d::OnBind(_mode);
}

void iGaiaShape3d::OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    iGaiaObject3d::OnUnbind(_mode);
}

ui32 iGaiaShape3d::OnDrawIndex(void)
{
    return kiGaiaShape3dRenderPriority;
}

void iGaiaShape3d::OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    iGaiaObject3d::OnDraw(_mode);
    
    switch (_mode)
    {
        case iGaiaMaterial::iGaia_E_RenderModeWorldSpaceCommon:
        {
            if(m_material->Get_OperatingShader() == nil)
            {
                iGaiaLog("Shader MODE_SIMPLE == nil");
            }
            
            m_material->Get_OperatingShader()->Set_Matrix4x4(m_worldMatrix, iGaiaShader::iGaia_E_ShaderAttributeMatrixWorld);
            m_material->Get_OperatingShader()->Set_Matrix4x4(m_camera->Get_ProjectionMatrix(), iGaiaShader::iGaia_E_ShaderAttributeMatrixProjection);
            m_material->Get_OperatingShader()->Set_Matrix4x4(m_camera->Get_ViewMatrix(), iGaiaShader::iGaia_E_ShaderAttributeMatrixView);
            
            m_material->Get_OperatingShader()->Set_Vector3(m_camera->Get_Position(), iGaiaShader::iGaia_E_ShaderAttributeVectorEyePosition);
            m_material->Get_OperatingShader()->Set_Vector3(m_light->Get_Position(), iGaiaShader::iGaia_E_ShaderAttributeVectorLightPosition);
        }
            break;
        case iGaiaMaterial::iGaia_E_RenderModeWorldSpaceReflection:
        {
            if(m_material->Get_OperatingShader() == nil)
            {
                iGaiaLog("Shader MODE_REFLECTION == nil");
            }
            
            m_material->Get_OperatingShader()->Set_Matrix4x4(m_worldMatrix, iGaiaShader::iGaia_E_ShaderAttributeMatrixWorld);
            m_material->Get_OperatingShader()->Set_Matrix4x4(m_camera->Get_ProjectionMatrix(), iGaiaShader::iGaia_E_ShaderAttributeMatrixProjection);
            m_material->Get_OperatingShader()->Set_Matrix4x4(m_camera->Get_ViewReflectionMatrix(), iGaiaShader::iGaia_E_ShaderAttributeMatrixView);
            
            m_material->Get_OperatingShader()->Set_Vector3(m_camera->Get_Position(), iGaiaShader::iGaia_E_ShaderAttributeVectorEyePosition);
            m_material->Get_OperatingShader()->Set_Vector3(m_light->Get_Position(), iGaiaShader::iGaia_E_ShaderAttributeVectorLightPosition);
            vec4 clipping = m_material->Get_Clipping();
            m_material->Get_OperatingShader()->Set_Vector4(clipping, iGaiaShader::iGaia_E_ShaderAttributePlaneClipping);
        }
            break;
        case iGaiaMaterial::iGaia_E_RenderModeWorldSpaceRefraction:
        {
            if(m_material->Get_OperatingShader() == nil)
            {
                iGaiaLog("Shader MODE_REFRACTION == nil");
            }
            
            m_material->Get_OperatingShader()->Set_Matrix4x4(m_worldMatrix, iGaiaShader::iGaia_E_ShaderAttributeMatrixWorld);
            m_material->Get_OperatingShader()->Set_Matrix4x4(m_camera->Get_ProjectionMatrix(), iGaiaShader::iGaia_E_ShaderAttributeMatrixProjection);
            m_material->Get_OperatingShader()->Set_Matrix4x4(m_camera->Get_ViewMatrix(), iGaiaShader::iGaia_E_ShaderAttributeMatrixView);
            
            m_material->Get_OperatingShader()->Set_Vector3(m_camera->Get_Position(), iGaiaShader::iGaia_E_ShaderAttributeVectorEyePosition);
            m_material->Get_OperatingShader()->Set_Vector3(m_light->Get_Position(), iGaiaShader::iGaia_E_ShaderAttributeVectorLightPosition);
            glm::vec4 clipping = m_material->Get_Clipping();
            clipping.y *= -1.0f;
            m_material->Get_OperatingShader()->Set_Vector4(clipping, iGaiaShader::iGaia_E_ShaderAttributePlaneClipping);
        }
            break;
        case iGaiaMaterial::iGaia_E_RenderModeWorldSpaceScreenNormalMap:
        {
        }
            break;
        default:
            break;
    }
    
    glDrawElements(GL_TRIANGLES, m_mesh->Get_NumIndexes(), GL_UNSIGNED_SHORT, NULL);
}
