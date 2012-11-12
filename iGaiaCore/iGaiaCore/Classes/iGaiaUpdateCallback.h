//
//  iGaiaUpdateCallback.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/7/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaCommon.h"

class iGaiaUpdateCallback
{
private:
    
protected:
    
public:
    iGaiaUpdateCallback(void) = default;
    virtual ~iGaiaUpdateCallback(void) = default;
    
    virtual void OnUpdate(void) = 0;
};

