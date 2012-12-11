//
//  iGaiaStageMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#include "iGaiaStageMgr.h"
#include "iGaiaLogger.h"

iGaiaStageMgr::iGaiaStageMgr(void)
{

}

iGaiaStageMgr::~iGaiaStageMgr(void)
{
    
}

iGaiaShape3d::iGaiaShape3dSettings iGaiaStageMgr::Get_Shape3dSettings(const string& _name)
{
    iGaiaShape3d::iGaiaShape3dSettings settings;
    if(m_shapes3dSettings.find(_name) != m_shapes3dSettings.end())
    {
        settings = m_shapes3dSettings.find(_name)->second;
    }
    else
    {
        iGaiaParser_Shape3dSettings* parser = new iGaiaParser_Shape3dSettings();
        settings = parser->Get_Settings(_name);
        m_shapes3dSettings[_name] = settings;
        delete parser;
    }
    return settings;
}
