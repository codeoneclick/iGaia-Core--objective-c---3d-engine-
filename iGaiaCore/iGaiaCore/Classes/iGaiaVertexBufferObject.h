//
//  iGaiaVertexBufferObject.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import <glm/glm.hpp>
#import <glm/gtc/type_precision.hpp>

#import "iGaiaShader.h"

struct iGaiaVertex
{
    glm::vec3 m_position;
    glm::vec2 m_texcoord;
    glm::u8vec4 m_normal;
    glm::u8vec4 m_tangent;
    glm::u8vec4 m_color;
};

@interface iGaiaVertexBufferObject : NSObject

@property(nonatomic, readonly) NSUInteger m_numVertexes;
@property(nonatomic, assign) iGaiaShader* m_operatingShader;

+ (glm::u8vec4)compressVec3:(const glm::vec3&)uncopressed;
+ (glm::vec3)uncompressU8Vec4:(const glm::u8vec4&)compressed;

- (id)initWithNumVertexes:(NSUInteger)numVertexes withMode:(GLenum)mode;
- (void)unload;

- (iGaiaVertex*)lock;
- (void)unlock;

- (void)bind;
- (void)unbind;

@end
