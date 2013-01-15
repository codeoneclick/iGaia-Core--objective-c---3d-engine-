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

iGaiaShape3d::iGaiaShape3d(iGaiaResourceMgr* _resourceMgr, const iGaiaShape3dSettings& _settings)
{
    m_mesh = _resourceMgr->Get_Mesh(_settings.m_name);
    iGaiaObject3d::ApplyObject3dSettings(_resourceMgr, _settings);
}

iGaiaShape3d::~iGaiaShape3d(void)
{
    
}

void iGaiaShape3d::Set_Clipping(vec4 const& _clipping, ui32 _renderMode)
{
    assert(m_materials.find(_renderMode) != m_materials.end());
    iGaiaMaterial* material = m_materials.find(_renderMode)->second;
    material->Set_Clipping(_clipping);
}

void iGaiaShape3d::Update_Receiver(f32 _deltaTime)
{
    iGaiaObject3d::Update_Receiver(_deltaTime);
}

void iGaiaShape3d::Bind_Receiver(ui32 _mode)
{
    iGaiaObject3d::Bind_Receiver(_mode);
}

void iGaiaShape3d::Unbind_Receiver(ui32 _mode)
{
    iGaiaObject3d::Unbind_Receiver(_mode);
}

void iGaiaShape3d::Draw_Receiver(ui32 _mode)
{
    assert(m_materials.find(_mode) != m_materials.end());
    iGaiaMaterial* material = m_materials.find(_mode)->second;

    iGaiaObject3d::Draw_Receiver(_mode);

    switch (_mode)
    {
        case iGaiaMaterial::RenderModeWorldSpace::Common :
        {
            iGaiaShader* shader = material->Get_Shader();
            assert(shader != nullptr);

            shader->Set_Matrix4x4(m_worldMatrix, iGaiaShader::iGaia_E_ShaderAttributeMatrixWorld);
            shader->Set_Matrix4x4(m_camera->Get_ProjectionMatrix(), iGaiaShader::iGaia_E_ShaderAttributeMatrixProjection);
            shader->Set_Matrix4x4(m_camera->Get_ViewMatrix(), iGaiaShader::iGaia_E_ShaderAttributeMatrixView);

            shader->Set_Vector3(m_camera->Get_Position(), iGaiaShader::iGaia_E_ShaderAttributeVectorEyePosition);
            shader->Set_Vector3(m_light->Get_Position(), iGaiaShader::iGaia_E_ShaderAttributeVectorLightPosition);
        }
            break;
        case iGaiaMaterial::RenderModeWorldSpace::Reflection :
        {
            iGaiaShader* shader = material->Get_Shader();
            assert(shader != nullptr);

            shader->Set_Matrix4x4(m_worldMatrix, iGaiaShader::iGaia_E_ShaderAttributeMatrixWorld);
            shader->Set_Matrix4x4(m_camera->Get_ProjectionMatrix(), iGaiaShader::iGaia_E_ShaderAttributeMatrixProjection);
            shader->Set_Matrix4x4(m_camera->Get_ViewReflectionMatrix(), iGaiaShader::iGaia_E_ShaderAttributeMatrixView);

            shader->Set_Vector3(m_camera->Get_Position(), iGaiaShader::iGaia_E_ShaderAttributeVectorEyePosition);
            shader->Set_Vector3(m_light->Get_Position(), iGaiaShader::iGaia_E_ShaderAttributeVectorLightPosition);
            shader->Set_Vector4(material->Get_Clipping(), iGaiaShader::iGaia_E_ShaderAttributePlaneClipping);
        }
            break;
        case iGaiaMaterial::RenderModeWorldSpace::Refraction :
        {
            iGaiaShader* shader = material->Get_Shader();
            assert(shader != nullptr);

            shader->Set_Matrix4x4(m_worldMatrix, iGaiaShader::iGaia_E_ShaderAttributeMatrixWorld);
            shader->Set_Matrix4x4(m_camera->Get_ProjectionMatrix(), iGaiaShader::iGaia_E_ShaderAttributeMatrixProjection);
            shader->Set_Matrix4x4(m_camera->Get_ViewMatrix(), iGaiaShader::iGaia_E_ShaderAttributeMatrixView);

            shader->Set_Vector3(m_camera->Get_Position(), iGaiaShader::iGaia_E_ShaderAttributeVectorEyePosition);
            shader->Set_Vector3(m_light->Get_Position(), iGaiaShader::iGaia_E_ShaderAttributeVectorLightPosition);
            shader->Set_Vector4(material->Get_Clipping(), iGaiaShader::iGaia_E_ShaderAttributePlaneClipping);
        }
            break;
        default:
            break;
    }
    
    glDrawElements(GL_TRIANGLES, m_mesh->Get_NumIndexes(), GL_UNSIGNED_SHORT, NULL);
}
