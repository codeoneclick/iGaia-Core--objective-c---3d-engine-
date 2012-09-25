//
//  iGaiaCoreFacade.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 9/25/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaCoreResourceMgrProtocol.h"

typedef id<iGaiaCoreResourceMgrProtocol, iGaiaCoreResourceFabricaProtocol> iGaiaCoreResourceMgr_;

@interface iGaiaCoreFacade : NSObject

+(iGaiaCoreResourceMgr_)resourceMgr;

@end
