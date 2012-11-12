//
//  iGaiaCamera.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaCamera.h"

iGaiaCamera::iGaiaCamera(f32 _fov, f32 _near, f32 _far, ui32 _width,  ui32 _height)
{
    m_fov = _fov;
    m_aspect = static_cast<f32>(_width) / static_cast<f32>(_height);
    m_near = _near;
    m_far = _far;
    m_projection = perspective(m_fov, m_aspect, m_near, m_far);
    m_altitude = 0;
    m_up = vec3(0.0f, 1.0f, 0.0f);
    m_frustum = new iGaiaFrustum(this);
}

iGaiaCamera::~iGaiaCamera(void)
{
    
}

inline mat4x4 iGaiaCamera::Get_ViewMatrix(void)
{
    return m_view;
}

inline mat4x4 iGaiaCamera::Get_ProjectionMatrix(void)
{
    return m_projection;
}

inline mat4x4 iGaiaCamera::Get_ViewReflectionMatrix(void)
{
    return m_reflection;
}

inline void iGaiaCamera::Set_Position(const vec3& _position)
{
    m_position = _position;
}

inline vec3 iGaiaCamera::Get_Position(void)
{
    return m_position;
}

inline void iGaiaCamera::Set_LookAt(const vec3& _look)
{
    m_look = _look;
}

inline vec3 iGaiaCamera::Get_LookAt(void)
{
    return m_look;
}

inline vec3 iGaiaCamera::Get_Up(void)
{
    return m_up;
}

inline void iGaiaCamera::Set_Rotation(f32 _rotation)
{
    m_rotation = _rotation;
}

inline f32 iGaiaCamera::Get_Rotation(void)
{
    return m_rotation;
}

inline void iGaiaCamera::Set_Altitude(f32 _altitude)
{
    m_altitude = _altitude;
}

inline f32 iGaiaCamera::Get_Altitude(void)
{
    return m_altitude;
}

inline void iGaiaCamera::Set_Distance(f32 _distance)
{
    m_distance = _distance;
}

inline f32 iGaiaCamera::Get_Distance(void)
{
    return m_distance;
}

inline f32 iGaiaCamera::Get_Fov(void)
{
    return m_fov;
}

inline f32 iGaiaCamera::Get_Aspect(void)
{
    return m_aspect;
}

inline f32 iGaiaCamera::Get_Near(void)
{
    return m_near;
}

inline f32 iGaiaCamera::Get_Far(void)
{
    return m_far;
}

void iGaiaCamera::OnUpdate(void)
{
    m_position.x = m_look.x + cosf(-m_rotation) * -m_distance;
    m_position.z = m_look.z + sinf(-m_rotation) * -m_distance;
    m_view = lookAt(m_position, m_look, m_up);

    vec3 position = m_position;
    position.y = -position.y + m_altitude * 2.0f;
    vec3 look = m_look;
    look.y = -look.y + m_altitude * 2.0f;
    m_reflection = lookAt(position, look, m_up * -1.0f);

    m_frustum->OnUpdate();
}

mat4x4 iGaiaCamera::Get_CylindricalMatrixForPosition(const vec3 &_position)
{
    vec3 direction = m_position - _position;
    direction = normalize(direction);

    vec3 up = vec3(0.0f, 1.0f, 0.0f);
    vec3 right = cross(direction, up);
    right = normalize(right);
    direction = cross(right, direction);

    mat4x4 cylindricalMatrix;
    cylindricalMatrix[0][0] = right.x;
    cylindricalMatrix[0][1] = right.y;
    cylindricalMatrix[0][2] = right.z;
    cylindricalMatrix[0][3] = 0.0f;
    cylindricalMatrix[1][0] = up.x;
    cylindricalMatrix[1][1] = up.y;
    cylindricalMatrix[1][2] = up.z;
    cylindricalMatrix[1][3] = 0.0f;
    cylindricalMatrix[2][0] = direction.x;
    cylindricalMatrix[2][1] = direction.y;
    cylindricalMatrix[2][2] = direction.z;
    cylindricalMatrix[2][3] = 0.0f;

    cylindricalMatrix[3][0] = _position.x;
    cylindricalMatrix[3][1] = _position.y;
    cylindricalMatrix[3][2] = _position.z;
    cylindricalMatrix[3][3] = 1.0f;

    return cylindricalMatrix;
}

mat4x4 iGaiaCamera::Get_SphericalMatrixForPosition(const vec3 &_position)
{
    vec3 direction = m_position - _position;
    direction = normalize(direction);
    vec3 up = vec3(m_view[1][0], m_view[1][1], m_view[1][2]);

    vec3 right = cross(direction, up);
    right = normalize(right);
    up = cross(right, direction);

    mat4x4 sphericalMatrix;
    sphericalMatrix[0][0] = right.x;
    sphericalMatrix[0][1] = right.y;
    sphericalMatrix[0][2] = right.z;
    sphericalMatrix[0][3] = 0.0f;
    sphericalMatrix[1][0] = up.x;
    sphericalMatrix[1][1] = up.y;
    sphericalMatrix[1][2] = up.z;
    sphericalMatrix[1][3] = 0.0f;
    sphericalMatrix[2][0] = direction.x;
    sphericalMatrix[2][1] = direction.y;
    sphericalMatrix[2][2] = direction.z;
    sphericalMatrix[2][3] = 0.0f;

    sphericalMatrix[3][0] = _position.x;
    sphericalMatrix[3][1] = _position.y;
    sphericalMatrix[3][2] = _position.z;
    sphericalMatrix[3][3] = 1.0f;

    return sphericalMatrix;
}
