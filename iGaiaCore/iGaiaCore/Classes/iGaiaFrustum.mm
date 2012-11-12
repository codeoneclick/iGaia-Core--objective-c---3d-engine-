//
//  iGaiaFrustum.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaFrustum.h"
#import "iGaiaCamera.h"

vec3 iGaiaFrustum::iGaiaPlane::Normal(void)
{
    return m_normal;
}

f32 iGaiaFrustum::iGaiaPlane::Offset(void)
{
    return m_offset;
}

f32 iGaiaFrustum::iGaiaPlane::Distance(const vec3 &_point)
{
     return (m_offset + dot(m_normal, _point)) * -1.0f;
}

void iGaiaFrustum::iGaiaPlane::Update(const vec3 &_point_01, const vec3 &_point_02, const vec3 &_point_03)
{
    vec3 edge_01, edge_02;
	edge_01 = _point_01 - _point_02;
	edge_02 = _point_03 - _point_02;
	m_normal = normalize(cross(edge_01, edge_02));
	m_offset = -dot(m_normal, _point_02);
}

iGaiaFrustum::iGaiaFrustum(iGaiaCamera* _camera)
{
    m_cameraReference = _camera;
}

iGaiaFrustum::~iGaiaFrustum(void)
{
    m_cameraReference = nullptr;
}

void iGaiaFrustum::OnUpdate(void)
{
    f32 tan = tanf(radians(m_cameraReference->Get_Fov()) * 0.5f);
	f32 nearHeight = m_cameraReference->Get_Near() * tan;
	f32 nearWidth = nearHeight * m_cameraReference->Get_Aspect();
	f32 farHeight = m_cameraReference->Get_Far()  * tan;
	f32 farWidth = farHeight * m_cameraReference->Get_Aspect();

	vec3 basis_Z = normalize(m_cameraReference->Get_Position() - m_cameraReference->Get_LookAt());
	vec3 basis_X = normalize(cross(m_cameraReference->Get_Up(), basis_Z));
	vec3 basis_Y = cross(basis_Z, basis_X);

	vec3 nearOffset = m_cameraReference->Get_Position() - basis_Z * m_cameraReference->Get_Near();
	vec3 farOffset = m_cameraReference->Get_Position() - basis_Z * m_cameraReference->Get_Far();

	vec3 nearTopLeftPoint = nearOffset + basis_Y * nearHeight - basis_X * nearWidth;
	vec3 nearTopRightPoint = nearOffset + basis_Y * nearHeight + basis_X * nearWidth;
	vec3 nearBottomLeftPoint = nearOffset - basis_Y * nearHeight - basis_X * nearWidth;
	vec3 nearBottomRightPoint = nearOffset - basis_Y * nearHeight + basis_X * nearWidth;

	vec3 farTopLeftPoint = farOffset + basis_Y * farHeight - basis_X * farWidth;
	vec3 farTopRightPoint = farOffset + basis_Y * farHeight + basis_X * farWidth;
	vec3 farBottomLeftPoint = farOffset - basis_Y * farHeight - basis_X * farWidth;
	vec3 farBottomRightPoint = farOffset - basis_Y * farHeight + basis_X * farWidth;

	m_planes[iGaia_E_FrustumPlaneTop].Update(nearTopRightPoint, nearTopLeftPoint, farTopLeftPoint);
	m_planes[iGaia_E_FrustumPlaneBottom].Update(nearBottomLeftPoint, nearBottomRightPoint, farBottomRightPoint);
	m_planes[iGaia_E_FrustumPlaneLeft].Update(nearTopLeftPoint, nearBottomLeftPoint, farBottomLeftPoint);
	m_planes[iGaia_E_FrustumPlaneRight].Update(nearBottomRightPoint, nearTopRightPoint, farBottomRightPoint);
	m_planes[iGaia_E_FrustumPlaneNear].Update(nearTopLeftPoint, nearTopRightPoint, nearBottomRightPoint);
	m_planes[iGaia_E_FrustumPlaneFar].Update(farTopRightPoint, farTopLeftPoint, farBottomLeftPoint);
}

iGaiaFrustum::iGaia_E_FrustumResult iGaiaFrustum::IsPointInFrustum(const vec3& _point)
{
    for(ui32 i = 0; i < iGaia_E_FrustumPlaneMaxValue; ++i)
    {
		if (m_planes[i].Distance(_point) < 0.0f)
        {
			return iGaia_E_FrustumResultOutside;
        }
	}
	return iGaia_E_FrustumResultInside;
}

iGaiaFrustum::iGaia_E_FrustumResult iGaiaFrustum::IsSphereInFrumstum(const vec3& _center, f32 _radius)
{
    i32 result = iGaia_E_FrustumResultInside;
	for(ui32 i = 0; i < iGaia_E_FrustumPlaneMaxValue; ++i)
    {
		f32 distance = m_planes[i].Distance(_center);
		if (distance < -_radius)
        {
			return iGaia_E_FrustumResultOutside;
        }
		else if (distance < _radius)
        {
			result =  iGaia_E_FrustumResultIntersect;
        }
	}
	return static_cast<iGaia_E_FrustumResult>(result);
}

iGaiaFrustum::iGaia_E_FrustumResult iGaiaFrustum::IsBoundBoxInFrustum(const vec3& _maxBound, const vec3& _minBound)
{
    i32 result = iGaia_E_FrustumResultInside;
    glm::vec3 operatingMaxBound, operatingMinBound;

    for(int i = 0; i < iGaia_E_FrustumPlaneMaxValue; ++i)
    {
        glm::vec3 normal = m_planes[i].Normal();
        if(normal.x > 0)
        {
            operatingMinBound.x = _minBound.x;
            operatingMaxBound.x = _maxBound.x;
        }
        else
        {
            operatingMinBound.x = _maxBound.x;
            operatingMaxBound.x = _minBound.x;
        }
        if(normal.y > 0)
        {
            operatingMinBound.y = _minBound.y;
            operatingMaxBound.y = _maxBound.y;
        }
        else
        {
            operatingMinBound.y = _maxBound.y;
            operatingMaxBound.y = _minBound.y;
        }
        if(normal.z > 0)
        {
            operatingMinBound.z = _minBound.z;
            operatingMaxBound.z = _maxBound.z;
        }
        else
        {
            operatingMinBound.z = _maxBound.z;
            operatingMaxBound.z = _minBound.z;
        }
        if(glm::dot(normal, operatingMinBound) + m_planes[i].Offset() > 0)
        {
            return iGaia_E_FrustumResultOutside;
        }
        if(glm::dot(normal, operatingMaxBound) + m_planes[i].Offset() >= 0)
        {
            result = iGaia_E_FrustumResultIntersect;
        }
    }
    return static_cast<iGaia_E_FrustumResult>(result);
}
