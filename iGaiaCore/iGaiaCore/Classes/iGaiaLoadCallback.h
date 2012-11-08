//
//  iGaiaLoadCallback.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaLoadCallbackClass
#define iGaiaLoadCallbackClass

class iGaiaResource;

class iGaiaLoadCallback
{
private:

protected:

public:
    iGaiaLoadCallback(void) = default;
    ~iGaiaLoadCallback(void) = default;
    virtual void OnLoad(iGaiaResource* _resource) = 0;
};

#endif
