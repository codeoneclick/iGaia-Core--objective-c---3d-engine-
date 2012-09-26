//
//  iGaiaCoreRenderMgr.h
//  iGaiaCoreRenderMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "iGaiaCoreCommunicator.h"

@interface iGaiaCoreRenderMgr : NSObject<iGaiaCoreRenderMgrProtocol>

+ (iGaiaCoreRenderMgr*)sharedInstance;

@end
