//
//  iGaiaTouchMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaTouchMgr.h"

iGaiaTouchMgr::iGaiaTouchMgr(void)
{
    m_responder = [iGaiaTouchResponder_iOS new];
    m_crosser = new iGaiaTouchCrosser();
    [m_responder AddEventListener:m_crosser->Get_TouchCallback()];
}

iGaiaTouchMgr::~iGaiaTouchMgr(void)
{
    
}

iGaiaTouchResponder_iOS* iGaiaTouchMgr::Get_TouchResponder(void)
{
    return m_responder;
}

iGaiaTouchCrosser* iGaiaTouchMgr::Get_TouchCrosser(void)
{
    return m_crosser;
}
