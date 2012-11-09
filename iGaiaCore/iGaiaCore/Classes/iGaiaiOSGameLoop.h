//
//  iGaiaiOSGameLoop.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/7/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaCommon.h"
#import "iGaiaLoopCallback.h"

@interface iGaiaiOSGameLoop : NSObject

@property(nonatomic, assign) SEL m_callback;

+ (iGaiaiOSGameLoop*)SharedInstance;

- (void)AddEventListener:(iGaiaLoopCallback*)_listener;
- (void)RemoveEventListener:(iGaiaLoopCallback*)_listener;

@end
