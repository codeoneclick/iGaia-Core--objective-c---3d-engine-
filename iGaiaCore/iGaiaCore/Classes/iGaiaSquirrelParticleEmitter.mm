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


SQInteger sq_createParticleEmmiterSettings(HSQUIRRELVM vm);

iGaiaSquirrelParticleEmitter::iGaiaSquirrelParticleEmitter(iGaiaSquirrelCommon* _commonWrapper)
{
    m_commonWrapper = _commonWrapper;
    Bind();
}

iGaiaSquirrelParticleEmitter::~iGaiaSquirrelParticleEmitter(void)
{

}

void iGaiaSquirrelParticleEmitter::Bind(void)
{
    m_commonWrapper->RegisterClass("ParticleEmitterWrapper");
    m_commonWrapper->RegisterFunction(sq_createParticleEmmiterSettings, "createParticleEmitterSettings", "ParticleEmitterWrapper");
}

SQInteger sq_createParticleEmmiterSettings(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if (numArgs >= 2)
    {
        /*iGaiaParticleEmitterSettings* settings = new iGaiaParticleEmitterSettings();
        settings->m_numParticles = iGaiaSquirrelCommon::SharedInstance()->PopFloat(2);
        settings->m_textureName = iGaiaSquirrelCommon::SharedInstance()->PopString(3);
        settings->m_duration = iGaiaSquirrelCommon::SharedInstance()->PopFloat(4);
        settings->m_durationRandomness = iGaiaSquirrelCommon::SharedInstance()->PopFloat(5);
        settings->m_velocitySensitivity = iGaiaSquirrelCommon::SharedInstance()->PopFloat(6);
        settings->m_minHorizontalVelocity = iGaiaSquirrelCommon::SharedInstance()->PopFloat(7);
        settings->m_maxHorizontalVelocity = iGaiaSquirrelCommon::SharedInstance()->PopFloat(8);
        settings->m_minVerticalVelocity = iGaiaSquirrelCommon::SharedInstance()->PopFloat(9);
        settings->m_maxVerticalVelocity = iGaiaSquirrelCommon::SharedInstance()->PopFloat(10);
        settings->m_endVelocity = iGaiaSquirrelCommon::SharedInstance()->PopFloat(11); 
        vec3 gravity = vec3(0.0f, 0.0f, 0.0f);
        iGaiaSquirrelCommon::SharedInstance()->PopVector3d(&gravity.x, &gravity.y, &gravity.z, 12); 
        settings->m_gravity = gravity;
        vec4 startColor = vec4(0.0f, 0.0f, 0.0f, 0.0f);
        iGaiaSquirrelCommon::SharedInstance()->PopVector4d(&startColor.x, &startColor.y, &startColor.z, &startColor.w, 13); 
        settings->m_startColor = u8vec4(startColor.x, startColor.y, startColor.z, startColor.w);
        vec4 endColor = vec4(0.0f, 0.0f, 0.0f, 0.0f);
        iGaiaSquirrelCommon::SharedInstance()->PopVector4d(&endColor.x, &endColor.y, &endColor.z, &endColor.w, 14);
        settings->m_endColor = u8vec4(endColor.x, endColor.y, endColor.z, endColor.w);
        vec2 startSize = vec2(0.0f, 0.0f);
        iGaiaSquirrelCommon::SharedInstance()->PopVector2d(&startSize.x, &startSize.y, 15);
        settings->m_startSize = startSize;
        vec2 endSize = vec2(0.0f, 0.0f);
        iGaiaSquirrelCommon::SharedInstance()->PopVector2d(&endSize.x, &endSize.y, 16);
        settings->m_endSize = endSize;
        settings->m_minParticleEmittInterval = iGaiaSquirrelCommon::SharedInstance()->PopFloat(17); 
        settings->m_maxParticleEmittInterval = iGaiaSquirrelCommon::SharedInstance()->PopFloat(18); 

        iGaiaStageMgr::SharedInstance()->Get_ParticleMgr()->PushParticleEmitterSettings(settings, "emitter");*/
        return true;
    }
    iGaiaLog(@"Script call args NULL.");
    return false;
}

