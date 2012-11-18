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

class iGaiaTouchCallback
{
private:

protected:

public:
    iGaiaTouchCallback(void) = default;
    virtual ~iGaiaTouchCallback(void) = default;

    virtual void OnTouch(f32 _x, f32 _y) = 0;
};

#endif
