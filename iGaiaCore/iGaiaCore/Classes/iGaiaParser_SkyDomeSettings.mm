//
//  iGaiaParser_SkyDomeSettings.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaParser_SkyDomeSettings.h"

iGaiaParser_SkyDomeSettings::iGaiaParser_SkyDomeSettings(void)
{

}

iGaiaParser_SkyDomeSettings::~iGaiaParser_SkyDomeSettings(void)
{

}

iGaiaSettingsProvider::SkyDomeSettings iGaiaParser_SkyDomeSettings::DeserializeSettings(string const& _name)
{
    string path([[[NSBundle mainBundle] resourcePath] UTF8String]);
    path.append("/");
    path.append(_name);

    xml_document document;
    xml_parse_result result = document.load_file(path.c_str());
    assert(result.status == status_ok);
    xml_node settings_node = document.child("settings");
    iGaiaSettingsProvider::SkyDomeSettings settings;

    settings.m_materialsSettings = m_parserObject3d.DeserializeSettings(settings_node);
    
    return settings;
}

