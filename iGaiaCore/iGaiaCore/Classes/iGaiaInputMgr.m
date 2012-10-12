//
//  iGaiaInputMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaInputMgr.h"
#import "iGaiaTouchResponder.h"

@interface iGaiaInputMgr()

@property(nonatomic, strong) iGaiaTouchResponder* m_responder;

@end

@implementation iGaiaInputMgr

@synthesize m_responder = _m_responder;
@synthesize m_operationView = _m_operationView;

- (id)init
{
    self = [super init];
    if(self)
    {
        _m_responder = [iGaiaTouchResponder new];
    }
    return self;
}

- (void)setM_operationView:(UIView *)m_operationView
{
    _m_responder.m_operationView = m_operationView;
}

@end
