//
//  iGaiaCoreResourceMgr.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaCoreCommunicator.h"
#import "iGaiaCoreShaderComposite.h"

@interface iGaiaCoreResourceMgr : NSObject

@property(nonatomic, readonly) iGaiaCoreShaderComposite* shaderComposite;

+ (iGaiaCoreResourceMgr*)sharedInstance;
- (void)loadResourceForOwner:(id<iGaiaCoreResourceLoaderProtocol>)owner withName:(NSString*)name;

@end
