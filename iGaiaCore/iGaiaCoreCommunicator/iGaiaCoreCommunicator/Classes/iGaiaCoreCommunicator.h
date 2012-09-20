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

@protocol iGaiaCoreResourceLoaderProtocol <NSObject>

- (void)onResourceLoad:(id<iGaiaCoreResourceProtocol>)resource withName:(NSString*)name;

@end

@interface iGaiaCoreCommunicator : NSObject

@end
