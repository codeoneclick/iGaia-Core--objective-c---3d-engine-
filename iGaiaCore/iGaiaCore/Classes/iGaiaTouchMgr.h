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

protected:

public:
    
};

@interface iGaiaTouchMgr : NSObject

@property(nonatomic, assign) UIView* m_operationView;

@property(nonatomic, readonly) iGaiaTouchResponder* m_responder;
@property(nonatomic, readonly) iGaiaTouchCrosser* m_crosser;

@end
