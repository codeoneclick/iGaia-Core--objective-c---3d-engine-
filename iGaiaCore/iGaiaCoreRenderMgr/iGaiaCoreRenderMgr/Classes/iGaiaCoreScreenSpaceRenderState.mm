//
//  iGaiaCoreScreenSpaceRenderState.m
//  iGaiaCoreRenderMgr
//
//  Created by Sergey Sergeev on 9/25/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <OpenGLES/ES2/gl.h>

#import "iGaiaCoreScreenSpaceRenderState.h"
#import "iGaiaCoreCommunicator.h"
#import "iGaiaCoreRenderMgrBridge.h"
#import "iGaiaCoreLogger.h"

@interface iGaiaCoreScreenSpaceRenderState()

@property(nonatomic, assign) GLuint frameBufferHandle;
@property(nonatomic, assign) GLuint depthBufferHandle;
@property(nonatomic, assign) GLuint textureHandle;
@property(nonatomic, assign) CGSize size;

@end

@implementation iGaiaCoreScreenSpaceRenderState

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

        iGaiaCoreVertexBuffer vertexBuffer = [[iGaiaCoreRenderMgrBridge sharedInstance].resourceMgrBridge createVertexBufferWithNumVertexes:4 withMode:GL_STATIC_DRAW];
        
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
        
        iGaiaCoreIndexBuffer indexBuffer = [[iGaiaCoreRenderMgrBridge sharedInstance].resourceMgrBridge createIndexBufferWithNumIndexes:6 withMode:GL_STATIC_DRAW];
        
        unsigned short* indexData = [indexBuffer lock];
        
        indexData[0] = 0;
        indexData[1] = 1;
        indexData[2] = 2;
        indexData[3] = 1;
        indexData[4] = 2;
        indexData[5] = 3;
        
        [indexBuffer unlock];

        /*iGaiaCoreVertexBuffer* vertexBuffer = [[iGaiaCoreVertexBuffer alloc] initWithNumVertexes:4 withMode:GL_STATIC_DRAW];
        iGaiaCoreVertex* vertexData = [vertexBuffer lock];
        memcpy(_vertexData, vertexData, sizeof(iGaiaCoreVertex) * _numVertexes);
        [vertexBuffer unlock];

        iGaiaCoreIndexBuffer* indexBuffer = [[iGaiaCoreIndexBuffer alloc] initWithNumIndexes:_numIndexes withMode:GL_STATIC_DRAW];
        unsigned short* indexData = [indexBuffer lock];
        memcpy(_indexData, indexData, sizeof(unsigned short) * _numIndexes);
        [indexBuffer unlock];


        CVertexBufferPositionTexcoord* pVertexBuffer = new CVertexBufferPositionTexcoord(4, GL_STATIC_DRAW);
        CVertexBufferPositionTexcoord::SVertex* pVertexBufferData = static_cast<CVertexBufferPositionTexcoord::SVertex*>(pVertexBuffer->Lock());

        unsigned i = 0;
        pVertexBufferData[i].m_vPosition = glm::vec3(-1.0f,-1.0f,0.0f);
        pVertexBufferData[i].m_vTexcoord = glm::vec2(0.0f,0.0f);
        i++;
        pVertexBufferData[i].m_vPosition = glm::vec3(-1.0f,1.0f,0.0f);
        pVertexBufferData[i].m_vTexcoord = glm::vec2(0.0f,1.0f);
        i++;
        pVertexBufferData[i].m_vPosition = glm::vec3(1.0f,-1.0f,0.0f);
        pVertexBufferData[i].m_vTexcoord = glm::vec2(1.0f,0.0f);
        i++;
        pVertexBufferData[i].m_vPosition = glm::vec3(1.0f,1.0f,0.0f);
        pVertexBufferData[i].m_vTexcoord = glm::vec2(1.0f,1.0f);
        i++;

        CIndexBuffer* pIndexBuffer = new CIndexBuffer(6, GL_STATIC_DRAW);
        unsigned short* pIndexBufferData = pIndexBuffer->Get_SourceData();

        i = 0;
        pIndexBufferData[i++] = 0;
        pIndexBufferData[i++] = 1;
        pIndexBufferData[i++] = 2;

        pIndexBufferData[i++] = 1;
        pIndexBufferData[i++] = 2;
        pIndexBufferData[i++] = 3;*/

    }
    return self;
}

@end
