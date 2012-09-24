//
//  iGaiaCoreRenderMgr.m
//  iGaiaCoreRenderMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaCoreRenderMgr.h"
#import "iGaiaCoreGLView.h"


const struct iGaiaCoreWorldSpaceRenderMode iGaiaCoreWorldSpaceRenderMode =
{
    .simple = @"igaia.worldspace.rendermode.simple",
    .reflection = @"igaia.worldspace.rendermode.reflection",
    .refraction = @"igaia.worldspace.rendermode.refraction",
    .screenNormalMapping = @"igaia.worldspace.rendermode.screennormalmapping"
};


const struct iGaiaCoreScreenSpaceRenderMode iGaiaCoreScreenSpaceRenderMode =
{
    .simple = @"igaia.screenspace.rendermode.simple",
    .blur = @"igaia.screenspace.rendermode.blur",
    .bloom = @"igaia.screenspace.rendermode.bloom",
    .edgeDetect = @"igaia.screenspace.rendermode.edgeDetect",
    .sepia = @"igaia.screenspace.rendermode.sepia",
};

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

- (void)addRenderNodeWithOwner:(id<iGaiaCoreRenderProtocol>)owner forRenderState:(NSString*)renderState;
{
    NSMutableArray* nodes = [self.container objectForKey:renderState];
    if(nodes == nil)
    {
        nodes = [NSMutableArray new];
        [self.container setObject:nodes forKey:renderState];
    }
    [nodes addObject:owner];
}

- (void) drawView:(CADisplayLink*)displayLink
{

}


@end
