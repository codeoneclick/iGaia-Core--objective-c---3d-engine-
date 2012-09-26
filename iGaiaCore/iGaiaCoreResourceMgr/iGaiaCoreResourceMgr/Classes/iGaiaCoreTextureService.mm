//
//  iGaiaCoreTextureService.m
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaCoreTextureService.h"
#import "iGaiaCoreTextureLoader.h"
#import "iGaiaCoreTexture.h"
#import "iGaiaCoreLogger.h"

@interface iGaiaCoreTextureService()

@end

@implementation iGaiaCoreTextureService

- (void)loadTextureForOwner:(iGaiaCoreResourceLoadDispatcherObjectRule)owner withName:(NSString*)name;
{
    if(owner == nil)
    {
        iGaiaLog(@"texture owner is nil");
        return;
    }
    if(name == nil)
    {
        iGaiaLog(@"texture name is nil");
        return;
    }
    
    if([self.container objectForKey:name] == nil)
    {
        [self validateTaskWithName:name forOwner:owner];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            iGaiaCoreTextureLoader* loader = [iGaiaCoreTextureLoader new];
            [self loadWithLoader:loader withName:name];
        });
    }
    else
    {
        [owner onResourceLoad:[self.container objectForKey:name] withName:name];
        iGaiaLog(@"texture with name : %@ get from cache for owner : %@", name, owner);
    }
}

@end
