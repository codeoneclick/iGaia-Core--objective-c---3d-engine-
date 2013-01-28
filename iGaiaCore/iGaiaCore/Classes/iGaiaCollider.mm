//
//  iGaiaCollider.cpp
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/28/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#include "iGaiaCollider.h"
#include "iGaiaLogger.h"

iGaiaColliderDataMapper::iGaiaColliderDataMapper(void)
{
    m_vertexes = nullptr;
    m_indexes = nullptr;

    m_numIndexes = 0;
    m_numVertexes = 0;
}

iGaiaColliderDataMapper::~iGaiaColliderDataMapper(void)
{
    delete m_vertexes;
    delete m_indexes;
}


void iGaiaColliderDataMapper::Deserialize(iGaiaVertexBufferObject* _vertexBuffer, iGaiaIndexBufferObject* _indexBuffer, const mat4x4& _matrix)
{
    assert(_vertexBuffer != nullptr);
    assert(_vertexBuffer->Lock() != nullptr);
    
    assert(_indexBuffer != nullptr);
    assert(_indexBuffer->Lock() != nullptr);

    assert(m_vertexes == nullptr);
    assert(m_indexes == nullptr);

    m_numVertexes = _vertexBuffer->Get_NumVertexes();
    m_numIndexes = _indexBuffer->Get_NumIndexes();

    m_vertexes = new vec3[m_numVertexes];
    m_indexes = new ui32[m_numIndexes];

    iGaiaVertexBufferObject::iGaiaVertex* vertexData = _vertexBuffer->Lock();
    ui16* indexData = _indexBuffer->Lock();

    for(ui32 i = 0; i < m_numVertexes; ++i)
    {
        vec4 position = vec4(vertexData[i].m_position.x, vertexData[i].m_position.y, vertexData[i].m_position.z, 1.0f);
        position = _matrix * position;
        m_vertexes[i] = vec3(position.x, position.y, position.z);
    }

    for(ui32 i = 0; i < m_numIndexes; ++i)
    {
        m_indexes[i] = static_cast<ui32>(indexData[i]);
    }
}

vec3* iGaiaColliderDataMapper::Get_Vertexes(void)
{
    assert(m_vertexes != nullptr);
    return m_vertexes;
}

ui32 iGaiaColliderDataMapper::Get_NumVertexes(void)
{
    return m_numVertexes;
}

ui32* iGaiaColliderDataMapper:: Get_Indexes(void)
{
    assert(m_indexes != nullptr);
    return m_indexes;
}

ui32 iGaiaColliderDataMapper::Get_NumIndexes(void)
{
    return m_numIndexes;
}


iGaiaColliderDataCallback::iGaiaColliderDataCallback(void)
{
    m_colliderDataDeserializeListener = nullptr;
}

iGaiaColliderDataCallback::~iGaiaColliderDataCallback(void)
{
    
}

void iGaiaColliderDataCallback::Set_ColliderDataDeserializeListener(const __ColliderDataDeserializeListener &_listener)
{
    assert(_listener != nullptr);
    m_colliderDataDeserializeListener = _listener;
}

void iGaiaColliderDataCallback::NotifyColliderDataDeserializeListener(iGaiaColliderDataMapper *_mapper)
{
    assert(m_colliderDataDeserializeListener != nullptr);
    m_colliderDataDeserializeListener(_mapper);
}

iGaiaColliderData_PROTOCOL::iGaiaColliderData_PROTOCOL(void)
{

}

iGaiaColliderData_PROTOCOL::~iGaiaColliderData_PROTOCOL(void)
{
 
}

void iGaiaColliderData_PROTOCOL::ConnectColliderDataCallback(void)
{
    m_colliderDataCallback.Set_ColliderDataDeserializeListener(bind(&iGaiaColliderData_PROTOCOL::ColliderDataDeserializeReceiver, this, placeholders::_1));
}

void iGaiaColliderData_PROTOCOL::ColliderDataDeserializeReceiver(iGaiaColliderDataMapper *_mapper)
{
    assert(false);
}

iGaiaCollider::iGaiaCollider(iGaiaColliderData_PROTOCOL* _collider)
{
    assert(_collider != nullptr);
    m_collider = _collider;
}

iGaiaCollider::~iGaiaCollider(void)
{
    
}

void iGaiaCollider::Unproject(const mat4x4 &_matrixProjection, const mat4x4 &_matrixView, const vec4 &_viewport, const vec2 &_point)
{
    f32 screenX =  -((( 2.0f * _point.x ) / _viewport.z) - 1.0f ) / _matrixProjection[0][0];
    f32 screenY =  -((( 2.0f * (_viewport.w - _point.y) ) / _viewport.w) - 1.0f ) / _matrixProjection[1][1];
    mat4x4 inverseView = inverse(_matrixView);

    m_direction.x  = (screenX * inverseView[0][0] + screenY * inverseView[1][0] + inverseView[2][0]);
    m_direction.y  = (screenX * inverseView[0][1] + screenY * inverseView[1][1] + inverseView[2][1]);
    m_direction.z  = (screenX * inverseView[0][2] + screenY * inverseView[1][2] + inverseView[2][2]);
    m_origin.x = inverseView[3][0];
    m_origin.y = inverseView[3][1];
    m_origin.z = inverseView[3][2];
}

bool iGaiaCollider::Collide(const mat4x4 &_matrixProjection, const mat4x4 &_matrixView, const vec4 &_viewport, const vec2 &_point)
{
    assert(m_collider != nullptr);
    
    Unproject(_matrixProjection, _matrixView, _viewport, _point);

    iGaiaColliderDataMapper mapper;
    m_collider->m_colliderDataCallback.NotifyColliderDataDeserializeListener(&mapper);

    vec3* vertexes = mapper.Get_Vertexes();

    ui32* indexes = mapper.Get_Indexes();
    ui32 numIndexes = mapper.Get_NumIndexes();

    assert(vertexes != nullptr);
    assert(indexes != nullptr);

    for(ui32 i = 0; i < numIndexes; i += 3)
    {
        vec3 point_01 = vertexes[indexes[i + 0]];
        vec3 point_02 = vertexes[indexes[i + 1]];
        vec3 point_03 = vertexes[indexes[i + 2]];

        vec3 edge_01 = point_02 - point_01;
        vec3 edge_02 = point_03 - point_01;

        vec3 p_vector = cross(m_direction, edge_02);
        f32 determinant = dot(edge_01, p_vector);
        if(fabs(determinant) < 0.0001f)
        {
            continue;
        }

        f32 inverseDeterminant = 1.0f / determinant;

        vec3 t_vector = m_origin - point_01;
        f32 u = dot(t_vector, p_vector) * inverseDeterminant;
        if(u < -0.0001f || u > 1.0001f)
        {
            continue;
        }

        vec3 q_vector = cross(t_vector, edge_01);
        f32 v = dot(m_direction, q_vector) * inverseDeterminant;
        if(v < -0.0001f || (v + u) > 1.0001f)
        {
            continue;
        }

        m_collidePoint = point_01 + (edge_01 * u) + (edge_02 * v);
        iGaiaLog("Collide point : x :%f, y :%f, z :%f", m_collidePoint.x, m_collidePoint.y, m_collidePoint.z);
        return true;
    }
    return false;
}

vec3 iGaiaCollider::Get_CollidePoint(void)
{
    return m_collidePoint;
}

