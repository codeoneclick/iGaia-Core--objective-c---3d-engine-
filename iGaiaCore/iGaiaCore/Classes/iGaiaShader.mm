//
//  iGaiaShader.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaShader.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import "iGaiaRenderMgr.h"
#import "iGaiaLogger.h"

extern const struct iGaiaShaderVertexSlot
{
    NSString* m_position;
    NSString* m_texcoord;
    NSString* m_normal;
    NSString* m_tangent;
    NSString* m_color;

} iGaiaShaderVertexSlot;

extern const struct iGaiaShaderAttributes
{
    NSString* m_worldMatrix;
    NSString* m_viewMatrix;
    NSString* m_projectionMatrix;
    NSString* m_worldViewProjectionMatrix;
    NSString* m_cameraPosition;
    NSString* m_lightPosition;
    NSString* m_clipPlane;
    NSString* m_texcoordOffset;
    NSString* m_time;

} iGaiaShaderAttributes;

extern const struct iGaiaShaderTextureSlot
{
    NSString* m_texture_01;
    NSString* m_texture_02;
    NSString* m_texture_03;
    NSString* m_texture_04;
    NSString* m_texture_05;
    NSString* m_texture_06;
    NSString* m_texture_07;
    NSString* m_texture_08;

} iGaiaShaderTextureSlot;

const struct iGaiaShaderVertexSlot iGaiaShaderVertexSlot = 
{
    .m_position = @"IN_SLOT_Position",
    .m_texcoord = @"IN_SLOT_TexCoord",
    .m_normal = @"IN_SLOT_Normal",
    .m_tangent = @"IN_SLOT_Tangent",
    .m_color = @"IN_SLOT_Color"
};

const struct iGaiaShaderAttributes iGaiaShaderAttributes = 
{
    .m_worldMatrix = @"EXT_MATRIX_World",
    .m_viewMatrix = @"EXT_MATRIX_View",
    .m_projectionMatrix = @"EXT_MATRIX_Projection",
    .m_worldViewProjectionMatrix = @"EXT_MATRIX_WVP",
    .m_cameraPosition = @"EXT_View",
    .m_lightPosition = @"EXT_Light",
    .m_clipPlane = @"EXT_Clip_Plane",
    .m_texcoordOffset = @"EXT_Texcoord_Offset",
    .m_time = @"EXT_Timer"
};

const struct iGaiaShaderTextureSlot iGaiaShaderTextureSlot = 
{
    .m_texture_01 = @"EXT_TEXTURE_01",
    .m_texture_02 = @"EXT_TEXTURE_02",
    .m_texture_03 = @"EXT_TEXTURE_03",
    .m_texture_04 = @"EXT_TEXTURE_04",
    .m_texture_05 = @"EXT_TEXTURE_05",
    .m_texture_06 = @"EXT_TEXTURE_06",
    .m_texture_07 = @"EXT_TEXTURE_07",
    .m_texture_08 = @"EXT_TEXTURE_08"
};

@interface iGaiaShader()
{
    NSInteger m_attributes[E_ATTRIBUTE::E_ATTRIBUTE_MAX];
    NSInteger m_vertexSlots[E_VERTEX_SLOT::E_VERTEX_SLOT_MAX];
    NSInteger m_textureSlots[E_TEXTURE_SLOT::E_TEXTURE_SLOT_MAX];
}

@property(nonatomic, assign) NSUInteger m_handle;

@end

@implementation iGaiaShader

@synthesize m_handle = _m_handle;

