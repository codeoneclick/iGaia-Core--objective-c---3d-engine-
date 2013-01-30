//
//  iGaiaMesh.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaMesh.h"

iGaiaMesh::iGaiaMesh(iGaiaVertexBufferObject* _vertexBuffer, iGaiaIndexBufferObject* _indexBuffer, const string& _name, iGaiaResource::iGaia_E_CreationMode _mode)
{
    assert(_vertexBuffer != nullptr);
    assert(_indexBuffer != nullptr);
    
    m_resourceType = iGaia_E_ResourceTypeMesh;
    m_creationMode = _mode;
    m_vertexBuffer = _vertexBuffer;
    m_indexBuffer = _indexBuffer;
    m_name = _name;

    m_maxBound = glm::vec3( -4096.0f, -4096.0f, -4096.0f );
    m_minBound = glm::vec3(  4096.0f,  4096.0f,  4096.0f );
}

iGaiaMesh::~iGaiaMesh(void)
{
    delete m_vertexBuffer;
    delete m_indexBuffer;
}

void iGaiaMesh::FillBoundBox(void)
{
    assert(m_vertexBuffer->Lock() != nullptr);
    assert(m_indexBuffer->Lock() != nullptr);
    
    iGaiaVertexBufferObject::iGaiaVertex* vertexData = m_vertexBuffer->Lock();
    for(unsigned int i = 0; i < m_vertexBuffer->Get_NumVertexes(); ++i)
    {
        if(vertexData[i].m_position.x > m_maxBound.x)
        {
            m_maxBound.x = vertexData[i].m_position.x;
        }
        if(vertexData[i].m_position.y > m_maxBound.y)
        {
            m_maxBound.y = vertexData[i].m_position.y;
        }
        if(vertexData[i].m_position.z > m_maxBound.z)
        {
            m_maxBound.z = vertexData[i].m_position.z;
        }
        if(vertexData[i].m_position.x < m_minBound.x)
        {
            m_minBound.x = vertexData[i].m_position.x;
        }
        if(vertexData[i].m_position.y < m_minBound.y)
        {
            m_minBound.y = vertexData[i].m_position.y;
        }
        if(vertexData[i].m_position.z < m_minBound.z)
        {
            m_minBound.z = vertexData[i].m_position.z;
        }
    }
}

void iGaiaMesh::Set_Settings(const map<ui32, ui32> &_settings)
{
    m_settings = _settings;
}

map<ui32, ui32> iGaiaMesh::Get_Settings(void)
{
    return m_settings;
}

iGaiaVertexBufferObject* iGaiaMesh::Get_VertexBuffer(void)
{
    return m_vertexBuffer;
}

iGaiaIndexBufferObject* iGaiaMesh::Get_IndexBuffer(void)
{
    return m_indexBuffer;
}

ui32 iGaiaMesh::Get_NumVertexes(void)
{
    return m_vertexBuffer->Get_NumVertexes();
}

ui32 iGaiaMesh::Get_NumIndexes(void)
{
    return m_indexBuffer->Get_NumIndexes();
}

vec3 iGaiaMesh::Get_MaxBound(void)
{
    return m_maxBound;
}

vec3 iGaiaMesh::Get_MinBound(void)
{
    return m_minBound;
}

void iGaiaMesh::Bind(void)
{
    m_vertexBuffer->Bind();
    m_indexBuffer->Bind();
}

void iGaiaMesh::Unbind(void)
{
    m_vertexBuffer->Unbind();
    m_indexBuffer->Unbind();
}


