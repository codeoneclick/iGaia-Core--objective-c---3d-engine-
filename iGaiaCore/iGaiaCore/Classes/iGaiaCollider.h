//
//  iGaiaCollider.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/28/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaColliderClass
#define iGaiaColliderClass

#include "iGaiaCommon.h"
#include "iGaiaMesh.h"

class iGaiaColliderDataMapper
{
private:

protected:

    vec3* m_vertexes;
    ui32 m_numVertexes;

    ui32* m_indexes;
    ui32 m_numIndexes;

public:

    iGaiaColliderDataMapper(void);
    ~iGaiaColliderDataMapper(void);

    void Deserialize(iGaiaVertexBufferObject* _vertexBuffer, iGaiaIndexBufferObject* _indexBuffer, const mat4x4& _matrix);

    vec3* Get_Vertexes(void);
    ui32 Get_NumVertexes(void);

    ui32* Get_Indexes(void);
    ui32 Get_NumIndexes(void);
};

typedef function<void(iGaiaColliderDataMapper*)> __ColliderDataDeserializeListener;

class iGaiaColliderDataCallback final
{ 
private:

    __ColliderDataDeserializeListener m_colliderDataDeserializeListener;
    
protected:

    friend class iGaiaColliderData_PROTOCOL;
    
    iGaiaColliderDataCallback(void);

    void Set_ColliderDataDeserializeListener(const __ColliderDataDeserializeListener& _listener);
    
public:

    ~iGaiaColliderDataCallback(void);

    void NotifyColliderDataDeserializeListener(iGaiaColliderDataMapper* _mapper);
};

class iGaiaColliderData_PROTOCOL
{
private:

protected:

    friend class iGaiaCollider;

    iGaiaColliderDataCallback m_colliderDataCallback;
    
    iGaiaColliderData_PROTOCOL(void);

    void ConnectColliderDataCallback(void);

    virtual void ColliderDataDeserializeReceiver(iGaiaColliderDataMapper* _mapper);
    
public:

    virtual ~iGaiaColliderData_PROTOCOL(void);
};

class iGaiaCollider
{
private:
    
protected:

    vec3 m_origin;
    vec3 m_direction;
    vec3 m_collidePoint;

    iGaiaColliderData_PROTOCOL* m_collider;
    
    void Unproject(const mat4x4& _matrixProjection, const mat4x4& _matrixView, const vec4& _viewport, const vec2& _point);
    
public:
    
    iGaiaCollider(iGaiaColliderData_PROTOCOL* _collider);
    ~iGaiaCollider(void);

    bool Collide(const mat4x4& _matrixProjection, const mat4x4& _matrixView, const vec4& _viewport, const vec2& _point);
    vec3 Get_CollidePoint(void);
    
};

#endif 