- (id)initWithHandle:(NSUInteger)handle
{
    self = [super init];
    if(self)
    {
        _m_handle = handle;

        m_attributes[E_ATTRIBUTE_MATRIX_WORLD] = glGetUniformLocation(_m_handle, [iGaiaShaderAttributes.m_worldMatrix cStringUsingEncoding:NSUTF8StringEncoding]);
        m_attributes[E_ATTRIBUTE_MATRIX_VIEW] = glGetUniformLocation(_m_handle, [iGaiaShaderAttributes.m_viewMatrix cStringUsingEncoding:NSUTF8StringEncoding]);
        m_attributes[E_ATTRIBUTE_MATRIX_PROJECTION] = glGetUniformLocation(_m_handle, [iGaiaShaderAttributes.m_projectionMatrix cStringUsingEncoding:NSUTF8StringEncoding]);
        m_attributes[E_ATTRIBUTE_MATRIX_WVP] = glGetUniformLocation(_m_handle, [iGaiaShaderAttributes.m_worldViewProjectionMatrix cStringUsingEncoding:NSUTF8StringEncoding]);
        m_attributes[E_ATTRIBUTE_VECTOR_CAMERA_POSITION] = glGetUniformLocation(_m_handle, [iGaiaShaderAttributes.m_cameraPosition cStringUsingEncoding:NSUTF8StringEncoding]);
        m_attributes[E_ATTRIBUTE_VECTOR_LIGHT_POSITION] = glGetUniformLocation(_m_handle, [iGaiaShaderAttributes.m_lightPosition cStringUsingEncoding:NSUTF8StringEncoding]);
        m_attributes[E_ATTRIBUTE_VECTOR_CLIP_PLANE] = glGetUniformLocation(_m_handle, [iGaiaShaderAttributes.m_clipPlane cStringUsingEncoding:NSUTF8StringEncoding]);
        m_attributes[E_ATTRIBUTE_VECTOR_TEXCOORD_OFFSET] = glGetUniformLocation(_m_handle, [iGaiaShaderAttributes.m_texcoordOffset cStringUsingEncoding:NSUTF8StringEncoding]);
        m_attributes[E_ATTRIBUTE_FLOAT_TIME] = glGetUniformLocation(_m_handle, [iGaiaShaderAttributes.m_time cStringUsingEncoding:NSUTF8StringEncoding]);

        m_textureSlots[E_TEXTURE_SLOT_01] = glGetUniformLocation(_m_handle, [iGaiaShaderTextureSlot.m_texture_01 cStringUsingEncoding:NSUTF8StringEncoding]);
        m_textureSlots[E_TEXTURE_SLOT_02] = glGetUniformLocation(_m_handle, [iGaiaShaderTextureSlot.m_texture_02 cStringUsingEncoding:NSUTF8StringEncoding]);
        m_textureSlots[E_TEXTURE_SLOT_03] = glGetUniformLocation(_m_handle, [iGaiaShaderTextureSlot.m_texture_03 cStringUsingEncoding:NSUTF8StringEncoding]);
        m_textureSlots[E_TEXTURE_SLOT_04] = glGetUniformLocation(_m_handle, [iGaiaShaderTextureSlot.m_texture_04 cStringUsingEncoding:NSUTF8StringEncoding]);
        m_textureSlots[E_TEXTURE_SLOT_05] = glGetUniformLocation(_m_handle, [iGaiaShaderTextureSlot.m_texture_05 cStringUsingEncoding:NSUTF8StringEncoding]);
        m_textureSlots[E_TEXTURE_SLOT_06] = glGetUniformLocation(_m_handle, [iGaiaShaderTextureSlot.m_texture_06 cStringUsingEncoding:NSUTF8StringEncoding]);
        m_textureSlots[E_TEXTURE_SLOT_07] = glGetUniformLocation(_m_handle, [iGaiaShaderTextureSlot.m_texture_07 cStringUsingEncoding:NSUTF8StringEncoding]);
        m_textureSlots[E_TEXTURE_SLOT_08] = glGetUniformLocation(_m_handle, [iGaiaShaderTextureSlot.m_texture_08 cStringUsingEncoding:NSUTF8StringEncoding]);

        m_vertexSlots[E_VERTEX_SLOT_POSITION] = glGetAttribLocation(_m_handle, [iGaiaShaderVertexSlot.m_position cStringUsingEncoding:NSUTF8StringEncoding]);
        m_vertexSlots[E_VERTEX_SLOT_TEXCOORD] = glGetAttribLocation(_m_handle, [iGaiaShaderVertexSlot.m_texcoord cStringUsingEncoding:NSUTF8StringEncoding]);
        m_vertexSlots[E_VERTEX_SLOT_NORMAL] = glGetAttribLocation(_m_handle, [iGaiaShaderVertexSlot.m_normal cStringUsingEncoding:NSUTF8StringEncoding]);
        m_vertexSlots[E_VERTEX_SLOT_TANGENT] = glGetAttribLocation(_m_handle, [iGaiaShaderVertexSlot.m_tangent cStringUsingEncoding:NSUTF8StringEncoding]);
        m_vertexSlots[E_VERTEX_SLOT_COLOR] = glGetAttribLocation(_m_handle, [iGaiaShaderVertexSlot.m_color cStringUsingEncoding:NSUTF8StringEncoding]);

    }
    return self;
}

