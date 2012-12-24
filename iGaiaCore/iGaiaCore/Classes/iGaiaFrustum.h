//
//  iGaiaFrustum.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaFrustumClass
#define iGaiaFrustumClass

#include "iGaiaCommon.h"

class iGaiaCamera;

class iGaiaFrustum
{
public:
    enum iGaia_E_FrustumResult
    {
        iGaia_E_FrustumResultOutside = 0,
        iGaia_E_FrustumResultIntersect,
        iGaia_E_FrustumResultInside
    };
private:
    class iGaiaPlane
    {
    protected:
        vec3 m_normal;
        f32 m_offset;
    public:
        iGaiaPlane(void) = default;
        ~iGaiaPlane(void) = default;
        void Update(const vec3& _point_01, const vec3& _point_02, const vec3& _point_03);
        f32 Distance(const vec3& _point);
        vec3 Normal(void);
        f32 Offset(void);
    };

    enum iGaia_E_FrustumPlane
    {
        iGaia_E_FrustumPlaneTop = 0,
        iGaia_E_FrustumPlaneBottom,
        iGaia_E_FrustumPlaneLeft,
        iGaia_E_FrustumPlaneRight,
        iGaia_E_FrustumPlaneNear,
        iGaia_E_FrustumPlaneFar,
        iGaia_E_FrustumPlaneMaxValue
    };

     iGaiaPlane m_planes[iGaia_E_FrustumPlaneMaxValue];
     iGaiaCamera* m_camera;
    
protected:

public:
    iGaiaFrustum(iGaiaCamera* _camera);
    ~iGaiaFrustum(void);
    
    void Set_Camera(iGaiaCamera* _camera);

    void OnUpdate(void);

    iGaia_E_FrustumResult IsPointInFrustum(const vec3& _point);
    iGaia_E_FrustumResult IsSphereInFrumstum(const vec3& _center, f32 _radius);
    iGaia_E_FrustumResult IsBoundBoxInFrustum(const vec3& _maxBound, const vec3& _minBound);
};

#endif
