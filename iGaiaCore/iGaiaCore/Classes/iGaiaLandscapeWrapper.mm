//
//  iGaiaLandscapeWrapper.cpp
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/29/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#include "iGaiaLandscapeWrapper.h"
#include "iGaiaLogger.h"

iGaiaLandscapeWrapper::iGaiaLandscapeWrapper(const iGaiaLandscapeSettings& _settings)
{
    // TEMP
    m_width = 512;
    m_height = 512;
    
    
    UIImage* image = [UIImage imageNamed:@"heightmap.png"];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    size_t bytesPerRow = image.size.width * 4;
    ui8 * imageData = (ui8*)malloc(image.size.height * bytesPerRow);
    CGContextRef context =  CGBitmapContextCreate(imageData, image.size.width,
                                                  image.size.height,
                                                  8, bytesPerRow,
                                                  colorSpace,
                                                  kCGImageAlphaNoneSkipFirst);
    UIGraphicsPushContext(context);
    CGContextTranslateCTM(context, 0.0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [image drawInRect:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
    UIGraphicsPopContext();

    
    m_heightmap = new f32[m_width * m_height];
    for(ui32 i = 0; i < m_width; ++i)
    {
        for(ui32 j = 0; j < m_height; ++j)
        {
            m_heightmap[i + j * m_width] = static_cast<f32>(imageData[(i + j * m_width) * 4 + 1]) / 255.0f * 32.0f;
            //iGaiaLog("Height : %i", imageData[(i + j * m_width) * 4 + 1]);
        }
    }
    
    m_heightmapProcessor = new iGaiaHeightmapProcessor(m_heightmap, nullptr, m_width, m_height, nullptr);
    m_heightmapProcessor->Process();
    
    ui32 chunkRowsCount = m_heightmapProcessor->Get_ChunkRowsCount();
    ui32 chunkCellsCount = m_heightmapProcessor->Get_ChunkCellsCount();
    
    m_landscapeContainer = new iGaiaLandscape*[chunkRowsCount * chunkCellsCount];
    
    for(ui32 i = 0; i < chunkRowsCount; ++i)
    {
        for(ui32 j = 0; j < chunkCellsCount; ++j)
        {
            iGaiaMesh* mesh = m_heightmapProcessor->Get_MeshForIndex(i, j);
            iGaiaQuadTreeObject3d* quadTree = m_heightmapProcessor->Get_QuadTreeForIndex(i, j);
            m_landscapeContainer[i + j * chunkRowsCount] = new iGaiaLandscape(_settings, mesh, quadTree);
        }
    }
}

iGaiaLandscapeWrapper::~iGaiaLandscapeWrapper(void)
{
    
}

void iGaiaLandscapeWrapper::Set_Clipping(const glm::vec4& _clipping)
{
    ui32 chunkRowsCount = m_heightmapProcessor->Get_ChunkRowsCount();
    ui32 chunkCellsCount = m_heightmapProcessor->Get_ChunkCellsCount();
    
    for(ui32 i = 0; i < chunkRowsCount; ++i)
    {
        for(ui32 j = 0; j < chunkCellsCount; ++j)
        {
            m_landscapeContainer[i + j * chunkRowsCount]->Set_Clipping(_clipping);
        }
    }
}

void iGaiaLandscapeWrapper::Set_Camera(iGaiaCamera* _camera)
{
    ui32 chunkRowsCount = m_heightmapProcessor->Get_ChunkRowsCount();
    ui32 chunkCellsCount = m_heightmapProcessor->Get_ChunkCellsCount();
    
    for(ui32 i = 0; i < chunkRowsCount; ++i)
    {
        for(ui32 j = 0; j < chunkCellsCount; ++j)
        {
            m_landscapeContainer[i + j * chunkRowsCount]->Set_Camera(_camera);
        }
    }
}

void iGaiaLandscapeWrapper::Set_Light(iGaiaLight* _light)
{
    ui32 chunkRowsCount = m_heightmapProcessor->Get_ChunkRowsCount();
    ui32 chunkCellsCount = m_heightmapProcessor->Get_ChunkCellsCount();
    
    for(ui32 i = 0; i < chunkRowsCount; ++i)
    {
        for(ui32 j = 0; j < chunkCellsCount; ++j)
        {
            m_landscapeContainer[i + j * chunkRowsCount]->Set_Light(_light);
        }
    }
}

void iGaiaLandscapeWrapper::Set_RenderMgr(iGaiaRenderMgr* _renderMgr)
{
    ui32 chunkRowsCount = m_heightmapProcessor->Get_ChunkRowsCount();
    ui32 chunkCellsCount = m_heightmapProcessor->Get_ChunkCellsCount();
    
    for(ui32 i = 0; i < chunkRowsCount; ++i)
    {
        for(ui32 j = 0; j < chunkCellsCount; ++j)
        {
            m_landscapeContainer[i + j * chunkRowsCount]->Set_RenderMgr(_renderMgr);
        }
    }
}

void iGaiaLandscapeWrapper::Set_UpdateMgr(iGaiaUpdateMgr* _updateMgr)
{
    ui32 chunkRowsCount = m_heightmapProcessor->Get_ChunkRowsCount();
    ui32 chunkCellsCount = m_heightmapProcessor->Get_ChunkCellsCount();
    
    for(ui32 i = 0; i < chunkRowsCount; ++i)
    {
        for(ui32 j = 0; j < chunkCellsCount; ++j)
        {
            m_landscapeContainer[i + j * chunkRowsCount]->Set_UpdateMgr(_updateMgr);
        }
    }
}

void iGaiaLandscapeWrapper::ListenRenderMgr(bool _value)
{
    ui32 chunkRowsCount = m_heightmapProcessor->Get_ChunkRowsCount();
    ui32 chunkCellsCount = m_heightmapProcessor->Get_ChunkCellsCount();
    
    for(ui32 i = 0; i < chunkRowsCount; ++i)
    {
        for(ui32 j = 0; j < chunkCellsCount; ++j)
        {
            m_landscapeContainer[i + j * chunkRowsCount]->ListenRenderMgr(_value);
        }
    }
}

void iGaiaLandscapeWrapper::ListenUpdateMgr(bool _value)
{
    ui32 chunkRowsCount = m_heightmapProcessor->Get_ChunkRowsCount();
    ui32 chunkCellsCount = m_heightmapProcessor->Get_ChunkCellsCount();
    
    for(ui32 i = 0; i < chunkRowsCount; ++i)
    {
        for(ui32 j = 0; j < chunkCellsCount; ++j)
        {
            m_landscapeContainer[i + j * chunkRowsCount]->ListenUpdateMgr(_value);
        }
    }
}

ui32 iGaiaLandscapeWrapper::Get_Width(void)
{
    return m_width;
}

ui32 iGaiaLandscapeWrapper::Get_Height(void)
{
    return m_height;
}

f32* iGaiaLandscapeWrapper::Get_HeightmapData(void)
{
    return m_heightmap;
}

