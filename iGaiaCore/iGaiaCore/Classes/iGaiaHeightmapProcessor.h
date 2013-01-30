//
//  iGaiaHeightmapProcessor.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/29/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaHeightmapProcessorClass
#define iGaiaHeightmapProcessorClass

#include "iGaiaCommon.h"
#include "iGaiaSettingsContainer.h"
#include "iGaiaLandscape.h"

class iGaiaHeightmapProcessor
{
private:

    struct MutableLandscapeData
    {
        iGaiaMesh* m_mesh;
        iGaiaQuadTreeObject3d* m_quadTree;

        MutableLandscapeData(void)
        {
            m_mesh = nullptr;
            m_quadTree = nullptr;
        }
    };

    struct LandscapeIndex
    {
        ui32 i;
        ui32 j;
        LandscapeIndex(ui32 _i, ui32 _j) : i(_i), j(_j){};
    };

    ui32 m_chunkWidth;
    ui32 m_chunkHeight;

    ui32 m_chunkRowsCount;
    ui32 m_chunkCellsCount;

    const f32* m_heightmap;
    const f32* m_splatting;

    iGaiaTexture** m_splattingTextures;

    ui32 m_width;
    ui32 m_height;

    iGaiaIndexBufferObject* CreateIndexBuffer(void);
    void FillVertexBuffer(iGaiaVertexBufferObject* _vertexBuffer, ui32 _widthOffset, ui32 _heightOffset);

    MutableLandscapeData** m_mutableLandscapeContainer;

protected:


public:
    
    iGaiaHeightmapProcessor(const f32* _heightmap, const f32* _splatting, const ui32 _width, const ui32 _height, iGaiaTexture** _splattingTextures);
    ~iGaiaHeightmapProcessor(void);

    void Process(void);
    
    ui32 Get_ChunkRowsCount(void);
    ui32 Get_ChunkCellsCount(void);
    
    iGaiaMesh* Get_MeshForIndex(ui32 _i, ui32 _j);
    iGaiaQuadTreeObject3d* Get_QuadTreeForIndex(ui32 _i, ui32 _j);

};

#endif 
