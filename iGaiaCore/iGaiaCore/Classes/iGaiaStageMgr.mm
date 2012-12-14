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

iGaiaOcean::iGaiaOceanSettings iGaiaStageMgr::Get_OceanSettings(const string &_name)
{
    iGaiaOcean::iGaiaOceanSettings settings;
    if(m_oceanSettings.find(_name) != m_oceanSettings.end())
    {
        settings = m_oceanSettings.find(_name)->second;
    }
    else
    {
        iGaiaParser_OceanSettings* parser = new iGaiaParser_OceanSettings();
        settings = parser->Get_Settings(_name);
        m_oceanSettings[_name] = settings;
        delete parser;
    }
    return settings;
}

iGaiaLandscape::iGaiaLandscapeSettings iGaiaStageMgr::Get_LandscapeSettings(const string &_name)
{
    iGaiaLandscape::iGaiaLandscapeSettings settings;
    if(m_landscapeSettings.find(_name) != m_landscapeSettings.end())
    {
        settings = m_landscapeSettings.find(_name)->second;
    }
    else
    {
        iGaiaParser_LandscapeSettings* parser = new iGaiaParser_LandscapeSettings();
        settings = parser->Get_Settings(_name);
        m_landscapeSettings[_name] = settings;
        delete parser;
    }
    return settings;
}

iGaiaSkyDome::iGaiaSkyDomeSettings iGaiaStageMgr::Get_SkyDomeSettings(const string &_name)
{
    iGaiaSkyDome::iGaiaSkyDomeSettings settings;
    if(m_skydomeSettings.find(_name) != m_skydomeSettings.end())
    {
        settings = m_skydomeSettings.find(_name)->second;
    }
    else
    {
        iGaiaParser_SkyDomeSettings* parser = new iGaiaParser_SkyDomeSettings();
        settings = parser->Get_Settings(_name);
        m_skydomeSettings[_name] = settings;
        delete parser;
    }
    return settings;
}
