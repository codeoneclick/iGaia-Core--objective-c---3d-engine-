//
//  iGaiaMeshMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaMeshMgr.h"
#import "iGaiaLoader_MDL.h"

static iGaiaMeshMgr* g_instance = nil;

@interface iGaiaMeshMgr()

@property(nonatomic, strong) NSMutableDictionary* m_meshes;

@end

@implementation iGaiaMeshMgr

+ (iGaiaMeshMgr*)sharedInstance
{
    static iGaiaMeshMgr *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (id)init
{
    NSAssert(g_instance == nil, @"iGaiaMeshMgr created twice.");
    self = [super init];
    if(self)
    {
        g_instance = self;
        _m_meshes = [NSMutableDictionary new];
    }
    return self;
}

- (iGaiaMesh*)getMeshWithName:(NSString *)name
{
    iGaiaMesh* mesh = nil;
    if([_m_meshes objectForKey:name] != nil)
    {
        mesh = [_m_meshes objectForKey:name];
        [mesh incReferenceCount];
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
    NSAssert(mesh != nil, @"Texture not loaded.");
    return mesh;
}

- (void)removeMeshWithName:(NSString *)name
{
    if([_m_meshes objectForKey:name] != nil)
    {
        iGaiaMesh* mesh = [_m_meshes objectForKey:name];
        [mesh decReferenceCount];
        if(mesh.m_referencesCount <= 0)
        {
            [_m_meshes removeObjectForKey:name];
            [mesh unload];
            mesh = nil;
        }
    }
}

@end
