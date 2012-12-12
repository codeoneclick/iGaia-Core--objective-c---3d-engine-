//
//  iGaiaParser_OceanSettings.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaParser_OceanSettings.h"

extern struct iGaiaOceanSettingsXMLValue
{
    const char* settings;
    const char* width;
    const char* height;
    const char* altitude;
    const char* textures;
    const char* texture_01;
    const char* texture_name;
    const char* texture_slot;
    const char* texture_wrap;
    const char* shaders;
    const char* shader_01;
    const char* shader_id;
    const char* shader_mode;

} iGaiaOceanSettingsXMLValue;

struct iGaiaOceanSettingsXMLValue iGaiaOceanSettingsXMLValue =
{
    .settings = "settings",
    .width = "width",
    .height = "height",
    .altitude = "altitude",
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

iGaiaParser_OceanSettings::iGaiaParser_OceanSettings(void)
{

}

iGaiaParser_OceanSettings::~iGaiaParser_OceanSettings(void)
{

}

iGaiaOcean::iGaiaOceanSettings iGaiaParser_OceanSettings::Get_Settings(const string &_name)
{
    string path([[[NSBundle mainBundle] resourcePath] UTF8String]);
    path.append("/");
    path.append(_name);

    xml_document document;
    xml_parse_result result = document.load_file(path.c_str());
    xml_node settings_node = document.child(iGaiaOceanSettingsXMLValue.settings);
    iGaiaOcean::iGaiaOceanSettings settings;

    settings.m_width = settings_node.child(iGaiaOceanSettingsXMLValue.width).attribute("value").as_float();
    settings.m_height = settings_node.child(iGaiaOceanSettingsXMLValue.height).attribute("value").as_float();
    settings.m_altitude = settings_node.child(iGaiaOceanSettingsXMLValue.altitude).attribute("value").as_float();

    iGaiaObject3d::iGaiaObject3dTextureSettings settingsTexture_01;
    settingsTexture_01.m_name = settings_node.child(iGaiaOceanSettingsXMLValue.textures).child(iGaiaOceanSettingsXMLValue.texture_01).attribute(iGaiaOceanSettingsXMLValue.texture_name).as_string();
    settingsTexture_01.m_slot = static_cast<iGaiaShader::iGaia_E_ShaderTextureSlot>(settings_node.child(iGaiaOceanSettingsXMLValue.textures).child(iGaiaOceanSettingsXMLValue.texture_01).attribute(iGaiaOceanSettingsXMLValue.texture_slot).as_int());
    settingsTexture_01.m_wrap = static_cast<iGaiaTexture::iGaia_E_TextureSettingsValue>(settings_node.child(iGaiaOceanSettingsXMLValue.textures).child(iGaiaOceanSettingsXMLValue.texture_01).attribute(iGaiaOceanSettingsXMLValue.texture_wrap).as_int());

    iGaiaObject3d::iGaiaObject3dShaderSettings settingsShader_01;
    settingsShader_01.m_shader = static_cast<iGaiaShader::iGaia_E_Shader>(settings_node.child(iGaiaOceanSettingsXMLValue.shaders).child(iGaiaOceanSettingsXMLValue.shader_01).attribute(iGaiaOceanSettingsXMLValue.shader_id).as_int());
    settingsShader_01.m_mode = static_cast<iGaiaMaterial::iGaia_E_RenderModeWorldSpace >(settings_node.child(iGaiaOceanSettingsXMLValue.shaders).child(iGaiaOceanSettingsXMLValue.shader_01).attribute(iGaiaOceanSettingsXMLValue.shader_mode).as_int());

    settings.m_textures.push_back(settingsTexture_01);
    settings.m_shaders.push_back(settingsShader_01);
    
    return settings;
}