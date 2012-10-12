//
//  iGaiaTouchMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "iGaiaTouchResponder.h"
#import "iGaiaTouchCrosser.h"

@interface iGaiaTouchMgr : NSObject

@property(nonatomic, assign) UIView* m_operationView;

@property(nonatomic, readonly) iGaiaTouchResponder* m_responder;
@property(nonatomic, readonly) iGaiaTouchCrosser* m_crosser;

@end
