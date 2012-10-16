//
//  iGaiaFrustum.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaFrustum.h"
#import "iGaiaCamera.h"

class iGaiaPlane
{
protected:
    glm::vec3 m_normal;
    float m_offset;
public:
    iGaiaPlane(void);
    ~iGaiaPlane(void);
    void Update(const glm::vec3& point_01, const glm::vec3& point_02, const glm::vec3& point_03);
    float Distance(const glm::vec3& point);
    inline glm::vec3 Normal(void) { return m_normal; }
    inline float Offset(void) { return m_offset; }
};

iGaiaPlane::iGaiaPlane(void)
{

}

iGaiaPlane::~iGaiaPlane(void)
{

}

float iGaiaPlane::Distance(const glm::vec3 &point)
{
    return (m_offset + glm::dot(m_normal, point)) * -1.0f;
}

void iGaiaPlane::Update(const glm::vec3& point_01, const glm::vec3& point_02, const glm::vec3& point_03)
{
    glm::vec3 edge_01, edge_02;
	edge_01 = point_01 - point_02;
	edge_02 = point_03 - point_02;
	m_normal = glm::normalize(glm::cross(edge_01, edge_02));
	m_offset = -glm::dot(m_normal, point_02);
}

enum E_FRUSTUM_PLANE
{
    E_FRUSTUM_PLANE_TOP = 0,
    E_FRUSTUM_PLANE_BOTTOM,
    E_FRUSTUM_PLANE_LEFT,
    E_FRUSTUM_PLANE_RIGHT,
    E_FRUSTUM_PLANE_NEAR,
    E_FRUSTUM_PLANE_FAR,
    E_FRUSTUM_PLANE_MAX
};

@interface iGaiaFrustum()
{
    iGaiaPlane m_planes[E_FRUSTUM_PLANE_MAX];
}

@property(nonatomic, assign) iGaiaCamera* m_camera;

@end


@implementation iGaiaFrustum

- (id)initWithCamera:(iGaiaCamera *)camera
{
    self = [super init];
    if(self)
    {
        _m_camera = camera;
    }
    return self;
}

- (void)onUpdate;
{
	float tan = tanf(glm::radians(_m_camera.m_fov) * 0.5f);
	float nearHeight = _m_camera.m_near * tan;
	float nearWidth = nearHeight * _m_camera.m_aspect;
	float farHeight = _m_camera.m_far  * tan;
	float farWidth = farHeight * _m_camera.m_aspect;

	glm::vec3 basis_Z = glm::normalize(_m_camera.m_position - _m_camera.m_look);
	glm::vec3 basis_X = glm::normalize(glm::cross(_m_camera.m_up, basis_Z));
	glm::vec3 basis_Y = glm::cross(basis_Z, basis_X);

	glm::vec3 nearOffset = _m_camera.m_position - basis_Z * _m_camera.m_near;
	glm::vec3 farOffset = _m_camera.m_position - basis_Z * _m_camera.m_far;

	glm::vec3 nearTopLeftPoint = nearOffset + basis_Y * nearHeight - basis_X * nearWidth;
	glm::vec3 nearTopRightPoint = nearOffset + basis_Y * nearHeight + basis_X * nearWidth;
	glm::vec3 nearBottomLeftPoint = nearOffset - basis_Y * nearHeight - basis_X * nearWidth;
	glm::vec3 nearBottomRightPoint = nearOffset - basis_Y * nearHeight + basis_X * nearWidth;

	glm::vec3 farTopLeftPoint = farOffset + basis_Y * farHeight - basis_X * farWidth;
	glm::vec3 farTopRightPoint = farOffset + basis_Y * farHeight + basis_X * farWidth;
	glm::vec3 farBottomLeftPoint = farOffset - basis_Y * farHeight - basis_X * farWidth;
	glm::vec3 farBottomRightPoint = farOffset - basis_Y * farHeight + basis_X * farWidth;

	m_planes[E_FRUSTUM_PLANE_TOP].Update(nearTopRightPoint, nearTopLeftPoint, farTopLeftPoint);
	m_planes[E_FRUSTUM_PLANE_BOTTOM].Update(nearBottomLeftPoint, nearBottomRightPoint, farBottomRightPoint);
	m_planes[E_FRUSTUM_PLANE_LEFT].Update(nearTopLeftPoint, nearBottomLeftPoint, farBottomLeftPoint);
	m_planes[E_FRUSTUM_PLANE_RIGHT].Update(nearBottomRightPoint, nearTopRightPoint, farBottomRightPoint);
	m_planes[E_FRUSTUM_PLANE_NEAR].Update(nearTopLeftPoint, nearTopRightPoint, nearBottomRightPoint);
	m_planes[E_FRUSTUM_PLANE_FAR].Update(farTopRightPoint, farTopLeftPoint, farBottomLeftPoint);
}

- (int)isPointInFrustum:(const glm::vec3 &)point
{
	for(NSUInteger i = 0; i < E_FRUSTUM_PLANE_MAX; ++i)
    {
		if (m_planes[i].Distance(point) < 0.0f)
        {
			return E_FRUSTUM_RESULT_OUTSIDE;
        }
	}
	return E_FRUSTUM_RESULT_INSIDE;
}

- (int)isSphereInFrustum:(const glm::vec3&)position withRadius:(float)radius
{
    int result = E_FRUSTUM_RESULT_INSIDE;
	for(int i = 0; i < E_FRUSTUM_PLANE_MAX; ++i)
    {
		float distance = m_planes[i].Distance(position);
		if (distance < -radius)
        {
			return E_FRUSTUM_RESULT_OUTSIDE;
        }
		else if (distance < radius)
        {
			result =  E_FRUSTUM_RESULT_INTERSECT;
        }
	}
	return result;
}

- (int)isBoundBoxInFrustumWithMaxBound:(const glm::vec3&)maxBound withMinBound:(const glm::vec3&)minBound
{
    int result = E_FRUSTUM_RESULT_INSIDE;
    glm::vec3 operatingMaxBound, operatingMinBound;

    for(int i = 0; i < E_FRUSTUM_PLANE_MAX; ++i)
    {
        glm::vec3 normal = m_planes[i].Normal();
        if(normal.x > 0)
        {
            operatingMinBound.x = minBound.x;
            operatingMaxBound.x = maxBound.x;
        }
        else
        {
            operatingMinBound.x = maxBound.x;
            operatingMaxBound.x = minBound.x;
        }
        if(normal.y > 0)
        {
            operatingMinBound.y = minBound.y;
            operatingMaxBound.y = maxBound.y;
        }
        else
        {
            operatingMinBound.y = maxBound.y;
            operatingMaxBound.y = minBound.y;
        }
        if(normal.z > 0)
        {
            operatingMinBound.z = minBound.z;
            operatingMaxBound.z = maxBound.z;
        }
        else
        {
            operatingMinBound.z = maxBound.z;
            operatingMaxBound.z = minBound.z;
        }
        if(glm::dot(normal, operatingMinBound) + m_planes[i].Offset() > 0)
        {
            return E_FRUSTUM_RESULT_OUTSIDE;
        }
        if(glm::dot(normal, operatingMaxBound) + m_planes[i].Offset() >= 0)
        {
            result = E_FRUSTUM_RESULT_INTERSECT;
        }
    }
    return result;
}

@end
