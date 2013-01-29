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

    ui32 m_chunkWidth;
    ui32 m_chunkHeight;

    ui32 m_chunkRowsCount;
    ui32 m_chunkCellsCount;

protected:

public:
    
    iGaiaHeightmapProcessor(const f32* _heightmap, const f32* _splatting, const ui32 _width, const ui32 _height, iGaiaTexture** _splattingTextures);
    ~iGaiaHeightmapProcessor(void);

    void Process(void);

};

#endif 
