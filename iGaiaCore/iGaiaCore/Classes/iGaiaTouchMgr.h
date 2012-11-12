//
//  iGaiaTouchMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaiOSTouchResponder.h"
#include "iGaiaTouchCrosser.h"

class iGaiaTouchMgr
{
private:
    iGaiaiOSTouchResponder* m_responder;
    iGaiaTouchCrosser* m_crosser;
protected:

public:
    iGaiaTouchMgr(void);
    ~iGaiaTouchMgr(void);
    
    void Set_OperationView(UIView* _view);
    
    iGaiaiOSTouchResponder* Get_TouchResponder(void);
    iGaiaTouchCrosser* Get_TouchCrosser(void);
};
