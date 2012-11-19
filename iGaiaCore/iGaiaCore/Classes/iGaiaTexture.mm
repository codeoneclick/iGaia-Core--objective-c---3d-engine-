//
//  iGaiaTexture.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaTexture.h"

iGaiaTexture::iGaiaTexture(ui32 _handle, ui16 _width, ui16 _height, const string& _name, iGaiaResource::iGaia_E_CreationMode _creationMode)
{
    m_resourceType = iGaiaResource::iGaia_E_ResourceTypeTexture;
    m_creationMode = _creationMode;
    m_handle = _handle;
    m_width = _width;
    m_height = _height;
    m_name = _name;
}

iGaiaTexture::~iGaiaTexture(void)
{
    glDeleteTextures(1, &m_handle);
}

map<ui32, ui32> iGaiaTexture::Get_Settings(void)
{
    return m_settings;
}

void iGaiaTexture::Set_Settings(const map<ui32, ui32>& _settings)
{
    if(m_settings == _settings)
    {
        return;
    }
    
    m_settings = _settings;
    
    if(m_settings.find(iGaia_E_TextureSettingsKeyWrapMode) != m_settings.end())
    {
        if(m_settings.find(iGaia_E_TextureSettingsKeyWrapMode)->second == iGaia_E_TextureSettingsValueClamp)
        {
            Bind();
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        }
        else if(m_settings.find(iGaia_E_TextureSettingsKeyWrapMode)->second == iGaia_E_TextureSettingsValueRepeat)
        {
            Bind();
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
        }
    }
}

ui32 iGaiaTexture::Get_Handle(void)
{
    return m_handle;
}

ui16 iGaiaTexture::Get_Width(void)
{
    return m_width;
}

ui16 iGaiaTexture::Get_Height(void)
{
    return m_height;
}

void iGaiaTexture::Bind(void)
{
    glBindTexture(GL_TEXTURE_2D, m_handle);
}

void iGaiaTexture::Unbind(void)
{
    glBindTexture(GL_TEXTURE_2D, NULL);
}
