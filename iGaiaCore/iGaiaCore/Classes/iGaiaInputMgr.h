//
//  iGaiaInputMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface iGaiaInputMgr : NSObject

+ (iGaiaInputMgr *)sharedInstance;
- (void)setResponderForView:(UIView*)view;

@end
