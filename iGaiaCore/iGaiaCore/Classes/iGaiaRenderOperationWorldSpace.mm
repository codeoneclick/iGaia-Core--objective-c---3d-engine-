//
//  iGaiaRenderOperationWorldSpace.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaRenderOperationWorldSpace.h"

#import <OpenGLES/ES2/gl.h>

#import "iGaiaLogger.h"

@interface iGaiaRenderOperationWorldSpace()

@property(nonatomic, assign) GLuint m_frameBufferHandle;
@property(nonatomic, assign) GLuint m_depthBufferHandle;
@property(nonatomic, assign) glm::vec2 m_size;
@property(nonatomic, strong) NSMutableSet* m_listeners;
@property(nonatomic, assign) E_RENDER_MODE_WORLD_SPACE m_renderMode;

@end

@implementation iGaiaRenderOperationWorldSpace

@synthesize m_frameBufferHandle = _m_frameBufferHandle;
@synthesize m_depthBufferHandle = _m_depthBufferHandle;
@synthesize m_texture = _m_texture;
@synthesize m_size = _m_size;
@synthesize m_listeners = _m_listeners;
@synthesize m_renderMode = _m_renderMode;

- (id)initWithSize:(glm::vec2)size forRenderMode:(E_RENDER_MODE_WORLD_SPACE)renderMode withName:(NSString*)name
{
    self = [super init];
    if(self)
    {
        _m_size = size;
        _m_renderMode = renderMode;

        NSUInteger textureHandle;
        glGenTextures(1, &textureHandle);
        glGenFramebuffers(1, &_m_frameBufferHandle);
        glGenRenderbuffers(1, &_m_depthBufferHandle);
        glBindTexture(GL_TEXTURE_2D, textureHandle);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, _m_size.x, _m_size.y, 0, GL_RGB, GL_UNSIGNED_SHORT_5_6_5, NULL);
        glBindFramebuffer(GL_FRAMEBUFFER, _m_frameBufferHandle);
        glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, textureHandle, 0);
        glBindRenderbuffer(GL_RENDERBUFFER, _m_depthBufferHandle);
        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, _m_size.x, _m_size.y);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _m_depthBufferHandle);

        if(glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
        {
            iGaiaLog(@"Failed init render state");
        }

        _m_texture = [[iGaiaTexture alloc] initWithHandle:textureHandle withWidth:_m_size.x withHeight:_m_size.y withName:name withCreationMode:E_CREATION_MODE_CUSTOM];

        _m_listeners = [NSMutableSet new];
    }
    return self;
}

- (void)addEventListener:(id<iGaiaRenderListener>)listener;
{
    [_m_listeners addObject:listener];
}

- (void)removeEventListener:(id<iGaiaRenderListener>)listener
{
    [_m_listeners removeObject:listener];
}

- (void)bind
{
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
    glBindFramebuffer(GL_FRAMEBUFFER, _m_frameBufferHandle);
    glViewport(0, 0, _m_size.x, _m_size.y);
    glClearColor(0, 0, 0, 1);
}

- (void)unbind
{
    
}

- (void)draw
{
    for(id<iGaiaRenderListener> listener in _m_listeners)
    {
        [listener onRenderWithWorldSpaceRenderMode:_m_renderMode];
    }
}

@end





