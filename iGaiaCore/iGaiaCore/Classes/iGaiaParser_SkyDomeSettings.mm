//
//  iGaiaParser_SkyDomeSettings.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaParser_SkyDomeSettings.h"

extern struct iGaiaSkyDomeSettingsXMLValue
{
    const char* settings;
    const char* textures;
    const char* texture_01;
    const char* texture_name;
    const char* texture_slot;
    const char* texture_wrap;
    const char* shaders;
    const char* shader_01;
    const char* shader_id;
    const char* shader_mode;

} iGaiaSkyDomeSettingsXMLValue;

struct iGaiaSkyDomeSettingsXMLValue iGaiaSkyDomeSettingsXMLValue =
{
    .settings = "settings",
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

iGaiaParser_SkyDomeSettings::iGaiaParser_SkyDomeSettings(void)
{

}

iGaiaParser_SkyDomeSettings::~iGaiaParser_SkyDomeSettings(void)
{

}

iGaiaSkyDome::iGaiaSkyDomeSettings iGaiaParser_SkyDomeSettings::Get_Settings(const string &_name)
{
    string path([[[NSBundle mainBundle] resourcePath] UTF8String]);
    path.append("/");
    path.append(_name);

    xml_document document;
    xml_parse_result result = document.load_file(path.c_str());
    xml_node settings_node = document.child(iGaiaSkyDomeSettingsXMLValue.settings);
    iGaiaSkyDome::iGaiaSkyDomeSettings settings;

    iGaiaObject3d::iGaiaObject3dTextureSettings settingsTexture_01;
    settingsTexture_01.m_name = settings_node.child(iGaiaSkyDomeSettingsXMLValue.textures).child(iGaiaSkyDomeSettingsXMLValue.texture_01).attribute(iGaiaSkyDomeSettingsXMLValue.texture_name).as_string();
    settingsTexture_01.m_slot = static_cast<iGaiaShader::iGaia_E_ShaderTextureSlot>(settings_node.child(iGaiaSkyDomeSettingsXMLValue.textures).child(iGaiaSkyDomeSettingsXMLValue.texture_01).attribute(iGaiaSkyDomeSettingsXMLValue.texture_slot).as_int());
    settingsTexture_01.m_wrap = static_cast<iGaiaTexture::iGaia_E_TextureSettingsValue>(settings_node.child(iGaiaSkyDomeSettingsXMLValue.textures).child(iGaiaSkyDomeSettingsXMLValue.texture_01).attribute(iGaiaSkyDomeSettingsXMLValue.texture_wrap).as_int());

    iGaiaObject3d::iGaiaObject3dShaderSettings settingsShader_01;
    settingsShader_01.m_shader = static_cast<iGaiaShader::iGaia_E_Shader>(settings_node.child(iGaiaSkyDomeSettingsXMLValue.shaders).child(iGaiaSkyDomeSettingsXMLValue.shader_01).attribute(iGaiaSkyDomeSettingsXMLValue.shader_id).as_int());
    settingsShader_01.m_mode = static_cast<iGaiaMaterial::iGaia_E_RenderModeWorldSpace >(settings_node.child(iGaiaSkyDomeSettingsXMLValue.shaders).child(iGaiaSkyDomeSettingsXMLValue.shader_01).attribute(iGaiaSkyDomeSettingsXMLValue.shader_mode).as_int());

    settings.m_textures.push_back(settingsTexture_01);
    settings.m_shaders.push_back(settingsShader_01);
    
    return settings;
}

