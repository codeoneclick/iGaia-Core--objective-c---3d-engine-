//
//  iGaiaVertexBufferObject.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaVertexBufferObject.h"
#import "iGaiaRenderMgr.h"

@interface iGaiaVertexBufferObject()

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

- (iGaiaVertex*)lock
{
    return _m_data;
}

- (void)unlock
{
    glBindBuffer(GL_ARRAY_BUFFER, _m_handle);
    glBufferData(GL_ARRAY_BUFFER, sizeof(iGaiaVertex) * _m_numVertexes, _m_data, _m_mode);
}

- (void)bind
{
    glBindBuffer(GL_ARRAY_BUFFER, _m_handle);
    iGaiaShader* shader = [iGaiaRenderMgr sharedInstance].m_activeShader;
    NSUInteger bytesPerVertex = 0;
    NSInteger slot = [shader getVertexSlotHandle:E_VERTEX_SLOT_POSITION];
    if(slot >= 0)
    {
        glEnableVertexAttribArray(slot);
        glVertexAttribPointer(slot, 3, GL_FLOAT, GL_FALSE, sizeof(iGaiaVertex), (GLvoid*)bytesPerVertex);
    }
    bytesPerVertex += sizeof(glm::vec3);
    slot = [shader getVertexSlotHandle:E_VERTEX_SLOT_TEXCOORD];
    if(slot >= 0)
    {
        glEnableVertexAttribArray(slot);
        glVertexAttribPointer(slot, 2, GL_FLOAT, GL_FALSE, sizeof(iGaiaVertex), (GLvoid*)bytesPerVertex);
    }
    bytesPerVertex += sizeof(glm::vec2);
    slot = [shader getVertexSlotHandle:E_VERTEX_SLOT_NORMAL];
    if(slot >= 0)
    {
        glEnableVertexAttribArray(slot);
        glVertexAttribPointer(slot, 4, GL_UNSIGNED_BYTE, GL_FALSE, sizeof(iGaiaVertex), (GLvoid*)bytesPerVertex);
    }
    bytesPerVertex += sizeof(glm::u8vec4);
    slot = [shader getVertexSlotHandle:E_VERTEX_SLOT_TANGENT];
    if(slot >= 0)
    {
        glEnableVertexAttribArray(slot);
        glVertexAttribPointer(slot, 4, GL_UNSIGNED_BYTE, GL_FALSE, sizeof(iGaiaVertex), (GLvoid*)bytesPerVertex);
    }
    bytesPerVertex += sizeof(glm::u8vec4);
    slot = [shader getVertexSlotHandle:E_VERTEX_SLOT_COLOR];
    if(slot >= 0)
    {
        glEnableVertexAttribArray(slot);
        glVertexAttribPointer(slot, 4, GL_UNSIGNED_BYTE, GL_FALSE, sizeof(iGaiaVertex), (GLvoid*)bytesPerVertex);
    }
}

- (void)unbind
{
    glBindBuffer(GL_ARRAY_BUFFER, _m_handle);
    iGaiaShader* shader = [iGaiaRenderMgr sharedInstance].m_activeShader;
    GLint slot = [shader getVertexSlotHandle:E_VERTEX_SLOT_POSITION];
    if(slot >= 0)
    {
        glDisableVertexAttribArray(slot);
    }
    slot = [shader getVertexSlotHandle:E_VERTEX_SLOT_TEXCOORD];
    if(slot >= 0)
    {
        glDisableVertexAttribArray(slot);
    }
    slot = [shader getVertexSlotHandle:E_VERTEX_SLOT_NORMAL];
    if(slot >= 0)
    {
        glDisableVertexAttribArray(slot);
    }
    slot = [shader getVertexSlotHandle:E_VERTEX_SLOT_TANGENT];
    if(slot >= 0)
    {
        glDisableVertexAttribArray(slot);
    }
    slot = [shader getVertexSlotHandle:E_VERTEX_SLOT_COLOR];
    if(slot >= 0)
    {
        glDisableVertexAttribArray(slot);
    }
    glBindBuffer(GL_ARRAY_BUFFER, NULL);
}

@end

