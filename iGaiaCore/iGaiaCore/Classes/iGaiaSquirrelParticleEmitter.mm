//
//  iGaiaSquirrelParticleEmitter.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/18/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaSquirrelParticleEmitter.h"
#import "iGaiaStageMgr.h"
#import "iGaiaLogger.h"

@interface iGaiaParticleEmitterSettings : NSObject<iGaiaParticleEmitterSettings>

@property(nonatomic, readwrite) NSUInteger m_numParticles;

@property(nonatomic, readwrite) NSString* m_textureName;

@property(nonatomic, readwrite) float m_duration;
@property(nonatomic, readwrite) float m_durationRandomness;

@property(nonatomic, readwrite) float m_velocitySensitivity;

@property(nonatomic, readwrite) float m_minHorizontalVelocity;
@property(nonatomic, readwrite) float m_maxHorizontalVelocity;

@property(nonatomic, readwrite) float m_minVerticalVelocity;
@property(nonatomic, readwrite) float m_maxVerticalVelocity;

@property(nonatomic, readwrite) float m_endVelocity;

@property(nonatomic, readwrite) glm::vec3 m_gravity;

@property(nonatomic, readwrite) glm::u8vec4 m_startColor;
@property(nonatomic, readwrite) glm::u8vec4 m_endColor;

@property(nonatomic, readwrite) glm::vec2 m_startSize;
@property(nonatomic, readwrite) glm::vec2 m_endSize;

@property(nonatomic, readwrite) float m_minParticleEmittInterval;
@property(nonatomic, readwrite) float m_maxParticleEmittInterval;

@end

@implementation iGaiaParticleEmitterSettings

@end

SQInteger sq_createParticleEmmiterSettings(HSQUIRRELVM vm);

@interface iGaiaSquirrelParticleEmitter()

@property(nonatomic, assign) iGaiaSquirrelCommon* m_commonWrapper;

@end

@implementation iGaiaSquirrelParticleEmitter

- (id)initWithCommonWrapper:(iGaiaSquirrelCommon *)commonWrapper
{
    self = [super init];
    if(self)
    {
        _m_commonWrapper = commonWrapper;
        [self bind];
    }
    return self;
}

- (void)bind
{
    [_m_commonWrapper registerClass:@"ParticleEmitterWrapper"];
    [_m_commonWrapper registerFunction:sq_createParticleEmmiterSettings withName:@"createParticleEmitterSettings" forClass:@"ParticleEmitterWrapper"];
}

/*
local m_num_particles = 64;

local m_texture_name = "fire.pvr";

local m_duration = 2000.0;
local m_duration_randomness = 1.0;

local m_velocitySensitivity = 1.0;

local m_minHorizontalVelocity = 0.0;
local m_maxHorizontalVelocity = 0.0001;

local m_minVerticalVelocity = 0.0001;
local m_maxVerticalVelocity = 0.0003;

local m_endVelocity = 1.0;

local m_gravity = vector3d(0.0, 0.0001, 0.0);

local m_startColor = vector4d(0, 0, 255, 255);
local m_endColor = vector4d(255, 0, 0, 0);

local m_startSize = vector2d(0.1, 0.1);
local m_endSize = vector2d(2.0, 2.0);

local m_minParticleEmittInterval = 66;
*/

SQInteger sq_createParticleEmmiterSettings(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if (numArgs >= 2)
    {
        iGaiaParticleEmitterSettings* settings = [iGaiaParticleEmitterSettings new];
        settings.m_numParticles = [[iGaiaSquirrelCommon sharedInstance] retriveFloatValueWithIndex:2];
        settings.m_textureName = [[NSString alloc] initWithUTF8String:[[iGaiaSquirrelCommon sharedInstance] retriveStringValueWithIndex:3]];
        settings.m_duration = [[iGaiaSquirrelCommon sharedInstance] retriveFloatValueWithIndex:4];
        settings.m_durationRandomness = [[iGaiaSquirrelCommon sharedInstance] retriveFloatValueWithIndex:5];
        settings.m_velocitySensitivity = [[iGaiaSquirrelCommon sharedInstance] retriveFloatValueWithIndex:6];
        settings.m_minHorizontalVelocity = [[iGaiaSquirrelCommon sharedInstance] retriveFloatValueWithIndex:7];
        settings.m_maxHorizontalVelocity = [[iGaiaSquirrelCommon sharedInstance] retriveFloatValueWithIndex:8];
        settings.m_minVerticalVelocity = [[iGaiaSquirrelCommon sharedInstance] retriveFloatValueWithIndex:9];
        settings.m_maxVerticalVelocity = [[iGaiaSquirrelCommon sharedInstance] retriveFloatValueWithIndex:10];
        settings.m_endVelocity = [[iGaiaSquirrelCommon sharedInstance] retriveFloatValueWithIndex:11];
        glm::vec3 gravity = glm::vec3(0.0f, 0.0f, 0.0f);
        [[iGaiaSquirrelCommon sharedInstance] popVector3dX:&gravity.x Y:&gravity.y Z:&gravity.z forIndex:12];
        settings.m_gravity = gravity;
        glm::vec4 startColor = glm::vec4(0.0f, 0.0f, 0.0f, 0.0f);
        [[iGaiaSquirrelCommon sharedInstance] popVector4dX:&startColor.x Y:&startColor.y Z:&startColor.z W:&startColor.w forIndex:13];
        settings.m_startColor = glm::u8vec4(startColor.x, startColor.y, startColor.z, startColor.w);
        glm::vec4 endColor = glm::vec4(0.0f, 0.0f, 0.0f, 0.0f);
        [[iGaiaSquirrelCommon sharedInstance] popVector4dX:&endColor.x Y:&endColor.y Z:&endColor.z W:&endColor.w forIndex:14];
        settings.m_endColor = glm::u8vec4(endColor.x, endColor.y, endColor.z, endColor.w);
        glm::vec2 startSize = glm::vec2(0.0f, 0.0f);
        [[iGaiaSquirrelCommon sharedInstance] popVector2dX:&startSize.x Y:&startSize.y forIndex:15];
        settings.m_startSize = startSize;
        glm::vec2 endSize = glm::vec2(0.0f, 0.0f);
        [[iGaiaSquirrelCommon sharedInstance] popVector2dX:&endSize.x Y:&endSize.y forIndex:16];
        settings.m_endSize = endSize;
        settings.m_minParticleEmittInterval = [[iGaiaSquirrelCommon sharedInstance] retriveFloatValueWithIndex:17];
        settings.m_maxParticleEmittInterval = [[iGaiaSquirrelCommon sharedInstance] retriveFloatValueWithIndex:18];

        [[iGaiaStageMgr sharedInstance].m_particleMgr createParticleEmitterSettings:settings forKey:@"emitter"];

        return YES;
    }
    iGaiaLog(@"Script call args NULL.");
    return NO;
}


@end
