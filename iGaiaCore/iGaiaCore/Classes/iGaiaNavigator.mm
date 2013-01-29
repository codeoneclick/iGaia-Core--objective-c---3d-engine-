//
//  iGaiaNavigator.mm
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/17/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaNavigator.h"
#include "iGaiaLandscapeHeightmapHelper.h"

iGaiaNavigator::iGaiaNavigator(f32 _moveForwardSpeed, f32 _moveBackwardSpeed, f32 _strafeSpeed, f32 _steerSpeed)
{
    m_moveForwardSpeed = _moveForwardSpeed;
    m_moveBackwardSpeed = _moveBackwardSpeed;
    m_strafeSpeed = _strafeSpeed;
    m_steerSpeed = _steerSpeed;

    m_position = vec3(0.0f, 0.0f, 0.0f);
    m_rotation = vec3(0.0f, 0.0f, 0.0f);

    m_heightmapData = nullptr;
    m_heightmapScaleFactor = vec2(1.0f, 1.0f);
    m_heightmapWidth = 0;
    m_heightmapHeight = 0;
}

void iGaiaNavigator::Set_Heightmap(f32* _heightmapData, ui32 _heightmapWidth, ui32 _heightmapHeight, vec2 _heightmapScaleFactor)
{
    m_heightmapData = _heightmapData;
    m_heightmapWidth = _heightmapWidth;
    m_heightmapHeight = _heightmapHeight;
    m_heightmapScaleFactor = _heightmapScaleFactor;
}

bool iGaiaNavigator::MoveForward(void)
{
    vec3 precomputePosition = vec3(m_position.x + cosf(-m_rotation.y) * m_moveForwardSpeed, 0.0f, m_position.z + sinf(-m_rotation.y) * m_moveForwardSpeed);
    if(floorf(precomputePosition.x) > m_heightmapWidth ||
       floorf(precomputePosition.x) < 0 ||
       floorf(precomputePosition.z) > m_heightmapHeight ||
       floorf(precomputePosition.z) < 0
       )
    {
        return false;
    }
    f32 height = iGaiaLandscapeHeightmapHelper::Get_HeightValue(m_heightmapData, m_heightmapWidth, m_heightmapHeight, m_heightmapScaleFactor, vec2(precomputePosition.x, precomputePosition.z));
    m_position = vec3(precomputePosition.x, height, precomputePosition.z);
    vec2 rotationOnHeightmap = iGaiaLandscapeHeightmapHelper::Get_RotationOnHeightmap(m_heightmapData, m_heightmapWidth, m_heightmapHeight, m_position, m_heightmapScaleFactor);
    m_rotation = vec3(rotationOnHeightmap.x, m_rotation.y, rotationOnHeightmap.y);
    return true;
}

bool iGaiaNavigator::MoveBackward(void)
{
    vec3 precomputePosition = vec3(m_position.x - cosf(-m_rotation.y) * m_moveBackwardSpeed, 0.0f, m_position.z - sinf(-m_rotation.y) * m_moveBackwardSpeed);
    if(floorf(precomputePosition.x) > m_heightmapWidth ||
       floorf(precomputePosition.x) < 0 ||
       floorf(precomputePosition.z) > m_heightmapHeight ||
       floorf(precomputePosition.z) < 0
       )
    {
        return false;
    }
    f32 height = iGaiaLandscapeHeightmapHelper::Get_HeightValue(m_heightmapData, m_heightmapWidth, m_heightmapHeight, m_heightmapScaleFactor, vec2(precomputePosition.x, precomputePosition.z));
    m_position = vec3(precomputePosition.x, height, precomputePosition.z);
    vec2 rotationOnHeightmap = iGaiaLandscapeHeightmapHelper::Get_RotationOnHeightmap(m_heightmapData, m_heightmapWidth, m_heightmapHeight, m_position, m_heightmapScaleFactor);
    m_rotation = vec3(rotationOnHeightmap.x, m_rotation.y, rotationOnHeightmap.y);
    return true;
}

