//
//  iGaiaCoreResultRenderState.m
//  iGaiaCoreRenderMgr
//
//  Created by Sergey Sergeev on 9/26/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <OpenGLES/ES2/gl.h>

#import "iGaiaCoreResultRenderState.h"
#import "iGaiaCoreLogger.h"
#import "iGaiaCoreRenderMgrBridge.h"
#import "iGaiaCoreDefinitions.h"

static NSString* resultRenderStateName = @"igaia.renderstate.result";

@interface iGaiaCoreResultRenderState()

@property(nonatomic, assign) GLuint frameBufferHandle;
@property(nonatomic, assign) GLuint renderBufferHandle;
@property(nonatomic, assign) CGSize size;
@property(nonatomic, strong) iGaiaCoreShaderObjectRule shader;
@property(nonatomic, strong) iGaiaCoreMeshObjectRule mesh;

@end

@implementation iGaiaCoreResultRenderState

@synthesize frameBufferHandle = _frameBufferHandle;
@synthesize renderBufferHandle = _renderBufferHandle;
@synthesize size = _size;
@synthesize shader = _shader;
@synthesize mesh = _mesh;

- (id)initWithSize:(CGSize)size withShaderName:(NSString*)shaderName withFrameBufferHandle:(NSUInteger)frameBufferHandle withRenderBufferHandle:(NSUInteger)renderBufferHandle;
{
    self = [super init];
    if(self)
    {
        _size = size;
        _frameBufferHandle = frameBufferHandle;
        _renderBufferHandle = renderBufferHandle;

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

        [vertexBuffer addShaderReference:_shader forRenderMode:resultRenderStateName];
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
    glBindRenderbuffer(GL_RENDERBUFFER, _renderBufferHandle);

    [_shader bind];
    [_shader setTexture:[texture handle] forSlot:iGaiaCoreDefinitionShaderTextureSlot.texture_01];
    [[_mesh vertexBuffer] bindForRenderMode:resultRenderStateName];
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
