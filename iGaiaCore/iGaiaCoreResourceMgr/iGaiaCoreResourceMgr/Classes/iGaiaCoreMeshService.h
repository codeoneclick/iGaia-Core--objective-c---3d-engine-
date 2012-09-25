//
//  iGaiaCoreMeshService.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iGaiaCoreResourceService.h"

@interface iGaiaCoreMeshService : iGaiaCoreResourceService

- (void)loadMeshForOwner:(iGaiaCoreResourceLoadDispatcher)owner withName:(NSString*)name;

@end
