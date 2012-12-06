//
//  iGaiaRenderOperationWorldSpace.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaRenderOperationWorldSpace.h"
#import "iGaiaLogger.h"

#define kMaxRenderPriority 8

iGaiaRenderOperationWorldSpace::iGaiaRenderOperationWorldSpace(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode, vec2 _frameSize, const string& _name)
{
    m_frameSize = _frameSize;
    m_mode = _mode;

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
        iGaiaLog(@"Failed init render state");
    }

    m_operatingTexture = new iGaiaTexture(textureHandle, m_frameSize.x, m_frameSize.y, _name, iGaiaResource::iGaia_E_CreationModeCustom);
    map<ui32, ui32> settings;
    settings[iGaiaTexture::iGaia_E_TextureSettingsKeyWrapMode] = iGaiaTexture::iGaia_E_TextureSettingsValueClamp;
    m_operatingTexture->Set_Settings(settings);
}


iGaiaRenderOperationWorldSpace::~iGaiaRenderOperationWorldSpace(void)
{

}

iGaiaTexture* iGaiaRenderOperationWorldSpace::Get_OperatingTexture(void)
{
    return m_operatingTexture;
}

void iGaiaRenderOperationWorldSpace::AddEventListener(iGaiaRenderCallback *_listener)
{
    if(m_listeners.find(_listener->InvokeOnDrawIndexListener()) != m_listeners.end())
    {
        m_listeners.find(_listener->InvokeOnDrawIndexListener())->second.insert(_listener);
    }
    else
    {
        m_listeners[_listener->InvokeOnDrawIndexListener()].insert(_listener);
    }
}

void iGaiaRenderOperationWorldSpace::RemoveEventListener(iGaiaRenderCallback *_listener)
{
    if(m_listeners.find(_listener->InvokeOnDrawIndexListener()) != m_listeners.end())
    {
        m_listeners.find(_listener->InvokeOnDrawIndexListener())->second.erase(_listener);
    }
    else
    {
        m_listeners[_listener->InvokeOnDrawIndexListener()].erase(_listener);
    }
}

void iGaiaRenderOperationWorldSpace::Bind(void)
{
    glDepthMask(GL_TRUE);
    glDisable(GL_DEPTH_TEST);
    glDisable(GL_CULL_FACE);
    glDisable(GL_BLEND);

    glBindFramebuffer(GL_FRAMEBUFFER, m_frameBufferHandle);
    glViewport(0, 0, m_frameSize.x, m_frameSize.y);
    glClearColor(1.0, 1.0, 1.0, 1.0);
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
}

void iGaiaRenderOperationWorldSpace::Unbind(void)
{
    
}

void iGaiaRenderOperationWorldSpace::Draw(void)
{
    for(map<ui32, set<iGaiaRenderCallback*>>::iterator iterator_01 = m_listeners.begin(); iterator_01 != m_listeners.end(); ++iterator_01)
    {
        for(set<iGaiaRenderCallback*>::iterator iterator_02 = (*iterator_01).second.begin(); iterator_02 !=  (*iterator_01).second.end(); ++iterator_02)
        {
            iGaiaRenderCallback* listener = (*iterator_02);
            if(listener->InvokeOnProcessStatusListener() == iGaiaRenderCallback::iGaia_E_LoadStatusReady)
            {
                listener->InvokeOnBindListener(m_mode);
                listener->InvokeOnDrawListener(m_mode);
                listener->InvokeOnUnbindListener(m_mode);
            }
        }
    }
}

