//
//  iGaiaLoop.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/7/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaLoop.h"

#import <QuartzCore/QuartzCore.h>

@interface iGaiaLoop()

@property(nonatomic, strong) NSMutableSet* m_listeners; 

@end

@implementation iGaiaLoop

@synthesize m_listeners = _m_listeners;
@synthesize m_callback = _m_callback;

+ (iGaiaLoop *)sharedInstance
{
    static iGaiaLoop *_shared = nil;
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
        _m_listeners = [NSMutableSet new];
        _m_callback = @selector(onUpdate:);
    }
    return self;
}

- (void)addEventListener:(id<iGaiaLoopCallback>)listener
{
    [_m_listeners addObject:listener];
}

- (void)onUpdate:(CADisplayLink*)displayLink
{
    for(id<iGaiaLoopCallback> listener in _m_listeners)
    {
        [listener onUpdate];
    }
}

@end
