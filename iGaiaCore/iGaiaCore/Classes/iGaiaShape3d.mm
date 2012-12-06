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
    m_crossingVertexData = nullptr;
    m_crossingIndexData = nullptr;
    
    m_crossingNumVertexes = 0;
    m_crossingNumIndexes = 0;
    
    m_mesh = static_cast<iGaiaMesh*>(iGaiaResourceMgr::SharedInstance()->LoadResourceSync(_name));
    
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
        iGaiaResourceMgr::SharedInstance()->LoadResourceSync(_name);
    }
}

void iGaiaShape3d::Set_Clipping(const glm::vec4& _clipping)
{
    m_material->Set_Clipping(_clipping);
}

iGaiaVertexBufferObject::iGaiaVertex* iGaiaShape3d::Get_CrossOperationVertexData(void)
{
    iGaiaVertexBufferObject::iGaiaVertex* vertexData = m_mesh->Get_VertexBuffer()->Lock();
    for(ui32 i = 0; i < m_mesh->Get_NumVertexes(); ++i)
    {
        vec4 position = vec4(vertexData[i].m_position.x, vertexData[i].m_position.y, vertexData[i].m_position.z, 1.0f);
        position = m_worldMatrix * position;
        m_crossingVertexData[i].m_position = glm::vec3(position.x, position.y, position.z);
    }
    return m_crossingVertexData;
}

ui16* iGaiaShape3d::Get_CrossOperationIndexData(void)
{
    return m_crossingIndexData = m_mesh->Get_IndexBuffer()->Lock();
}

ui32 iGaiaShape3d::Get_CrossOperationNumVertexes(void)
{
    return m_crossingNumVertexes = m_mesh->Get_NumVertexes();
}

ui32 iGaiaShape3d::Get_CrossOperationNumIndexes(void)
{
    return m_crossingNumIndexes = m_mesh->Get_NumIndexes();
}

void iGaiaShape3d::OnLoad(iGaiaResource *_resource)
{
    if(_resource->Get_ResourceType() == iGaiaResource::iGaia_E_ResourceTypeMesh)
    {
        m_mesh = static_cast<iGaiaMesh*>(_resource);
        if(m_crossingVertexData != nullptr)
        {
            delete m_crossingVertexData;
        }
        m_crossingVertexData = new iGaiaVertexBufferObject::iGaiaVertex[m_mesh->Get_NumVertexes()];
    }
}

void iGaiaShape3d::OnCross(void)
{
    
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
        case iGaiaMaterial::iGaia_E_RenderModeWorldSpaceSimple:
        {
            if(m_material->Get_OperatingShader() == nil)
            {
                iGaiaLog(@"Shader MODE_SIMPLE == nil");
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
                iGaiaLog(@"Shader MODE_REFLECTION == nil");
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
                iGaiaLog(@"Shader MODE_REFRACTION == nil");
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