- (NSInteger)getVertexSlotHandle:(E_VERTEX_SLOT)slot
{
    if(slot > E_VERTEX_SLOT::E_VERTEX_SLOT_MAX)
    {
        return 0;
    }
    return m_vertexSlots[slot];
}

- (void)setMatrix4x4:(const glm::mat4x4&)matrix forAttribute:(E_ATTRIBUTE)attribute
{
    NSInteger handle = m_attributes[attribute];
    glUniformMatrix4fv(handle, 1, 0, &matrix[0][0]);
}

- (void)setMatrix4x4:(const glm::mat4x4&)matrix forCustomAttribute:(NSString*)attribute
{
    NSInteger handle = glGetUniformLocation(_m_handle, [attribute cStringUsingEncoding:NSUTF8StringEncoding]);
    glUniformMatrix4fv(handle, 1, 0, &matrix[0][0]);
}

- (void)setMatrix3x3:(const glm::mat3x3&)matrix forAttribute:(E_ATTRIBUTE)attribute
{
    NSInteger handle = m_attributes[attribute];
    glUniformMatrix3fv(handle, 1, 0, &matrix[0][0]);
}

- (void)setMatrix3x3:(const glm::mat3x3&)matrix forCustomAttribute:(NSString*)attribute
{
    NSInteger handle = glGetUniformLocation(_m_handle, [attribute cStringUsingEncoding:NSUTF8StringEncoding]);
    glUniformMatrix3fv(handle, 1, 0, &matrix[0][0]);
}

- (void)setVector2:(const glm::vec2&)vector forAttribute:(E_ATTRIBUTE)attribute
{
    NSInteger handle = m_attributes[attribute];
    glUniform2fv(handle, 1, &vector[0]);
}

- (void)setVector2:(const glm::vec2&)vector forCustomAttribute:(NSString*)attribute
{
    NSInteger handle = glGetUniformLocation(_m_handle, [attribute cStringUsingEncoding:NSUTF8StringEncoding]);
    glUniform2fv(handle, 1, &vector[0]);
}

- (void)setVector3:(const glm::vec3&)vector forAttribute:(E_ATTRIBUTE)attribute
{
    NSInteger handle = m_attributes[attribute];
    glUniform3fv(handle, 1, &vector[0]);
}

- (void)setVector3:(const glm::vec3&)vector forCustomAttribute:(NSString*)attribute
{
    int handle = glGetUniformLocation(_m_handle, [attribute cStringUsingEncoding:NSUTF8StringEncoding]);
    glUniform3fv(handle, 1, &vector[0]);
}

- (void)setVector4:(const glm::vec4&)vector forAttribute:(E_ATTRIBUTE)attribute
{
    int handle= m_attributes[attribute];
    glUniform4fv(handle, 1, &vector[0]);
}

- (void)setVector4:(const glm::vec4&)vector forCustomAttribute:(NSString*)attribute
{
    int handle = glGetUniformLocation(_m_handle, [attribute cStringUsingEncoding:NSUTF8StringEncoding]);
    glUniform4fv(handle, 1, &vector[0]);
}

- (void)setFloat:(float)value forAttribute:(E_ATTRIBUTE)attribute
{
    int handle = m_attributes[attribute];
    glUniform1f(handle, value);
}

- (void)setFloat:(float)value forCustomAttribute:(NSString*)attribute
{
    int handle = glGetUniformLocation(_m_handle, [attribute cStringUsingEncoding:NSUTF8StringEncoding]);
    glUniform1f(handle, value);
}

- (void)setTexture:(iGaiaTexture*)texture forSlot:(E_TEXTURE_SLOT)slot;
{
    glActiveTexture(GL_TEXTURE0 + slot);
    [texture bind];
    glUniform1i(m_textureSlots[slot], 0);
}

- (void)bind
{
    glUseProgram(_m_handle);
    
    /*glValidateProgram(_m_handle); // codeoneclick - uncoment only for debug mode
    GLint success;
    glGetProgramiv(_m_handle, GL_VALIDATE_STATUS, &success);
    if (success == GL_FALSE)
    {
        GLchar message[256];
        glGetProgramInfoLog(_m_handle, sizeof(message), 0, &message[0]);
        iGaiaLog(@"%s", message);
    }*/
}

- (void)unbind
{
    glUseProgram(NULL);
}


@end

