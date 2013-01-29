//
//  iGaiaSettingsContainer.mm
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/16/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#include "iGaiaSettingsContainer.h"
#include "iGaiaParser_HeightmapSettings.h"

iGaiaSettingsContainer::iGaiaSettingsContainer(void)
{

}

iGaiaSettingsContainer::~iGaiaSettingsContainer(void)
{
    
}

const iGaiaSettingsContainer::HeightmapSettings* iGaiaSettingsContainer::Get_HeightmapSettings(string const& _name)
{
    const iGaiaSettingsContainer::HeightmapSettings* settings = nullptr;
    if(m_settingsContainer.find(_name) == m_settingsContainer.end())
    {
        iGaiaParser_HeightmapSettings parser;
        settings = parser.DeserializeSettings(_name);
        m_settingsContainer.insert(make_pair(_name, settings));
    }
    else
    {
        settings = static_cast<const iGaiaSettingsContainer::HeightmapSettings*>(m_settingsContainer.find(_name)->second);
    }
    return settings;
}



