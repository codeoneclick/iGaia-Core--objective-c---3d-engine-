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

iGaiaRenderOperationScreenSpace::iGaiaRenderOperationScreenSpace(vec2 _frameSize, iGaiaShader::iGaia_E_Shader _shader,const string& _name)
{
    m_frameSize = _frameSize;

    ui32 textureHandle;
    glGenTextures(1, &textureHandle);
    glGenFramebuffers(1, &m_frameBufferHandle);
    glGenRenderbuffers(1, &m_depthBufferHandle);
    glBindTexture(GL_TEXTURE_2D, textureHandle);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, m_frameSize.x, m_frameSize.y, 0, GL_RGB, GL_UNSIGNED_SHORT_5_6_5, NULL);
    glBindFramebuffer(GL_FRAMEBUFFER, m_frameBufferHandle);
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, textureHandle, 0);
    glBindRenderbuffer(GL_RENDERBUFFER, m_depthBufferHandle);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, m_frameSize.x, m_frameSize.y);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, m_depthBufferHandle);

    if(glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
    {
        iGaiaLog("Failed init render state");
    }

    m_operatingTexture = new iGaiaTexture(textureHandle, m_frameSize.x, m_frameSize.y, _name, iGaiaResource::iGaia_E_CreationModeCustom);
    map<ui32, ui32> settings;
    settings[iGaiaTexture::iGaia_E_TextureSettingsKeyWrapMode] = iGaiaTexture::iGaia_E_TextureSettingsValueClamp;
    m_operatingTexture->Set_Settings(settings);


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

    m_operatingMaterial = new iGaiaMaterial();
    m_operatingMaterial->Set_Shader(_shader, k_RENDER_OPERATION_SCREEN_SPACE_MODE);

    m_operatingMaterial->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateCullMode, false);
    m_operatingMaterial->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateDepthMask, true);
    m_operatingMaterial->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateDepthTest, false);
    m_operatingMaterial->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateBlendMode, false);

    m_operatingMaterial->Set_CullFaceMode(GL_FRONT);
    m_operatingMaterial->Set_BlendFunctionSource(GL_SRC_ALPHA);
    m_operatingMaterial->Set_BlendFunctionDest(GL_ONE_MINUS_SRC_ALPHA);

    m_mesh = new iGaiaMesh(vertexBuffer, indexBuffer, _name, iGaiaResource::iGaia_E_CreationModeCustom);
}

iGaiaRenderOperationScreenSpace::~iGaiaRenderOperationScreenSpace(void)
{

}

iGaiaTexture* iGaiaRenderOperationScreenSpace::Get_OperatingTexture(void)
{
    return m_operatingTexture;
}

iGaiaMaterial* iGaiaRenderOperationScreenSpace::Get_OperatingMaterial(void)
{
    return m_operatingMaterial;
}

void iGaiaRenderOperationScreenSpace::Bind(void)
{
    glBindFramebuffer(GL_FRAMEBUFFER, m_frameBufferHandle);
    glViewport(0, 0, m_frameSize.x, m_frameSize.y);
    glClearColor(0, 0, 0, 1);
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

    m_operatingMaterial->Bind(k_RENDER_OPERATION_SCREEN_SPACE_MODE);
    m_mesh->Get_VertexBuffer()->Set_OperatingShader(m_operatingMaterial->Get_OperatingShader());
    m_mesh->Bind();
}

void iGaiaRenderOperationScreenSpace::Unbind(void)
{
    m_mesh->Get_VertexBuffer()->Unbind();
    m_mesh->Get_IndexBuffer()->Unbind();
    m_operatingMaterial->Unbind(k_RENDER_OPERATION_SCREEN_SPACE_MODE);
}

void iGaiaRenderOperationScreenSpace::Draw(void)
{
    glDrawElements(GL_TRIANGLES, m_mesh->Get_NumIndexes(), GL_UNSIGNED_SHORT, nullptr);
}

