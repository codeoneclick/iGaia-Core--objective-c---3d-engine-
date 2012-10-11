//
//  iGaiaRenderMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <OpenGLES/ES2/gl.h>
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

#import "iGaiaRenderMgr.h"
#import "iGaiaRenderCallback.h"
#import "iGaiaGLView.h"
#import "iGaiaRenderOperationWorldSpace.h"
#import "iGaiaRenderOperationScreenSpace.h"
#import "iGaiaRenderOperationOutlet.h"
#import "iGaiaLogger.h"
#import "iGaiaLoop.h"

@interface iGaiaRenderMgr()<iGaiaLoopCallback>
{
    iGaiaRenderOperationWorldSpace* _m_worldSpaceOperations[E_RENDER_MODE_WORLD_SPACE_MAX];
    iGaiaRenderOperationScreenSpace* _m_screenSpaceOperations[E_RENDER_MODE_SCREEN_SPACE_MAX];
    iGaiaRenderOperationOutlet* _m_outletOperation;
}

@property(nonatomic, readwrite) iGaiaGLView* m_glView;

@end

@implementation iGaiaRenderMgr

@synthesize m_glView = _m_glView;

+ (iGaiaRenderMgr *)sharedInstance
{
    static iGaiaRenderMgr *_shared = nil;
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
        [[iGaiaLoop sharedInstance] addEventListener:self];
    }
    return self;
}

- (UIView*)createViewWithFrame:(CGRect)frame;
{
    _m_glView = [[iGaiaGLView alloc] initWithFrame:frame];

    for(NSInteger i = 0; i < E_RENDER_MODE_WORLD_SPACE_MAX; ++i)
    {
        _m_worldSpaceOperations[i] = [[iGaiaRenderOperationWorldSpace alloc] initWithSize:glm::vec2(frame.size.width, frame.size.height) forRenderMode:(E_RENDER_MODE_WORLD_SPACE)i withName:@"render.mode.worldspace"];
    }

    for(NSInteger i = 0; i < E_RENDER_MODE_SCREEN_SPACE_MAX; ++i)
    {
        _m_screenSpaceOperations[i] = [[iGaiaRenderOperationScreenSpace alloc] initWithSize:glm::vec2(frame.size.width, frame.size.height) withShader:E_SHADER_SCREEN_PLANE withName:@"render.mode.screenspace"];
    }

    _m_outletOperation = [[iGaiaRenderOperationOutlet alloc] initWithSize:glm::vec2(frame.size.width, frame.size.height) withShaderName:E_SHADER_SCREEN_PLANE withFrameBufferHandle:((iGaiaGLView*)_m_glView).m_frameBufferHandle withRenderBufferHandle:((iGaiaGLView*)_m_glView).m_renderBufferHandle];

    return _m_glView;
}

- (void)addEventListener:(id<iGaiaRenderCallback>)listener forRendeMode:(E_RENDER_MODE_WORLD_SPACE)mode
{
    [_m_worldSpaceOperations[mode] addEventListener:listener];
}

- (iGaiaTexture*)retriveTextureFromWorldSpaceRenderMode:(E_RENDER_MODE_WORLD_SPACE)mode
{
    return _m_worldSpaceOperations[mode].m_externalTexture;
}

- (iGaiaTexture*)retriveTextureFromScreenSpaceRenderMode:(E_RENDER_MODE_SCREEN_SPACE)mode
{
    return _m_screenSpaceOperations[mode].m_externalTexture;
}

- (void)onUpdate
{
    for(NSInteger i = 0; i < E_RENDER_MODE_WORLD_SPACE_MAX; ++i)
    {
        [_m_worldSpaceOperations[i] bind];
        [_m_worldSpaceOperations[i] draw];
        [_m_worldSpaceOperations[i] unbind];
    }

    for(NSInteger i = 0; i < E_RENDER_MODE_SCREEN_SPACE_MAX; ++i)
    {
        [_m_screenSpaceOperations[i] bind];
        [_m_screenSpaceOperations[i] draw];
        [_m_screenSpaceOperations[i] unbind];
    }

    [_m_outletOperation.m_material setTexture:_m_worldSpaceOperations[E_RENDER_MODE_WORLD_SPACE_SIMPLE].m_externalTexture forSlot:E_TEXTURE_SLOT_01];
    [_m_outletOperation bind];
    [_m_outletOperation draw];
    [_m_outletOperation unbind];

    [((iGaiaGLView*)_m_glView).m_context presentRenderbuffer:GL_RENDERBUFFER];

    GLenum error = glGetError();
    if (error != GL_NO_ERROR)
    {
        iGaiaLog(@"GL error -> %i", error);
    }
}

@end
