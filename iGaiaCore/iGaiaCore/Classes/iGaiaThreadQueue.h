//
//  iGaiaThreadQueue.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 11/20/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaThreadQueueClass
#define iGaiaThreadQueueClass

#include "iGaiaCommon.h"

class iGaiaThreadQueue
{
private:
    thread m_thread;
    bool m_isStarted;
    void Loop(void);
protected:
    
public:
    iGaiaThreadQueue(void);
    ~iGaiaThreadQueue(void);
    void Start(void);
    void Stop(void);
    void Dispatch(std::function<void()> _function);
};


#endif 
