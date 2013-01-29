//
//  iGaiaParser_HeightmapSettings.mm
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaParser_HeightmapSettings.h"

iGaiaParser_HeightmapSettings::iGaiaParser_HeightmapSettings(void)
{

}

iGaiaParser_HeightmapSettings::~iGaiaParser_HeightmapSettings(void)
{

}

const iGaiaSettingsContainer::HeightmapSettings* iGaiaParser_HeightmapSettings::DeserializeSettings(string const& _name)
{
    string path([[[NSBundle mainBundle] resourcePath] UTF8String]);
    path.append("/");
    path.append(_name);

    xml_document document;
    xml_parse_result result = document.load_file(path.c_str());
    assert(result.status == status_ok);
    xml_node settings_node = document.child("settings");
    iGaiaSettingsContainer::HeightmapSettings* settings = new iGaiaSettingsContainer::HeightmapSettings();

    settings->m_materialsSettings = m_parserObject3d.DeserializeSettings(settings_node);

    settings->m_width = settings_node.child("width").attribute("value").as_int();
    settings->m_height = settings_node.child("height").attribute("value").as_int();
    settings->m_heightmapDataFileName = settings_node.child("heightmap_data").attribute("value").as_string();
    settings->m_splattingDataFileName = settings_node.child("splattin_data").attribute("value").as_string();
    
    return settings;
}

