//
//  iGaiaRenderMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <OpenGLES/ES2/gl.h>
#import <QuartzCore/QuartzCore.h>

#import "iGaiaRenderMgr.h"
#import "iGaiaRenderListener.h"
#import "iGaiaGLView.h"
#import "iGaiaRenderOperationWorldSpace.h"
#import "iGaiaRenderOperationScreenSpace.h"
#import "iGaiaRenderOperationOutlet.h"

@interface iGaiaRenderMgr()
{
    iGaiaRenderOperationWorldSpace* _m_worldSpaceOperations[E_RENDER_MODE_WORLD_SPACE_MAX];
    iGaiaRenderOperationScreenSpace* _m_screenSpaceOperations[E_RENDER_MODE_SCREEN_SPACE_MAX];
    iGaiaRenderOperationOutlet* _m_outletOperation;
}

@property(nonatomic, strong) iGaiaGLView* m_view;

@end

@implementation iGaiaRenderMgr

@synthesize m_view = _m_view;

+ (iGaiaRenderMgr *)sharedInstance
{
    static iGaiaRenderMgr *_shared = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (UIView*)createViewWithFrame:(CGRect)frame;
{
    _m_view = [[iGaiaGLView alloc] initWithFrame:frame withCallbackDrawOwner:self withCallbackDrawSelector:@selector(drawView:)];

    for(NSInteger i = 0; i < E_RENDER_MODE_WORLD_SPACE_MAX; ++i)
    {
        _m_worldSpaceOperations[i] = [[iGaiaRenderOperationWorldSpace alloc] initWithSize:glm::vec2(frame.size.width, frame.size.height) forRenderMode:(E_RENDER_MODE_WORLD_SPACE)i withName:@"render.mode.worldspace"];
    }

    for(NSInteger i = 0; i < E_RENDER_MODE_SCREEN_SPACE_MAX; ++i)
    {
        _m_screenSpaceOperations[i] = [[iGaiaRenderOperationScreenSpace alloc] initWithSize:glm::vec2(frame.size.width, frame.size.height) withShader:E_SHADER_SCREEN_PLANE forRenderMode:(E_RENDER_MODE_SCREEN_SPACE)i withName:@"render.mode.screenspace"];
    }

    _m_outletOperation = [[iGaiaRenderOperationOutlet alloc] initWithSize:glm::vec2(frame.size.width, frame.size.height) withShaderName:E_SHADER_SCREEN_PLANE withFrameBufferHandle:_m_view.m_frameBufferHandle withRenderBufferHandle:_m_view.m_renderBufferHandle];

    return _m_view;
}

- (void)addEventListener:(id<iGaiaRenderListener>)listener forRendeMode:(E_RENDER_MODE_WORLD_SPACE)renderMode
{
    [_m_worldSpaceOperations[renderMode] addEventListener:listener];
}

- (void)drawView:(CADisplayLink*)displayLink
{
    iGaiaTexture* fakeTexture = nil;
    
    for(NSInteger i = 0; i < E_RENDER_MODE_WORLD_SPACE_MAX; ++i)
    {
        [_m_worldSpaceOperations[i] bind];
        [_m_worldSpaceOperations[i] draw];
        [_m_worldSpaceOperations[i] unbind];
        fakeTexture = _m_worldSpaceOperations[i].m_texture;
    }

    for(NSInteger i = 0; i < E_RENDER_MODE_SCREEN_SPACE_MAX; ++i)
    {
        [_m_screenSpaceOperations[i] bind];
        [_m_screenSpaceOperations[i] draw];
        [_m_screenSpaceOperations[i] unbind];
    }

    _m_outletOperation.m_outletTexture = fakeTexture;
    [_m_outletOperation bind];
    [_m_outletOperation draw];
    [_m_outletOperation unbind];

    [_m_view.m_context presentRenderbuffer:GL_RENDERBUFFER];
}

@end
