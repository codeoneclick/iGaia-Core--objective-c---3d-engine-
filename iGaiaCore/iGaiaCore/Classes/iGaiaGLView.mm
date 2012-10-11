//
//  iGaiaGLView.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/2/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaGLView.h"

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES2/gl.h>

#import "iGaiaLoop.h"
#import "iGaiaLogger.h"

@interface iGaiaGLView()

@property(nonatomic, strong) CAEAGLLayer* m_eaglLayer;

@end

@implementation iGaiaGLView

@synthesize m_eaglLayer = _m_eaglLayer;
@synthesize m_context = _m_context;
@synthesize m_frameBufferHandle = _m_frameBufferHandle;
@synthesize m_renderBufferHandle = _m_renderBufferHandle;

+ (Class) layerClass
{
    return [CAEAGLLayer class];
}

- (id)initWithFrame:(CGRect)frame;
{
    if (self = [super initWithFrame:frame])
    {
        _m_eaglLayer = (CAEAGLLayer*) super.layer;
        _m_eaglLayer.opaque = YES;

        EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
        _m_context = [[EAGLContext alloc] initWithAPI:api];

        if (!_m_context || ![EAGLContext setCurrentContext:_m_context])
        {
            return nil;
        }

        glGenRenderbuffers(1, &_m_renderBufferHandle);
        glBindRenderbuffer(GL_RENDERBUFFER, _m_renderBufferHandle);
        [_m_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_m_eaglLayer];

        glGenFramebuffers(1, &_m_frameBufferHandle);
        glBindFramebuffer(GL_FRAMEBUFFER, _m_frameBufferHandle);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _m_renderBufferHandle);

        if(glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
        {

        }
        CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:[iGaiaLoop sharedInstance] selector:[iGaiaLoop sharedInstance].m_callback];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return self;
}

@end






