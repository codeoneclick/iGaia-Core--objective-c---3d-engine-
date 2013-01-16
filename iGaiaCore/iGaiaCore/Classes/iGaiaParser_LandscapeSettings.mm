//
//  iGaiaParser_LandscapeSettings.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaParser_LandscapeSettings.h"

iGaiaParser_LandscapeSettings::iGaiaParser_LandscapeSettings(void)
{

}

iGaiaParser_LandscapeSettings::~iGaiaParser_LandscapeSettings(void)
{

}

iGaiaSettingsProvider::LandscapeSettings iGaiaParser_LandscapeSettings::DeserializeSettings(string const& _name)
{
    string path([[[NSBundle mainBundle] resourcePath] UTF8String]);
    path.append("/");
    path.append(_name);

    xml_document document;
    xml_parse_result result = document.load_file(path.c_str());
    assert(result.status == status_ok);
    xml_node settings_node = document.child(iGaiaSkyDomeSettingsXMLValue.settings);
    iGaiaSettingsProvider::LandscapeSettings settings;

    settings.m_materialsSettings = m_parserObject3d.DeserializeSettings(settings_node);

    settings.m_width = settings_node.child("width").attribute("value").as_int();
    settings.m_height = settings_node.child("height").attribute("value").as_int();
    settings.m_scaleFactor.x = settings_node.child("scaleFactor").attribute("x").as_float();
    settings.m_scaleFactor.y = settings_node.child("scaleFactor").attribute("y").as_float();
    
    return settings;
}

