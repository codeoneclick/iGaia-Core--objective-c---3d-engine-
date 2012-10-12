//
//  iGaiaTouchResponder.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaTouchResponder.h"
#import "iGaiaLogger.h"

@interface iGaiaTouchResponder() 

@end

@implementation iGaiaTouchResponder

@synthesize m_operationView = _m_operationView;

- (id)init
{
    self = [super init];
    if(self)
    {
      
    }
    return self;
}

- (void)setM_operationView:(UIView *)m_operationView
{
    if(_m_operationView == m_operationView)
    {
        return;
    }
    
    _m_operationView = m_operationView;
    [self removeFromSuperview];
    [self setFrame:_m_operationView.frame];
    [_m_operationView addSubview:self];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:_m_operationView];
        iGaiaLog(@"Touch Began x : %f , y : %f", touchLocation.x, touchLocation.y);
    }
}
- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:_m_operationView];
        iGaiaLog(@"Touch Moved x : %f , y : %f", touchLocation.x, touchLocation.y);
    }
}
- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:_m_operationView];
        iGaiaLog(@"Touch Ended x : %f , y : %f", touchLocation.x, touchLocation.y);
    }
}
- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:_m_operationView];
        iGaiaLog(@"Touch Cancelled x : %f , y : %f", touchLocation.x, touchLocation.y);
    }
}

@end
