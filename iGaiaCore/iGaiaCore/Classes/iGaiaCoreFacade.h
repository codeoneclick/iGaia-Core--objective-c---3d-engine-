//
//  iGaiaCoreFacade.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 9/25/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaCoreCommunicator.h"

@interface iGaiaCoreFacade : NSObject

+(iGaiaCoreResourceMgrObjectRule)resourceMgr;
+(iGaiaCoreShaderCompositeObjectRule)shaderComposite;
+(iGaiaCoreRenderMgrObjectRule)renderMgr;

@end
