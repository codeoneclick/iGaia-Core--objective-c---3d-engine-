//
//  iGaiaCamera.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaCamera.h"

@interface iGaiaCamera()

@end

@implementation iGaiaCamera

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
        _m_up = glm::vec3(0.0f, 1.0f, 0.0f);
        _m_frustum = [[iGaiaFrustum alloc] initWithCamera:self];
    }
    return self;
}

- (void)onUpdate
{
    _m_position.x = _m_look.x + cos(-_m_rotation) * -_m_distance;
    _m_position.z = _m_look.z + sin(-_m_rotation) * -_m_distance;
    _m_view = glm::lookAt(_m_position, _m_look, _m_up);

    glm::vec3 position = _m_position;
    position.y = -position.y + _m_altitude * 2.0f;
    glm::vec3 look = _m_look;
    look.y = -look.y + _m_altitude * 2.0f;
    _m_reflection = glm::lookAt(position, look, _m_up * -1.0f);
}

- (glm::mat4x4)retriveSphericalMatrixForPosition:(const glm::vec3&)position;
{
    glm::vec3 look = _m_position - position;
    look = glm::normalize(look);
    glm::vec3 up = glm::vec3(_m_view[1][0], _m_view[1][1], _m_view[1][2]);

    glm::vec3 right = glm::cross(look, up);
    right = glm::normalize(right);
    up = glm::cross(right, look);

    glm::mat4x4 sphericalMatrix;
    sphericalMatrix[0][0] = right.x;
    sphericalMatrix[0][1] = right.y;
    sphericalMatrix[0][2] = right.z;
    sphericalMatrix[0][3] = 0.0f;
    sphericalMatrix[1][0] = up.x;
    sphericalMatrix[1][1] = up.y;
    sphericalMatrix[1][2] = up.z;
    sphericalMatrix[1][3] = 0.0f;
    sphericalMatrix[2][0] = look.x;
    sphericalMatrix[2][1] = look.y;
    sphericalMatrix[2][2] = look.z;
    sphericalMatrix[2][3] = 0.0f;

    sphericalMatrix[3][0] = position.x;
    sphericalMatrix[3][1] = position.y;
    sphericalMatrix[3][2] = position.z;
    sphericalMatrix[3][3] = 1.0f;

    return sphericalMatrix;
}

- (glm::mat4x4)retriveCylindricalMatrixForPosition:(const glm::vec3&)position;
{
    glm::vec3 look = _m_position - position;
    look = glm::normalize(look);

    glm::vec3 up = glm::vec3(0.0f, 1.0f, 0.0f);
    glm::vec3 right = glm::cross(look, up);
    right = glm::normalize(right);
    look = glm::cross(right, look);

    glm::mat4x4 cylindricalMatrix;
    cylindricalMatrix[0][0] = right.x;
    cylindricalMatrix[0][1] = right.y;
    cylindricalMatrix[0][2] = right.z;
    cylindricalMatrix[0][3] = 0.0f;
    cylindricalMatrix[1][0] = up.x;
    cylindricalMatrix[1][1] = up.y;
    cylindricalMatrix[1][2] = up.z;
    cylindricalMatrix[1][3] = 0.0f;
    cylindricalMatrix[2][0] = look.x;
    cylindricalMatrix[2][1] = look.y;
    cylindricalMatrix[2][2] = look.z;
    cylindricalMatrix[2][3] = 0.0f;

    cylindricalMatrix[3][0] = position.x;
    cylindricalMatrix[3][1] = position.y;
    cylindricalMatrix[3][2] = position.z;
    cylindricalMatrix[3][3] = 1.0f;

    return cylindricalMatrix;
}


@end
