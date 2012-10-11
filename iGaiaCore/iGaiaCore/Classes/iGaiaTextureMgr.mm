//
//  iGaiaTextureMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaTextureMgr.h"
#import "iGaiaLoader_PVR.h"
#import "iGaiaTexture.h"

@interface iGaiaTextureMgr()

@property(nonatomic, strong) NSMutableDictionary* m_tasks;
@property(nonatomic, strong) NSMutableDictionary* m_resources;

@end

@implementation iGaiaTextureMgr

@synthesize m_tasks = _m_tasks;
@synthesize m_resources = _m_resources;

- (id)init
{
    self = [super init];
    if(self)
    {
        _m_tasks = [NSMutableDictionary new];
        _m_resources = [NSMutableDictionary new];
    }
    return self;
}

- (id<iGaiaResource>)loadResourceSyncWithName:(NSString*)name
{
    iGaiaTexture* texture = nil;
    if([_m_resources objectForKey:name] != nil)
    {
        texture = [_m_resources objectForKey:name];
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
    return texture;
}

- (id<iGaiaResource>)loadResourceAsyncWithName:(NSString*)name withListener:(id<iGaiaLoadCallback>)listener
{
    iGaiaTexture* texture = nil;
    if([_m_resources objectForKey:name] != nil)
    {
        texture = [_m_resources objectForKey:name];
    }
    else
    {
        texture = [[iGaiaTexture alloc] initWithHandle:0 withWidth:0 withHeight:0 withName:name withCreationMode:E_CREATION_MODE_NATIVE];
        if([_m_tasks objectForKey:name] != nil)
        {
            iGaiaLoader_PVR* loader = [_m_tasks objectForKey:name];
            [loader addEventListener:listener];
        }
        else
        {
            iGaiaLoader_PVR* loader = [iGaiaLoader_PVR new];
            [_m_tasks setObject:loader forKey:name];
            [loader addEventListener:listener];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [loader parseFileWithName:name];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(loader.m_status == E_LOAD_STATUS_DONE)
                    {
                        iGaiaTexture* texture = [loader commitToVRAM];
                        [_m_resources setObject:texture forKey:name];
                    }
                });
            });
        }
    }
    return texture;
}

@end



