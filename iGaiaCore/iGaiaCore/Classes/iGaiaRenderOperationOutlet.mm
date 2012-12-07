//
//  iGaiaRenderOperationOutlet.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaRenderOperationOutlet.h"
#import "iGaiaLogger.h"

static NSUInteger k_RENDER_OPERATION_OUTLET_MODE = 0;

iGaiaRenderOperationOutlet::iGaiaRenderOperationOutlet(vec2 _frameSize, iGaiaShader::iGaia_E_Shader _shader, ui32 _frameBufferHandle, ui32 _renderBufferHandle)
{
    m_frameSize = _frameSize;
    m_frameBufferHandle = _frameBufferHandle;
    m_renderBufferHandle = _renderBufferHandle;

    iGaiaVertexBufferObject* vertexBuffer = new iGaiaVertexBufferObject(4, GL_STATIC_DRAW); 
    iGaiaVertexBufferObject::iGaiaVertex* vertexData = vertexBuffer->Lock();
    vertexData[0].m_position = glm::vec3(-1.0f, -1.0f, 0.0f);
    vertexData[0].m_texcoord = glm::vec2(0.0f, 0.0f);
    vertexData[1].m_position = glm::vec3(-1.0f, 1.0f, 0.0f);
    vertexData[1].m_texcoord = glm::vec2(0.0f, 1.0f);
    vertexData[2].m_position = glm::vec3(1.0f, -1.0f, 0.0f);
    vertexData[2].m_texcoord = glm::vec2(1.0f, 0.0f);
    vertexData[3].m_position = glm::vec3(1.0f, 1.0f, 0.0f);
    vertexData[3].m_texcoord = glm::vec2(1.0f, 1.0f);
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
    m_operatingMaterial->Set_Shader(_shader, k_RENDER_OPERATION_OUTLET_MODE);

    m_operatingMaterial->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateCullMode, false);
    m_operatingMaterial->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateDepthMask, true);
    m_operatingMaterial->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateDepthTest, false);
    m_operatingMaterial->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateBlendMode, false);

    m_operatingMaterial->Set_CullFaceMode(GL_FRONT);
    m_operatingMaterial->Set_BlendFunctionSource(GL_SRC_ALPHA);
    m_operatingMaterial->Set_BlendFunctionDest(GL_ONE_MINUS_SRC_ALPHA);
    
    m_mesh = new iGaiaMesh(vertexBuffer, indexBuffer, "render.operation.outlet", iGaiaResource::iGaia_E_CreationModeCustom);
}

iGaiaRenderOperationOutlet::~iGaiaRenderOperationOutlet(void)
{

}

iGaiaMaterial* iGaiaRenderOperationOutlet::Get_OperatingMaterial(void)
{
    return m_operatingMaterial;
}

void iGaiaRenderOperationOutlet::Bind(void)
{
    glBindFramebuffer(GL_FRAMEBUFFER, m_frameBufferHandle);
    glBindRenderbuffer(GL_RENDERBUFFER, m_renderBufferHandle);
    glViewport(0, 0, m_frameSize.x, m_frameSize.y);
    glClearColor(0.0, 0.0, 0.0, 1.0);
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

    m_operatingMaterial->Bind(k_RENDER_OPERATION_OUTLET_MODE);
    m_mesh->Get_VertexBuffer()->Set_OperatingShader(m_operatingMaterial->Get_OperatingShader());
    m_mesh->Bind();
}

void iGaiaRenderOperationOutlet::Unbind(void)
{
    m_mesh->Unbind();
    m_operatingMaterial->Unbind(k_RENDER_OPERATION_OUTLET_MODE);
}

void iGaiaRenderOperationOutlet::Draw(void)
{
    glDrawElements(GL_TRIANGLES, m_mesh->Get_NumIndexes(), GL_UNSIGNED_SHORT, nullptr);
}

