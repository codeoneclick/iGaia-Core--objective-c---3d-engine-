//
//  iGaiaCoreRenderMgrBridge.h
//  iGaiaCoreRenderMgr
//
//  Created by Sergey Sergeev on 9/25/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iGaiaCoreCommunicator.h"

@interface iGaiaCoreRenderMgrBridge : NSObject

@property(nonatomic, strong) iGaiaCoreResourceMgr resourceMgrBridge;

+ (iGaiaCoreRenderMgrBridge*)sharedInstance;

@end
