//
//  iGaiaRenderOperationScreenSpace.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaRenderOperationScreenSpace.h"
#import "iGaiaLogger.h"

static ui32 k_RENDER_OPERATION_SCREEN_SPACE_MODE = 0;

iGaiaRenderOperationScreenSpace::iGaiaRenderOperationScreenSpace(vec2 _frameSize, iGaiaMaterial* _material, string const& _name)
{
    m_frameSize = _frameSize;

    ui32 frameTextureHandle;
    glGenTextures(1, &frameTextureHandle);
    glGenFramebuffers(1, &m_frameBufferHandle);
    glGenRenderbuffers(1, &m_depthBufferHandle);
    glBindTexture(GL_TEXTURE_2D, frameTextureHandle);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, m_frameSize.x, m_frameSize.y, 0, GL_RGB, GL_UNSIGNED_SHORT_5_6_5, NULL);
    glBindFramebuffer(GL_FRAMEBUFFER, m_frameBufferHandle);
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, frameTextureHandle, 0);
    glBindRenderbuffer(GL_RENDERBUFFER, m_depthBufferHandle);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, m_frameSize.x, m_frameSize.y);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, m_depthBufferHandle);

    if(glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
    {
        iGaiaLog("Failed init render state");
    }

    m_frameTexture = new iGaiaTexture(frameTextureHandle, m_frameSize.x, m_frameSize.y, _name, iGaiaResource::iGaia_E_CreationModeCustom);
    m_frameTexture->Set_WrapMode(iGaiaTexture::Clamp);

    iGaiaVertexBufferObject* vertexBuffer = new iGaiaVertexBufferObject(4, GL_STATIC_DRAW);
    iGaiaVertexBufferObject::iGaiaVertex* vertexData = vertexBuffer->Lock();
    vertexData[0].m_position = glm::vec3(-1.0f,-1.0f,0.0f);
    vertexData[0].m_texcoord = glm::vec2(0.0f,0.0f);
    vertexData[1].m_position = glm::vec3(-1.0f,1.0f,0.0f);
    vertexData[1].m_texcoord = glm::vec2(0.0f,1.0f);
    vertexData[2].m_position = glm::vec3(1.0f,-1.0f,0.0f);
    vertexData[2].m_texcoord = glm::vec2(1.0f,0.0f);
    vertexData[3].m_position = glm::vec3(1.0f,1.0f,0.0f);
    vertexData[3].m_texcoord = glm::vec2(1.0f,1.0f);
    vertexBuffer->Unlock();

    iGaiaIndexBufferObject* indexBuffer = new iGaiaIndexBufferObject(6, GL_STATIC_DRAW); 
    ui16* indexData = indexBuffer->Lock(); 
    indexData[0] = 0;
    indexData[1] = 1;
    indexData[2] = 2;
    indexData[3] = 1;
    indexData[4] = 2;
    indexData[5] = 3;
    indexBuffer->Unlock();

    m_material = _material;

    m_mesh = new iGaiaMesh(vertexBuffer, indexBuffer, _name, iGaiaResource::iGaia_E_CreationModeCustom);
}

iGaiaRenderOperationScreenSpace::~iGaiaRenderOperationScreenSpace(void)
{

}

iGaiaTexture* iGaiaRenderOperationScreenSpace::Get_FrameTexture(void)
{
    return m_frameTexture;
}

void iGaiaRenderOperationScreenSpace::Bind(void)
{
    glBindFramebuffer(GL_FRAMEBUFFER, m_frameBufferHandle);
    glViewport(0, 0, m_frameSize.x, m_frameSize.y);
    glClearColor(0, 0, 0, 1);
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

    m_material->Bind();
    m_mesh->Get_VertexBuffer()->Set_OperatingShader(m_material->Get_Shader());
    m_mesh->Bind();
}

void iGaiaRenderOperationScreenSpace::Unbind(void)
{
    m_mesh->Get_VertexBuffer()->Unbind();
    m_mesh->Get_IndexBuffer()->Unbind();
    m_material->Unbind();
}

void iGaiaRenderOperationScreenSpace::Draw(void)
{
    glDrawElements(GL_TRIANGLES, m_mesh->Get_NumIndexes(), GL_UNSIGNED_SHORT, nullptr);
}

