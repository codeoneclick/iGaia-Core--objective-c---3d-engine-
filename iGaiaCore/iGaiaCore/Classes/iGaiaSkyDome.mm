//
//  iGaiaSkyDome.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaSkyDome.h"
#import "iGaiaLogger.h"

static ui32 kiGaiaSkyDomeRenderPriority = 0;

iGaiaSkyDome::iGaiaSkyDome(iGaiaResourceMgr* _resourceMgr, iGaiaSkyDomeSettings const& _settings)
{
    iGaiaVertexBufferObject* vertexBuffer = new iGaiaVertexBufferObject(24, GL_STATIC_DRAW);
    iGaiaVertexBufferObject::iGaiaVertex* vertexData = vertexBuffer->Lock();
    
    vec3 minBound = vec3( -4.0f, -4.0f, -4.0f);
    vec3 maxBound = vec3(  4.0f,  4.0f,  4.0f);
    
    vertexData[0].m_position = vec3(minBound.x,  minBound.y, maxBound.z);
    vertexData[1].m_position = vec3(maxBound.x,  minBound.y, maxBound.z);
    vertexData[2].m_position = vec3(maxBound.x,  maxBound.y, maxBound.z);
    vertexData[3].m_position = vec3(minBound.x,  maxBound.y, maxBound.z);
    
    vertexData[4].m_position = vec3(minBound.x,  minBound.y,  minBound.z);
    vertexData[5].m_position = vec3(minBound.x,  maxBound.y,  minBound.z);
    vertexData[6].m_position = vec3(maxBound.x,  maxBound.y,  minBound.z);
    vertexData[7].m_position = vec3(maxBound.x,  minBound.y,  minBound.z);
    
    vertexData[8].m_position = vec3(minBound.x,  maxBound.y,  minBound.z);
    vertexData[9].m_position = vec3(minBound.x,  maxBound.y,  maxBound.z);
    vertexData[10].m_position = vec3(maxBound.x,  maxBound.y,  maxBound.z);
    vertexData[11].m_position = vec3(maxBound.x,  maxBound.y,  minBound.z);
    
    vertexData[12].m_position = vec3(minBound.x,  maxBound.y,  minBound.z);
    vertexData[13].m_position = vec3(maxBound.x,  maxBound.y,  minBound.z);
    vertexData[14].m_position = vec3(maxBound.x,  maxBound.y,  maxBound.z);
    vertexData[15].m_position = vec3(minBound.x,  maxBound.y,  maxBound.z);
    
    vertexData[16].m_position = vec3(maxBound.x,  minBound.y,  minBound.z);
    vertexData[17].m_position = vec3(maxBound.x,  maxBound.y,  minBound.z);
    vertexData[18].m_position = vec3(maxBound.x,  maxBound.y,  maxBound.z);
    vertexData[19].m_position = vec3(maxBound.x,  minBound.y,  maxBound.z);
    
    vertexData[20].m_position = vec3(minBound.x,  minBound.y,  minBound.z);
    vertexData[21].m_position = vec3(minBound.x,  minBound.y,  maxBound.z);
    vertexData[22].m_position = vec3(minBound.x,  maxBound.y,  maxBound.z);
    vertexData[23].m_position = vec3(minBound.x,  maxBound.y,  minBound.z);
    
    vertexData[0].m_texcoord = vec2(0.0f, 0.0f);
    vertexData[1].m_texcoord = vec2(1.0f, 0.0f);
    vertexData[2].m_texcoord = vec2(1.0f, 1.0f);
    vertexData[3].m_texcoord = vec2(0.0f, 1.0f);
    
    vertexData[4].m_texcoord = vec2(1.0f, 0.0f);
    vertexData[5].m_texcoord = vec2(1.0f, 1.0f);
    vertexData[6].m_texcoord = vec2(0.0f, 1.0f);
    vertexData[7].m_texcoord = vec2(0.0f, 0.0f);
    
    vertexData[8].m_texcoord = vec2(1.0f, 0.0f);
    vertexData[9].m_texcoord = vec2(1.0f, 1.0f);
    vertexData[10].m_texcoord = vec2(0.0f, 1.0f);
    vertexData[11].m_texcoord = vec2(0.0f, 0.0f);
    
    vertexData[12].m_texcoord = vec2(0.0f, 0.0f);
    vertexData[13].m_texcoord = vec2(1.0f, 0.0f);
    vertexData[14].m_texcoord = vec2(1.0f, 1.0f);
    vertexData[15].m_texcoord = vec2(0.0f, 1.0f);
    
    vertexData[16].m_texcoord = vec2(1.0f, 0.0f);
    vertexData[17].m_texcoord = vec2(1.0f, 1.0f);
    vertexData[18].m_texcoord = vec2(0.0f, 1.0f);
    vertexData[19].m_texcoord = vec2(0.0f, 0.0f);
    
    vertexData[20].m_texcoord = vec2(0.0f, 0.0f);
    vertexData[21].m_texcoord = vec2(1.0f, 0.0f);
    vertexData[22].m_texcoord = vec2(1.0f, 1.0f);
    vertexData[23].m_texcoord = vec2(0.0f, 1.0f);
    
    vertexBuffer->Unlock();
    
    iGaiaIndexBufferObject* indexBuffer = new iGaiaIndexBufferObject(36, GL_STATIC_DRAW);
    u16* indexData = indexBuffer->Lock(); 
    
    indexData[0] = 0;
    indexData[1] = 1;
    indexData[2] = 2;
    indexData[3] = 0;
    indexData[4] = 2;
    indexData[5] = 3;
    
    indexData[6] = 4;
    indexData[7] = 5;
    indexData[8] = 6;
    indexData[9] = 4;
    indexData[10] = 6;
    indexData[11] = 7;
    
    indexData[12] = 8;
    indexData[13] = 9;
    indexData[14] = 10;
    indexData[15] = 8;
    indexData[16] = 10;
    indexData[17] = 11;
    
    indexData[18] = 12;
    indexData[19] = 13;
    indexData[20] = 14;
    indexData[21] = 12;
    indexData[22] = 14;
    indexData[23] = 15;
    
    indexData[24] = 16;
    indexData[25] = 17;
    indexData[26] = 18;
    indexData[27] = 16;
    indexData[28] = 18;
    indexData[29] = 19;
    
    indexData[30] = 20;
    indexData[31] = 21;
    indexData[32] = 22;
    indexData[33] = 20;
    indexData[34] = 22;
    indexData[35] = 23;
    
    indexBuffer->Unlock(); 
    
    m_mesh = new iGaiaMesh(vertexBuffer, indexBuffer,"igaia.mesh.skydome", iGaiaResource::iGaia_E_CreationModeCustom);
    iGaiaObject3d::ApplyObject3dSettings(_resourceMgr, _settings);
}

iGaiaSkyDome::~iGaiaSkyDome(void)
{
    
}

void iGaiaSkyDome::Update_Receiver(f32 _deltaTime)
{
    m_position = m_camera->Get_Position();
    iGaiaObject3d::Update_Receiver(_deltaTime);
}

void iGaiaSkyDome::Bind_Receiver(ui32 _mode)
{
    iGaiaObject3d::Bind_Receiver(_mode);
}

void iGaiaSkyDome::Unbind_Receiver(ui32 _mode)
{
    iGaiaObject3d::Unbind_Receiver(_mode);
}

void iGaiaSkyDome::Draw_Receiver(ui32 _mode)
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
        default:
            break;
    }
    glDrawElements(GL_TRIANGLES, m_mesh->Get_NumIndexes(), GL_UNSIGNED_SHORT, nullptr);
}
