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
    m_isStarted = false;
}

iGaiaThreadQueue::~iGaiaThreadQueue(void)
{
    
}

void iGaiaThreadQueue::Loop(void)
{
    while(m_isStarted)
    {
        std::cout<<"THREAD !!!"<<std::endl;
    }
}

void iGaiaThreadQueue::Start(void)
{
    if(!m_isStarted)
    {
        std::function<void()> loop = std::bind(&iGaiaThreadQueue::Loop, this);
        m_thread = std::thread(loop);
        m_isStarted = true;
    }
}

void iGaiaThreadQueue::Stop(void)
{
    m_isStarted = false;
}

void iGaiaThreadQueue::Dispatch(std::function<void ()> _function)
{
    
}

