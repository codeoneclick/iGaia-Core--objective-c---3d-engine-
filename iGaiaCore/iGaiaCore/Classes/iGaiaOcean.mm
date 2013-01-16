//
//  iGaiaOcean.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaOcean.h"
#import "iGaiaLogger.h"

static ui32 kiGaiaOceanRenderPriority = 6;

iGaiaOcean::iGaiaOcean(iGaiaResourceMgr* _resourceMgr, iGaiaSettingsProvider::OceanSettings const& _settings)
{
    m_width = _settings.m_width;
    m_height = _settings.m_height;
    m_altitude = _settings.m_altitude;

    iGaiaVertexBufferObject* vertexBuffer = new iGaiaVertexBufferObject(4, GL_STATIC_DRAW);
    iGaiaVertexBufferObject::iGaiaVertex* vertexData = vertexBuffer->Lock();

    vertexData[0].m_position = vec3(0.0f,  _settings.m_altitude,  0.0f);
    vertexData[1].m_position = vec3(m_width, _settings.m_altitude,  0.0f);
    vertexData[2].m_position = vec3(m_width, _settings.m_altitude,  m_height);
    vertexData[3].m_position = vec3(0.0f,  _settings.m_altitude,  m_height);

    vertexData[0].m_texcoord = vec2(0.0f,  0.0f);
    vertexData[1].m_texcoord = vec2(1.0f,  0.0f);
    vertexData[2].m_texcoord = vec2(1.0f,  1.0f);
    vertexData[3].m_texcoord = vec2(0.0f,  1.0f);

    vertexBuffer->Unlock();

    iGaiaIndexBufferObject* indexBuffer = new iGaiaIndexBufferObject(6, GL_STATIC_DRAW); 
    ui16* indexData = indexBuffer->Lock();

    indexData[0] = 0;
    indexData[1] = 1;
    indexData[2] = 2;
    indexData[3] = 0;
    indexData[4] = 2;
    indexData[5] = 3;

    indexBuffer->Unlock();

    m_mesh = new iGaiaMesh(vertexBuffer, indexBuffer, "igaia.mesh.ocean", iGaiaResource::iGaia_E_CreationModeCustom);

    iGaiaObject3d::ApplyObject3dSettings(_resourceMgr, _settings);

    m_waveGeneratorTimer = 0.0f;
    m_waveGeneratorInterval = 0.005f;
}

iGaiaOcean::~iGaiaOcean(void)
{

}

void iGaiaOcean::Set_ReflectionTexture(iGaiaTexture* _texture, ui32 _renderMode)
{
    assert(m_materials.find(_renderMode) != m_materials.end());
    iGaiaMaterial* material = m_materials.find(_renderMode)->second;
    material->Set_Texture(_texture, iGaiaShader::iGaia_E_ShaderTextureSlot_01);
}

void iGaiaOcean::Set_RefractionTexture(iGaiaTexture* _texture, ui32 _renderMode)
{
    assert(m_materials.find(_renderMode) != m_materials.end());
    iGaiaMaterial* material = m_materials.find(_renderMode)->second;
    material->Set_Texture(_texture, iGaiaShader::iGaia_E_ShaderTextureSlot_01);
}

void iGaiaOcean::Set_HeightmapTexture(iGaiaTexture *_texture, ui32 _renderMode)
{
    assert(m_materials.find(_renderMode) != m_materials.end());
    iGaiaMaterial* material = m_materials.find(_renderMode)->second;
    material->Set_Texture(_texture, iGaiaShader::iGaia_E_ShaderTextureSlot_01);
}

f32 iGaiaOcean::Get_Altitude(void)
{
    return m_altitude + 0.1f;
}

void iGaiaOcean::Update_Receiver(f32 _deltaTime)
{
    m_waveGeneratorTimer += m_waveGeneratorInterval;
    iGaiaObject3d::Update_Receiver(_deltaTime);
}

void iGaiaOcean::Bind_Receiver(ui32 _mode)
{
    iGaiaObject3d::Bind_Receiver(_mode);
}

void iGaiaOcean::Unbind_Receiver(ui32 _mode)
{
    iGaiaObject3d::Unbind_Receiver(_mode);
}

void iGaiaOcean::Draw_Receiver(ui32 _mode)
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
            shader->Set_FloatCustom(m_waveGeneratorTimer, "EXT_Timer");
        }
            break;
        default:
            break;
    }

    glDrawElements(GL_TRIANGLES, m_mesh->Get_NumIndexes(), GL_UNSIGNED_SHORT, NULL);
}
