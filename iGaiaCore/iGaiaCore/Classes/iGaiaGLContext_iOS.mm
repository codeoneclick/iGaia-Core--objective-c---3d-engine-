//
//  iGaiaGLContext_iOS.cpp
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/22/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#include "iGaiaGLContext_iOS.h"

iGaiaGLContext_iOS::iGaiaGLContext_iOS(const CAEAGLLayer* _iOSGLLayer)
{
    m_iOSGLContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    assert(m_iOSGLContext != nullptr);
    
    ui8 result = [EAGLContext setCurrentContext:m_iOSGLContext];
    assert(result == true);
    
    glGenRenderbuffers(1, &m_renderBufferHandle);
    glBindRenderbuffer(GL_RENDERBUFFER, m_renderBufferHandle);
    [m_iOSGLContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:_iOSGLLayer];
    
    glGenFramebuffers(1, &m_frameBufferHandle);
    glBindFramebuffer(GL_FRAMEBUFFER, m_frameBufferHandle);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, m_renderBufferHandle);
    assert(glCheckFramebufferStatus(GL_FRAMEBUFFER) == GL_FRAMEBUFFER_COMPLETE);
}

iGaiaGLContext_iOS::~iGaiaGLContext_iOS(void)
{
    
}

void iGaiaGLContext_iOS::Present(void) const
{
    assert(m_iOSGLContext != nullptr);
    [m_iOSGLContext presentRenderbuffer:GL_RENDERBUFFER];
}



