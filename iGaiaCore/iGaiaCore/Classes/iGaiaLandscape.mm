//
//  iGaiaLandscape.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/13/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaLandscape.h"
#include "iGaiaLogger.h"
#include "iGaiaLandscapeHeightmapTextureProcessorHelper.h"
#include "iGaiaLandscapeSplattingTextureProcessorHelper.h"

static ui32 kiGaiaLandscapeRenderPriority = 3;

iGaiaLandscape::iGaiaLandscape(const iGaiaLandscapeSettings& _settings)
{

    m_width = _settings.m_width;
    m_height = _settings.m_height;
    m_scaleFactor = _settings.m_scaleFactor;

// TODO : remove after texture heightmap implementation
    m_heightmapData = new f32[m_width * m_height];
    m_maxAltitude = 0.0f;
    for(ui32 i = 0; i < m_width;++i)
    {
        for(ui32 j = 0; j < m_height;++j)
        {
            m_heightmapData[i + j * m_height] = (sin(i * 0.33f) / 2.0f + cos(j * 0.33f) / 2.0f) * 2.0f;
            if(fabsf(m_heightmapData[i +j * m_height]) > m_maxAltitude)
            {
                m_maxAltitude = fabsf(m_heightmapData[i +j * m_height]);
            }
        }
    }

    iGaiaVertexBufferObject* vertexBuffer = new iGaiaVertexBufferObject(m_width * m_height, GL_STATIC_DRAW);
    iGaiaVertexBufferObject::iGaiaVertex* vertexData = vertexBuffer->Lock();
    
    ui32 index = 0;
    for(ui32 i = 0; i < m_width;++i)
    {
        for(ui32 j = 0; j < m_height;++j)
        {
            vertexData[index].m_position.x = i;
            vertexData[index].m_position.y = m_heightmapData[i + j * m_height];
            vertexData[index].m_position.z = j;
            
            vertexData[index].m_texcoord.x = i / static_cast<f32>(m_width);
            vertexData[index].m_texcoord.y = j / static_cast<f32>(m_height);
            ++index;
        }
    }
    vertexBuffer->Unlock();
    
    iGaiaIndexBufferObject* indexBuffer = new iGaiaIndexBufferObject((m_width - 1) * (m_height - 1) * 6, GL_STATIC_DRAW);
    ui16* indexData = indexBuffer->Lock();
    
    index = 0;
    for(ui32 i = 0; i < (m_width - 1); ++i)
    {
        for(ui32 j = 0; j < (m_height - 1); ++j)
        {
            indexData[index] = i + j * m_width;
            index++;
            indexData[index] = i + (j + 1) * m_width;
            index++;
            indexData[index] = i + 1 + j * m_width;
            index++;
            
            indexData[index] = i + (j + 1) * m_width;
            index++;
            indexData[index] = i + 1 + (j + 1) * m_width;
            index++;
            indexData[index] = i + 1 + j * m_width;
            index++;
        }
    }
    
    indexBuffer->Unlock();
    
    m_mesh = new iGaiaMesh(vertexBuffer, indexBuffer, "igaia.mesh.landscape", iGaiaResource::iGaia_E_CreationModeCustom);
    
    m_quadTree = new iGaiaQuadTreeObject3d();
    m_quadTree->BuildRoot(vertexBuffer, indexBuffer, m_mesh->Get_MaxBound(), m_mesh->Get_MinBound(), 2, m_width);
    
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
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateBlendMode, false);
    m_material->Set_CullFaceMode(GL_FRONT);
    m_material->Set_BlendFunctionSource(GL_SRC_ALPHA);
    m_material->Set_BlendFunctionDest(GL_ONE_MINUS_SRC_ALPHA);

    m_heightmapTexture = iGaiaLandscapeHeightmapTextureProcessorHelper::CreateTexture(m_heightmapData, m_width, m_height, m_scaleFactor, m_maxAltitude);
    m_splattingTexture = iGaiaLandscapeSplattingTextureProcessorHelper::CreateTexture(m_heightmapData, m_width, m_height, m_scaleFactor, 0.0f, 0.1f, 1.0f);
    
    m_updateMode = iGaia_E_UpdateModeSync;
}

iGaiaLandscape::~iGaiaLandscape(void)
{
    
}

void iGaiaLandscape::Set_Clipping(const glm::vec4& _clipping)
{
    m_material->Set_Clipping(_clipping);
}

iGaiaTexture* iGaiaLandscape::Get_HeightmapTexture(void)
{
    return m_heightmapTexture;
}

iGaiaTexture* iGaiaLandscape::Get_SplattingTexture(void)
{
    return m_splattingTexture;
}

ui32 iGaiaLandscape::Get_Width(void)
{
    return m_width;
}

ui32 iGaiaLandscape::Get_Height(void)
{
    return m_height;
}

f32* iGaiaLandscape::Get_HeightmapData(void)
{
    return m_heightmapData;
}

vec2 iGaiaLandscape::Get_ScaleFactor(void)
{
    return m_scaleFactor;
}

void iGaiaLandscape::OnUpdate(void)
{
    m_quadTree->Update(m_camera->Get_Frustum());
    iGaiaObject3d::OnUpdate();
}

ui32 iGaiaLandscape::OnDrawIndex(void)
{
    return kiGaiaLandscapeRenderPriority;
}

void iGaiaLandscape::OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    iGaiaObject3d::OnBind(_mode);
}

void iGaiaLandscape::OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    iGaiaObject3d::OnUnbind(_mode);
}

void iGaiaLandscape::OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
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
            glm::vec4 clipping = m_material->Get_Clipping();
            m_material->Get_OperatingShader()->Set_Vector4(clipping, iGaiaShader::iGaia_E_ShaderAttributePlaneClipping);
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
