//
//  iGaiaVertexBufferObject.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaVertexBufferObject.h"

@interface iGaiaVertexBufferObject()
{
    iGaiaShader* _m_shaderReferences[777];
}

@property(nonatomic, assign) NSUInteger m_handle;
@property(nonatomic, assign) iGaiaVertex* m_data;
@property(nonatomic, assign) GLenum m_mode;

@end

@implementation iGaiaVertexBufferObject

@synthesize m_handle = _m_handle;
@synthesize m_data = _m_data;
@synthesize m_numVertexes = _m_numVertexes;
@synthesize m_mode = _m_mode;

+ (glm::u8vec4)compressVec3:(const glm::vec3&)uncopressed
{
    glm::vec3 normalized = glm::normalize(uncopressed);
    glm::u8vec4 compressed;
    compressed.x = static_cast<unsigned char>((normalized.x + 1.0f) * 0.5f * 255.0f);
    compressed.y = static_cast<unsigned char>((normalized.y + 1.0f) * 0.5f * 255.0f);
    compressed.z = static_cast<unsigned char>((normalized.z + 1.0f) * 0.5f * 255.0f);
    compressed.w = 0;
    return compressed;
}

+ (glm::vec3)uncompressU8Vec4:(const glm::u8vec4&)compressed
{
    glm::vec3 uncompressed;
    uncompressed.x = static_cast<float>(compressed.x / (255.0f * 0.5f) - 1.0f);
    uncompressed.y = static_cast<float>(compressed.y / (255.0f * 0.5f) - 1.0f);
    uncompressed.z = static_cast<float>(compressed.z / (255.0f * 0.5f) - 1.0f);
    return uncompressed;
}

- (id)initWithNumVertexes:(NSUInteger)numVertexes withMode:(GLenum)mode
{
    self = [super init];
    if(self)
    {
        _m_mode = mode;
        _m_numVertexes = numVertexes;
        _m_data = new iGaiaVertex[_m_numVertexes];
        glGenBuffers(1, &_m_handle);
    }
    return self;
}

- (void)unload
{
    delete [] _m_data;
    glDeleteBuffers(1, &_m_handle);
    _m_handle = NULL;
}

- (void)putShaderReference:(iGaiaShader*)shader withRenderMode:(NSUInteger)renderMode
{
    _m_shaderReferences[renderMode] = shader;
}

- (iGaiaVertex*)lock
{
    return _m_data;
}

- (void)unlock
{
    glBindBuffer(GL_ARRAY_BUFFER, _m_handle);
    glBufferData(GL_ARRAY_BUFFER, sizeof(iGaiaVertex) * _m_numVertexes, _m_data, _m_mode);
}

- (void)bindWithRenderMode:(NSUInteger)renderMode
{
    glBindBuffer(GL_ARRAY_BUFFER, _m_handle);
    iGaiaShader* shader = _m_shaderReferences[renderMode];
    unsigned int bytesPerVertex = 0;
    int slot = shader->Get_VertexSlot(CShader::E_VERTEX_SLOT_POSITION);
    if(slot >= 0)
    {
        glEnableVertexAttribArray(slot);
        glVertexAttribPointer(slot, 3, GL_FLOAT, GL_FALSE, sizeof(SVertex), (GLvoid*)bytesPerVertex);
    }
    bytesPerVertex += sizeof(glm::vec3);
    slot = shader->Get_VertexSlot(CShader::E_VERTEX_SLOT_TEXCOORD);
    if(slot >= 0)
    {
        glEnableVertexAttribArray(slot);
        glVertexAttribPointer(slot, 2, GL_FLOAT, GL_FALSE, sizeof(SVertex), (GLvoid*)bytesPerVertex);
    }
    bytesPerVertex += sizeof(glm::vec2);
    slot = shader->Get_VertexSlot(CShader::E_VERTEX_SLOT_NORMAL);
    if(slot >= 0)
    {
        glEnableVertexAttribArray(slot);
        glVertexAttribPointer(slot, 4, GL_UNSIGNED_BYTE, GL_FALSE, sizeof(SVertex), (GLvoid*)bytesPerVertex);
    }
    bytesPerVertex += sizeof(glm::u8vec4);
    slot = shader->Get_VertexSlot(CShader::E_VERTEX_SLOT_TANGENT);
    if(slot >= 0)
    {
        glEnableVertexAttribArray(slot);
        glVertexAttribPointer(slot, 4, GL_UNSIGNED_BYTE, GL_FALSE, sizeof(SVertex), (GLvoid*)bytesPerVertex);
    }
    bytesPerVertex += sizeof(glm::u8vec4);
    slot = shader->Get_VertexSlot(CShader::E_VERTEX_SLOT_COLOR);
    if(slot >= 0)
    {
        glEnableVertexAttribArray(slot);
        glVertexAttribPointer(slot, 4, GL_UNSIGNED_BYTE, GL_FALSE, sizeof(SVertex), (GLvoid*)bytesPerVertex);
    }
}

- (void)unbindWithRenderMode:(NSUInteger)renderMode
{
    glBindBuffer(GL_ARRAY_BUFFER, m_handle);
    CShader* shader = m_shaderReferences[_renderMode];
    GLint slot = shader->Get_VertexSlot(CShader::E_VERTEX_SLOT_POSITION);
    if(slot >= 0)
    {
        glDisableVertexAttribArray(slot);
    }
    slot = shader->Get_VertexSlot(CShader::E_VERTEX_SLOT_TEXCOORD);
    if(slot >= 0)
    {
        glDisableVertexAttribArray(slot);
    }
    slot = shader->Get_VertexSlot(CShader::E_VERTEX_SLOT_NORMAL);
    if(slot >= 0)
    {
        glDisableVertexAttribArray(slot);
    }
    slot = shader->Get_VertexSlot(CShader::E_VERTEX_SLOT_TANGENT);
    if(slot >= 0)
    {
        glDisableVertexAttribArray(slot);
    }
    slot = shader->Get_VertexSlot(CShader::E_VERTEX_SLOT_COLOR);
    if(slot >= 0)
    {
        glDisableVertexAttribArray(slot);
    }
    glBindBuffer(GL_ARRAY_BUFFER, NULL);
}

@end

