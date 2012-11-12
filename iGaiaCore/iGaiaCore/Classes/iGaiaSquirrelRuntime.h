//
//  iGaiaSquirrelRuntime.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaCommon.h"
#include "iGaiaSquirrelCommon.h"

class iGaiaSquirrelRuntime
{
private:
    iGaiaSquirrelCommon* m_commonWrapper;
    void Bind(void);
protected:
    
public:
    iGaiaSquirrelRuntime(iGaiaSquirrelCommon* _commonWrapper);
    ~iGaiaSquirrelRuntime(void);
    
    void sq_OnUpdate(void);
};
