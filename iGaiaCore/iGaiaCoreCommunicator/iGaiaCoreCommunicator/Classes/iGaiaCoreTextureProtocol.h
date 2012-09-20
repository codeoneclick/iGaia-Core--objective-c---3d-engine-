//
//  iGaiaCoreTextureProtocol.h
//  iGaiaCoreCommunicator
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "iGaiaCoreResourceProtocol.h"

@protocol iGaiaCoreTextureProtocol <iGaiaCoreResourceProtocol>

@property(nonatomic, readonly) NSUInteger handle;
@property(nonatomic, readonly) CGSize size;

- (void)setWrapSettings:(NSInteger)settings;

@end
