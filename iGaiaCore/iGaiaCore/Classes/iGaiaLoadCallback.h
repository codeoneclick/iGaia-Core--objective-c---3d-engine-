//
//  iGaiaLoadCallback.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

class iGaiaResource;

class iGaiaLoadCallback
{
private:

protected:

public:
    iGaiaLoadCallback(void) = default;
    ~iGaiaLoadCallback(void) = default;
    void OnLoad(const iGaiaResource* _resource);
};

