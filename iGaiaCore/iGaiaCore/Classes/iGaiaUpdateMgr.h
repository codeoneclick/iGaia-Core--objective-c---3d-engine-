//
//  iGaiaUpdateMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/6/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaUpdateMgrClass
#define iGaiaUpdateMgrClass

#include "iGaiaCommon.h"
#include "iGaiaUpdateCallback.h"
#include "iGaiaLoopCallback.h"

class iGaiaUpdateMgr
{
private:
    set<iGaiaUpdateCallback*> m_listeners;
    iGaiaLoopCallback m_loopCallback;

protected:
    void OnLoop(void);
public:
    iGaiaUpdateMgr(void);
    ~iGaiaUpdateMgr(void);

    void AddEventListener(iGaiaUpdateCallback* _listener);
    void RemoveEventListener(iGaiaUpdateCallback* _listener);
};

#endif