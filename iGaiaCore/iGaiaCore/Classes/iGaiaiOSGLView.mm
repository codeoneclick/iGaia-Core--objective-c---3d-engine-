//
//  iGaiaiOSGLView.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/2/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaiOSGLView.h"
#import "iGaiaiOSGameLoop.h"
#import "iGaiaLogger.h"

@interface iGaiaiOSGLView()

@property(nonatomic, strong) CAEAGLLayer* m_eaglLayer;

@end

@implementation iGaiaiOSGLView


+ (Class) layerClass
{
    return [CAEAGLLayer class];
}

- (id)initWithFrame:(CGRect)frame;
{
    if (self = [super initWithFrame:frame])
    {
        self.m_eaglLayer = (CAEAGLLayer*) super.layer;
        self.m_eaglLayer.opaque = YES;

        EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
        _m_context = [[EAGLContext alloc] initWithAPI:api];

        if (!self.m_context || ![EAGLContext setCurrentContext:self.m_context])
        {
            return nil;
        }

        glGenRenderbuffers(1, &_m_renderBufferHandle);
        glBindRenderbuffer(GL_RENDERBUFFER, self.m_renderBufferHandle);
        [self.m_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.m_eaglLayer];

        glGenFramebuffers(1, &_m_frameBufferHandle);
        glBindFramebuffer(GL_FRAMEBUFFER, self.m_frameBufferHandle);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, self.m_renderBufferHandle);

        if(glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
        {

        }
        CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:[iGaiaiOSGameLoop SharedInstance] selector:[iGaiaiOSGameLoop SharedInstance].m_callback];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return self;
}

@end






