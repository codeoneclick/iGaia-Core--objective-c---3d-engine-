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
    m_responder = [iGaiaiOSTouchResponder new];
    m_crosser = new iGaiaTouchCrosser();
    [m_responder AddEventListener:m_crosser];
}

iGaiaTouchMgr::~iGaiaTouchMgr(void)
{
    
}

void iGaiaTouchMgr::Set_OperationView(UIView* _view)
{
    m_responder.m_operationView = _view;
}

iGaiaiOSTouchResponder* iGaiaTouchMgr::Get_TouchResponder(void)
{
    return m_responder;
}

iGaiaTouchCrosser* iGaiaTouchMgr::Get_TouchCrosser(void)
{
    return m_crosser;
}
