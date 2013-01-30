//
//  iGaiaLandscapeSplattingTextureProcessor.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaLandscapeSplattingTextureProcessorHelper.h"
#include "iGaiaLandscapeHeightmapHelper.h"

iGaiaTexture* iGaiaLandscapeSplattingTextureProcessorHelper::CreateTexture(f32* _data, ui32 _width, ui32 _height, vec2 _scaleFactor, f32 _level_01, f32 _level_02, f32 _level_03)
{
    ui32 textureHandle;
    glGenTextures(1, &textureHandle);
    glBindTexture(GL_TEXTURE_2D, textureHandle);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);

    ui16* data = new ui16[_width * _height];
    for(int i = 0; i < _width; i++)
    {
        for(int j = 0; j < _height; j++)
        {
            data[i + j * _height] = iGaia_RGB(255, 0, 0);

            f32 height = iGaiaLandscapeHeightmapHelper::Get_HeightValue(_data, _width, _height, vec3(i * _scaleFactor.x, 0.0f, j * _scaleFactor.y), _scaleFactor);

            if(height > _level_03)
            {
                data[i + j * _height] = iGaia_RGB(0, 255, 0);
            }
            if(height < _level_02)
            {
                data[i + j * _height] = iGaia_RGB(0, 0, 255);
            }

            if( i == 0 || j == 0 || i == (_width - 1) * _scaleFactor.x || j == (_height - 1) * _scaleFactor.y)
            {
                data[i + j * _height] = iGaia_RGB(255, 0, 0);
            }
        }
    }
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, _width, _height, 0, GL_RGB, GL_UNSIGNED_SHORT_5_6_5, data);
    delete data;
    
    iGaiaTexture* texture = new iGaiaTexture(textureHandle, _width, _height, "igaia.texture.landscape.splatting", iGaiaResource::iGaia_E_CreationModeCustom);
    map<ui32, ui32> settings;
    settings[iGaiaTexture::iGaia_E_TextureSettingsKeyWrapMode] = iGaiaTexture::iGaia_E_TextureSettingsValueClamp;
    texture->Set_Settings(settings);
    return texture;
}