//
//  iGaiaParser_OceanSettings.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaParser_OceanSettings.h"

iGaiaParser_OceanSettings::iGaiaParser_OceanSettings(void)
{

}

iGaiaParser_OceanSettings::~iGaiaParser_OceanSettings(void)
{

}

iGaiaSettingsProvider::OceanSettings iGaiaParser_OceanSettings::DeserializeSettings(string const& _name)
{
    string path([[[NSBundle mainBundle] resourcePath] UTF8String]);
    path.append("/");
    path.append(_name);

    xml_document document;
    xml_parse_result result = document.load_file(path.c_str());
    assert(result.status == status_ok);
    xml_node settings_node = document.child("settings");
    iGaiaSettingsProvider::OceanSettings settings;

    settings.m_materialsSettings = m_parserObject3d.DeserializeSettings(settings_node);

    settings.m_width = settings_node.child("width").attribute("value").as_float();
    settings.m_height = settings_node.child("height").attribute("value").as_float();
    settings.m_altitude = settings_node.child("altitude").attribute("value").as_float();
    
    return settings;
}