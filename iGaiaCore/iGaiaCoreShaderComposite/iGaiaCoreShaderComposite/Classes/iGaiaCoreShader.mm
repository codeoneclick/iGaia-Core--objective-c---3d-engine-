//
//  iGaiaCoreShader.m
//  iGaiaCoreShaderComposite
//
//  Created by Sergey Sergeev on 9/24/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

#import "iGaiaCoreShader.h"
#import "iGaiaCoreDefinitions.h"

@interface iGaiaCoreShader()

@property (nonatomic, readwrite) NSString* name;
@property (nonatomic, readwrite) NSUInteger handle;
@property (nonatomic, strong) NSMutableDictionary* attributesContainer;
@property (nonatomic, strong) NSMutableDictionary* vertexSlotsContainer;
@property (nonatomic, strong) NSMutableDictionary* textureSlotsContainer;
@property (nonatomic, strong) NSArray* textureSlotsIndexes;

@end

@implementation iGaiaCoreShader

@synthesize name = _name;
@synthesize handle = _handle;
@synthesize attributesContainer = _attributesContainer;
@synthesize vertexSlotsContainer = _vertexSlotsContainer;
@synthesize textureSlotsContainer = _textureSlotsContainer;

- (id)initWithHandle:(NSUInteger)handle
{
    self = [super init];
    if(self != nil)
    {
        _handle = handle;

        _attributesContainer = [NSMutableDictionary new];

        [_attributesContainer setObject:[NSNumber numberWithInteger:glGetUniformLocation(_handle, [iGaiaCoreDefinitionShaderAttribute.matrixWorld cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderAttribute.matrixWorld];
        [_attributesContainer setObject:[NSNumber numberWithInteger:glGetUniformLocation(_handle, [iGaiaCoreDefinitionShaderAttribute.matrixView cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderAttribute.matrixView];
        [_attributesContainer setObject:[NSNumber numberWithInteger:glGetUniformLocation(_handle, [iGaiaCoreDefinitionShaderAttribute.matrixProjection cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderAttribute.matrixProjection];
        [_attributesContainer setObject:[NSNumber numberWithInteger:glGetUniformLocation(_handle, [iGaiaCoreDefinitionShaderAttribute.matrixWorldViewProjection cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderAttribute.matrixWorldViewProjection];
        [_attributesContainer setObject:[NSNumber numberWithInteger:glGetUniformLocation(_handle, [iGaiaCoreDefinitionShaderAttribute.vectorCameraPosition cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderAttribute.vectorCameraPosition];
        [_attributesContainer setObject:[NSNumber numberWithInteger:glGetUniformLocation(_handle, [iGaiaCoreDefinitionShaderAttribute.vectorLightPosition cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderAttribute.vectorLightPosition];
        [_attributesContainer setObject:[NSNumber numberWithInteger:glGetUniformLocation(_handle, [iGaiaCoreDefinitionShaderAttribute.vectorClipPlane cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderAttribute.vectorClipPlane];
        [_attributesContainer setObject:[NSNumber numberWithInteger:glGetUniformLocation(_handle, [iGaiaCoreDefinitionShaderAttribute.vectorTexcoordOffset cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderAttribute.vectorTexcoordOffset];
        [_attributesContainer setObject:[NSNumber numberWithInteger:glGetUniformLocation(_handle, [iGaiaCoreDefinitionShaderAttribute.floatTimer cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderAttribute.floatTimer];

        _textureSlotsContainer = [NSMutableDictionary new];

        [_textureSlotsContainer setObject:[NSNumber numberWithInteger:glGetUniformLocation(_handle, [iGaiaCoreDefinitionShaderTextureSlot.texture_01 cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderTextureSlot.texture_01];
        [_textureSlotsContainer setObject:[NSNumber numberWithInteger:glGetUniformLocation(_handle, [iGaiaCoreDefinitionShaderTextureSlot.texture_02 cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderTextureSlot.texture_02];
        [_textureSlotsContainer setObject:[NSNumber numberWithInteger:glGetUniformLocation(_handle, [iGaiaCoreDefinitionShaderTextureSlot.texture_03 cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderTextureSlot.texture_03];
        [_textureSlotsContainer setObject:[NSNumber numberWithInteger:glGetUniformLocation(_handle, [iGaiaCoreDefinitionShaderTextureSlot.texture_04 cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderTextureSlot.texture_04];
        [_textureSlotsContainer setObject:[NSNumber numberWithInteger:glGetUniformLocation(_handle, [iGaiaCoreDefinitionShaderTextureSlot.texture_05 cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderTextureSlot.texture_05];
        [_textureSlotsContainer setObject:[NSNumber numberWithInteger:glGetUniformLocation(_handle, [iGaiaCoreDefinitionShaderTextureSlot.texture_06 cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderTextureSlot.texture_06];
        [_textureSlotsContainer setObject:[NSNumber numberWithInteger:glGetUniformLocation(_handle, [iGaiaCoreDefinitionShaderTextureSlot.texture_07 cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderTextureSlot.texture_07];
        [_textureSlotsContainer setObject:[NSNumber numberWithInteger:glGetUniformLocation(_handle, [iGaiaCoreDefinitionShaderTextureSlot.texture_08 cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderTextureSlot.texture_08];

        _vertexSlotsContainer = [NSMutableDictionary new];

        [_vertexSlotsContainer setObject:[NSNumber numberWithInteger:glGetAttribLocation(_handle, [iGaiaCoreDefinitionShaderVertexSlot.position cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderVertexSlot.position];
        [_vertexSlotsContainer setObject:[NSNumber numberWithInteger:glGetAttribLocation(_handle, [iGaiaCoreDefinitionShaderVertexSlot.textcoord cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderVertexSlot.textcoord];
        [_vertexSlotsContainer setObject:[NSNumber numberWithInteger:glGetAttribLocation(_handle, [iGaiaCoreDefinitionShaderVertexSlot.normal cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderVertexSlot.normal];
        [_vertexSlotsContainer setObject:[NSNumber numberWithInteger:glGetAttribLocation(_handle, [iGaiaCoreDefinitionShaderVertexSlot.tangent cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderVertexSlot.tangent];
        [_vertexSlotsContainer setObject:[NSNumber numberWithInteger:glGetAttribLocation(_handle, [iGaiaCoreDefinitionShaderVertexSlot.color cStringUsingEncoding:NSUTF8StringEncoding])] forKey:iGaiaCoreDefinitionShaderVertexSlot.color];

        self.textureSlotsIndexes = [self.textureSlotsContainer allKeys];
    }
    return self;
}

- (void)bind;
{
    glValidateProgram(self.handle);
    GLint success = 0;
    glGetProgramiv(self.handle, GL_VALIDATE_STATUS, &success);
    if (success == GL_FALSE)
    {
        GLchar message[256];
        glGetProgramInfoLog(self.handle, sizeof(message), 0, &message[0]);
        NSLog(@"%s", message);
        return;
    }
    glUseProgram(self.handle);
}
- (void)unbind;
{
    glUseProgram(nil);
}

- (NSUInteger)getHandleForSlot:(NSString*)slot;
{
    return ((NSNumber*)[self.vertexSlotsContainer objectForKey:slot]).integerValue;
}

- (void)setMatrix4x4:(glm::mat4x4&)matrix forAttribure:(NSString*)attribute;
{
    GLint handleAttribute = ((NSNumber*)[self.attributesContainer objectForKey:attribute]).integerValue;
    glUniformMatrix4fv(handleAttribute, 1, 0, &matrix[0][0]);
}

- (void)setMatrix3x3:(glm::mat3x3&)matrix forAttribute:(NSString*)attribute;
{
    GLint handleAttribute = ((NSNumber*)[self.attributesContainer objectForKey:attribute]).integerValue;
    glUniformMatrix3fv(handleAttribute, 1, 0, &matrix[0][0]);
}

- (void)setVector2:(glm::vec2&)vector forAttribute:(NSString*)attribute;
{
    GLint handleAttribute = ((NSNumber*)[self.attributesContainer objectForKey:attribute]).integerValue;
    glUniform2fv(handleAttribute, 1, &vector[0]);
}

- (void)setVector3:(glm::vec3&)vector forAttribute:(NSString*)attribute;
{
    GLint handleAttribute = ((NSNumber*)[self.attributesContainer objectForKey:attribute]).integerValue;
    glUniform3fv(handleAttribute, 1, &vector[0]);
}

- (void)setVector4:(glm::vec4&)vector forAttribute:(NSString*)attribute;
{
    GLint handleAttribute = ((NSNumber*)[self.attributesContainer objectForKey:attribute]).integerValue;
    glUniform4fv(handleAttribute, 1, &vector[0]);
}

- (void)setFloat:(float)value forAttribute:(NSString*)attribute;
{
    GLint handleAttribute = ((NSNumber*)[self.attributesContainer objectForKey:attribute]).integerValue;
    glUniform1f(handleAttribute, value);
}

- (void)setTexture:(NSUInteger)handle forSlot:(NSString*)slot;
{
    NSInteger index = [self.textureSlotsIndexes indexOfObject:slot];
    glActiveTexture(GL_TEXTURE0 + index);
    glBindTexture(GL_TEXTURE_2D, handle);
    GLint handleAttribute = ((NSNumber*)[self.textureSlotsContainer objectForKey:slot]).integerValue;
    glUniform1i(handleAttribute, index);
}

@end
