//
//  iGaiaRenderOperationOutlet.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaRenderOperationOutlet.h"

#import <OpenGLES/ES2/gl.h>

#import "iGaiaMesh.h"
#import "iGaiaShaderComposite.h"

#import "iGaiaLogger.h"

static NSUInteger k_RENDER_OPERATION_OUTLET_MODE = 0;

@interface iGaiaRenderOperationOutlet()

@property(nonatomic, assign) GLuint m_frameBufferHandle;
@property(nonatomic, assign) GLuint m_renderBufferHandle;
@property(nonatomic, assign) glm::vec2 m_size;
@property(nonatomic, strong) iGaiaMesh* m_mesh;

@end

@implementation iGaiaRenderOperationOutlet

@synthesize m_frameBufferHandle = _m_frameBufferHandle;
@synthesize m_renderBufferHandle = _m_renderBufferHandle;
@synthesize m_size = _m_size;
@synthesize m_mesh = _m_mesh;
@synthesize m_material = _m_material;

- (id)initWithSize:(glm::vec2)size withShaderName:(E_SHADER)shader withFrameBufferHandle:(NSUInteger)frameBufferHandle withRenderBufferHandle:(NSUInteger)renderBufferHandle;
{
    self = [super init];
    if(self)
    {
        _m_size = size;
        _m_frameBufferHandle = frameBufferHandle;
        _m_renderBufferHandle = renderBufferHandle;

        iGaiaVertexBufferObject* vertexBuffer = [[iGaiaVertexBufferObject alloc] initWithNumVertexes:4 withMode:GL_STATIC_DRAW];
        iGaiaVertex* vertexData = [vertexBuffer lock];
        vertexData[0].m_position = glm::vec3(-1.0f,-1.0f,0.0f);
        vertexData[0].m_texcoord = glm::vec2(0.0f,0.0f);
        vertexData[1].m_position = glm::vec3(-1.0f,1.0f,0.0f);
        vertexData[1].m_texcoord = glm::vec2(0.0f,1.0f);
        vertexData[2].m_position = glm::vec3(1.0f,-1.0f,0.0f);
        vertexData[2].m_texcoord = glm::vec2(1.0f,0.0f);
        vertexData[3].m_position = glm::vec3(1.0f,1.0f,0.0f);
        vertexData[3].m_texcoord = glm::vec2(1.0f,1.0f);
        [vertexBuffer unlock];

        iGaiaIndexBufferObject* indexBuffer = [[iGaiaIndexBufferObject alloc] initWithNumIndexes:6 withMode:GL_STATIC_DRAW];
        unsigned short* indexData = [indexBuffer lock];
        indexData[0] = 0;
        indexData[1] = 1;
        indexData[2] = 2;
        indexData[3] = 1;
        indexData[4] = 2;
        indexData[5] = 3;
        [indexBuffer unlock];

        _m_material = [iGaiaMaterial new];
        [_m_material setShader:shader forState:k_RENDER_OPERATION_OUTLET_MODE];
        _m_mesh = [[iGaiaMesh alloc] initWithVertexBuffer:vertexBuffer withIndexBuffer:indexBuffer withName:@"render.operation.outlet" withCreationMode:E_CREATION_MODE_CUSTOM];
    }
    return self;
}

- (void)bind;
{
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
    glBindFramebuffer(GL_FRAMEBUFFER, _m_frameBufferHandle);
    glViewport(0, 0, _m_size.x, _m_size.y);
    glClearColor(0, 0, 0, 1);
    glBindRenderbuffer(GL_RENDERBUFFER, _m_renderBufferHandle);

    [_m_material bindWithState:k_RENDER_OPERATION_OUTLET_MODE];
    [_m_mesh.m_vertexBuffer bind];
    [_m_mesh.m_indexBuffer bind];
}

- (void)draw;
{
    glDrawElements(GL_TRIANGLES, _m_mesh.m_indexBuffer.m_numIndexes, GL_UNSIGNED_SHORT, (void*)NULL);
}

- (void)unbind;
{
    [_m_mesh.m_vertexBuffer unbind];
    [_m_mesh.m_indexBuffer unbind];
    [_m_material unbindWithState:k_RENDER_OPERATION_OUTLET_MODE];
}

@end

