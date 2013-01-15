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

iGaiaLandscape::iGaiaLandscape(iGaiaResourceMgr* _resourceMgr, iGaiaLandscapeSettings const& _settings)
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

    iGaiaObject3d::ApplyObject3dSettings(_resourceMgr, _settings);

    m_quadTree = new iGaiaQuadTreeObject3d();
    m_quadTree->BuildRoot(vertexBuffer, indexBuffer, m_mesh->Get_MaxBound(), m_mesh->Get_MinBound(), 2, m_width);

    m_heightmapTexture = iGaiaLandscapeHeightmapTextureProcessorHelper::CreateTexture(m_heightmapData, m_width, m_height, m_scaleFactor, m_maxAltitude);
    m_splattingTexture = iGaiaLandscapeSplattingTextureProcessorHelper::CreateTexture(m_heightmapData, m_width, m_height, m_scaleFactor, 0.0f, 0.1f, 1.0f);
}

iGaiaLandscape::~iGaiaLandscape(void)
{
    
}

void iGaiaLandscape::Set_Clipping(vec4 const& _clipping, ui32 _renderMode)
{
    assert(m_materials.find(_renderMode) != m_materials.end());
    iGaiaMaterial* material = m_materials.find(_renderMode)->second;
    material->Set_Clipping(_clipping);
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

void iGaiaLandscape::Update_Receiver(f32 _deltaTime)
{
    m_quadTree->Update(m_camera->Get_Frustum());
    iGaiaObject3d::Update_Receiver(_deltaTime);
}

void iGaiaLandscape::Bind_Receiver(ui32 _mode)
{
    iGaiaObject3d::Bind_Receiver(_mode);
}

void iGaiaLandscape::Unbind_Receiver(ui32 _mode)
{
    iGaiaObject3d::Unbind_Receiver(_mode);
}

void iGaiaLandscape::Draw_Receiver(ui32 _mode)
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
            shader->Set_Vector4(material->Get_Clipping(), iGaiaShader::iGaia_E_ShaderAttributePlaneClipping);
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
        case iGaiaMaterial::RenderModeWorldSpace ::Refraction :
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
