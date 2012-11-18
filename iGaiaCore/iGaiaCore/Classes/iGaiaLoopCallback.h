//
//  iGaiaLoopCallback.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/7/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaLoopCallbackClass
#define iGaiaLoopCallbackClass

class iGaiaLoopCallback
{
private:

protected:

public:
    iGaiaLoopCallback(void) = default;
    virtual ~iGaiaLoopCallback(void) = default;

    virtual void OnUpdate(void) = 0;
};

#endif
