//
//  iGaiaLandscapeSplattingTextureProcessor.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaLandscapeSplattingTextureProcessorHelper.h"

iGaiaTexture* iGaiaLandscapeSplattingTextureProcessorHelper::CreateTexture(f32* _landscapeData, ui32 _ladnscapeWidth, ui32 _landscapeHeight, f32 _level_01, f32 _level_02, f32 _level_03)
{
    /*ui32 textureHandle;
    glGenTextures(1, &textureHandle);
    glBindTexture(GL_TEXTURE_2D, textureHandle);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);

    ui16* textureData = new ui16[_ladnscapeWidth * _landscapeHeight];
    for(int i = 0; i < _ladnscapeWidth; i++)
    {
        for(int j = 0; j < _landscapeHeight; j++)
        {
            textureData[i + j * _landscapeHeight] = RGB(255, 0, 0);

            if(Get_HeightValue(i * m_vScaleFactor.x, j * m_vScaleFactor.y) > 1.0f)
            {
                textureData[i + j * m_iHeight] = RGB(0, 255, 0);
            }
            if(Get_HeightValue(i * m_vScaleFactor.x, j * m_vScaleFactor.y) < 0.1f)
            {
                textureData[i + j * m_iHeight] = RGB(0, 0, 255);
            }

            if( i == 0 || j == 0 || i == (m_iWidth - 1) * m_vScaleFactor.x || j == (m_iHeight - 1) * m_vScaleFactor.y)
            {
                pTextureData[i + j * m_iHeight] = RGB(255, 0, 0);
            }

        }
    }
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, m_iWidth, m_iHeight, 0, GL_RGB, GL_UNSIGNED_SHORT_5_6_5, pTextureData);*/
}