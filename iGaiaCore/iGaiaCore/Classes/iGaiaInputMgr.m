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

+ (iGaiaInputMgr *)sharedInstance
{
    static iGaiaInputMgr *_shared = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (void)setResponderForView:(UIView*)view
{
    _m_responder = [[iGaiaTouchResponder alloc] initWithView:view];
}

@end
