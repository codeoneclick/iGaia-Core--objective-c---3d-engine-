//
//  iGaiaCoreRenderMgr.m
//  iGaiaCoreRenderMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaCoreRenderMgr.h"
#import "iGaiaCoreGLView.h"
#import "iGaiaCoreDefinitions.h"

@interface iGaiaCoreRenderMgr()

@property(nonatomic, strong) iGaiaCoreGLView* glView;

@property(nonatomic, strong) NSMutableDictionary* container;

@end

@implementation iGaiaCoreRenderMgr

@synthesize glView = _glView;
@synthesize container = _container;

+ (iGaiaCoreRenderMgr *)sharedInstance;
{
    static iGaiaCoreRenderMgr *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];

    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        _container = [NSMutableDictionary new];
    }
    return self;
}

- (UIView*)createViewWithFrame:(CGRect)frame withOwner:(id<iGaiaCoreRenderViewProtocol>)owner;
{
    return _glView = [[iGaiaCoreGLView alloc] initWithFrame:frame withCallbackDrawOwner:self withCallbackDrawSelector:@selector(drawView:)];
}

- (void)createRelationForObjectOwner:(iGaiaCoreRenderDispatcher)owner withRenderState:(NSString*)renderState;
{
    NSMutableArray* owners = [self.container objectForKey:renderState];
    if(owners == nil)
    {
        owners = [NSMutableArray new];
        [self.container setObject:owners forKey:renderState];
    }
    [owners addObject:owner];
}

- (void)drawView:(CADisplayLink*)displayLink
{
    NSArray* owners = [self.container objectForKey:iGaiaCoreDefinitionWorldSpaceRenderMode.simple];
    for(iGaiaCoreRenderDispatcher owner in owners)
    {
        [owner onRenderWithRenderMode:iGaiaCoreDefinitionWorldSpaceRenderMode.simple withForceUpdate:NO];
    }
    owners = [self.container objectForKey:iGaiaCoreDefinitionWorldSpaceRenderMode.reflection];
    for(iGaiaCoreRenderDispatcher owner in owners)
    {
        [owner onRenderWithRenderMode:iGaiaCoreDefinitionWorldSpaceRenderMode.reflection withForceUpdate:YES];
    }
    owners = [self.container objectForKey:iGaiaCoreDefinitionWorldSpaceRenderMode.refraction];
    for(iGaiaCoreRenderDispatcher owner in owners)
    {
        [owner onRenderWithRenderMode:iGaiaCoreDefinitionWorldSpaceRenderMode.refraction withForceUpdate:YES];
    }
}


@end
