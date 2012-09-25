//
//  iGaiaCoreCommunicator.h
//  iGaiaCoreCommunicator
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaCoreShaderProtocol.h"
#import "iGaiaCoreTextureProtocol.h"
#import "iGaiaCoreMeshProtocol.h"
#import "iGaiaCoreResourceProtocol.h"
#import "iGaiaCoreResourceMgrProtocol.h"

@protocol iGaiaCoreResourceMgrProtocol;
@protocol iGaiaCoreRenderProtocol <NSObject>

@property(nonatomic, assign) NSInteger priority;

- (void)onRenderWithRenderMode:(NSString*)renderMode withForceUpdate:(BOOL)force;

@end

@interface iGaiaCoreCommunicator : NSObject

@end
