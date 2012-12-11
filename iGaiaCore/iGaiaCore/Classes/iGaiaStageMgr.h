//
//  iGaiaStageMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaStageMgrClass
#define iGaiaStageMgrClass

#include "iGaiaParser_Shape3dSettings.h"

class iGaiaStageMgr
{
private:
    
    map<string, iGaiaShape3d::iGaiaShape3dSettings> m_shapes3dSettings;

protected:
    
public:
    
    iGaiaStageMgr(void);
    ~iGaiaStageMgr(void);

    iGaiaShape3d::iGaiaShape3dSettings Get_Shape3dSettings(const string& _name);
    
};

#endif