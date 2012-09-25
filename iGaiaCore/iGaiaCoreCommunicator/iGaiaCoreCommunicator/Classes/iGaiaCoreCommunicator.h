//
//  iGaiaCoreCommunicator.h
//  iGaiaCoreCommunicator
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iGaiaCoreResourceMgrProtocol.h"
#import "iGaiaCoreShaderCompositeProtocol.h"

@protocol iGaiaCoreRenderDispatcherProtocol <NSObject>

@property(nonatomic, assign) NSInteger priority;

- (void)onRenderWithRenderMode:(NSString*)renderMode withForceUpdate:(BOOL)force;

@end

typedef id<iGaiaCoreRenderDispatcherProtocol> iGaiaCoreRenderDispatcher;

@interface iGaiaCoreCommunicator : NSObject

@end
