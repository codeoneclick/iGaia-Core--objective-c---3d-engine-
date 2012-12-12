//
//  iGaiaParser_Shape3dSettings.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaParser_Shape3dSettings.h"

extern struct iGaiaShape3dSettingsXMLValue
{
    const char* settings;
    const char* mesh;
    const char* mesh_name;
    const char* textures;
    const char* texture_01;
    const char* texture_name;
    const char* texture_slot;
    const char* texture_wrap;
    const char* shaders;
    const char* shader_01;
    const char* shader_02;
    const char* shader_03;
    const char* shader_id;
    const char* shader_mode;

} iGaiaShape3dSettingsXMLValue;

struct iGaiaShape3dSettingsXMLValue iGaiaShape3dSettingsXMLValue =
{
    .settings = "settings",
    .mesh = "mesh",
    .mesh_name = "name",
    .textures = "textures",
    .texture_01 = "texture_01",
    .texture_name = "name",
    .texture_slot = "slot",
    .texture_wrap = "wrap",
    .shaders = "shaders",
    .shader_01 = "shader_01",
    .shader_02 = "shader_02",
    .shader_03 = "shader_03",
    .shader_id = "id",
    .shader_mode = "mode"
};

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
    xml_node settings_node = document.child(iGaiaShape3dSettingsXMLValue.settings);
    iGaiaShape3d::iGaiaShape3dSettings settings;
    
    settings.m_meshName = settings_node.child(iGaiaShape3dSettingsXMLValue.mesh).attribute(iGaiaShape3dSettingsXMLValue.mesh_name).as_string();

    iGaiaObject3d::iGaiaObject3dTextureSettings settingsTexture_01;
    settingsTexture_01.m_name = settings_node.child(iGaiaShape3dSettingsXMLValue.textures).child(iGaiaShape3dSettingsXMLValue.texture_01).attribute(iGaiaShape3dSettingsXMLValue.texture_name).as_string();
    settingsTexture_01.m_slot = static_cast<iGaiaShader::iGaia_E_ShaderTextureSlot>(settings_node.child(iGaiaShape3dSettingsXMLValue.textures).child(iGaiaShape3dSettingsXMLValue.texture_01).attribute(iGaiaShape3dSettingsXMLValue.texture_slot).as_int());
    settingsTexture_01.m_wrap = static_cast<iGaiaTexture::iGaia_E_TextureSettingsValue>(settings_node.child(iGaiaShape3dSettingsXMLValue.textures).child(iGaiaShape3dSettingsXMLValue.texture_01).attribute(iGaiaShape3dSettingsXMLValue.texture_wrap).as_int());

    iGaiaObject3d::iGaiaObject3dShaderSettings settingsShader_01;
    settingsShader_01.m_shader = static_cast<iGaiaShader::iGaia_E_Shader>(settings_node.child(iGaiaShape3dSettingsXMLValue.shaders).child(iGaiaShape3dSettingsXMLValue.shader_01).attribute(iGaiaShape3dSettingsXMLValue.shader_id).as_int());
    settingsShader_01.m_mode = static_cast<iGaiaMaterial::iGaia_E_RenderModeWorldSpace >(settings_node.child(iGaiaShape3dSettingsXMLValue.shaders).child(iGaiaShape3dSettingsXMLValue.shader_01).attribute(iGaiaShape3dSettingsXMLValue.shader_mode).as_int());

    iGaiaObject3d::iGaiaObject3dShaderSettings settingsShader_02;
    settingsShader_02.m_shader = static_cast<iGaiaShader::iGaia_E_Shader>(settings_node.child(iGaiaShape3dSettingsXMLValue.shaders).child(iGaiaShape3dSettingsXMLValue.shader_02).attribute(iGaiaShape3dSettingsXMLValue.shader_id).as_int());
    settingsShader_02.m_mode = static_cast<iGaiaMaterial::iGaia_E_RenderModeWorldSpace >(settings_node.child(iGaiaShape3dSettingsXMLValue.shaders).child(iGaiaShape3dSettingsXMLValue.shader_02).attribute(iGaiaShape3dSettingsXMLValue.shader_mode).as_int());

    iGaiaObject3d::iGaiaObject3dShaderSettings settingsShader_03;
    settingsShader_03.m_shader = static_cast<iGaiaShader::iGaia_E_Shader>(settings_node.child(iGaiaShape3dSettingsXMLValue.shaders).child(iGaiaShape3dSettingsXMLValue.shader_03).attribute(iGaiaShape3dSettingsXMLValue.shader_id).as_int());
    settingsShader_03.m_mode = static_cast<iGaiaMaterial::iGaia_E_RenderModeWorldSpace >(settings_node.child(iGaiaShape3dSettingsXMLValue.shaders).child(iGaiaShape3dSettingsXMLValue.shader_03).attribute(iGaiaShape3dSettingsXMLValue.shader_mode).as_int());

    settings.m_textures.push_back(settingsTexture_01);
    settings.m_shaders.push_back(settingsShader_01);
    settings.m_shaders.push_back(settingsShader_02);
    settings.m_shaders.push_back(settingsShader_03);
    
    return settings;
}