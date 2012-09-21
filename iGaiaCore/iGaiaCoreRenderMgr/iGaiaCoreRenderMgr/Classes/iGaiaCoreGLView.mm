//
//  iGaiaCoreGLView.m
//  iGaiaCoreRenderMgr
//
//  Created by Sergey Sergeev on 9/21/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES2/gl.h>

#import "iGaiaCoreGLView.h"

@interface iGaiaCoreGLView()

@property(nonatomic, strong) CAEAGLLayer* eaglLayer;
@property(nonatomic, strong) EAGLContext* context;

@end

@implementation iGaiaCoreGLView

@synthesize eaglLayer = _eaglLayer;
@synthesize context = _context;

+ (Class) layerClass
{
    return [CAEAGLLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _eaglLayer = (CAEAGLLayer*) super.layer;
        _eaglLayer.opaque = YES;

        EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
        _context = [[EAGLContext alloc] initWithAPI:api];

        if (!_context || ![EAGLContext setCurrentContext:_context])
        {
            return nil;
        }

        GLuint handleRenderBuffer;
        glGenRenderbuffers(1, &handleRenderBuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, handleRenderBuffer);
        [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];

        GLuint handleFrameBuffer;
        glGenFramebuffers(1, &handleFrameBuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, handleFrameBuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, handleRenderBuffer);

        if(glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
        {
            
        }

        CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawView:)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (void)didRotate: (NSNotification*) notification
{

}

- (void) drawView:(CADisplayLink*)displayLink
{

}


@end
