//
//  iGaiaCoreTextureService.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iGaiaCoreResourceService.h"

@protocol iGaiaCoreResourceLoaderProtocol;
@interface iGaiaCoreTextureService : iGaiaCoreResourceService

- (void)loadTextureForOwner:(iGaiaCoreResourceLoadDispatcher)owner withName:(NSString*)name;

@end
