//
//  iGaiaCoreScreenSpaceRenderState.m
//  iGaiaCoreRenderMgr
//
//  Created by Sergey Sergeev on 9/25/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <OpenGLES/ES2/gl.h>

#import "iGaiaCoreScreenSpaceRenderState.h"
#import "iGaiaCoreLogger.h"
#import "iGaiaCoreRenderMgrBridge.h"
#import "iGaiaCoreDefinitions.h"

@interface iGaiaCoreScreenSpaceRenderState()

@property(nonatomic, assign) GLuint frameBufferHandle;
@property(nonatomic, assign) GLuint depthBufferHandle;
@property(nonatomic, assign) CGSize size;
@property(nonatomic, strong) iGaiaCoreShaderObjectRule shader;
@property(nonatomic, strong) iGaiaCoreMeshObjectRule mesh;
@property(nonatomic, strong) NSString* renderStateName;

@end

@implementation iGaiaCoreScreenSpaceRenderState

@synthesize frameBufferHandle = _frameBufferHandle;
@synthesize depthBufferHandle = _depthBufferHandle;
@synthesize texture = _texture;
@synthesize size = _size;
@synthesize shader = _shader;
@synthesize mesh = _mesh;
@synthesize renderStateName = _renderStateName;

- (id)initWithSize:(CGSize)size withShaderName:(NSString*)shaderName withRenderStateName:(NSString*)renderStateName;
{
    self = [super init];
    if(self)
    {
        _renderStateName = renderStateName;
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

        iGaiaCoreVertexBufferObjectRule vertexBuffer = [[iGaiaCoreRenderMgrBridge sharedInstance].resourceMgrBridge createVertexBufferWithNumVertexes:4 withMode:GL_STATIC_DRAW];

        iGaiaCoreVertex* vertexData = [vertexBuffer lock];

        vertexData[0].position = glm::vec3(-1.0f,-1.0f,0.0f);
        vertexData[0].texcoord = glm::vec2(0.0f,0.0f);
        vertexData[1].position = glm::vec3(-1.0f,1.0f,0.0f);
        vertexData[1].texcoord = glm::vec2(0.0f,1.0f);
        vertexData[2].position = glm::vec3(1.0f,-1.0f,0.0f);
        vertexData[2].texcoord = glm::vec2(1.0f,0.0f);
        vertexData[3].position = glm::vec3(1.0f,1.0f,0.0f);
        vertexData[3].texcoord = glm::vec2(1.0f,1.0f);

        [vertexBuffer unlock];

        iGaiaCoreIndexBufferObjectRule indexBuffer = [[iGaiaCoreRenderMgrBridge sharedInstance].resourceMgrBridge createIndexBufferWithNumIndexes:6 withMode:GL_STATIC_DRAW];

        unsigned short* indexData = [indexBuffer lock];
        
        indexData[0] = 0;
        indexData[1] = 1;
        indexData[2] = 2;
        indexData[3] = 1;
        indexData[4] = 2;
        indexData[5] = 3;

        [indexBuffer unlock];

        _shader = [[iGaiaCoreRenderMgrBridge sharedInstance].shaderCompositeBrigde retrieveShaderWithName:shaderName];

        [vertexBuffer addShaderReference:_shader forRenderMode:_renderStateName];
        _mesh = [[iGaiaCoreRenderMgrBridge sharedInstance].resourceMgrBridge createMeshWithVertexBuffer:vertexBuffer withIndexBuffer:indexBuffer];

    }
    return self;
}

- (void)bindWithOriginTexture:(iGaiaCoreTextureObjectRule)texture;
{
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
    glBindFramebuffer(GL_FRAMEBUFFER, _frameBufferHandle);
    glViewport(0, 0, _size.width, _size.height);
    glClearColor(0, 1, 0, 1);

    [_shader bind];
    [_shader setTexture:[texture handle] forSlot:iGaiaCoreDefinitionShaderTextureSlot.texture_01];
    [[_mesh vertexBuffer] bindForRenderMode:_renderStateName];
    [[_mesh indexBuffer] bind];
}

- (void)draw;
{
     glDrawElements(GL_TRIANGLES, [[_mesh indexBuffer] numIndexes], GL_UNSIGNED_SHORT, (void*) NULL);
}

- (void)unbind;
{
    [[_mesh indexBuffer] unbind];
    [[_mesh vertexBuffer] unbindForRenderMode:iGaiaCoreDefinitionScreenSpaceRenderMode.simple];
    [_shader unbind];
}


@end
