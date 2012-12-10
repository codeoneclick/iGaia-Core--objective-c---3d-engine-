//
//  iGaiaCamera.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaCameraClass
#define iGaiaCameraClass

#include "iGaiaFrustum.h"
#include "iGaiaUpdateCallback.h"
#include "iGaiaUpdateMgr.h"

class iGaiaCamera
{
private:
    
    mat4x4 m_view;
    mat4x4 m_reflection;
    mat4x4 m_projection;

    vec3 m_position;
    vec3 m_look;
    vec3 m_up;
    f32 m_rotation;
    f32 m_altitude;
    f32 m_distance;
    f32 m_fov;
    f32 m_aspect;

    f32 m_near;
    f32 m_far;
    
    iGaiaFrustum* m_frustum;

    iGaiaUpdateCallback m_updateCallback;
    
    iGaiaUpdateMgr* m_updateMgr;

    void OnUpdate(void);
    
protected:

public:
    iGaiaCamera(f32 _fov, f32 _near, f32 _far, vec4 _viewport);
    ~iGaiaCamera(void);

    mat4x4 Get_ViewMatrix(void);
    mat4x4 Get_ProjectionMatrix(void);
    mat4x4 Get_ViewReflectionMatrix(void);

    void Set_Position(const vec3& _position);
    vec3 Get_Position(void);

    void Set_LookAt(const vec3& _look);
    vec3 Get_LookAt(void);

    vec3 Get_Up(void);

    void Set_Rotation(f32 _rotation);
    f32 Get_Rotation(void);

    void Set_Altitude(f32 _altitude);
    f32 Get_Altitude(void);

    void Set_Distance(f32 _distance);
    f32 Get_Distance(void);

    f32 Get_Fov(void);
    f32 Get_Aspect(void);

    f32 Get_Near(void);
    f32 Get_Far(void);

    mat4x4 Get_SphericalMatrixForPosition(const vec3& _position);
    mat4x4 Get_CylindricalMatrixForPosition(const vec3& _position);

    void Set_UpdateMgr(iGaiaUpdateMgr* _updateMgr);

    void ListenUpdateMgr(bool _value);
};

#endif