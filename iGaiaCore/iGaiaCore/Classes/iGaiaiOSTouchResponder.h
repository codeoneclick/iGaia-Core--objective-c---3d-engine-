//
//  iGaiaiOSTouchResponder.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaTouchCallback.h"

@interface iGaiaiOSTouchResponder : UIView

@property(nonatomic, assign) UIView* m_operationView;

- (void)AddEventListener:(iGaiaTouchCallback*)_listener;
- (void)RemoveEventListener:(iGaiaTouchCallback*)_listener;

@end
