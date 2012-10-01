//
//  iGaiaCoreObject3d.h
//  iGaiaCoreStorageMgr
//
//  Created by Sergey Sergeev on 9/27/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaCoreCommunicator.h"

@interface iGaiaCoreObject3d : NSObject<iGaiaCoreUpdateDispatcherProtocol, iGaiaCoreRenderDispatcherProtocol, iGaiaCoreLoadDispatcherProtocol>

@property(nonatomic, assign) glm::vec3 position;
@property(nonatomic, assign) glm::vec3 rotation;
@property(nonatomic, assign) glm::vec3 scale;
@property(nonatomic, readonly) glm::mat4x4 worldMatrix;
@property(nonatomic, readonly) glm::vec3 maxBound;
@property(nonatomic, readonly) glm::vec3 minBound;

@end
