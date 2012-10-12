//
//  iGaiaTouchCallback.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol iGaiaTouchCallback <NSObject>

- (void)onTouchX:(float)x Y:(float)y;

@end
