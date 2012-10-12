//
//  iGaiaTouchMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaTouchMgr.h"

@interface iGaiaTouchMgr()

@property(nonatomic, readwrite) iGaiaTouchResponder* m_responder;
@property(nonatomic, readwrite) iGaiaTouchCrosser* m_crosser;

@end

@implementation iGaiaTouchMgr

@synthesize m_responder = _m_responder;
@synthesize m_crosser = _m_crosser;
@synthesize m_operationView = _m_operationView;

- (id)init
{
    self = [super init];
    if(self)
    {
        _m_responder = [iGaiaTouchResponder new];
        _m_crosser = [iGaiaTouchCrosser new];
        [_m_responder addEventListener:_m_crosser];
    }
    return self;
}

- (void)setM_operationView:(UIView *)m_operationView
{
    _m_responder.m_operationView = m_operationView;
}

@end
