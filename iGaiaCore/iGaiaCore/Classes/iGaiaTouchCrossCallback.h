//
//  iGaiaTouchCrossCallback.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/28/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaTouchCrossCallbackClass
#define iGaiaTouchCrossCallbackClass

#include "iGaiaCommon.h"

typedef std::function<void(string const& _guid)> OnTouchCrossListener;

class iGaiaTouchCrossCallback final
{
private:
    OnTouchCrossListener m_onTouchCrossListener;
protected:
    
public:
    iGaiaTouchCrossCallback(void) = default;
    ~iGaiaTouchCrossCallback(void) = default;
    
    void Set_OnTouchCrossListener(OnTouchCrossListener const& _listener)
    {
        m_onTouchCrossListener = _listener;
    }
    
    void InvokeOnTouchListener(string const& _guid)
    {
        m_onTouchCrossListener(_guid);
    }
};

#endif