//
//  iGaiaThreadQueue.cpp
//  iGaiaCore
//
//  Created by Sergey Sergeev on 11/20/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaThreadQueue.h"


iGaiaThreadQueue::iGaiaThreadQueue(void)
{
    function<void()> loop = std::bind(&iGaiaThreadQueue::Loop, this);
    m_thread = thread(loop);
}

iGaiaThreadQueue::~iGaiaThreadQueue(void)
{
    
}

void iGaiaThreadQueue::Loop(void)
{
    while(m_isStarted)
    {
    }
}

void iGaiaThreadQueue::Start(void)
{
    if(!m_isStarted)
    {
        
        m_isStarted = true;
    }
}

void iGaiaThreadQueue::Stop(void)
{
    m_isStarted = false;
}

void iGaiaThreadQueue::Dispatch(std::function<void()> _function)
{
    
}

