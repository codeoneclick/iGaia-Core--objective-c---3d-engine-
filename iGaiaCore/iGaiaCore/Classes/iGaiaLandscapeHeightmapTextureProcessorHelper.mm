//
//  iGaiaLandscapeHeightmapTextureProcessor.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaLandscapeHeightmapTextureProcessorHelper.h"
#include "iGaiaLandscapeHeightmapHelper.h"

iGaiaTexture* iGaiaLandscapeHeightmapTextureProcessorHelper::CreateTexture(f32* _data, ui32 _width, ui32 _height, vec2 _scaleFactor, f32 _maxAltitude)
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
            f32 height = iGaiaLandscapeHeightmapHelper::Get_HeightValue(_data, _width, _height, vec2(i * _scaleFactor.x, j * _scaleFactor.y), _scaleFactor) / _maxAltitude;
            
            if(height > 0.0f || height < -1.0f)
            {
                data[i + j * _height] = iGaia_RGB(0, static_cast<ui8>(255), 0);
            }
            else
            {
                data[i + j * _height] = iGaia_RGB(static_cast<ui8>(fabsf(height) * 255), 0, 0);
            }
        }
    }
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, _width, _height, 0, GL_RGB, GL_UNSIGNED_SHORT_5_6_5, data);

    iGaiaTexture* texture = new iGaiaTexture(textureHandle, _width, _height, "igaia.texture.landscape.heightmap", iGaiaResource::iGaia_E_CreationModeCustom);
    map<ui32, ui32> settings;
    settings[iGaiaTexture::iGaia_E_TextureSettingsKeyWrapMode] = iGaiaTexture::iGaia_E_TextureSettingsValueClamp;
    texture->Set_Settings(settings);
    return texture;
}


