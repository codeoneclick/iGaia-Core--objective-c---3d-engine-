//
//  iGaiaLoop.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/7/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaLoopCallback.h"

@interface iGaiaLoop : NSObject

@property(nonatomic, assign) SEL m_callback;

+ (iGaiaLoop *)sharedInstance;

- (void)addEventListener:(id<iGaiaLoopCallback>)listener;

@end
