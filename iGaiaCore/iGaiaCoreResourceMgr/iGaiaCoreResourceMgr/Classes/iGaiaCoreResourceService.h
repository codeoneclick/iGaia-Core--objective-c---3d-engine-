//
//  iGaiaCoreResourceService.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/20/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaCoreCommunicator.h"
#import "iGaiaCoreLoaderProtocol.h"

@interface iGaiaCoreResourceService : NSObject

@property(nonatomic, strong) NSMutableDictionary* container;
@property(nonatomic, strong) NSMutableDictionary* taskPool;

- (void)loadWithLoader:(iGaiaCoreLoaderObjectRule)loader withName:(NSString*)name;
- (void)validateTaskWithName:(NSString*)name forOwner:(iGaiaCoreResourceLoadDispatcherObjectRule)owner;

@end
