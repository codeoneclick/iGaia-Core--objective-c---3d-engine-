//
//  iGaiaCoreWorldSpaceRenderState.m
//  iGaiaCoreRenderMgr
//
//  Created by Sergey Sergeev on 9/25/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <OpenGLES/ES2/gl.h>

#import "iGaiaCoreWorldSpaceRenderState.h"
#import "iGaiaCoreLogger.h"

@interface iGaiaCoreWorldSpaceRenderState()

@property(nonatomic, assign) GLuint frameBufferHandle;
@property(nonatomic, assign) GLuint depthBufferHandle;
@property(nonatomic, assign) GLuint textureHandle;
@property(nonatomic, assign) CGSize size;

@end

@implementation iGaiaCoreWorldSpaceRenderState

@synthesize frameBufferHandle = _frameBufferHandle;
@synthesize depthBufferHandle = _depthBufferHandle;
@synthesize textureHandle = _textureHandle;
@synthesize size = _size;

- (id)initWithSize:(CGSize)size 
{
    self = [super init];
    if(self)
    {
        glGenTextures(1, &_textureHandle);
        glGenFramebuffers(1, &_frameBufferHandle);
        glGenRenderbuffers(1, &_depthBufferHandle);
        glBindTexture(GL_TEXTURE_2D, _textureHandle);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, size.width, size.height, 0, GL_RGB, GL_UNSIGNED_SHORT_5_6_5, NULL);
        glBindFramebuffer(GL_FRAMEBUFFER, _frameBufferHandle);
        glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, _textureHandle, 0);
        glBindRenderbuffer(GL_RENDERBUFFER, _depthBufferHandle);
        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, size.width, size.height);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthBufferHandle);
            
        if(glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
        {
            iGaiaLog(@"Failed init render state");
        }
    }
    return self;
}

@end
