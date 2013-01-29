//
//  iGaiaParser_Object3dSettings.cpp
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/16/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#include "iGaiaParser_Object3dSettings.h"

vector<const iGaiaSettingsContainer::MaterialSettings*> iGaiaParser_Object3dSettingsDeserializeSettings(xml_node const& _settingsNode)
{
    vector<const iGaiaSettingsContainer::MaterialSettings*> materialsSettings;
    
    xml_node materials_node = _settingsNode.child("materials");

    for (xml_node material = materials_node.child("material"); material; material = materials_node.next_sibling("material"))
    {
        iGaiaSettingsContainer::MaterialSettings* materialSettings = new iGaiaSettingsContainer::MaterialSettings();
        materialSettings->m_renderMode = material.attribute("render_mode").as_uint();
        materialSettings->m_isCullFace = material.attribute("is_cull_face").as_bool();
        materialSettings->m_isDepthTest = material.attribute("is_depth_test").as_bool();
        materialSettings->m_isDepthMask = material.attribute("is_depth_mask").as_bool();
        materialSettings->m_isBlend = material.attribute("is_blend").as_bool();
        materialSettings->m_cullFaceMode = material.attribute("cull_face_mode").as_uint();
        materialSettings->m_blendFunctionSource = material.attribute("blend_function_source").as_uint();
        materialSettings->m_blendFunctionDestination = material.attribute("blend_function_destination").as_uint();

        iGaiaSettingsContainer::ShaderSettings* shaderSettings = new iGaiaSettingsContainer::ShaderSettings();
        shaderSettings->m_vsName = material.child("shader").attribute("vs_name").as_string();
        shaderSettings->m_fsName = material.child("shader").attribute("fs_name").as_string();
        materialSettings->m_shaderSettings = shaderSettings;

        xml_node textures_node = material.child("textures");
        for (xml_node texture = textures_node.child("texture"); texture; texture = textures_node.next_sibling("texture"))
        {
            iGaiaSettingsContainer::TextureSettings* textureSettings = new iGaiaSettingsContainer::TextureSettings();
            textureSettings->m_name = texture.attribute("name").as_string();
            textureSettings->m_slot = texture.attribute("slot").as_uint();
            textureSettings->m_wrap = texture.attribute("wrap").as_uint();
            materialSettings->m_texturesSettings.push_back(textureSettings);
        }
        materialsSettings.push_back(materialSettings);
    }
    return materialsSettings;
}