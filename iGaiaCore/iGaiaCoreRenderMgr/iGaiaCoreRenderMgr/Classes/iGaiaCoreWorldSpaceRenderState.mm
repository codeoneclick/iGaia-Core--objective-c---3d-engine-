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
#import "iGaiaCoreRenderMgrBridge.h"

@interface iGaiaCoreWorldSpaceRenderState()

@property(nonatomic, assign) GLuint frameBufferHandle;
@property(nonatomic, assign) GLuint depthBufferHandle;
@property(nonatomic, assign) CGSize size;

@end

@implementation iGaiaCoreWorldSpaceRenderState

@synthesize frameBufferHandle = _frameBufferHandle;
@synthesize depthBufferHandle = _depthBufferHandle;
@synthesize texture = _texture;
@synthesize size = _size;

- (id)initWithSize:(CGSize)size 
{
    self = [super init];
    if(self)
    {
        _size = size;
        
        NSUInteger textureHandle;
        glGenTextures(1, &textureHandle);
        glGenFramebuffers(1, &_frameBufferHandle);
        glGenRenderbuffers(1, &_depthBufferHandle);
        glBindTexture(GL_TEXTURE_2D, textureHandle);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, size.width, size.height, 0, GL_RGB, GL_UNSIGNED_SHORT_5_6_5, NULL);
        glBindFramebuffer(GL_FRAMEBUFFER, _frameBufferHandle);
        glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, textureHandle, 0);
        glBindRenderbuffer(GL_RENDERBUFFER, _depthBufferHandle);
        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, size.width, size.height);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthBufferHandle);
            
        if(glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
        {
            iGaiaLog(@"Failed init render state");
        }

         _texture = [[iGaiaCoreRenderMgrBridge sharedInstance].resourceMgrBridge createTextureWithHandle:textureHandle withSize:size];
    }
    return self;
}

- (void)bind
{
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
    glBindFramebuffer(GL_FRAMEBUFFER, _frameBufferHandle);
    glViewport(0, 0, _size.width, _size.height);
    glClearColor(0, 0, 0, 0);
}

- (void)unbind
{

}

@end
