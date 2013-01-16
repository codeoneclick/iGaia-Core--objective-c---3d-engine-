//
//  iGaiaParser_ParticleEmitterSettings.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/10/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaParser_ParticleEmitterSettings.h"


iGaiaParser_ParticleEmitterSettings::iGaiaParser_ParticleEmitterSettings(void)
{
    
}

iGaiaParser_ParticleEmitterSettings::~iGaiaParser_ParticleEmitterSettings(void)
{

}

iGaiaSettingsProvider::ParticleEmitterSettings iGaiaParser_ParticleEmitterSettings::DeserializeSettings(string const& _name)
{
    string path([[[NSBundle mainBundle] resourcePath] UTF8String]);
    path.append("/");
    path.append(_name);

    xml_document document;
    xml_parse_result result = document.load_file(path.c_str());
    assert(result.status == status_ok);
    xml_node settings_node = document.child("settings");

    iGaiaSettingsProvider::ParticleEmitterSettings settings;
    settings.m_materialsSettings = m_parserObject3d.DeserializeSettings(settings_node);
    
    settings.m_numParticles = settings_node.child("num_particles").attribute("value").as_int();
    settings.m_duration = settings_node.child("duration").attribute("value").as_int();
    settings.m_durationRandomness = settings_node.child("duration_randomness").attribute("value").as_float();
    settings.m_velocitySensitivity = settings_node.child("velocity_sensitivity").attribute("value").as_float();
    settings.m_minHorizontalVelocity = settings_node.child("min_horizontal_velocity").attribute("value").as_float();
    settings.m_maxHorizontalVelocity = settings_node.child("max_horizontal_velocity").attribute("value").as_float();
    settings.m_minVerticalVelocity = settings_node.child("min_vertical_velocity").attribute("value").as_float();
    settings.m_maxVerticalVelocity = settings_node.child("max_vertical_velocity").attribute("value").as_float();
    settings.m_endVelocity = settings_node.child("end_velocity").attribute("value").as_float();
    settings.m_gravity.x = settings_node.child("gravity").attribute("x").as_float();
    settings.m_gravity.y = settings_node.child("gravity").attribute("y").as_float();
    settings.m_gravity.z = settings_node.child("gravity").attribute("z").as_float();
    settings.m_startColor.x = settings_node.child("start_color").attribute("r").as_float();
    settings.m_startColor.y = settings_node.child("start_color").attribute("g").as_float();
    settings.m_startColor.z = settings_node.child("start_color").attribute("b").as_float();
    settings.m_startColor.w = settings_node.child("start_color").attribute("a").as_float();
    settings.m_endColor.x = settings_node.child("end_color").attribute("r").as_float();
    settings.m_endColor.y = settings_node.child("end_color").attribute("g").as_float();
    settings.m_endColor.z = settings_node.child("end_color").attribute("b").as_float();
    settings.m_endColor.w = settings_node.child("end_color").attribute("a").as_float();
    settings.m_startSize.x = settings_node.child("start_size").attribute("width").as_float();
    settings.m_startSize.y = settings_node.child("start_size").attribute("height").as_float();
    settings.m_endSize.x = settings_node.child("end_size").attribute("width").as_float();
    settings.m_endSize.y = settings_node.child("end_size").attribute("height").as_float();
    settings.m_minParticleEmittInterval = settings_node.child("min_particle_emitt_interval").attribute("value").as_int();
    settings.m_maxParticleEmittInterval = settings_node.child("max_particle_emitt_interval").attribute("value").as_int();

    return settings;
}