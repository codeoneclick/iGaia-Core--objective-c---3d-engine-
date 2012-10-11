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

@property(nonatomic, assign) UIView *m_glView;

@end

@implementation iGaiaTouchResponder

@synthesize m_glView = _m_glView;

- (id)initWithView:(UIView *)view
{
    self = [super init];
    if(self)
    {
        _m_glView = view;
        self.frame = _m_glView.frame;
        [_m_glView addSubview:self];
    }
    return self;
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:_m_glView];
        iGaiaLog(@"Touch Began x : %f , y : %f", touchLocation.x, touchLocation.y);
    }
}
- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:_m_glView];
        iGaiaLog(@"Touch Moved x : %f , y : %f", touchLocation.x, touchLocation.y);
    }
}
- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:_m_glView];
        iGaiaLog(@"Touch Ended x : %f , y : %f", touchLocation.x, touchLocation.y);
    }
}
- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:_m_glView];
        iGaiaLog(@"Touch Cancelled x : %f , y : %f", touchLocation.x, touchLocation.y);
    }
}

@end
