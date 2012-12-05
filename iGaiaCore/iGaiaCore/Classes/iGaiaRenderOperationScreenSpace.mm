//
//  iGaiaRenderOperationScreenSpace.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaRenderOperationScreenSpace.h"

#import <OpenGLES/ES2/gl.h>

#import "iGaiaMesh.h"
#import "iGaiaLogger.h"
#import "iGaiaShaderComposite.h"

static NSUInteger k_RENDER_OPERATION_SCREEN_SPACE_MODE = 0;

@interface iGaiaRenderOperationScreenSpace()

@property(nonatomic, assign) GLuint m_frameBufferHandle;
@property(nonatomic, assign) GLuint m_depthBufferHandle;
@property(nonatomic, assign) glm::vec2 m_size;
@property(nonatomic, strong) iGaiaMesh* m_mesh;

@end

@implementation iGaiaRenderOperationScreenSpace

@synthesize m_frameBufferHandle = _m_frameBufferHandle;
@synthesize m_depthBufferHandle = _m_depthBufferHandle;
@synthesize m_externalTexture = _m_externalTexture;
@synthesize m_size = _m_size;
@synthesize m_mesh = _m_mesh;
@synthesize m_material = _m_material;

- (id)initWithSize:(glm::vec2)size withShader:(E_SHADER)shader withName:(NSString*)name;
{
    self = [super init];
    if(self)
    {
        _m_size = size;

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

        _m_externalTexture = [[iGaiaTexture alloc] initWithHandle:textureHandle withWidth:_m_size.x withHeight:_m_size.y withName:name withCreationMode:iGaia_E_CreationModeCustom];
        NSDictionary* settings = [NSDictionary dictionaryWithObjectsAndKeys:iGaiaTextureSettingValues.clamp,iGaiaTextureSettingKeys.wrap, nil];
        _m_externalTexture.m_settings = settings;

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
        [_m_material setShader:shader forMode:k_RENDER_OPERATION_SCREEN_SPACE_MODE];
        
        [_m_material invalidateState:E_RENDER_STATE_CULL_MODE withValue:NO];
        [_m_material invalidateState:E_RENDER_STATE_DEPTH_MASK withValue:YES];
        [_m_material invalidateState:E_RENDER_STATE_DEPTH_TEST withValue:NO];
        [_m_material invalidateState:E_RENDER_STATE_BLEND_MODE withValue:NO];
        _m_material.m_cullFaceMode = GL_FRONT;
        _m_material.m_blendFunctionSource = GL_SRC_ALPHA;
        _m_material.m_blendFunctionDest = GL_ONE_MINUS_SRC_ALPHA;
        
        _m_mesh = [[iGaiaMesh alloc] initWithVertexBuffer:vertexBuffer withIndexBuffer:indexBuffer withName:name withCreationMode:iGaia_E_CreationModeCustom];

    }
    return self;
}

- (void)bind
{
    glBindFramebuffer(GL_FRAMEBUFFER, _m_frameBufferHandle);
    glViewport(0, 0, _m_size.x, _m_size.y);
    glClearColor(0, 0, 0, 1);
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
    
    [_m_material bindWithMode:k_RENDER_OPERATION_SCREEN_SPACE_MODE];
    _m_mesh.m_vertexBuffer.m_operatingShader = _m_material.m_operatingShader;
    [_m_mesh.m_vertexBuffer bind];
    [_m_mesh.m_indexBuffer bind];
}

- (void)draw;
{
    glDrawElements(GL_TRIANGLES, _m_mesh.m_numIndexes, GL_UNSIGNED_SHORT, (void*)NULL);
}

- (void)unbind;
{
    [_m_mesh.m_vertexBuffer unbind];
    [_m_mesh.m_indexBuffer unbind];
    [_m_material bindWithMode:k_RENDER_OPERATION_SCREEN_SPACE_MODE];
}

@end

