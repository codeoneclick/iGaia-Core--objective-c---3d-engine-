//
//  iGaiaLandscapeSplattingTextureProcessor.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaLandscapeSplattingTextureProcessorHelperClass
#define iGaiaLandscapeSplattingTextureProcessorHelperClass

#import "iGaiaCommon.h"
#import "iGaiaTexture.h"

class iGaiaLandscapeSplattingTextureProcessorHelper final
{
private:

protected:

public:
    iGaiaLandscapeSplattingTextureProcessorHelper(void) = default;
    ~iGaiaLandscapeSplattingTextureProcessorHelper(void) = default;

    iGaiaTexture* CreateTexture(f32* _landscapeData, ui32 _ladnscapeWidth, ui32 _landscapeHeight, f32 _level_01, f32 _level_02, f32 _level_03);
};

#endif