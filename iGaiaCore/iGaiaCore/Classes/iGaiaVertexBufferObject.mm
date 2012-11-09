//
//  iGaiaVertexBufferObject.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaVertexBufferObject.h"


iGaiaVertexBufferObject::iGaiaVertexBufferObject(ui32 _numVertexes, GLenum _mode)
{
    m_mode = _mode;
    m_numVertexes = _numVertexes;
    m_data = new iGaiaVertex[m_numVertexes];
    glGenBuffers(1, &m_handle);
}

iGaiaVertexBufferObject::~iGaiaVertexBufferObject(void)
{
    delete [] m_data;
    glDeleteBuffers(1, &m_handle);
    m_handle = NULL;
}

u8vec4 iGaiaVertexBufferObject::CompressVec3(const vec3 &_uncompressed)
{
    vec3 normalized = normalize(_uncompressed);
    u8vec4 compressed;
    compressed.x = static_cast<unsigned char>((normalized.x + 1.0f) * 0.5f * 255.0f);
    compressed.y = static_cast<unsigned char>((normalized.y + 1.0f) * 0.5f * 255.0f);
    compressed.z = static_cast<unsigned char>((normalized.z + 1.0f) * 0.5f * 255.0f);
    compressed.w = 0;
    return compressed;
}

vec3 iGaiaVertexBufferObject::UncompressU8Vec4(const u8vec4 &_compressed)
{
    glm::vec3 uncompressed;
    uncompressed.x = static_cast<float>(_compressed.x / (255.0f * 0.5f) - 1.0f);
    uncompressed.y = static_cast<float>(_compressed.y / (255.0f * 0.5f) - 1.0f);
    uncompressed.z = static_cast<float>(_compressed.z / (255.0f * 0.5f) - 1.0f);
    return uncompressed;
}

inline ui32 iGaiaVertexBufferObject::Get_NumVertexes(void)
{
    return m_numVertexes;
}

inline iGaiaVertexBufferObject::iGaiaVertex* iGaiaVertexBufferObject::Lock(void)
{
    return m_data;
}

inline void iGaiaVertexBufferObject::Set_OperatingShader(iGaiaShader *_shader)
{
    m_operatingShader = _shader;
}

inline void iGaiaVertexBufferObject::Unlock(void)
{
    glBindBuffer(GL_ARRAY_BUFFER, m_handle);
    glBufferData(GL_ARRAY_BUFFER, sizeof(iGaiaVertex) * m_numVertexes, m_data, m_mode);
}

void iGaiaVertexBufferObject::Bind(void)
{
    glBindBuffer(GL_ARRAY_BUFFER, m_handle);
    ui32 bytesPerVertex = 0;
    i32 slot = m_operatingShader->Get_VertexSlotHandle(iGaiaShader::iGaia_E_ShaderVertexSlotPosition);
    if(slot >= 0)
    {
        glEnableVertexAttribArray(slot);
        glVertexAttribPointer(slot, 3, GL_FLOAT, GL_FALSE, sizeof(iGaiaVertex), (GLvoid*)bytesPerVertex);
    }
    bytesPerVertex += sizeof(vec3);
    slot = m_operatingShader->Get_VertexSlotHandle(iGaiaShader::iGaia_E_ShaderVertexSlotTexcoord);
    if(slot >= 0)
    {
        glEnableVertexAttribArray(slot);
        glVertexAttribPointer(slot, 2, GL_FLOAT, GL_FALSE, sizeof(iGaiaVertex), (GLvoid*)bytesPerVertex);
    }
    bytesPerVertex += sizeof(vec2);
    slot = m_operatingShader->Get_VertexSlotHandle(iGaiaShader::iGaia_E_ShaderVertexSlotNormal);
    if(slot >= 0)
    {
        glEnableVertexAttribArray(slot);
        glVertexAttribPointer(slot, 4, GL_UNSIGNED_BYTE, GL_FALSE, sizeof(iGaiaVertex), (GLvoid*)bytesPerVertex);
    }
    bytesPerVertex += sizeof(u8vec4);
    slot = m_operatingShader->Get_VertexSlotHandle(iGaiaShader::iGaia_E_ShaderVertexSlotTangent);
    if(slot >= 0)
    {
        glEnableVertexAttribArray(slot);
        glVertexAttribPointer(slot, 4, GL_UNSIGNED_BYTE, GL_FALSE, sizeof(iGaiaVertex), (GLvoid*)bytesPerVertex);
    }
    bytesPerVertex += sizeof(u8vec4);
    slot = m_operatingShader->Get_VertexSlotHandle(iGaiaShader::iGaia_E_ShaderVertexSlotColor);
    if(slot >= 0)
    {
        glEnableVertexAttribArray(slot);
        glVertexAttribPointer(slot, 4, GL_UNSIGNED_BYTE, GL_FALSE, sizeof(iGaiaVertex), (GLvoid*)bytesPerVertex);
    }
}

void iGaiaVertexBufferObject::Unbind(void)
{
    glBindBuffer(GL_ARRAY_BUFFER, m_handle);
    GLint slot = m_operatingShader->Get_VertexSlotHandle(iGaiaShader::iGaia_E_ShaderVertexSlotPosition);
    if(slot >= 0)
    {
        glDisableVertexAttribArray(slot);
    }
    slot = m_operatingShader->Get_VertexSlotHandle(iGaiaShader::iGaia_E_ShaderVertexSlotTexcoord);
    if(slot >= 0)
    {
        glDisableVertexAttribArray(slot);
    }
    slot = m_operatingShader->Get_VertexSlotHandle(iGaiaShader::iGaia_E_ShaderVertexSlotNormal);
    if(slot >= 0)
    {
        glDisableVertexAttribArray(slot);
    }
    slot = m_operatingShader->Get_VertexSlotHandle(iGaiaShader::iGaia_E_ShaderVertexSlotTangent);
    if(slot >= 0)
    {
        glDisableVertexAttribArray(slot);
    }
    slot = m_operatingShader->Get_VertexSlotHandle(iGaiaShader::iGaia_E_ShaderVertexSlotColor);
    if(slot >= 0)
    {
        glDisableVertexAttribArray(slot);
    }
    glBindBuffer(GL_ARRAY_BUFFER, NULL);
}

