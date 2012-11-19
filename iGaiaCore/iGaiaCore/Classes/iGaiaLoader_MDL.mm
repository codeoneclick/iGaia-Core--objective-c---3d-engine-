//
//  iGaiaLoader_MDL.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaLoader_MDL.h"

iGaiaLoader_MDL::iGaiaLoader_MDL(void)
{
     m_status = iGaia_E_LoadStatusNone;
}

iGaiaLoader_MDL::~iGaiaLoader_MDL(void)
{
    
}

void iGaiaLoader_MDL::ParseFileWithName(const string &_name)
{
    m_status = iGaia_E_LoadStatusProcess;
    m_name = _name;

    string path([[[NSBundle mainBundle] resourcePath] UTF8String]);
    path.append("/");
    path.append(m_name);

    std::ifstream stream;
    stream.open(path.c_str(), ios::binary);
    stream.read((char*)&m_numVertexes, sizeof(ui32));
    stream.read((char*)&m_numIndexes, sizeof(ui32));
    
    m_vertexData = new iGaiaVertexBufferObject::iGaiaVertex[m_numVertexes];

    for(ui32 i = 0; i < m_numVertexes; ++i)
    {
        glm::vec3 position;
        stream.read((char*)&position, sizeof(vec3));
        glm::vec3 normal;
        stream.read((char*)&normal, sizeof(vec3));
        glm::vec3 tangent;
        stream.read((char*)&tangent, sizeof(vec3));
        glm::vec2 texcoord;
        stream.read((char*)&texcoord, sizeof(vec2));

        m_vertexData[i].m_position = position;
        m_vertexData[i].m_texcoord = texcoord;
        m_vertexData[i].m_normal = iGaiaVertexBufferObject::CompressVec3(normal);
        m_vertexData[i].m_tangent = iGaiaVertexBufferObject::CompressVec3(tangent);
    }

    m_indexData = new ui16[m_numIndexes];

    for(ui32 i = 0; i < m_numIndexes; ++i)
    {
        stream.read((char*)&m_indexData[i], sizeof(ui16));
    }

    for(ui32 i = 0; i < m_numIndexes; i += 3)
    {
        unsigned short index = m_indexData[i + 1];
        m_indexData[i + 1] = m_indexData[i + 2];
        m_indexData[i + 2] = index;
    }
    
    stream.close();
    m_status = iGaia_E_LoadStatusDone;
}

iGaiaResource* iGaiaLoader_MDL::CommitToVRAM(void)
{
    iGaiaVertexBufferObject* vertexBuffer = new iGaiaVertexBufferObject(m_numVertexes, GL_STATIC_DRAW);
    iGaiaVertexBufferObject::iGaiaVertex* vertexData = vertexBuffer->Lock();
    memcpy(vertexData, m_vertexData , sizeof(iGaiaVertexBufferObject::iGaiaVertex) * m_numVertexes);
    vertexBuffer->Unlock();

    iGaiaIndexBufferObject* indexBuffer = new iGaiaIndexBufferObject(m_numIndexes, GL_STATIC_DRAW);
    ui16* indexData = indexBuffer->Lock();
    memcpy(indexData, m_indexData, sizeof(ui16) * m_numIndexes);
    indexBuffer->Unlock();

    iGaiaMesh* mesh = new iGaiaMesh(vertexBuffer, indexBuffer, m_name, iGaiaResource::iGaia_E_CreationModeNative);

    for(iGaiaLoadCallback* listener : m_listeners)
    {
        mesh->IncReferenceCount();
        listener->OnLoad(mesh);
    }
    m_listeners.clear();
    return mesh;
}
