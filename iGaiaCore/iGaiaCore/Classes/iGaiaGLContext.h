//
//  iGaiaGLContext.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/22/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaGLContextClass
#define iGaiaGLContextClass

#include "iGaiaCommon.h"

class iGaiaGLContext
{
private:
    
protected:
    ui32 m_frameBufferHandle;
    ui32 m_renderBufferHandle;
public:
    iGaiaGLContext(void);
    ~iGaiaGLContext(void);
    
    const ui32 Get_FrameBufferHandle(void) const;
    const ui32 Get_RenderBufferHandle(void) const;
    
    virtual void PresentRenderBuffer(void) const = 0;
};

#endif
