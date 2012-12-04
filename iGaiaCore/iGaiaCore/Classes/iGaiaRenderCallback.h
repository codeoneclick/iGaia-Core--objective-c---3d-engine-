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

typedef std::function<ui32(void)> GetPrecedenceListener;
typedef std::function<void(iGaiaMaterial::iGaia_E_RenderModeWorldSpace)> OnBindListener;
typedef std::function<void(iGaiaMaterial::iGaia_E_RenderModeWorldSpace)> OnUnbindListener;
typedef std::function<void(iGaiaMaterial::iGaia_E_RenderModeWorldSpace)> OnDrawListener;

class iGaiaRenderCallback final
{
private:
    GetPrecedenceListener m_getPrecedenceListener;
    OnBindListener m_onBindListener;
    OnUnbindListener m_onUnbindListener;
    OnDrawListener m_OnDrawListener;
protected:

public:
    iGaiaRenderCallback(void) = default;
    ~iGaiaRenderCallback(void) = default;
    
    void Set_GetPrecedenceListener(const GetPrecedenceListener& _listener)
    {
        m_getPrecedenceListener = _listener;
    }
    
    void Set_OnBindListener(const OnBindListener& _listener)
    {
        m_onBindListener = _listener;
    }
    
    void Set_OnUnbindListener(const OnUnbindListener& _listener)
    {
        m_onUnbindListener = _listener;
    }
    
    void Set_OnDrawListener(const OnDrawListener& _listener)
    {
        m_OnDrawListener = _listener;
    }
    
    ui32 InvokeGetPrecedenceListener(void)
    {
        return m_getPrecedenceListener();
    }
    
    void InvokeOnBindListener(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
    {
        m_onBindListener(_mode);
    }
    
    void InvokeOnUnbindListener(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
    {
        m_onUnbindListener(_mode);
    }
    
    void InvokeOnDrawListener(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
    {
        m_OnDrawListener(_mode);
    }
};

#endif