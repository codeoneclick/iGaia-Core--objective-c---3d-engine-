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

@end
