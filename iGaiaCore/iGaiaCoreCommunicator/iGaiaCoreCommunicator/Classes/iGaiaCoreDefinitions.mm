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
    .position = @"",
    .textcoord = @"",
    .normal = @"",
    .tangent = @"",
    .color = @""
};

const struct iGaiaCoreDefinitionShaderAttribute iGaiaCoreDefinitionShaderAttribute =
{
    .matrixWorld = @"",
    .matrixView = @"",
    .matrixProjection = @"",
    .matrixWorldViewProjection = @"",
    .vectorCameraPosition = @"",
    .vectorLightPosition = @"",
    .vectorClipPlane = @"",
    .vectorTexcoordOffset = @"",
    .floatTimer = @""
};

const struct iGaiaCoreDefinitionShaderTextureSlot iGaiaCoreDefinitionShaderTextureSlot =
{
    .texture_01 = @"",
    .texture_02 = @"",
    .texture_03 = @"",
    .texture_04 = @"",
    .texture_05 = @"",
    .texture_06 = @"",
    .texture_07 = @"",
    .texture_08 = @""
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



