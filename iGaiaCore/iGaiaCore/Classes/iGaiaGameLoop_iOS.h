//
//  iGaiaGameLoop_iOS.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/7/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaGameLoop_iOSClass
#define iGaiaGameLoop_iOSClass

#import "iGaiaCommon.h"
#import "iGaiaLoopCallback.h"

@interface iGaiaGameLoop_iOS : NSObject

@property(nonatomic, assign) SEL m_callback;

+ (iGaiaGameLoop_iOS*)SharedInstance;

- (void)AddEventListener:(iGaiaLoopCallback*)_listener;
- (void)RemoveEventListener:(iGaiaLoopCallback*)_listener;

@end

#endif