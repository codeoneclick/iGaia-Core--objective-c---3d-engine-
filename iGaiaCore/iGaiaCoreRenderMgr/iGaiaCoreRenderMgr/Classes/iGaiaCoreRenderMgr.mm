//
//  iGaiaCoreRenderMgr.m
//  iGaiaCoreRenderMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#import <OpenGLES/ES2/gl.h>
#import <QuartzCore/QuartzCore.h>

#import "iGaiaCoreRenderMgr.h"
#import "iGaiaCoreGLView.h"
#import "iGaiaCoreDefinitions.h"
#import "iGaiaCoreWorldSpaceRenderState.h"
#import "iGaiaCoreScreenSpaceRenderState.h"
#import "iGaiaCoreResultRenderState.h"

@interface iGaiaCoreRenderMgr()

@property(nonatomic, strong) iGaiaCoreGLView* glView;
@property(nonatomic, strong) NSMutableDictionary* container;
@property(nonatomic, strong) NSMutableDictionary* worldSpaceRenderStates;
@property(nonatomic, strong) NSMutableDictionary* screenSpaceRenderStates;
@property(nonatomic, strong) iGaiaCoreResultRenderState* resultRenderState;

@end

@implementation iGaiaCoreRenderMgr

@synthesize glView = _glView;
@synthesize container = _container;
@synthesize worldSpaceRenderStates = _worldSpaceRenderStates;
@synthesize screenSpaceRenderStates = _screenSpaceRenderStates;
@synthesize bridgeSetupDelegate = _bridgeSetupDelegate;

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
        _worldSpaceRenderStates = [NSMutableDictionary new];
        _screenSpaceRenderStates = [NSMutableDictionary new];
    }
    return self;
}

- (UIView*)createViewWithFrame:(CGRect)frame;
{
    _glView = [[iGaiaCoreGLView alloc] initWithFrame:frame withCallbackDrawOwner:self withCallbackDrawSelector:@selector(drawView:)];
    [self.bridgeSetupDelegate onRenderMgrBridgeReadyToSetup];
    
    iGaiaCoreWorldSpaceRenderState* worldSpaceRenderState = [[iGaiaCoreWorldSpaceRenderState alloc] initWithSize:[_glView bounds].size];
    [_worldSpaceRenderStates setObject:worldSpaceRenderState forKey:iGaiaCoreDefinitionWorldSpaceRenderMode.simple];

    iGaiaCoreScreenSpaceRenderState* screenSpaceRenderState = [[iGaiaCoreScreenSpaceRenderState alloc] initWithSize:[_glView bounds].size withShaderName:iGaiaCoreDefinitionShaderName.screenSpaceSimple withRenderStateName:iGaiaCoreDefinitionScreenSpaceRenderMode.simple];
    [_screenSpaceRenderStates setObject:screenSpaceRenderState forKey:iGaiaCoreDefinitionScreenSpaceRenderMode.simple];

    _resultRenderState = [[iGaiaCoreResultRenderState alloc] initWithSize:[_glView bounds].size withShaderName:iGaiaCoreDefinitionShaderName.screenSpaceSimple withFrameBufferHandle:_glView.frameBufferHandle withRenderBufferHandle:_glView.renderBufferHandle];

    return _glView;
}

- (void)createRelationForObjectOwner:(iGaiaCoreRenderDispatcherObjectRule)owner withRenderState:(NSString*)renderState;
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

    iGaiaCoreWorldSpaceRenderState* worldSpaceRenderState = [_worldSpaceRenderStates objectForKey:iGaiaCoreDefinitionWorldSpaceRenderMode.simple];
    [worldSpaceRenderState bind];
    for(iGaiaCoreRenderDispatcherObjectRule owner in owners)
    {
        [owner onRenderWithRenderMode:iGaiaCoreDefinitionWorldSpaceRenderMode.simple withForceUpdate:NO];
    }
    [worldSpaceRenderState unbind];
    
    owners = [self.container objectForKey:iGaiaCoreDefinitionWorldSpaceRenderMode.reflection];
    
    worldSpaceRenderState = [_worldSpaceRenderStates objectForKey:iGaiaCoreDefinitionWorldSpaceRenderMode.reflection];
    [worldSpaceRenderState bind];
    for(iGaiaCoreRenderDispatcherObjectRule owner in owners)
    {
        [owner onRenderWithRenderMode:iGaiaCoreDefinitionWorldSpaceRenderMode.reflection withForceUpdate:YES];
    }
    [worldSpaceRenderState unbind];
    
    owners = [self.container objectForKey:iGaiaCoreDefinitionWorldSpaceRenderMode.refraction];

    worldSpaceRenderState = [_worldSpaceRenderStates objectForKey:iGaiaCoreDefinitionWorldSpaceRenderMode.refraction];
    [worldSpaceRenderState bind];
    for(iGaiaCoreRenderDispatcherObjectRule owner in owners)
    {
        [owner onRenderWithRenderMode:iGaiaCoreDefinitionWorldSpaceRenderMode.refraction withForceUpdate:YES];
    }
    [worldSpaceRenderState unbind];

    iGaiaCoreScreenSpaceRenderState* screenSpaceRenderState = [_screenSpaceRenderStates objectForKey:iGaiaCoreDefinitionScreenSpaceRenderMode.simple];
    [screenSpaceRenderState bindWithOriginTexture:[(iGaiaCoreWorldSpaceRenderState*)[_worldSpaceRenderStates objectForKey:iGaiaCoreDefinitionWorldSpaceRenderMode.simple] texture]];
    [screenSpaceRenderState draw];
    [screenSpaceRenderState unbind];

    [_resultRenderState bindWithOriginTexture:screenSpaceRenderState.texture];
    [_resultRenderState draw];
    [_resultRenderState unbind];

    [[_glView context] presentRenderbuffer:GL_RENDERBUFFER];
}


@end
