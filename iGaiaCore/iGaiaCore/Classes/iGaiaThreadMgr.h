//
//  iGaiaThreadMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 11/20/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaThreadMgrClass
#define iGaiaThreadMgrClass

#include "iGaiaCommon.h"
#include "iGaiaThreadQueue.h"

class iGaiaThreadMgr
{
private:
    set<iGaiaThreadQueue> m_threadQueue;
protected:
    
public:
    iGaiaThreadMgr(void);
    ~iGaiaThreadMgr(void);

    void DispatchTask(const std::function<void()>& _function, iGaiaThreadQueue _queue);
};

#endif 
