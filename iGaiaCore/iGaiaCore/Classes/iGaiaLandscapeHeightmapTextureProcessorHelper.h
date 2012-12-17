//
//  iGaiaLandscapeHeightmapTextureProcessor.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaLandscapeHeightmapTextureProcessorHelperClass
#define iGaiaLandscapeHeightmapTextureProcessorHelperClass

#import "iGaiaCommon.h"
#import "iGaiaTexture.h"

class iGaiaLandscapeHeightmapTextureProcessorHelper final
{
private:

protected:

public:
    iGaiaLandscapeHeightmapTextureProcessorHelper(void) = default;
    ~iGaiaLandscapeHeightmapTextureProcessorHelper(void) = default;

    static iGaiaTexture* CreateTexture(f32* _data, ui32 _width, ui32 _height, vec2 _scaleFactor, f32 _maxAltitude);
};

#endif