bool iGaiaNavigator::MoveLeft(void)
{
    vec3 precomputePosition = vec3(m_position.x - sinf(m_rotation.y) * m_strafeSpeed, 0.0f, m_position.z - cosf(m_rotation.y) * m_strafeSpeed);
    if(floorf(precomputePosition.x) > m_heightmapWidth ||
       floorf(precomputePosition.x) < 0 ||
       floorf(precomputePosition.z) > m_heightmapHeight ||
       floorf(precomputePosition.z) < 0
       )
    {
        return false;
    }
    f32 height = iGaiaLandscapeHeightmapHelper::Get_HeightValue(m_heightmapData, m_heightmapWidth, m_heightmapHeight, m_heightmapScaleFactor, vec2(precomputePosition.x, precomputePosition.z));
    m_position = vec3(precomputePosition.x, height, precomputePosition.z);
    vec2 rotationOnHeightmap = iGaiaLandscapeHeightmapHelper::Get_RotationOnHeightmap(m_heightmapData, m_heightmapWidth, m_heightmapHeight, m_position, m_heightmapScaleFactor);
    m_rotation = vec3(rotationOnHeightmap.x, m_rotation.y, rotationOnHeightmap.y);
    return true;
}

bool iGaiaNavigator::MoveRight(void)
{
    vec3 precomputePosition = vec3(m_position.x + sinf(m_rotation.y) * m_strafeSpeed, 0.0f, m_position.z + cosf(m_rotation.y) * m_strafeSpeed);
    if(floorf(precomputePosition.x) > m_heightmapWidth ||
       floorf(precomputePosition.x) < 0 ||
       floorf(precomputePosition.z) > m_heightmapHeight ||
       floorf(precomputePosition.z) < 0
       )
    {
        return false;
    }
    f32 height = iGaiaLandscapeHeightmapHelper::Get_HeightValue(m_heightmapData, m_heightmapWidth, m_heightmapHeight, m_heightmapScaleFactor, vec2(precomputePosition.x, precomputePosition.z));
    m_position = vec3(precomputePosition.x, height, precomputePosition.z);
    vec2 rotationOnHeightmap = iGaiaLandscapeHeightmapHelper::Get_RotationOnHeightmap(m_heightmapData, m_heightmapWidth, m_heightmapHeight, m_position, m_heightmapScaleFactor);
    m_rotation = vec3(rotationOnHeightmap.x, m_rotation.y, rotationOnHeightmap.y);
    return true;
}

void iGaiaNavigator::SteerLeft(void)
{
    m_rotation.y += m_steerSpeed;
    vec2 rotationOnHeightmap = iGaiaLandscapeHeightmapHelper::Get_RotationOnHeightmap(m_heightmapData, m_heightmapWidth, m_heightmapHeight, m_position, m_heightmapScaleFactor);
    m_rotation = vec3(rotationOnHeightmap.x, m_rotation.y, rotationOnHeightmap.y);
}

void iGaiaNavigator::SteerRight(void)
{
    m_rotation.y -= m_steerSpeed;
    vec2 rotationOnHeightmap = iGaiaLandscapeHeightmapHelper::Get_RotationOnHeightmap(m_heightmapData, m_heightmapWidth, m_heightmapHeight, m_position, m_heightmapScaleFactor);
    m_rotation = vec3(rotationOnHeightmap.x, m_rotation.y, rotationOnHeightmap.y);
}


vec3 iGaiaNavigator::Get_Position(void)
{
    return m_position;
}

void iGaiaNavigator::Set_Position(const vec3& _position)
{
    m_position = _position;
}

vec3 iGaiaNavigator::Get_Rotation(void)
{
    return m_rotation;
}

void iGaiaNavigator::Set_Rotation(const vec3& _rotation)
{
    m_rotation = _rotation;
}

void iGaiaNavigator::Set_MoveForwardSpeed(f32 _speed)
{
    m_moveForwardSpeed = _speed;
}

void iGaiaNavigator::Set_MoveBackwardSpeed(f32 _speed)
{
    m_moveBackwardSpeed = _speed;
}

void iGaiaNavigator::Set_StrafeSpeed(f32 _speed)
{
    m_strafeSpeed = _speed;
}

void iGaiaNavigator::Set_SteerSpeed(f32 _speed)
{
    m_steerSpeed = _speed;
}

