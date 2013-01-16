//
//  iGaiaParser_Shape3dSettings.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaParser_Shape3dSettings.h"

iGaiaParser_Shape3dSettings::iGaiaParser_Shape3dSettings(void)
{

}

iGaiaParser_Shape3dSettings::~iGaiaParser_Shape3dSettings(void)
{

}

iGaiaSettingsProvider::Shape3dSettings iGaiaParser_Shape3dSettings::DeserializeSettings(string const& _name)
{
    string path([[[NSBundle mainBundle] resourcePath] UTF8String]);
    path.append("/");
    path.append(_name);

    xml_document document;
    xml_parse_result result = document.load_file(path.c_str());
    assert(result.status == status_ok);
    xml_node settings_node = document.child("settings");
    iGaiaSettingsProvider::Shape3dSettings settings;

    settings.m_materialsSettings = m_parserObject3d.DeserializeSettings(settings_node);
    
    settings.m_name = settings_node.child("mesh").attribute("name").as_string();
    
    return settings;
}