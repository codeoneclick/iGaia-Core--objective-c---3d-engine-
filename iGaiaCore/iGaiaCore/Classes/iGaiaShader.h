//
//  iGaiaShader.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <glm/glm.hpp>
#import <glm/gtc/type_precision.hpp>

#import "iGaiaTexture.h"

enum E_SHADER
{
    E_SHADER_LANDSCAPE = 0,
    E_SHADER_LANDSCAPE_ND,
    E_SHADER_MODEL,
    E_SHADER_MODEL_ND,
    E_SHADER_GRASS,
    E_SHADER_GRASS_ND,
    E_SHADER_OCEAN,
    E_SHADER_DECAL,
    E_SHADER_PARTICLE,
    E_SHADER_PARTICLE_ND,
    E_SHADER_SKYBOX,
    E_SHADER_LANDSCAPE_EDGES,
    E_SHADER_SCREEN_PLANE,
    E_SHADER_SCREEN_PLANE_BLOOM_EXTRACT,
    E_SHADER_SCREEN_PLANE_BLOOM_COMBINE,
    E_SHADER_SCREEN_PLANE_BLUR,
    E_SHADER_SCREEN_PLANE_EDGE_DETECT,
    E_SHADER_SCREEN_PLANE_LANDSCAPE_DETAIL,
    E_SHADER_MAX
};

enum E_VERTEX_SLOT
{
    E_VERTEX_SLOT_POSITION = 0,
    E_VERTEX_SLOT_TEXCOORD,
    E_VERTEX_SLOT_NORMAL,
    E_VERTEX_SLOT_TANGENT,
    E_VERTEX_SLOT_COLOR,
    E_VERTEX_SLOT_MAX
};

enum E_ATTRIBUTE
{
    E_ATTRIBUTE_MATRIX_WORLD = 0,
    E_ATTRIBUTE_MATRIX_VIEW,
    E_ATTRIBUTE_MATRIX_PROJECTION,
    E_ATTRIBUTE_MATRIX_WVP,
    E_ATTRIBUTE_VECTOR_CAMERA_POSITION,
    E_ATTRIBUTE_VECTOR_LIGHT_POSITION,
    E_ATTRIBUTE_VECTOR_CLIP_PLANE,
    E_ATTRIBUTE_VECTOR_TEXCOORD_OFFSET,
    E_ATTRIBUTE_FLOAT_TIME,
    E_ATTRIBUTE_MAX
};

enum E_TEXTURE_SLOT
{
    E_TEXTURE_SLOT_01 = 0,
    E_TEXTURE_SLOT_02,
    E_TEXTURE_SLOT_03,
    E_TEXTURE_SLOT_04,
    E_TEXTURE_SLOT_05,
    E_TEXTURE_SLOT_06,
    E_TEXTURE_SLOT_07,
    E_TEXTURE_SLOT_08,
    E_TEXTURE_SLOT_MAX
};

@interface iGaiaShader : NSObject

- (id)initWithHandle:(NSUInteger)handle;

- (NSInteger)getVertexSlotHandle:(E_VERTEX_SLOT)slot;

- (void)setMatrix4x4:(const glm::mat4x4&)matrix forAttribute:(E_ATTRIBUTE)attribute;
- (void)setMatrix4x4:(const glm::mat4x4&)matrix forCustomAttribute:(NSString*)attribute;
- (void)setMatrix3x3:(const glm::mat3x3&)matrix forAttribute:(E_ATTRIBUTE)attribute;
- (void)setMatrix3x3:(const glm::mat3x3&)matrix forCustomAttribute:(NSString*)attribute;
- (void)setVector2:(const glm::vec2&)vector forAttribute:(E_ATTRIBUTE)attribute;
- (void)setVector2:(const glm::vec2&)vector forCustomAttribute:(NSString*)attribute;
- (void)setVector3:(const glm::vec3&)vector forAttribute:(E_ATTRIBUTE)attribute;
- (void)setVector3:(const glm::vec3&)vector forCustomAttribute:(NSString*)attribute;
- (void)setVector4:(const glm::vec4&)vector forAttribute:(E_ATTRIBUTE)attribute;
- (void)setVector4:(const glm::vec4&)vector forCustomAttribute:(NSString*)attribute;
- (void)setFloat:(float)value forAttribute:(E_ATTRIBUTE)attribute;
- (void)setFloat:(float)value forCustomAttribute:(NSString*)attribute;
- (void)setTexture:(iGaiaTexture*)texture forSlot:(E_TEXTURE_SLOT)slot;

- (void)bind;
- (void)unbind;

@end
