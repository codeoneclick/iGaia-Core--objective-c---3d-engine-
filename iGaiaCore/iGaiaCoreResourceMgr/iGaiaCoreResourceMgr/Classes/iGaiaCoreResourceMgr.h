//
//  iGaiaCoreResourceMgr.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaCoreCommunicator.h"
#import "iGaiaCoreResourceMgrProtocol.h"

@interface iGaiaCoreResourceMgr : NSObject<iGaiaCoreResourceMgrProtocol, iGaiaCoreResourceFabricaProtocol>

+ (id<iGaiaCoreResourceMgrProtocol, iGaiaCoreResourceFabricaProtocol>)sharedInstance;

@end
