//
//  iGaiaCoreDefinitions.h
//  iGaiaCoreCommunicator
//
//  Created by Sergey Sergeev on 9/25/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const struct iGaiaCoreDefinitionShaderVertexSlot
{
    NSString *position;
    NSString *textcoord;
    NSString *normal;
    NSString *tangent;
    NSString *color;

} iGaiaCoreDefinitionShaderVertexSlot;

extern const struct iGaiaCoreDefinitionShaderAttribute
{
    NSString *matrixWorld;
    NSString *matrixView;
    NSString *matrixProjection;
    NSString *matrixWorldViewProjection;
    NSString *vectorCameraPosition;
    NSString *vectorLightPosition;
    NSString *vectorClipPlane;
    NSString *vectorTexcoordOffset;
    NSString *floatTimer;

} iGaiaCoreDefinitionShaderAttribute;

extern const struct iGaiaCoreDefinitionShaderTextureSlot
{
    NSString *texture_01;
    NSString *texture_02;
    NSString *texture_03;
    NSString *texture_04;
    NSString *texture_05;
    NSString *texture_06;
    NSString *texture_07;
    NSString *texture_08;

} iGaiaCoreDefinitionShaderTextureSlot;


extern const struct iGaiaCoreDefinitionResourceType
{
    NSString *texture;
    NSString *mesh;

} iGaiaCoreDefinitionResourceType;

extern const struct iGaiaCoreDefinitionResourceFormat
{
    NSString *pvr;
    NSString *mdl;

} iGaiaCoreDefinitionResourceFormat;


extern const struct iGaiaCoreDefinitionWorldSpaceRenderMode
{
    NSString *simple;
    NSString *reflection;
    NSString *refraction;
    NSString *screenNormalMapping;

} iGaiaCoreDefinitionWorldSpaceRenderMode;

extern const struct iGaiaCoreDefinitionScreenSpaceRenderMode
{
    NSString *simple;
    NSString *blur;
    NSString *bloom;
    NSString *edgeDetect;
    NSString *sepia;

} iGaiaCoreDefinitionScreenSpaceRenderMode;


extern const struct iGaiaCoreDefinitionShaderName
{
    NSString *worldSpaceModel;
    NSString *worldSpaceOcean;
    NSString *worldSpaceSkybox;
    NSString *worldSpaceParticle;
    NSString *screenSpaceSimple;

} iGaiaCoreDefinitionShaderName;




