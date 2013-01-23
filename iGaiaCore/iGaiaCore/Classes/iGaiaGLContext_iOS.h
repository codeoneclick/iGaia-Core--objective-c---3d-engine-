//
//  iGaiaGLContext_iOS.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/22/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaGLContext_iOSClass
#define iGaiaGLContext_iOSClass

#include "iGaiaGLContext.h"

class iGaiaGLContext_iOS : public iGaiaGLContext
{
private:
    
protected:
    EAGLContext* m_iOSGLContext;
public:
    iGaiaGLContext_iOS(const CAEAGLLayer* _iOSGLLayer);
    ~iGaiaGLContext_iOS(void);
    
    void PresentRenderBuffer(void) const;
};

#endif 
