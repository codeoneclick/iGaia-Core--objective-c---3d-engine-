//
//  iGaiaCoreResourceMgr.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaCoreCommunicator.h"

@interface iGaiaCoreResourceMgr : NSObject

+ (iGaiaCoreResourceMgr*)sharedInstance;
- (void)loadResourceForOwner:(id<iGaiaCoreResourceLoaderProtocol>)owner withName:(NSString*)name;

@end
