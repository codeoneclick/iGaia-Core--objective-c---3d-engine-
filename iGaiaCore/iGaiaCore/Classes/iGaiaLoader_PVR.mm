//
//  iGaiaLoader_PVR.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaLoader_PVR.h"
#include "iGaiaLogger.h"
#include "PVRTTexture.h"

iGaiaLoader_PVR::iGaiaLoader_PVR(void)
{
    m_status = iGaia_E_LoadStatusNone;
}

iGaiaLoader_PVR::~iGaiaLoader_PVR(void)
{
    
}

void iGaiaLoader_PVR::ParseFileWithName(const string &_name)
{
    m_status = iGaia_E_LoadStatusProcess;
    m_name = _name;

    string path([[[NSBundle mainBundle] resourcePath] UTF8String]);
    path.append(m_name);

    std::ifstream stream;
    stream.open(path.c_str(), ios::binary);
    stream.seekg(0, std::ios::end);
    i32 lenght = stream.tellg();
    stream.seekg(0, std::ios::beg);
    m_data = new i8[lenght];
    stream.read((char*)m_data, lenght);
    stream.close();

    if(*(PVRTuint32*)m_data != PVRTEX3_IDENT)
	{
        PVR_Texture_Header* header;
        header = (PVR_Texture_Header*)m_data;
        switch (header->dwpfFlags & PVRTEX_PIXELTYPE)
        {
            case OGL_PVRTC2:
                if(header->dwAlphaBitMask)
                {
                    m_bytesPerPixel = 2;
                    m_format = GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG;
                }
                else
                {
                    m_bytesPerPixel = 2;
                    m_format = GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG;
                }
                break;
            case OGL_PVRTC4:
                if(header->dwAlphaBitMask)
                {
                    m_bytesPerPixel = 4;
                    m_format = GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG;
                }
                else
                {
                    m_bytesPerPixel = 4;
                    m_format = GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG;
                }
                break;
            default:
                m_status = iGaia_E_LoadStatusError;
                return;
        }
        m_size.x = header->dwWidth;
        m_size.y = header->dwHeight;
        m_compressed = YES;
        m_headerSize = header->dwHeaderSize;
        iGaiaLog(@"Parse Texture with old pvr format -> : %s, with width : %f,  with height : %f, with mips : %d", m_name.c_str(), m_size.x, m_size.y, header->dwMipMapCount ? header->dwMipMapCount : 1);
        m_status = iGaia_E_LoadStatusDone;
        return;
    }
    else
    {
        PVRTextureHeaderV3* header = (PVRTextureHeaderV3*)m_data;
        PVRTuint64 pixelFormat = header->u64PixelFormat;
        switch (pixelFormat)
		{
            case 0:
            {
                m_bytesPerPixel = 2;
                m_format = GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG;
            }
                break;
            case 1:
            {
                m_bytesPerPixel = 2;
                m_format = GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG;
            }
                break;
            case 2:
            {
                m_bytesPerPixel = 4;
                m_format = GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG;
            }
            case 3:
            {
                m_bytesPerPixel = 4;
                m_format = GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG;
            }
                break;
            default:
                m_status = iGaia_E_LoadStatusError;
                return;
        }
        m_size.x = header->u32Width;
        m_size.y = header->u32Height;
        m_compressed = YES;
        m_headerSize = PVRTEX3_HEADERSIZE + header->u32MetaDataSize;
        iGaiaLog(@"Parse Texture with new pvr format -> : %s, with width : %f,  with height : %f, with mips : %d", m_name.c_str(), m_size.x, m_size.y, header->u32MIPMapCount ? header->u32MIPMapCount : 1);
        m_status = iGaia_E_LoadStatusDone;
    }
}

iGaiaResource* iGaiaLoader_PVR::CommitToVRAM(void)
{
    i32 width  = m_size.x;
    i32 height = m_size.y;
    i8* data = m_data + m_headerSize;

    ui32 handle = 0;
    glGenTextures(1, &handle);
    glBindTexture(GL_TEXTURE_2D, handle);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

    for (NSInteger level = 0; width > 0 && height > 0; ++level)
    {
        GLsizei size = std::max(32, width * height * m_bytesPerPixel / 8);
        glCompressedTexImage2D(GL_TEXTURE_2D, level, m_format, width, height, 0, size, data);
        data += size;
        width >>= 1; height >>= 1;
    }

    iGaiaTexture* texture = new iGaiaTexture(handle, m_size.x, m_size.y, m_name, iGaiaResource::iGaia_E_CreationModeNative);

    for(iGaiaLoadCallback* listener : m_listeners)
    {
        texture->IncReferenceCount();
        listener->OnLoad(texture);
    }
    
    m_listeners.clear();
    
    return texture;
}

