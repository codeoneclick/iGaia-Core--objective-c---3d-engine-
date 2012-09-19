//
//  iGaiaCoreTextureLoader.m
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import <UIKit/UIKit.h>

#import "PVRTTexture.h"

#import "iGaiaCoreTextureLoader.h"
#import "iGaiaCoreTextureProtocol.h"

#import "NSData+iGaiaCoreExtension.h"

@interface iGaiaCoreTextureLoader()

@property(nonatomic, assign) GLenum format;
@property(nonatomic, assign) GLenum type;
@property(nonatomic, assign) NSInteger bytesPerPixel;
@property(nonatomic, assign) CGSize size;
@property(nonatomic, assign) BOOL compressed;
@property(nonatomic, assign) NSUInteger numFaces;
@property(nonatomic, strong) NSData* data;
@property(nonatomic, assign) NSUInteger offset;

@end

@implementation iGaiaCoreTextureLoader

@synthesize format = _format;
@synthesize type = _type;
@synthesize bytesPerPixel = _bytesPerPixel;
@synthesize size = _size;
@synthesize compressed = _compressed;
@synthesize numFaces = _numFaces;
@synthesize data = _data;

- (void)loadWithName:(NSString*)name;
{
    NSString* path = [[NSBundle mainBundle] resourcePath];
    path = [path stringByAppendingPathComponent:name];

    _data = [NSData dataWithContentsOfFile:path];
    
    if(*(PVRTuint32*)_data.bytes != PVRTEX3_IDENT)
	{
        PVR_Texture_Header* header;
        header = (PVR_Texture_Header*)_data.bytes;
        switch (header->dwpfFlags & PVRTEX_PIXELTYPE)
        {
            case OGL_PVRTC2:
                if(header->dwAlphaBitMask)
                {
                    _bytesPerPixel = 2;
                    _format = GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG;
                }
                else
                {
                    _bytesPerPixel = 2;
                    _format = GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG;
                }
                break;
            case OGL_PVRTC4:
                if(header->dwAlphaBitMask)
                {
                    _bytesPerPixel = 4;
                    _format = GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG;
                }
                else
                {
                    _bytesPerPixel = 4;
                    _format = GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG;
                }
                break;
            default:
                return;
        }
        _size.width = header->dwWidth;
        _size.height = header->dwHeight;
        _offset =  header->dwHeaderSize;
        _compressed = YES;
        _numFaces = 1;
    }
    else
    {
        PVRTextureHeaderV3* header = (PVRTextureHeaderV3*)_data.bytes;
        PVRTuint64 pixelFormat = header->u64PixelFormat;
        switch (pixelFormat)
		{
            case 0:
            {
                _bytesPerPixel = 2;
                _format = GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG;
            }
                break;
            case 1:
            {
                _bytesPerPixel = 2;
                _format = GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG;
            }
                break;
            case 2:
            {
                _bytesPerPixel = 4;
                _format = GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG;
            }
            case 3:
            {
                _bytesPerPixel = 4;
                _format = GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG;
            }
                break;
            default:
                return;
        }
        _size.width = header->u32Width;
        _size.height = header->u32Height;
        _offset =  PVRTEX3_HEADERSIZE + header->u32MetaDataSize;
        _compressed = YES;
        _numFaces = header->u32NumFaces;
    }
}

- (id<iGaiaCoreTextureProtocol>)commit;
{
    
}


IResource* CParser_PVR::Commit(void)
{
    int iWidth  = m_pDescription->m_vSize.x;
    int iHeight = m_pDescription->m_vSize.y;
    char* pData = m_pDescription->m_pData;

    GLuint iHandle = 0;
    glGenTextures(1, &iHandle);

    GLenum iTextureTarget = GL_TEXTURE_2D;

    if(m_pDescription->m_iNumFaces > 1)
    {
        iTextureTarget = GL_TEXTURE_CUBE_MAP;
    }

    glBindTexture(iTextureTarget, iHandle);
    if(iTextureTarget == GL_TEXTURE_2D)
    {
        glTexParameteri(iTextureTarget, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_NEAREST);
        glTexParameteri(iTextureTarget, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    }
    else
    {
        glTexParameteri(iTextureTarget, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameteri(iTextureTarget, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        m_pDescription->m_bCompressed = false;
    }

    if(iTextureTarget == GL_TEXTURE_CUBE_MAP)
    {
        iTextureTarget = GL_TEXTURE_CUBE_MAP_POSITIVE_X;
    }

    for(unsigned int iFaces = 0; iFaces < m_pDescription->m_iNumFaces; iFaces++)
    {
        if (m_pDescription->m_bCompressed)
        {
            for (int level = 0; iWidth > 0 && iHeight > 0; ++level)
            {
                GLsizei iSize = std::max(32, iWidth * iHeight * m_pDescription->m_uiBPP / 8);
                glCompressedTexImage2D(iTextureTarget + iFaces, level, m_pDescription->m_glFormat, iWidth, iHeight, 0, iSize, pData);
                pData += iSize;
                iWidth >>= 1; iHeight >>= 1;
            }
        }
        else
        {
            glTexImage2D(iTextureTarget + iFaces, 0, m_pDescription->m_glFormat, iWidth, iHeight, 0, m_pDescription->m_glFormat, m_pDescription->m_glType, pData);
            glHint(GL_GENERATE_MIPMAP_HINT, GL_FASTEST);
            glGenerateMipmap(iTextureTarget + iFaces);
        }
    }

    CTexture* pTexture = new CTexture();
    pTexture->Set_Handle(iHandle);
    pTexture->Set_Width(m_pDescription->m_vSize.x);
    pTexture->Set_Height(m_pDescription->m_vSize.y);
    return pTexture;
}



@end
