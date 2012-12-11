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

iGaiaShape3d::iGaiaShape3dSettings iGaiaParser_Shape3dSettings::Get_Settings(const string &_name)
{
    string path([[[NSBundle mainBundle] resourcePath] UTF8String]);
    path.append("/");
    path.append(_name);

    xml_document document;
    xml_parse_result result = document.load_file(path.c_str());
    xml_node settings_node = document.child(iGaiaParticleEmitterSettingsXMLValue.settings);
    iGaiaParticleEmitter::iGaiaParticleEmitterSettings settings;
    settings.m_numParticles = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.num_particles).attribute("value").as_int();
    settings.m_duration = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.duration).attribute("value").as_int();
    settings.m_durationRandomness = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.duration_randomness).attribute("value").as_float();
}