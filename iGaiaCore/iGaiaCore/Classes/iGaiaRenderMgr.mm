//
//  iGaiaRenderMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaRenderMgr.h"
#include "iGaiaLogger.h"
#include "iGaiaiOSGLView.h"
#include "iGaiaiOSGameLoop.h"

iGaiaRenderMgr::iGaiaRenderMgr(void)
{
    m_loopCallback.Set_OnUpdateListener(std::bind(&iGaiaRenderMgr::OnUpdate, this));
    [[iGaiaiOSGameLoop SharedInstance] AddEventListener:&m_loopCallback];

    m_glView = [[iGaiaiOSGLView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];

    for(ui32 i = 0; i < iGaiaMaterial::iGaia_E_RenderModeWorldSpaceMaxValue; ++i)
    {
        m_worldSpaceOperations[i] = new iGaiaRenderOperationWorldSpace(static_cast<iGaiaMaterial::iGaia_E_RenderModeWorldSpace>(i), vec2(m_glView.frame.size.width, m_glView.frame.size.height), "render.mode.worldspace"); 
    }

    for(ui32 i = 0; i < iGaiaMaterial::iGaia_E_RenderModeScreenSpaceMaxValue; ++i)
    {
        m_screenSpaceOperations[i] = new iGaiaRenderOperationScreenSpace(vec2(m_glView.frame.size.width, m_glView.frame.size.height), iGaiaShader::iGaia_E_ShaderScreenQuadSimple, "render.mode.screenspace");
    }

    m_outletOperation = new iGaiaRenderOperationOutlet(vec2(m_glView.frame.size.width, m_glView.frame.size.height), iGaiaShader::iGaia_E_ShaderScreenQuadSimple, ((iGaiaiOSGLView*)m_glView).m_frameBufferHandle, ((iGaiaiOSGLView*)m_glView).m_renderBufferHandle); 
}

iGaiaRenderMgr::~iGaiaRenderMgr(void)
{
    
}

void iGaiaRenderMgr::AddEventListener(iGaiaRenderCallback *_listener, iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    m_worldSpaceOperations[_mode]->AddEventListener(_listener);
}

void iGaiaRenderMgr::RemoveEventListener(iGaiaRenderCallback *_listener, iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    m_worldSpaceOperations[_mode]->RemoveEventListener(_listener);
}

UIView* iGaiaRenderMgr::Get_GLView(void)
{
    return m_glView;
}

iGaiaTexture* iGaiaRenderMgr::Get_TextureFromWorldSpaceRenderMode(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    return m_worldSpaceOperations[_mode]->Get_OperatingTexture();
}

iGaiaTexture* iGaiaRenderMgr::Get_TextureFromScreenSpaceRenderMode(iGaiaMaterial::iGaia_E_RenderModeScreenSpace _mode)
{
    return m_screenSpaceOperations[_mode]->Get_OperatingTexture();
}

void iGaiaRenderMgr::OnUpdate(void)
{
    for(ui32 i = 0; i < iGaiaMaterial::iGaia_E_RenderModeWorldSpaceMaxValue; ++i)
    {
        m_worldSpaceOperations[i]->Bind();
        m_worldSpaceOperations[i]->Draw();
        m_worldSpaceOperations[i]->Unbind();
    }

    for(ui32 i = 0; i < iGaiaMaterial::iGaia_E_RenderModeScreenSpaceMaxValue; ++i)
    {
        m_screenSpaceOperations[i]->Bind();
        m_screenSpaceOperations[i]->Draw();
        m_screenSpaceOperations[i]->Unbind();
    }

    m_outletOperation->Get_OperatingMaterial()->Set_Texture(m_worldSpaceOperations[iGaiaMaterial::iGaia_E_RenderModeWorldSpaceSimple]->Get_OperatingTexture(), iGaiaShader::iGaia_E_ShaderTextureSlot_01);
    m_outletOperation->Bind();
    m_outletOperation->Draw();
    m_outletOperation->Unbind();

    [((iGaiaiOSGLView*)m_glView).m_context presentRenderbuffer:GL_RENDERBUFFER];

    GLenum error = glGetError();
    if (error != GL_NO_ERROR)
    {
        iGaiaLog(@"GL error -> %i", error);
    }
}

