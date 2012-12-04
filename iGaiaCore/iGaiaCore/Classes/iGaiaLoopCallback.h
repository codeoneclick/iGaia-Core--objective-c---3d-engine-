//
//  iGaiaLoopCallback.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/7/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaLoopCallbackClass
#define iGaiaLoopCallbackClass

#include "iGaiaCommon.h"

typedef std::function<void(void)> OnUpdateListener;

class iGaiaLoopCallback final
{
private:
    OnUpdateListener m_onUpdateListener;
protected:

public:
    iGaiaLoopCallback(void) = default;
    ~iGaiaLoopCallback(void) = default;

    void Set_OnUpdateListener(const OnUpdateListener& _listener)
    {
        m_onUpdateListener = _listener;
    }
    
    void InvokeOnUpdateListener(void)
    {
        m_onUpdateListener();
    }
};

#endif
