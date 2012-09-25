//
//  iGaiaCoreVertexBuffer.m
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

#import "iGaiaCoreVertexBuffer.h"
#import "iGaiaCoreShaderProtocol.h"
#import "iGaiaCoreDefinitions.h"

@interface iGaiaCoreVertexBuffer()

@property(nonatomic, readwrite) NSUInteger numVertexes;
@property(nonatomic, assign) NSUInteger handle;
@property(nonatomic, unsafe_unretained) iGaiaCoreVertex* vertexes;
@property(nonatomic, assign) GLenum mode;
@property(nonatomic, strong) NSMutableDictionary* shaderReferencesContainer;

@end

@implementation iGaiaCoreVertexBuffer

@synthesize numVertexes = _numVertexes;
@synthesize handle = _handle;
@synthesize vertexes = _vertexes;
@synthesize mode = _mode;
@synthesize shaderReferencesContainer = _shaderReferencesContainer;

- (id)initWithNumVertexes:(NSUInteger)numVertexes withMode:(GLenum)mode;
{
    self = [super init];
    if(self)
    {
        _numVertexes = numVertexes;
        _vertexes = new iGaiaCoreVertex[_numVertexes];
        _mode = mode;
        _shaderReferencesContainer = [NSMutableDictionary new];
        glGenBuffers(1, &_handle);
    }
    return self;
}

- (void)addShaderReference:(id<iGaiaCoreShaderProtocol>)shaderReference forRenderMode:(NSString*)renderMode;
{
    [self.shaderReferencesContainer setObject:shaderReference forKey:renderMode];
}

- (iGaiaCoreVertex*)lock;
{
    return self.vertexes;
}

- (void)unlock;
{
    glBindBuffer(GL_ARRAY_BUFFER, self.handle);
    glBufferData(GL_ARRAY_BUFFER, sizeof(iGaiaCoreVertex) * self.numVertexes, self.vertexes, self.mode);
}

- (void)bindForRenderMode:(NSString*)renderMode;
{
    glBindBuffer(GL_ARRAY_BUFFER, self.handle);
    id<iGaiaCoreShaderProtocol> shaderReference = [self.shaderReferencesContainer objectForKey:renderMode];
    unsigned char bytesOffset = 0;
    GLint slotHandle = [shaderReference getHandleForSlot:iGaiaCoreDefinitionShaderVertexSlot.position];
    if(slotHandle >= 0)
    {
        glEnableVertexAttribArray(slotHandle);
        glVertexAttribPointer(slotHandle, 3, GL_FLOAT, GL_FALSE, sizeof(iGaiaCoreVertex), (GLvoid*)bytesOffset);
    }
    bytesOffset += sizeof(glm::vec3);
    slotHandle = [shaderReference getHandleForSlot:iGaiaCoreDefinitionShaderVertexSlot.textcoord];
    if(slotHandle >= 0)
    {
        glEnableVertexAttribArray(slotHandle);
        glVertexAttribPointer(slotHandle, 2, GL_FLOAT, GL_FALSE, sizeof(iGaiaCoreVertex), (GLvoid*)bytesOffset);
    }
    bytesOffset += sizeof(glm::vec2);
    slotHandle = [shaderReference getHandleForSlot:iGaiaCoreDefinitionShaderVertexSlot.normal];
    if(slotHandle >= 0)
    {
        glEnableVertexAttribArray(slotHandle);
        glVertexAttribPointer(slotHandle, 4, GL_UNSIGNED_BYTE, GL_FALSE, sizeof(iGaiaCoreVertex), (GLvoid*)bytesOffset);
    }
    bytesOffset += sizeof(glm::u8vec4);
    slotHandle = [shaderReference getHandleForSlot:iGaiaCoreDefinitionShaderVertexSlot.tangent];
    if(slotHandle >= 0)
    {
        glEnableVertexAttribArray(slotHandle);
        glVertexAttribPointer(slotHandle, 4, GL_UNSIGNED_BYTE, GL_FALSE, sizeof(iGaiaCoreVertex), (GLvoid*)bytesOffset);
    }
    bytesOffset += sizeof(glm::u8vec4);
    slotHandle = [shaderReference getHandleForSlot:iGaiaCoreDefinitionShaderVertexSlot.color];
    if(slotHandle >= 0)
    {
        glEnableVertexAttribArray(slotHandle);
        glVertexAttribPointer(slotHandle, 4, GL_UNSIGNED_BYTE, GL_FALSE, sizeof(iGaiaCoreVertex), (GLvoid*)bytesOffset);
    }
}

- (void)unbindForRenderMode:(NSString*)renderMode;
{
    glBindBuffer(GL_ARRAY_BUFFER, self.handle);
    id<iGaiaCoreShaderProtocol> shaderReference = [self.shaderReferencesContainer objectForKey:renderMode];
    GLint slotHandle = [shaderReference getHandleForSlot:iGaiaCoreDefinitionShaderVertexSlot.position];
    if(slotHandle >= 0)
    {
        glDisableVertexAttribArray(slotHandle);
    }
    slotHandle = [shaderReference getHandleForSlot:iGaiaCoreDefinitionShaderVertexSlot.textcoord];
    if(slotHandle >= 0)
    {
        glDisableVertexAttribArray(slotHandle);
    }
    slotHandle = [shaderReference getHandleForSlot:iGaiaCoreDefinitionShaderVertexSlot.normal];
    if(slotHandle >= 0)
    {
        glDisableVertexAttribArray(slotHandle);
    }
    slotHandle = [shaderReference getHandleForSlot:iGaiaCoreDefinitionShaderVertexSlot.tangent];
    if(slotHandle >= 0)
    {
        glDisableVertexAttribArray(slotHandle);
    }
    slotHandle = [shaderReference getHandleForSlot:iGaiaCoreDefinitionShaderVertexSlot.color];
    if(slotHandle >= 0)
    {
        glDisableVertexAttribArray(slotHandle);
    }
    glBindBuffer(GL_ARRAY_BUFFER, nil);
}

@end
