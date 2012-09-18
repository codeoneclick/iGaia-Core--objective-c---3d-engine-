//
//  iGaiaCoreVertexBufferProtocol.h
//  iGaiaCoreCommunicator
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <glm/glm.hpp>
#import <glm/gtc/type_precision.hpp>

struct iGaiaCoreVertex
{
    glm::vec3 position;
    glm::vec2 texcoord;
    glm::u8vec4 normal;
    glm::u8vec4 tangent;
    glm::u8vec4 color;
};

@protocol iGaiaCoreShaderProtocol;
@protocol iGaiaCoreVertexBufferProtocol <NSObject>

@property(nonatomic, readonly) NSUInteger numVertexes;

- (iGaiaCoreVertex*)lock;
- (void)unlock;

- (void)bindForRenderMode:(NSString*)renderMode;
- (void)unbindForRenderMode:(NSString*)renderMode;

- (void)addShaderReference:(id<iGaiaCoreShaderProtocol>)shaderReference forRenderMode:(NSString*)renderMode;

@end
