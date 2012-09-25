//
//  iGaiaCoreResourceService.m
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/20/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaCoreResourceService.h"
#import "iGaiaCoreLoaderProtocol.h"
#import "iGaiaCoreResourceMgrProtocol.h"
#import "iGaiaCoreLogger.h"

@implementation iGaiaCoreResourceService

@synthesize container = _container;
@synthesize taskPool = _taskPool;

- (id)init;
{
    self = [super init];
    if(self)
    {
        _container = [NSMutableDictionary new];
        _taskPool = [NSMutableDictionary new];
    }
    return self;
}

- (void)validateTaskWithName:(NSString*)name forOwner:(iGaiaCoreResourceLoadDispatcher)owner;
{
    if([self.taskPool objectForKey:name] == nil)
    {
        NSMutableArray* owners = [NSMutableArray new];
        [self.taskPool setObject:owners forKey:name];
    }
    NSMutableArray* owners = [self.taskPool objectForKey:name];
    [owners addObject:owner];
}

- (void)loadWithLoader:(iGaiaCoreLoader)loader withName:(NSString*)name;
{
    BOOL result = [loader loadWithName:name];
    dispatch_async(dispatch_get_main_queue(), ^{
        if(result != NO)
        {
            iGaiaCoreResource resource = [loader commit];
            [self.container setObject:resource forKey:name];
            NSMutableArray* owners = [self.taskPool objectForKey:name];
            for(iGaiaCoreResourceLoadDispatcher owner in owners)
            {
                [owner onResourceLoad:[self.container objectForKey:name] withName:name];
                iGaiaLog(@"resource with name : %@ load for owner : %@", name, owner);
            }
            [self.taskPool removeObjectForKey:name];
        }
        else
        {
             iGaiaLog(@"resource loader error for resource with name : %@", name);
        }
    });
}

@end
