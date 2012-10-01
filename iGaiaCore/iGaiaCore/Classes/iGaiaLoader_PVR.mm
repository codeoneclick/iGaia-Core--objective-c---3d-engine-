//
//  iGaiaLoader_PVR.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaLoader_PVR.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import "PVRTTexture.h"

#import <glm/glm.hpp>
#import <glm/gtc/type_precision.hpp>

#import "NSData+iGaiaExtension.h"
#import "iGaiaResourceLoadListener.h"
#import "iGaiaTexture.h"

#import "iGaiaLogger.h"

@interface iGaiaLoader_PVR()

@property(nonatomic, readwrite) E_LOAD_STATUS m_status;
@property(nonatomic, readwrite) std::string m_name;
@property(nonatomic, strong) NSMutableSet* m_listeners;
@property(nonatomic, assign) GLenum m_format;
@property(nonatomic, assign) NSInteger m_bytesPerPixel;
@property(nonatomic, assign) glm::vec2 m_size;
@property(nonatomic, assign) BOOL m_compressed;
@property(nonatomic, strong) NSData* m_data;
@property(nonatomic, assign) NSInteger m_headerSize;

@end

@implementation iGaiaLoader_PVR

@synthesize m_status = _m_status;
@synthesize m_name = _m_name;
@synthesize m_listeners = _m_listeners;
@synthesize m_format = _m_format;
@synthesize m_bytesPerPixel = _m_bytesPerPixel;
@synthesize m_size = _m_size;
@synthesize m_compressed = _m_compressed;
@synthesize m_data = _m_data;
@synthesize m_headerSize = _m_headerSize;

- (id)init
{
    self = [super init];
    if(self)
    {
        _m_status = E_LOAD_STATUS_NONE;
    }
    return self;
}

- (void)addEventListener:(id<iGaiaResourceLoadListener>)listener
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_m_listeners addObject:listener];
    });
}

- (void)removeEventListener:(id<iGaiaResourceLoadListener>)listener
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_m_listeners removeObject:listener];
    });
}

- (void)parseFileWithName:(const std::string &)name
{
    _m_status = E_LOAD_STATUS_PROCESS;
    _m_name = name;

    NSString* path = [[NSBundle mainBundle] resourcePath];
    path = [path stringByAppendingPathComponent:[NSString stringWithCString:name.c_str() encoding:NSUTF8StringEncoding]];

    _m_data = [NSData dataWithContentsOfFile:path];

    if(*(PVRTuint32*)_m_data.bytes != PVRTEX3_IDENT)
	{
        PVR_Texture_Header* header;
        header = (PVR_Texture_Header*)_m_data.bytes;
        switch (header->dwpfFlags & PVRTEX_PIXELTYPE)
        {
            case OGL_PVRTC2:
                if(header->dwAlphaBitMask)
                {
                    _m_bytesPerPixel = 2;
                    _m_format = GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG;
                }
                else
                {
                    _m_bytesPerPixel = 2;
                    _m_format = GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG;
                }
                break;
            case OGL_PVRTC4:
                if(header->dwAlphaBitMask)
                {
                    _m_bytesPerPixel = 4;
                    _m_format = GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG;
                }
                else
                {
                    _m_bytesPerPixel = 4;
                    _m_format = GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG;
                }
                break;
            default:
                _m_status = E_LOAD_STATUS_ERROR;
                return;
        }
        _m_size.x = header->dwWidth;
        _m_size.y = header->dwHeight;
        _m_compressed = YES;
        _m_headerSize = header->dwHeaderSize;
        iGaiaLog(@"Parse Texture with old pvr format -> : %@, with width : %f,  with height : %f, with mips : %d", [NSString stringWithCString:name.c_str() encoding:NSUTF8StringEncoding], _m_size.x, _m_size.y, header->dwMipMapCount ? header->dwMipMapCount : 1);
        _m_status = E_LOAD_STATUS_DONE;
        return;
    }
    else
    {
        PVRTextureHeaderV3* header = (PVRTextureHeaderV3*)_m_data.bytes;
        PVRTuint64 pixelFormat = header->u64PixelFormat;
        switch (pixelFormat)
		{
            case 0:
            {
                _m_bytesPerPixel = 2;
                _m_format = GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG;
            }
                break;
            case 1:
            {
                _m_bytesPerPixel = 2;
                _m_format = GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG;
            }
                break;
            case 2:
            {
                _m_bytesPerPixel = 4;
                _m_format = GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG;
            }
            case 3:
            {
                _m_bytesPerPixel = 4;
                _m_format = GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG;
            }
                break;
            default:
                _m_status = E_LOAD_STATUS_ERROR;
                return;
        }
        _m_size.x = header->u32Width;
        _m_size.y = header->u32Height;
        _m_compressed = YES;
        _m_headerSize = PVRTEX3_HEADERSIZE + header->u32MetaDataSize;
        iGaiaLog(@"Parse Texture with new pvr format -> : %@, with width : %f,  with height : %f, with mips : %d", [NSString stringWithCString:name.c_str() encoding:NSUTF8StringEncoding], _m_size.x, _m_size.y, header->u32MIPMapCount ? header->u32MIPMapCount : 1);
        _m_status = E_LOAD_STATUS_DONE;
    }
}

- (id<iGaiaResource>)commitToVRAM
{
    NSInteger width  = _m_size.x;
    NSInteger height = _m_size.y;
    char* data = (char*)_m_data.bytes + _m_headerSize;

    NSUInteger handle = 0;
    glGenTextures(1, &handle);
    glBindTexture(GL_TEXTURE_2D, handle);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    for (NSInteger level = 0; width > 0 && height > 0; ++level)
    {
        GLsizei size = std::max(32, width * height * _m_bytesPerPixel / 8);
        glCompressedTexImage2D(GL_TEXTURE_2D, level, _m_format, width, height, 0, size, data);
        data += size;
        width >>= 1; height >>= 1;
    }

    iGaiaTexture* texture = [[iGaiaTexture alloc] initWithHandle:handle withWidth:_m_size.x withHeight:_m_size.y withName:_m_name withCreationMode:E_CREATION_MODE_NATIVE];

    for(id<iGaiaResourceLoadListener> listener in _m_listeners)
    {
        [texture incReferenceCount];
        [listener onResourceLoad:texture];
    }
    [_m_listeners removeAllObjects];
    return texture;
}

@end
