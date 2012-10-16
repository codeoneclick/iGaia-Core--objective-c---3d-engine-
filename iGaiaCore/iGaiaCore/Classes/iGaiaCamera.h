//
//  iGaiaCamera.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <glm/glm.hpp>
#import <glm/gtc/type_precision.hpp>
#import <glm/gtc/matrix_transform.hpp>

#import "iGaiaFrustum.h"

@interface iGaiaCamera : NSObject

@property(nonatomic, readonly) glm::mat4x4 m_view;
@property(nonatomic, readonly) glm::mat4x4 m_reflection;
@property(nonatomic, readonly) glm::mat4x4 m_projection;

@property(nonatomic, assign) glm::vec3 m_position;
@property(nonatomic, assign) glm::vec3 m_look;
@property(nonatomic, readonly) glm::vec3 m_up;
@property(nonatomic, assign) float m_rotation;
@property(nonatomic, assign) float m_altitude;
@property(nonatomic, readonly) float m_fov;
@property(nonatomic, readonly) float m_aspect;

@property(nonatomic, readonly) float m_near;
@property(nonatomic, readonly) float m_far;

@property(nonatomic, readonly) iGaiaFrustum* m_frustum;

- (id)initWithFov:(float)fov withNear:(float)near withFar:(float)far forScreenWidth:(NSUInteger)width forScreenHeight:(NSUInteger)height;

- (void)onUpdate;

- (glm::mat4x4)retriveSphericalMatrixForPosition:(const glm::vec3&)position;
- (glm::mat4x4)retriveCylindricalMatrixForPosition:(const glm::vec3&)position;

@end
