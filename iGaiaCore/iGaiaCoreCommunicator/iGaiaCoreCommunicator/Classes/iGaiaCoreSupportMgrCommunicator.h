//
//  iGaiaCoreSupportMgrCommunicator.h
//  iGaiaCoreCommunicator
//
//  Created by Sergey Sergeev on 9/27/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import <glm/glm.hpp>
#import <glm/gtc/type_precision.hpp>

@protocol iGaiaCoreCameraProtocol <NSObject>

@property(nonatomic, assign) glm::vec3 position;
@property(nonatomic, assign) float rotation;
@property(nonatomic, assign) glm::vec3 lookAt;
@property(nonatomic, assign) float fov;
@property(nonatomic, readonly) glm::mat4x4 viewMatrix;
@property(nonatomic, readonly) glm::mat4x4 projectionMatrix;

- (glm::mat4x4)retrieveSphericalMatrixForPosition:(glm::vec3&)position;
- (glm::mat4x4)retrieveCylindricalMatrixForPosition:(glm::vec3&)position;

@end
