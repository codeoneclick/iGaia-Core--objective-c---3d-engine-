//
//  iGaiaRenderMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaRenderMgr.h"
#include "iGaiaGameLoop_iOS.h"
#include "iGaiaGLWindow_iOS.h"
#include "iGaiaSettings_iOS.h"
#include "iGaiaLogger.h"

iGaiaRenderMgr::iGaiaRenderMgr(const iGaiaGLContext* _glContext)
{
    m_glContext = _glContext;
    
    m_loopCallback.Set_OnUpdateListener(std::bind(&iGaiaRenderMgr::OnUpdate, this));
    [[iGaiaGameLoop_iOS SharedInstance] AddEventListener:&m_loopCallback];

    for(ui32 i = 0; i < iGaiaMaterial::iGaia_E_RenderModeWorldSpaceMaxValue; ++i)
    {
        m_worldSpaceOperations[i] = new iGaiaRenderOperationWorldSpace(static_cast<iGaiaMaterial::iGaia_E_RenderModeWorldSpace>(i), vec2([iGaiaSettings_iOS Get_Size].width, [iGaiaSettings_iOS Get_Size].height), "render.mode.worldspace");
    }

    for(ui32 i = 0; i < iGaiaMaterial::iGaia_E_RenderModeScreenSpaceMaxValue; ++i)
    {
        m_screenSpaceOperations[i] = new iGaiaRenderOperationScreenSpace(vec2([iGaiaSettings_iOS Get_Size].width, [iGaiaSettings_iOS Get_Size].height), iGaiaShader::iGaia_E_ShaderScreenQuadSimple, "render.mode.screenspace");
    }

    m_outletOperation = new iGaiaRenderOperationOutlet(vec2([iGaiaSettings_iOS Get_Size].width, [iGaiaSettings_iOS Get_Size].height), iGaiaShader::iGaia_E_ShaderScreenQuadSimple, m_glContext->Get_FrameBufferHandle(), m_glContext->Get_RenderBufferHandle());
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

void iGaiaRenderMgr::AddOffscreenProcessOperation(iGaiaRenderOperationOffscreenProcessingHelper *_operation)
{
    m_offscreenProcessingOperation.push(_operation);
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
    while(m_offscreenProcessingOperation.empty() != true)
    {
        iGaiaRenderOperationOffscreenProcessingHelper* operation = m_offscreenProcessingOperation.front();
        operation->Bind();
        operation->Draw();
        operation->Unbind();
        m_offscreenProcessingOperation.pop();
    }

    for(i32 i = (iGaiaMaterial::iGaia_E_RenderModeWorldSpaceMaxValue - 1); i >= 0; --i)
    {
        m_worldSpaceOperations[i]->Bind();
        m_worldSpaceOperations[i]->Draw();
        m_worldSpaceOperations[i]->Unbind();
    }

    /*for(ui32 i = 0; i < iGaiaMaterial::iGaia_E_RenderModeScreenSpaceMaxValue; ++i)
    {
        m_screenSpaceOperations[i]->Bind();
        m_screenSpaceOperations[i]->Draw();
        m_screenSpaceOperations[i]->Unbind();
    }*/

    m_outletOperation->Get_OperatingMaterial()->Set_Texture(m_worldSpaceOperations[iGaiaMaterial::iGaia_E_RenderModeWorldSpaceCommon]->Get_OperatingTexture(), iGaiaShader::iGaia_E_ShaderTextureSlot_01);
    m_outletOperation->Bind();
    m_outletOperation->Draw();
    m_outletOperation->Unbind();

    m_glContext->Present();
    
    
    static ui64 lastTime = 0;
    ui64 currentTime = Get_TickCount();
    static ui32 currentFramesPerCount = 0;
    currentFramesPerCount++;
    if(currentTime - lastTime > 1000 )
    {
        lastTime = Get_TickCount();
        //[iGaiaGLWindow_iOS SharedInstance].m_framesPerSecond = currentFramesPerCount;
        currentFramesPerCount = 0;
    }

    GLenum error = glGetError();
    if (error != GL_NO_ERROR)
    {
        iGaiaLog("GL error -> %i", error);
    }
}

