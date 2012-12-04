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

typedef std::function<void(void)> OnUpdateListener;

class iGaiaUpdateCallback final
{
private:
    OnUpdateListener m_onUpdateListener;
protected:
    
public:
    iGaiaUpdateCallback(void) = default;
    ~iGaiaUpdateCallback(void) = default;
    
    void Set_OnUpdateListener(const OnUpdateListener& _listener)
    {
        m_onUpdateListener = _listener;
    }

    void InvokeOnUpdate 
};

#endif
