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
    const char* mesh;
    const char* mesh_name;
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