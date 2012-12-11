//
//  iGaiaParser_ParticleEmitterSettings.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/10/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaParser_ParticleEmitterSettings.h"

extern struct iGaiaParticleEmitterSettingsXMLValue
{
    const char* settings;
    const char* num_particles;
    const char* duration;
    const char* duration_randomness;
    const char* velocity_sensitivity;
    const char* min_horizontal_velocity;
    const char* max_horizontal_velocity;
    const char* min_vertical_velocity;
    const char* max_vertical_velocity;
    const char* end_velocity;
    const char* gravity;
    const char* start_color;
    const char* end_color;
    const char* start_size;
    const char* end_size;
    const char* min_particle_emitt_interval;
    const char* max_particle_emitt_interval;
    const char* textures;
    const char* texture_01;
    const char* texture_name;
    const char* texture_slot;
    const char* texture_wrap;
    const char* shaders;
    const char* shader_01;
    const char* shader_id;
    const char* shader_mode;
    
} iGaiaParticleEmitterSettingsXMLValue;

struct iGaiaParticleEmitterSettingsXMLValue iGaiaParticleEmitterSettingsXMLValue =
{
    .settings = "settings",
    .num_particles = "num_particles",
    .duration = "duration",
    .duration_randomness = "duration_randomness",
    .velocity_sensitivity = "velocity_sensitivity",
    .min_horizontal_velocity = "min_horizontal_velocity",
    .max_horizontal_velocity = "max_horizontal_velocity",
    .min_vertical_velocity = "min_vertical_velocity",
    .max_vertical_velocity = "max_vertical_velocity",
    .end_velocity = "end_velocity",
    .gravity = "gravity",
    .start_color = "start_color",
    .end_color = "end_color",
    .start_size = "start_size",
    .end_size = "end_size",
    .min_particle_emitt_interval = "min_particle_emitt_interval",
    .max_particle_emitt_interval = "max_particle_emitt_interval",
    .textures = "textures",
    .texture_01 = "texture_01",
    .texture_name = "name",
    .texture_slot = "slot",
    .texture_wrap = "wrap",
    .shaders = "shaders",
    .shader_01 = "shader_01",
    .shader_id = "id",
    .shader_mode = "mode"
};

iGaiaParser_ParticleEmitterSettings::iGaiaParser_ParticleEmitterSettings(void)
{
    
}

iGaiaParser_ParticleEmitterSettings::~iGaiaParser_ParticleEmitterSettings(void)
{

}

iGaiaParticleEmitter::iGaiaParticleEmitterSettings iGaiaParser_ParticleEmitterSettings::Get_Settings(const string &_name)
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
    settings.m_velocitySensitivity = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.velocity_sensitivity).attribute("value").as_float();
    settings.m_minHorizontalVelocity = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.min_horizontal_velocity).attribute("value").as_float();
    settings.m_maxHorizontalVelocity = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.max_horizontal_velocity).attribute("value").as_float();
    settings.m_minVerticalVelocity = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.min_vertical_velocity).attribute("value").as_float();
    settings.m_maxVerticalVelocity = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.max_vertical_velocity).attribute("value").as_float();
    settings.m_endVelocity = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.end_velocity).attribute("value").as_float();
    settings.m_gravity.x = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.gravity).attribute("x").as_float();
    settings.m_gravity.y = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.gravity).attribute("y").as_float();
    settings.m_gravity.z = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.gravity).attribute("z").as_float();
    settings.m_startColor.x = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.start_color).attribute("r").as_float();
    settings.m_startColor.y = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.start_color).attribute("g").as_float();
    settings.m_startColor.z = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.start_color).attribute("b").as_float();
    settings.m_startColor.w = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.start_color).attribute("a").as_float();
    settings.m_endColor.x = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.end_color).attribute("r").as_float();
    settings.m_endColor.y = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.end_color).attribute("g").as_float();
    settings.m_endColor.z = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.end_color).attribute("b").as_float();
    settings.m_endColor.w = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.end_color).attribute("a").as_float();
    settings.m_startSize.x = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.start_size).attribute("width").as_float();
    settings.m_startSize.y = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.start_size).attribute("height").as_float();
    settings.m_endSize.x = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.end_size).attribute("width").as_float();
    settings.m_endSize.y = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.end_size).attribute("height").as_float();
    settings.m_minParticleEmittInterval = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.min_particle_emitt_interval).attribute("value").as_int();
    settings.m_maxParticleEmittInterval = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.max_particle_emitt_interval).attribute("value").as_int();

    iGaiaObject3d::iGaiaObject3dTextureSettings settingsTexture_01;
    settingsTexture_01.m_name = settings_node.child(iGaiaParticleEmitterSettingsXMLValue.textures).child(iGaiaParticleEmitterSettingsXMLValue.texture_01).attribute(iGaiaParticleEmitterSettingsXMLValue.texture_name).as_string();
    settingsTexture_01.m_slot = static_cast<iGaiaShader::iGaia_E_ShaderTextureSlot>(settings_node.child(iGaiaParticleEmitterSettingsXMLValue.textures).child(iGaiaParticleEmitterSettingsXMLValue.texture_01).attribute(iGaiaParticleEmitterSettingsXMLValue.texture_slot).as_int());
    settingsTexture_01.m_wrap = static_cast<iGaiaTexture::iGaia_E_TextureSettingsValue>(settings_node.child(iGaiaParticleEmitterSettingsXMLValue.textures).child(iGaiaParticleEmitterSettingsXMLValue.texture_01).attribute(iGaiaParticleEmitterSettingsXMLValue.texture_wrap).as_int());

    iGaiaObject3d::iGaiaObject3dShaderSettings settingsShader_01;
    settingsShader_01.m_shader = static_cast<iGaiaShader::iGaia_E_Shader>(settings_node.child(iGaiaParticleEmitterSettingsXMLValue.shaders).child(iGaiaParticleEmitterSettingsXMLValue.shader_01).attribute(iGaiaParticleEmitterSettingsXMLValue.shader_id).as_int());
    settingsShader_01.m_mode = static_cast<iGaiaMaterial::iGaia_E_RenderModeWorldSpace >(settings_node.child(iGaiaParticleEmitterSettingsXMLValue.shaders).child(iGaiaParticleEmitterSettingsXMLValue.shader_01).attribute(iGaiaParticleEmitterSettingsXMLValue.shader_mode).as_int());

    settings.m_textures.push_back(settingsTexture_01);
    settings.m_shaders.push_back(settingsShader_01);

    return settings;
}