//
//  iGaiaCoreResourceService.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/20/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol iGaiaCoreLoaderProtocol, iGaiaCoreResourceLoaderProtocol;
@interface iGaiaCoreResourceService : NSObject

@property(nonatomic, strong) NSMutableDictionary* container;
@property(nonatomic, strong) NSMutableDictionary* taskPool;

- (void)loadWithLoader:(id<iGaiaCoreLoaderProtocol>)loader withName:(NSString*)name;
- (void)validateTaskWithName:(NSString*)name forOwner:(id<iGaiaCoreResourceLoaderProtocol>)owner;

@end
