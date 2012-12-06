//
//  iGaiaUpdateMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/6/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaUpdateMgr.h"

iGaiaUpdateMgr::iGaiaUpdateMgr(void)
{
    
}

iGaiaUpdateMgr::~iGaiaUpdateMgr(void)
{

}

void iGaiaUpdateMgr::AddEventListener(iGaiaUpdateCallback *_listener)
{
    m_listeners.insert(_listener);
}

void iGaiaUpdateMgr::RemoveEventListener(iGaiaUpdateCallback *_listener)
{
    m_listeners.erase(_listener);
}

void iGaiaUpdateMgr::OnLoop(void)
{
    for(set<iGaiaUpdateCallback*>::iterator iterator_ = m_listeners.begin(); iterator_ != m_listeners.end(); ++iterator_)
    {
        iGaiaUpdateCallback* listener = (*iterator_);
        if(listener->InvokeOnProcessStatusListener() == iGaiaUpdateCallback::iGaia_E_LoadStatusReady)
        {
            listener->InvokeOnUpdate();
        }
    }
}