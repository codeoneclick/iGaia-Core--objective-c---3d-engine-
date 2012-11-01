//
//  iGaiaSettings.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 11/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface iGaiaSettings : NSObject

+ (CGRect)retriveFrameRect;
+ (void)registerDefaultsFromSettingsBundle;

@end
