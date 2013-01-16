//
//  iGaiaSettingsProvider.cpp
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/16/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#include "iGaiaSettingsProvider.h"

#include "iGaiaParser_Shape3dSettings.h"
#include "iGaiaParser_OceanSettings.h"
#include "iGaiaParser_SkyDomeSettings.h"
#include "iGaiaParser_LandscapeSettings.h"
#include "iGaiaParser_ParticleEmitterSettings.h"

iGaiaSettingsProvider::iGaiaSettingsProvider(void)
{

}

iGaiaSettingsProvider::~iGaiaSettingsProvider(void)
{
    
}

iGaiaSettingsProvider::ParticleEmitterSettings iGaiaSettingsProvider::Get_ParticleEmitterSettings(string const& _name)
{
    iGaiaSettingsProvider::ParticleEmitterSettings settings;
    if(m_settingsContainer.find(_name) == m_settingsContainer.end())
    {
        iGaiaParser_ParticleEmitterSettings parser;
        settings = parser.DeserializeSettings(_name);
        m_settingsContainer.insert(make_pair(_name, settings));
    }
    else
    {
        settings = m_settingsContainer.find(_name)->second;
    }
    return settings;
}

iGaiaSettingsProvider::Shape3dSettings iGaiaSettingsProvider::Get_Shape3dSettings(string const& _name)
{
    iGaiaSettingsProvider::Shape3dSettings settings;
    if(m_settingsContainer.find(_name) == m_settingsContainer.end())
    {
        iGaiaParser_Shape3dSettings parser;
        settings = parser.DeserializeSettings(_name);
        m_settingsContainer.insert(make_pair(_name, settings));
    }
    else
    {
        settings = m_settingsContainer.find(_name)->second;
    }
    return settings;

}

iGaiaSettingsProvider::OceanSettings iGaiaSettingsProvider::Get_OceanSettings(string const& _name)
{
    iGaiaSettingsProvider::OceanSettings settings;
    if(m_settingsContainer.find(_name) == m_settingsContainer.end())
    {
        iGaiaParser_OceanSettings parser;
        settings = parser.DeserializeSettings(_name);
        m_settingsContainer.insert(make_pair(_name, settings));
    }
    else
    {
        settings = m_settingsContainer.find(_name)->second;
    }
    return settings;

}

iGaiaSettingsProvider::LandscapeSettings iGaiaSettingsProvider::Get_LandscapeSettings(string const& _name)
{
    iGaiaSettingsProvider::LandscapeSettings settings;
    if(m_settingsContainer.find(_name) == m_settingsContainer.end())
    {
        iGaiaParser_LandscapeSettings parser;
        settings = parser.DeserializeSettings(_name);
        m_settingsContainer.insert(make_pair(_name, settings));
    }
    else
    {
        settings = m_settingsContainer.find(_name)->second;
    }
    return settings;

}

iGaiaSettingsProvider::SkyDomeSettings iGaiaSettingsProvider::Get_SkyDomeSettings(string const& _name)
{
    iGaiaSettingsProvider::SkyDomeSettings settings;
    if(m_settingsContainer.find(_name) == m_settingsContainer.end())
    {
        iGaiaParser_SkyDomeSettings parser;
        settings = parser.DeserializeSettings(_name);
        m_settingsContainer.insert(make_pair(_name, settings));
    }
    else
    {
        settings = m_settingsContainer.find(_name)->second;
    }
    return settings;
}



