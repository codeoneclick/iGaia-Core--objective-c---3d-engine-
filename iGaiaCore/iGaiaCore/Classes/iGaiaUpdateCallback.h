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

class iGaiaUpdateCallback
{
private:
    
protected:
    
public:
    iGaiaUpdateCallback(void) { };
    virtual ~iGaiaUpdateCallback(void) { };
    
    virtual void OnUpdate(void) = 0;
};

#endif
