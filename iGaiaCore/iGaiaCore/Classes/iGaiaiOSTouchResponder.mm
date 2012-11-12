//
//  iGaiaiOSTouchResponder.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaiOSTouchResponder.h"
#import "iGaiaLogger.h"

@interface iGaiaiOSTouchResponder()

@property(nonatomic, unsafe_unretained) set<iGaiaTouchCallback*> m_listeners;

@end

@implementation iGaiaiOSTouchResponder

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

- (void)AddEventListener:(iGaiaTouchCallback*)_listener
{
    self.m_listeners.insert(_listener);
};

- (void)RemoveEventListener:(iGaiaTouchCallback*)_listener
{
    self.m_listeners.erase(_listener);
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:_m_operationView];
    }
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:_m_operationView];
    }
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:_m_operationView];

        for(iGaiaTouchCallback* listener : self.m_listeners)
        {
            listener->OnTouch(touchLocation.x, touchLocation.y);
        }
    }
}

- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:_m_operationView];
    }
}

@end
