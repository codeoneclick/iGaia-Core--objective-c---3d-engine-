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
#include "iGaiaParser_OceanSettings.h"
#include "iGaiaParser_SkyDomeSettings.h"

class iGaiaStageMgr
{
private:
    
    map<string, iGaiaShape3d::iGaiaShape3dSettings> m_shapes3dSettings;
    map<string, iGaiaOcean::iGaiaOceanSettings> m_oceanSettings;
    map<string, iGaiaSkyDome::iGaiaSkyDomeSettings> m_skydomeSettings;

protected:
    
public:
    
    iGaiaStageMgr(void);
    ~iGaiaStageMgr(void);

    iGaiaShape3d::iGaiaShape3dSettings Get_Shape3dSettings(const string& _name);
    iGaiaOcean::iGaiaOceanSettings Get_OceanSettings(const string& _name);
    iGaiaSkyDome::iGaiaSkyDomeSettings Get_SkyDomeSettings(const string& _name);
    
};

#endif