//
//  iGaiaRenderListener.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/2/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaRenderCallbackClass
#define iGaiaRenderCallbackClass

#include "iGaiaMaterial.h"

class iGaiaRenderCallback
{
private:
    
protected:

public:
    iGaiaRenderCallback(void) { };
    virtual ~iGaiaRenderCallback(void) { };

    virtual ui32 Get_Priority(void) = 0;

    virtual void OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode) = 0;
    virtual void OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode) = 0;

    virtual void OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode) = 0;
};

#endif