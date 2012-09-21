//
//  iGaiaCoreMeshService.m
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaCoreMeshService.h"
#import "iGaiaCoreCommunicator.h"
#import "iGaiaCoreMeshLoader.h"
#import "iGaiaCoreMesh.h"
#import "iGaiaCoreLogger.h"

@interface iGaiaCoreMeshService()

@end

@implementation iGaiaCoreMeshService

- (void)loadMeshForOwner:(id<iGaiaCoreResourceLoaderProtocol>)owner withName:(NSString*)name;
{
    if(owner == nil)
    {
        iGaiaLog(@"mesh owner is nil");
        return;
    }
    if(name == nil)
    {
        iGaiaLog(@"mesh name is nil");
        return;
    }

    if([self.container objectForKey:name] == nil)
    {
        [self validateTaskWithName:name forOwner:owner];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            iGaiaCoreMeshLoader* loader = [iGaiaCoreMeshLoader new];
            [self loadWithLoader:loader withName:name];
        });
    }
    else
    {
        [owner onResourceLoad:[self.container objectForKey:name] withName:name];
        iGaiaLog(@"mesh with name : %@ get from cache for owner : %@", name, owner);
    }
}

@end

