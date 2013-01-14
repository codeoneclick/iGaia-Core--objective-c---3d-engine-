//
//  iGaiaTouchCallback.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaTouchCallbackClass
#define iGaiaTouchCallbackClass

#include "iGaiaCommon.h"

typedef std::function<void(f32 _x, f32 _y)> OnTouchListener;

class iGaiaTouchCallback final
{
private:
    OnTouchListener m_onTouchListener;
protected:
    
public:
    iGaiaTouchCallback(void) = default;
    ~iGaiaTouchCallback(void) = default;

    void Set_OnTouchListener(OnTouchListener const& _listener)
    {
        m_onTouchListener = _listener;
    }
    
    void InvokeOnTouchListener(f32 _x, f32 _y)
    {
        m_onTouchListener(_x, _y);
    }
};

#endif
