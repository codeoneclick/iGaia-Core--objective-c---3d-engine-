//
//  iGaiaTouchResponder.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iGaiaTouchCallback.h"

@interface iGaiaTouchResponder : UIView

@property(nonatomic, assign) UIView* m_operationView;

- (void)addEventListener:(id<iGaiaTouchCallback>)listener;
- (void)removeEventListener:(id<iGaiaTouchCallback>)listener;

@end
