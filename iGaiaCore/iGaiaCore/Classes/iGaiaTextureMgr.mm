//
//  iGaiaTextureMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaTextureMgr.h"
#import "iGaiaLoader_PVR.h"

static iGaiaTextureMgr* g_instance = nil;

@interface iGaiaTextureMgr()

@property(nonatomic, strong) NSMutableDictionary* m_textures;

@end

@implementation iGaiaTextureMgr

+ (iGaiaTextureMgr*)sharedInstance
{
    static iGaiaTextureMgr *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (id)init
{
    NSAssert(g_instance == nil, @"iGaiaTextureMgr created twice.");
    self = [super init];
    if(self)
    {
        g_instance = self;
        _m_textures = [NSMutableDictionary new];
    }
    return self;
}

- (iGaiaTexture*)getTextureWithName:(NSString *)name
{
    iGaiaTexture* texture = nil;
    if([_m_textures objectForKey:name] != nil)
    {
        texture = [_m_textures objectForKey:name];
        [texture incReferenceCount];
    }
    else
    {
        iGaiaLoader_PVR* loader = [iGaiaLoader_PVR new];
        [loader parseFileWithName:name];
        if(loader.m_status == E_LOAD_STATUS_DONE)
        {
            texture = [loader commitToVRAM];
            [texture incReferenceCount];
        }
    }
    NSAssert(texture != nil, @"Texture not loaded.");
    return texture;
}

- (void)removeTextureWithName:(NSString *)name
{
    if([_m_textures objectForKey:name] != nil)
    {
        iGaiaTexture* texture = [_m_textures objectForKey:name];
        [texture decReferenceCount];
        if(texture.m_referencesCount <= 0)
        {
            [_m_textures removeObjectForKey:name];
            [texture unload];
            texture = nil;
        }
    }
}

@end



