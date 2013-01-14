//
//  iGaiaTouchMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaTouchMgrClass
#define iGaiaTouchMgrClass

#include "iGaiaTouchResponder_iOS.h"
#include "iGaiaTouchCrosser.h"

class iGaiaTouchMgr
{
private:
    iGaiaTouchResponder_iOS* m_responder;
    iGaiaTouchCrosser* m_crosser;
protected:

public:
    iGaiaTouchMgr(void);
    ~iGaiaTouchMgr(void);
    
    iGaiaTouchResponder_iOS* Get_TouchResponder(void);
    iGaiaTouchCrosser* Get_TouchCrosser(void);
};

#endif
