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

void iGaiaTexture::Set_WrapMode(iGaiaTexture::WrapMode _wrapMode)
{

    switch (_wrapMode)
    {
        case iGaiaTexture::WrapMode::repeat:
        {
            Bind();
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
        }
            break;
        case iGaiaTexture::WrapMode::clamp:
        {
            Bind();
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        }
            break;
        case iGaiaTexture::WrapMode::mirror:
        {
            Bind();
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_MIRRORED_REPEAT);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_MIRRORED_REPEAT);
        }
            break;

        default:
            break;
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
