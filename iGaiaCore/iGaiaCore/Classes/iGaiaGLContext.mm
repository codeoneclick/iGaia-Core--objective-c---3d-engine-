//
//  iGaiaGLContext.cpp
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/22/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#include "iGaiaGLContext.h"

iGaiaGLContext::iGaiaGLContext(void)
{
    
}

iGaiaGLContext::~iGaiaGLContext(void)
{
    
}

const ui32 iGaiaGLContext::Get_FrameBufferHandle(void) const
{
    return m_frameBufferHandle;
}

const ui32 iGaiaGLContext::Get_RenderBufferHandle(void) const
{
    return m_renderBufferHandle;
}