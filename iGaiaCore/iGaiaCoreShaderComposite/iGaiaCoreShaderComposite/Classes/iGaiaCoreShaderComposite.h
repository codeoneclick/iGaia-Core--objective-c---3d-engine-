//
//  iGaiaCoreShaderComposite.h
//  iGaiaCoreShaderComposite
//
//  Created by Sergey Sergeev on 9/24/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaCoreCommunicator.h"
#import "iGaiaCoreDefinitions.h"

@interface iGaiaCoreShaderComposite : NSObject<iGaiaCoreShaderCompositeProtocol>

+ (iGaiaCoreShaderComposite*)sharedInstance;

@end
