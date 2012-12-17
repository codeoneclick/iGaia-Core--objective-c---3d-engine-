//
//  iGaiaNavigationHelper.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/17/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaNavigationHelperClass
#define iGaiaNavigationHelperClass

#import "iGaiaCommon.h"
#import "iGaiaCamera.h"

class iGaiaNavigationHelper
{
private:
    
    f32 m_moveForwardSpeed;
    f32 m_moveBackwardSpeed;
    f32 m_strafeSpeed;
    f32 m_steerSpeed;

    vec3 m_position;
    vec3 m_rotation;

    iGaiaCamera* m_camera;

    f32* m_heightmapData;
    vec2 m_heightmapScaleFactor;
    ui32 m_heightmapWidth;
    ui32 m_heightmapHeight;
    
protected:

public:
    
    iGaiaNavigationHelper(f32 _moveForwardSpeed, f32 _moveBackwardSpeed, f32 _strafeSpeed, f32 _steerSpeed);
    ~iGaiaNavigationHelper(void) = default;

    void Set_Camera(iGaiaCamera* _camera);
    void Set_Heightmap(f32* _heightmapData, ui32 _heightmapWidth, ui32 _heightmapHeight, vec2 _heightmapScaleFactor);

    bool MoveForward(void);
    bool MoveBackward(void);
    bool MoveLeft(void);
    bool MoveRight(void);

    void SteerLeft(void);
    void SteerRight(void);

    vec3 Get_Position(void);
    void Set_Position(const vec3& _position);

    vec3 Get_Rotation(void);
    void Set_Rotation(const vec3& _rotation);

    void Set_MoveForwardSpeed(f32 _speed);
    void Set_MoveBackwardSpeed(f32 _speed);
    void Set_StrafeSpeed(f32 _speed);
    void Set_SteerSpeed(f32 _speed);
};

#endif