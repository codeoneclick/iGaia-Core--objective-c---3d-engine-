//
//  iGaiaiOSGameLoop.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/7/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaiOSGameLoop.h"

@interface iGaiaiOSGameLoop()
{
    set<iGaiaLoopCallback*> m_listeners;
}

@end

@implementation iGaiaiOSGameLoop

@synthesize m_callback = _m_callback;

+ (iGaiaiOSGameLoop*)SharedInstance
{
    static iGaiaiOSGameLoop *instance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        _m_callback = @selector(onUpdate:);
    }
    return self;
}

- (void)AddEventListener:(iGaiaLoopCallback*)_listener
{
    m_listeners.insert(_listener);
}

- (void)RemoveEventListener:(iGaiaLoopCallback *)_listener
{
    m_listeners.erase(_listener);
}

- (void)onUpdate:(CADisplayLink*)displayLink
{
    for (set<iGaiaLoopCallback*>::iterator iterator = m_listeners.begin(); iterator != m_listeners.end(); ++iterator)
    {
        iGaiaLoopCallback* listener = *iterator;
        listener->InvokeOnUpdateListener();
    }
}

@end
