//
//  iGaiaLandscapeWrapper.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/29/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaLandscapeWrapperClass
#define iGaiaLandscapeWrapperClass

#include "iGaiaCommon.h"
#include "iGaiaLandscape.h"

class iGaiaLandscapeWrapper : public iGaiaLandscape
{
private:

protected:
    
    vector<iGaiaLandscape*> m_container;
    
public:
    
    iGaiaLandscapeWrapper(void);
    ~iGaiaLandscapeWrapper(void);
    
};

#endif 
