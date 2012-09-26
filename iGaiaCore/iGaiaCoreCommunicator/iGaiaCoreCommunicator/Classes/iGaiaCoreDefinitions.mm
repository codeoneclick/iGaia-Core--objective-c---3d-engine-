//
//  iGaiaCoreDefinitions.m
//  iGaiaCoreCommunicator
//
//  Created by Sergey Sergeev on 9/25/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaCoreDefinitions.h"

const struct iGaiaCoreDefinitionShaderVertexSlot iGaiaCoreDefinitionShaderVertexSlot =
{
    .position = @"IN_SLOT_Position",
    .textcoord = @"IN_SLOT_TexCoord",
    .normal = @"IN_SLOT_Normal",
    .tangent = @"IN_SLOT_Tangent",
    .color = @"IN_SLOT_Color"
};

const struct iGaiaCoreDefinitionShaderAttribute iGaiaCoreDefinitionShaderAttribute =
{
    .matrixWorld = @"EXT_MATRIX_World",
    .matrixView = @"EXT_MATRIX_View",
    .matrixProjection = @"EXT_MATRIX_Projection",
    .matrixWorldViewProjection = @"EXT_MATRIX_WVP",
    .vectorCameraPosition = @"EXT_View",
    .vectorLightPosition = @"EXT_Light",
    .vectorClipPlane = @"EXT_Clip_Plane",
    .vectorTexcoordOffset = @"EXT_Texcoord_Offset",
    .floatTimer = @"EXT_Timer"
};

const struct iGaiaCoreDefinitionShaderTextureSlot iGaiaCoreDefinitionShaderTextureSlot =
{
    .texture_01 = @"EXT_TEXTURE_01",
    .texture_02 = @"EXT_TEXTURE_02",
    .texture_03 = @"EXT_TEXTURE_03",
    .texture_04 = @"EXT_TEXTURE_04",
    .texture_05 = @"EXT_TEXTURE_05",
    .texture_06 = @"EXT_TEXTURE_06",
    .texture_07 = @"EXT_TEXTURE_07",
    .texture_08 = @"EXT_TEXTURE_08"
};

const struct iGaiaCoreDefinitionWorldSpaceRenderMode iGaiaCoreDefinitionWorldSpaceRenderMode =
{
    .simple = @"igaia.worldspace.rendermode.simple",
    .reflection = @"igaia.worldspace.rendermode.reflection",
    .refraction = @"igaia.worldspace.rendermode.refraction",
    .screenNormalMapping = @"igaia.worldspace.rendermode.screennormalmapping"
};

const struct iGaiaCoreDefinitionScreenSpaceRenderMode iGaiaCoreDefinitionScreenSpaceRenderMode =
{
    .simple = @"igaia.screenspace.rendermode.simple",
    .blur = @"igaia.screenspace.rendermode.blur",
    .bloom = @"igaia.screenspace.rendermode.bloom",
    .edgeDetect = @"igaia.screenspace.rendermode.edgeDetect",
    .sepia = @"igaia.screenspace.rendermode.sepia",
};

const struct iGaiaCoreDefinitionResourceType iGaiaCoreDefinitionResourceType =
{
    .texture = @"texture",
    .mesh = @"mesh"
};

const struct iGaiaCoreDefinitionResourceFormat iGaiaCoreDefinitionResourceFormat =
{
    .pvr = @".pvr",
    .mdl = @".mdl",
};

const struct iGaiaCoreDefinitionShaderName iGaiaCoreDefinitionShaderName =
{
    .worldSpaceModel = @"igaia.worldspace.shader.model",
    .worldSpaceOcean = @"igaia.worldspace.shader.ocean",
    .worldSpaceSkybox = @"igaia.worldspace.shader.skybox",
    .worldSpaceParticle = @"igaia.worldspace.shader.particle",
    .screenSpaceSimple = @"igaia.screenspace.shader.simple"

};



