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
@property(nonatomic, strong) NSMutableSet* m_unsortedListeners;
@property(nonatomic, strong) NSArray* m_sortedListeners;
@property(nonatomic, assign) E_RENDER_MODE_WORLD_SPACE m_mode;

@end

@implementation iGaiaRenderOperationWorldSpace

@synthesize m_frameBufferHandle = _m_frameBufferHandle;
@synthesize m_depthBufferHandle = _m_depthBufferHandle;
@synthesize m_externalTexture = _m_externalTexture;
@synthesize m_size = _m_size;
@synthesize m_unsortedListeners = _m_unsortedListeners;
@synthesize m_sortedListeners = _m_sortedListeners;
@synthesize m_mode = _m_mode;

- (id)initWithSize:(glm::vec2)size forRenderMode:(E_RENDER_MODE_WORLD_SPACE)mode withName:(NSString*)name
{
    self = [super init];
    if(self)
    {
        _m_size = size;
        _m_mode = mode;

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

        _m_externalTexture = [[iGaiaTexture alloc] initWithHandle:textureHandle withWidth:_m_size.x withHeight:_m_size.y withName:name withCreationMode:E_CREATION_MODE_CUSTOM];
        NSDictionary* settings = [NSDictionary dictionaryWithObjectsAndKeys:iGaiaTextureSettingValues.clamp,iGaiaTextureSettingKeys.wrap, nil];
        _m_externalTexture.m_settings = settings;

        _m_unsortedListeners = [NSMutableSet new];
    }
    return self;
}

- (void)addEventListener:(id<iGaiaRenderCallback>)listener;
{
    [_m_unsortedListeners addObject:listener];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO comparator:^NSComparisonResult(id<iGaiaRenderCallback> listener_01, id<iGaiaRenderCallback> listener_02) {
        NSComparisonResult result = NSOrderedSame;
        if(listener_01.m_priority < listener_02.m_priority)
        {
            result = NSOrderedDescending;
        }
        else if(listener_01.m_priority > listener_02.m_priority)
        {
            result = NSOrderedAscending;
        }
        return result;
    }];
    _m_sortedListeners = [_m_unsortedListeners sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
}

- (void)removeEventListener:(id<iGaiaRenderCallback>)listener
{
    [_m_unsortedListeners removeObject:listener];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO comparator:^NSComparisonResult(id<iGaiaRenderCallback> listener_01, id<iGaiaRenderCallback> listener_02) {
        NSComparisonResult result = NSOrderedSame;
        if(listener_01.m_priority < listener_02.m_priority)
        {
            result = NSOrderedDescending;
        }
        else if(listener_01.m_priority > listener_02.m_priority)
        {
            result = NSOrderedAscending;
        }
        return result;
    }];
    _m_sortedListeners = [_m_unsortedListeners sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
}

- (void)bind
{
    glBindFramebuffer(GL_FRAMEBUFFER, _m_frameBufferHandle);
    glViewport(0, 0, _m_size.x, _m_size.y);
    glClearColor(0.5, 0.5, 0.5, 1.0);
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
}

- (void)unbind
{
    
}

- (void)draw
{
    for(id<iGaiaRenderCallback> listener in _m_sortedListeners)
    {
        [listener onDrawWithRenderMode:_m_mode];
    }
}

@end





