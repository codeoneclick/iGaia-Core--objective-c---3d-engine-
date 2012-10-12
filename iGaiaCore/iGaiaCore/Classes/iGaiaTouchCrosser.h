//
//  iGaiaTouchCrosser.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "iGaiaCrossCallback.h"
#import "iGaiaTouchCallback.h"
#import "iGaiaCamera.h"

@interface iGaiaTouchCrosser : NSObject<iGaiaTouchCallback>

@property(nonatomic, assign) iGaiaCamera* m_camera;

- (void)addEventListener:(id<iGaiaCrossCallback>)listener;
- (void)removeEventListener:(id<iGaiaCrossCallback>)listener;

@end
