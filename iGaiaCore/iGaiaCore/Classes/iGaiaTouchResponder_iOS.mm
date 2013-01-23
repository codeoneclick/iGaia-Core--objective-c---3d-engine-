//
//  iGaiaiOSTouchResponder.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaTouchResponder_iOS.h"
#include "iGaiaLogger.h"
#include "iGaiaGLWindow_iOS.h"

@interface iGaiaTouchResponder_iOS()
{
    set<iGaiaTouchCallback*> m_listeners;
}

@end

@implementation iGaiaTouchResponder_iOS

- (id)init
{
    self = [super init];
    if(self)
    {
        [self removeFromSuperview];
        //[self setFrame:[iGaiaGLWindow_iOS SharedInstance].frame];
        //[[iGaiaGLWindow_iOS SharedInstance] addSubview:self];
    }
    return self;
}

- (void)AddEventListener:(iGaiaTouchCallback*)_listener
{
    m_listeners.insert(_listener);
}

- (void)RemoveEventListener:(iGaiaTouchCallback*)_listener
{
    m_listeners.erase(_listener);
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        //CGPoint touchLocation = [touch locationInView:[iGaiaGLWindow_iOS SharedInstance]];
    }
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        //CGPoint touchLocation = [touch locationInView:[iGaiaGLWindow_iOS SharedInstance]];
    }
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        //CGPoint touchLocation = [touch locationInView:[iGaiaGLWindow_iOS SharedInstance]];

        for (set<iGaiaTouchCallback*>::iterator iterator = m_listeners.begin(); iterator != m_listeners.end(); ++iterator)
        {
            iGaiaTouchCallback* listener = *iterator;
            //listener->InvokeOnTouchListener(touchLocation.x, touchLocation.y);
        }
    }
}

- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        //CGPoint touchLocation = [touch locationInView:[iGaiaGLWindow_iOS SharedInstance]];
    }
}

@end
