//
//  iGaiaTouchCrosser.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaTouchCrosser.h"
#import "iGaiaLogger.h"

iGaiaTouchCrosser::iGaiaTouchCrosser(void)
{

}

iGaiaTouchCrosser::~iGaiaTouchCrosser(void)
{
    
}

inline void iGaiaTouchCrosser::Set_Camera(iGaiaCamera *_camera)
{
    m_cameraReference = _camera;
}


inline void iGaiaTouchCrosser::AddEventListener(iGaiaCrossCallback* _listener)
{
    m_listeners.insert(_listener);
}

inline void iGaiaTouchCrosser::RemoveEventListener(iGaiaCrossCallback* _listener)
{
    m_listeners.erase(_listener);
}

iGaiaTouchCrosser::iGaiaRay iGaiaTouchCrosser::Unproject(const vec2& _point)
{
    mat4x4 projection = m_cameraReference->Get_ProjectionMatrix();
    CGRect viewport = CGRectMake(0, 0, 320, 480);
    f32 screenX =  -((( 2.0f * _point.x ) / viewport.size.width) - 1.0f ) / projection[0][0];
    f32 screenY =  -((( 2.0f * (viewport.size.height - _point.y) ) / viewport.size.height) - 1.0f ) / projection[1][1];
    mat4x4 inverseView = inverse(m_cameraReference->Get_ViewMatrix());

    iGaiaRay ray;
    ray.m_direction.x  = (screenX * inverseView[0][0] + screenY * inverseView[1][0] + inverseView[2][0]);
    ray.m_direction.y  = (screenX * inverseView[0][1] + screenY * inverseView[1][1] + inverseView[2][1]);
    ray.m_direction.z  = (screenX * inverseView[0][2] + screenY * inverseView[1][2] + inverseView[2][2]);
    ray.m_origin.x = inverseView[3][0];
    ray.m_origin.y = inverseView[3][1];
    ray.m_origin.z = inverseView[3][2];
    return ray;
}

bool iGaiaTouchCrosser::IsCross(iGaiaCrossCallback *_listener, const iGaiaTouchCrosser::iGaiaRay &_ray)
{
    iGaiaVertexBufferObject::iGaiaVertex* vertexData = _listener->Get_CrossOperationVertexData();
    ui16* indexData = _listener->Get_CrossOperationIndexData();
    for(ui32 i = 0; i < _listener->Get_CrossOperationNumIndexes(); i += 3)
    {
        vec3 point_01 = vertexData[indexData[i + 0]].m_position;
        vec3 point_02 = vertexData[indexData[i + 1]].m_position;
        vec3 point_03 = vertexData[indexData[i + 2]].m_position;

        vec3 edge_01 = point_02 - point_01;
        vec3 edge_02 = point_03 - point_01;

        vec3 p_vector = cross(_ray.m_direction, edge_02);
        f32 determinant = dot(edge_01, p_vector);
        if(fabs(determinant) < 0.0001f)
        {
            continue;
        }

        f32 inverseDeterminant = 1.0f / determinant;

        vec3 t_vector = _ray.m_origin - point_01;
        f32 u = dot(t_vector, p_vector) * inverseDeterminant;
        if(u < -0.0001f || u > 1.0001f)
        {
            continue;
        }

        vec3 q_vector = cross(t_vector, edge_01);
        f32 v = glm::dot(_ray.m_direction, q_vector) * inverseDeterminant;
        if(v < -0.0001f || (v + u) > 1.0001f)
        {
            continue;
        }

        glm::vec3 crossPoint = point_01 + (edge_01 * u) + (edge_02 * v);
        iGaiaLog(@"Cross Point : x :%f, y :%f, z :%f", crossPoint.x, crossPoint.y, crossPoint.z);
        return true;
    }
    return false;
}

void iGaiaTouchCrosser::OnTouch(f32 _x, f32 _y)
{
    iGaiaRay ray = Unproject(vec2(_x, _y));

    for(iGaiaCrossCallback* listener : m_listeners)
    {
        if(IsCross(listener, ray));
        {
            listener->OnCross();
        }
    }
}
