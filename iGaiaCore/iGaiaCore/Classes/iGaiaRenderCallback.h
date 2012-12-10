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

typedef std::function<ui32(void)> OnDrawIndexListener;
typedef std::function<ui32(void)> OnProcessStatusListener;
typedef std::function<void(iGaiaMaterial::iGaia_E_RenderModeWorldSpace)> OnBindListener;
typedef std::function<void(iGaiaMaterial::iGaia_E_RenderModeWorldSpace)> OnUnbindListener;
typedef std::function<void(iGaiaMaterial::iGaia_E_RenderModeWorldSpace)> OnDrawListener;

class iGaiaRenderCallback final
{
public:
    enum iGaia_E_ProcessStatus
    {
        iGaia_E_LoadStatusNone = 0,
        iGaia_E_LoadStatusLoading,
        iGaia_E_LoadStatusReady,
        iGaia_E_LoadStatusError
    };
private:
    OnDrawIndexListener m_onDrawIndexListener;
    OnBindListener m_onBindListener;
    OnUnbindListener m_onUnbindListener;
    OnDrawListener m_onDrawListener;
    OnProcessStatusListener m_onProcessStatusListener;
protected:

public:
    iGaiaRenderCallback(void) = default;
    ~iGaiaRenderCallback(void) = default;
    
    void Set_OnDrawIndexListener(const OnDrawIndexListener& _listener)
    {
        m_onDrawIndexListener = _listener;
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
        m_onDrawListener = _listener;
    }

    void Set_OnProcessStatusListener(const OnProcessStatusListener& _listener)
    {
        m_onProcessStatusListener = _listener;
    }
    
    ui32 InvokeOnDrawIndexListener(void)
    {
        return m_onDrawIndexListener();
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
        m_onDrawListener(_mode);
    }

    ui32 InvokeOnProcessStatusListener(void)
    {
        return m_onProcessStatusListener();
    }
};

#endif