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
#import "iGaiaCoreTexture.h"
#import "iGaiaCoreLogger.h"

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

- (BOOL)loadWithName:(NSString*)name;
{
    NSString* path = [[NSBundle mainBundle] resourcePath];
    path = [path stringByAppendingPathComponent:name];

    _data = [NSData dataWithContentsOfFile:path];


    NSUInteger mips = 1;
    
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
                return NO;
        }
        _size.width = header->dwWidth;
        _size.height = header->dwHeight;
        _offset =  header->dwHeaderSize;
        _compressed = YES;
        _numFaces = 1;
        mips = header->dwMipMapCount ? header->dwMipMapCount : 1;
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
                return NO;
        }
        _size.width = header->u32Width;
        _size.height = header->u32Height;
        _offset =  PVRTEX3_HEADERSIZE + header->u32MetaDataSize;
        _compressed = YES;
        _numFaces = header->u32NumFaces;
        mips = header->u32MIPMapCount ? header->u32MIPMapCount : 1;
    }

    iGaiaLog(@"texture name : %@, with width : %f,  with height : %f, with mips : %d", name, _size.width, _size.height, mips);

    return YES;
}

- (iGaiaCoreResourceObjectRule)commit;
{
    GLuint handle = 0;
    glGenTextures(1, &handle);
    glBindTexture(GL_TEXTURE_2D, handle);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

    char* data = (char*)_data.bytes;
    data += _offset;

    NSInteger width = _size.width;
    NSInteger height = _size.height;

    for(NSUInteger face = 0; face < _numFaces; ++face)
    {
        if (_compressed)
        {
            for (NSUInteger level = 0; width > 0 && height > 0; ++level)
            {
                GLsizei size = MAX(32, width * height * _bytesPerPixel / 8);
                glCompressedTexImage2D(GL_TEXTURE_2D + face, level, _format, width, height, 0, size, data);
                data += size;
                width >>= 1; height >>= 1;
            }
        }
        else
        {
            glTexImage2D(GL_TEXTURE_2D + face, 0, _format, width, height, 0, _format, _type, data);
            glHint(GL_GENERATE_MIPMAP_HINT, GL_FASTEST);
            glGenerateMipmap(GL_TEXTURE_2D + face);
        }
    }

    iGaiaCoreTexture* texture = [[iGaiaCoreTexture alloc] initWithHandle:handle withSize:_size];
    return texture;
}

@end
