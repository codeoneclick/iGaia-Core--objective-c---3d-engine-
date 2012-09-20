//
//  iGaiaCoreTextureService.m
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaCoreTextureService.h"
#import "iGaiaCoreCommunicator.h"
#import "iGaiaCoreTextureLoader.h"
#import "iGaiaCoreTexture.h"

@interface iGaiaCoreTextureService()

@property(nonatomic, strong) NSMutableDictionary* container;
@property(nonatomic, strong) NSMutableDictionary* tasks;

@end

@implementation iGaiaCoreTextureService

@synthesize container = _container;
@synthesize tasks = _tasks;

- (id)init
{
    self = [super init];
    if(self)
    {
        _container = [NSMutableDictionary new];
        _tasks = [NSMutableDictionary new];
    }
    return self;
}

- (void)loadTextureForOwner:(id<iGaiaCoreResourceLoaderProtocol>)owner withName:(NSString*)name;
{
    if([self.container objectForKey:name] == nil)
    {
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
        }
    }
    else
    {
        [owner onResourceLoad:[self.container objectForKey:name] withName:name];
    }
}

@end
