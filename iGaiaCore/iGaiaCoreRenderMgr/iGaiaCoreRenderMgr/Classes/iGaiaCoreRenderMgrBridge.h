//
//  iGaiaCoreRenderMgrBridge.h
//  iGaiaCoreRenderMgr
//
//  Created by Sergey Sergeev on 9/26/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaCoreCommunicator.h"

@interface iGaiaCoreRenderMgrBridge : NSObject

@property(nonatomic, strong) iGaiaCoreResourceMgrObjectRule resourceMgrBridge;
@property(nonatomic, strong) iGaiaCoreShaderCompositeObjectRule shaderCompositeBrigde;

+ (iGaiaCoreRenderMgrBridge*)sharedInstance;

@end
