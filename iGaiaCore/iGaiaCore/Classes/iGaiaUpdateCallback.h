//
//  iGaiaUpdateCallback.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/7/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaUpdateCallbackClass
#define iGaiaUpdateCallbackClass

#include "iGaiaCommon.h"

typedef std::function<ui32(void)> OnProcessStatusListener;
typedef std::function<void(void)> OnUpdateListener;

class iGaiaUpdateCallback final
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
    OnUpdateListener m_onUpdateListener;
    OnProcessStatusListener m_onProcessStatusListener;
protected:
    
public:
    iGaiaUpdateCallback(void) = default;
    ~iGaiaUpdateCallback(void) = default;
    
    void Set_OnUpdateListener(const OnUpdateListener& _listener)
    {
        m_onUpdateListener = _listener;
    }

    void Set_OnProcessStatusListener(const OnProcessStatusListener& _listener)
    {
        m_onProcessStatusListener = _listener;
    }

    void InvokeOnUpdate(void)
    {
        m_onUpdateListener();
    }

    ui32 InvokeOnProcessStatusListener(void)
    {
        return m_onProcessStatusListener();
    }
};

#endif
