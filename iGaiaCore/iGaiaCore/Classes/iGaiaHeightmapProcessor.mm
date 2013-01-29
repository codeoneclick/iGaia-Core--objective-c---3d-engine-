//
//  iGaiaHeightmapProcessor.cpp
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/29/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#include "iGaiaHeightmapProcessor.h"

iGaiaHeightmapProcessor::iGaiaHeightmapProcessor(const f32* _heightmap, const f32* _splatting, const ui32 _width, const ui32 _height, iGaiaTexture** _splattingTextures)
{
    m_chunkWidth = 32;
    m_chunkHeight = 32;

    m_chunkRowsCount = _width / m_chunkWidth;
    m_chunkCellsCount = _height / m_chunkHeight;

    m_heightmap = _heightmap;
    m_splatting = _splatting;

    m_height = _height;
    m_width = _width;

    m_splattingTextures = _splattingTextures;

    m_mutableLandscapeContainer = new MutableLandscapeData*[m_chunkRowsCount * m_chunkCellsCount];

    for(ui32 i = 0; i < m_chunkRowsCount; ++i)
    {
        for(ui32 j = 0; j < m_chunkCellsCount; ++j)
        {
            MutableLandscapeData* mutableLandscapeData = new MutableLandscapeData();
            iGaiaVertexBufferObject* vertexBuffer = new iGaiaVertexBufferObject(m_chunkWidth * m_chunkHeight, GL_STATIC_DRAW);
            iGaiaIndexBufferObject* indexBuffer = CreateIndexBuffer();
            mutableLandscapeData->m_mesh = new iGaiaMesh(vertexBuffer, indexBuffer, "igaia.mesh.landscape", iGaiaResource::iGaia_E_CreationModeCustom);
            mutableLandscapeData->m_quadTree = new iGaiaQuadTreeObject3d();
            m_mutableLandscapeContainer[i + j * m_chunkRowsCount] = mutableLandscapeData;
        }
    }
}

iGaiaHeightmapProcessor::~iGaiaHeightmapProcessor(void)
{

}

iGaiaIndexBufferObject* iGaiaHeightmapProcessor::CreateIndexBuffer(void)
{
    assert(m_chunkWidth != 0);
    assert(m_chunkHeight != 0);
    
    iGaiaIndexBufferObject* indexBuffer = new iGaiaIndexBufferObject((m_chunkWidth - 1) * (m_chunkHeight - 1) * 6, GL_STATIC_DRAW);
    ui16* indexData = indexBuffer->Lock();

    ui32 index = 0;
    for(ui32 i = 0; i < (m_chunkWidth - 1); ++i)
    {
        for(ui32 j = 0; j < (m_chunkHeight - 1); ++j)
        {
            indexData[index] = i + j * m_chunkWidth;
            index++;
            indexData[index] = i + (j + 1) * m_chunkWidth;
            index++;
            indexData[index] = i + 1 + j * m_chunkWidth;
            index++;

            indexData[index] = i + (j + 1) * m_chunkWidth;
            index++;
            indexData[index] = i + 1 + (j + 1) * m_chunkWidth;
            index++;
            indexData[index] = i + 1 + j * m_chunkWidth;
            index++;
        }
    }
    indexBuffer->Unlock();
    return indexBuffer;
}

void iGaiaHeightmapProcessor::FillVertexBuffer(iGaiaVertexBufferObject *_vertexBuffer, ui32 _widthOffset, ui32 _heightOffset)
{
    assert(m_heightmap != nullptr);
    assert(_vertexBuffer != nullptr);

    assert(m_chunkWidth != 0);
    assert(m_chunkHeight != 0);
    
    iGaiaVertexBufferObject::iGaiaVertex* vertexData = _vertexBuffer->Lock();

    ui32 index = 0;
    for(ui32 i = 0; i < m_chunkWidth;++i)
    {
        for(ui32 j = 0; j < m_chunkHeight;++j)
        {
            vertexData[index].m_position.x = i * _widthOffset + i;
            vertexData[index].m_position.y = m_heightmap[(i * _widthOffset + i) + (j * _heightOffset + j) * m_height];
            vertexData[index].m_position.z = j * _heightOffset + j;

            vertexData[index].m_texcoord.x = i / static_cast<f32>(m_chunkWidth);
            vertexData[index].m_texcoord.y = j / static_cast<f32>(m_chunkHeight);
            ++index;
        }
    }
    _vertexBuffer->Unlock();
}

void iGaiaHeightmapProcessor::Process(void)
{
    assert(m_mutableLandscapeContainer);
    
    for(ui32 i = 0; i < m_chunkRowsCount; ++i)
    {
        for(ui32 j = 0; j < m_chunkCellsCount; ++j)
        {
            assert(m_mutableLandscapeContainer[i + j * m_chunkRowsCount] != nullptr);
            MutableLandscapeData* mutableLandscapeData = m_mutableLandscapeContainer[i + j * m_chunkRowsCount];
            FillVertexBuffer(mutableLandscapeData->m_mesh->Get_VertexBuffer(), i, j);
        }
    }
}




