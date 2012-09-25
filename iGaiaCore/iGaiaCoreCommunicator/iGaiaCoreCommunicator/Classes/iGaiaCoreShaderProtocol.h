//
//  iGaiaCoreShaderProtocol.h
//  iGaiaCoreCommunicator
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <glm/glm.hpp>

#import "iGaiaCoreResourceProtocol.h"

@protocol iGaiaCoreShaderProtocol <NSObject>

@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSUInteger handle;

- (void)bind;
- (void)unbind;

- (NSUInteger)getHandleForSlot:(NSString*)slot;

- (void)setMatrix4x4:(glm::mat4x4&)matrix forAttribure:(NSString*)attribute;
- (void)setMatrix3x3:(glm::mat3x3&)matrix forAttribute:(NSString*)attribute;
- (void)setVector2:(glm::vec2&)vector forAttribute:(NSString*)attribute;
- (void)setVector3:(glm::vec3&)vector forAttribute:(NSString*)attribute;
- (void)setVector4:(glm::vec4&)vector forAttribute:(NSString*)attribute;
- (void)setFloat:(float)value forAttribute:(NSString*)attribute;
- (void)setTexture:(NSUInteger)handle forSlot:(NSString*)slot;

@end
