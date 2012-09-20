//
//  iGaiaCoreMeshService.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iGaiaCoreResourceService.h"

@protocol iGaiaCoreResourceLoaderProtocol;
@interface iGaiaCoreMeshService : iGaiaCoreResourceService

- (void)loadMeshForOwner:(id<iGaiaCoreResourceLoaderProtocol>)owner withName:(NSString*)name;

@end
