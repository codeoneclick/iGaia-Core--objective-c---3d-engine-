//
//  iGaiaMeshMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaMeshMgr.h"
#import "iGaiaLoader_MDL.h"
#import "iGaiaMesh.h"

@interface iGaiaMeshMgr()

@property(nonatomic, strong) NSMutableDictionary* m_tasks;
@property(nonatomic, strong) NSMutableDictionary* m_resources;

@end

@implementation iGaiaMeshMgr

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
    iGaiaMesh* mesh = nil;
    if([_m_resources objectForKey:name] != nil)
    {
        mesh = [_m_resources objectForKey:name];
    }
    else
    {
        iGaiaLoader_MDL* loader = [iGaiaLoader_MDL new];
        [loader parseFileWithName:name];
        if(loader.m_status == E_LOAD_STATUS_DONE)
        {
            mesh = [loader commitToVRAM];
            [mesh incReferenceCount];
        }
    }
    return mesh;
}

- (id<iGaiaResource>)loadResourceAsyncWithName:(NSString*)name withListener:(id<iGaiaResourceLoadListener>)listener
{
    iGaiaMesh* mesh = nil;
    if([_m_resources objectForKey:name] != nil)
    {
        mesh = [_m_resources objectForKey:name];
    }
    else
    {
        mesh = [[iGaiaMesh alloc] initWithVertexBuffer:nil withIndexBuffer:nil withName:name withCreationMode:E_CREATION_MODE_NATIVE];
        if([_m_tasks objectForKey:name] != nil)
        {
            iGaiaLoader_MDL* loader = [_m_tasks objectForKey:name];
            [loader addEventListener:listener];
        }
        else
        {
            iGaiaLoader_MDL* loader = [iGaiaLoader_MDL new];
            [_m_tasks setObject:loader forKey:name];
            [loader addEventListener:listener];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [loader parseFileWithName:name];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(loader.m_status == E_LOAD_STATUS_DONE)
                    {
                        iGaiaMesh* mesh = [loader commitToVRAM];
                        [_m_resources setObject:mesh forKey:name];
                    }
                });
            });
        }
    }
    return mesh;
}

@end
