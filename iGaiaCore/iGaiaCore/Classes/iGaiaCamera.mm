//
//  iGaiaCamera.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaCamera.h"

@interface iGaiaCamera()

@property(nonatomic, assign) float m_fov;
@property(nonatomic, assign) float m_aspect;
@property(nonatomic, assign) float m_near;
@property(nonatomic, assign) float m_far;

@end

@implementation iGaiaCamera

@synthesize m_view = _m_view;
@synthesize m_reflection = _m_reflection;
@synthesize m_projection = _m_projection;

@synthesize m_fov = _m_fov;
@synthesize m_aspect = _m_aspect;
@synthesize m_near = _m_near;
@synthesize m_far = _m_far;

@synthesize m_position = _m_position;
@synthesize m_rotation = _m_rotation;
@synthesize m_look = _m_look;
@synthesize m_altitude = _m_altitude;

- (id)initWithFov:(float)fov withNear:(float)near withFar:(float)far forScreenWidth:(NSUInteger)width forScreenHeight:(NSUInteger)height
{
    self = [super init];
    if(self)
    {
        _m_fov = fov;
        _m_aspect = static_cast<float>(width) / static_cast<float>(height);
        _m_near = near;
        _m_far = far;
        _m_projection = glm::perspective(_m_fov, _m_aspect, _m_near, _m_far);
        _m_altitude = 0;
    }
    return self;
}

- (void)onUpdate
{
    _m_position.y = 20.0f;
    _m_position.x = _m_look.x + cos(-_m_rotation) * -60.0f;
    _m_position.z = _m_look.z + sin(-_m_rotation) * -60.0f;
    _m_view = glm::lookAt(_m_position, _m_look, glm::vec3(0.0f, 1.0f, 0.0f));

    glm::vec3 position = _m_position;
    _m_position.y = -_m_position.y + _m_altitude * 2.0f;
    glm::vec3 look = _m_look;
    _m_look.y = -_m_look.y + _m_altitude * 2.0f;
    _m_reflection = glm::lookAt(position, look, glm::vec3(0.0f, -1.0f, 0.0f));
}

@end
