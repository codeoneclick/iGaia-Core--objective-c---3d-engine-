//
//  iGaiaScriptMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/10/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaScriptMgr.h"

iGaiaScriptMgr::iGaiaScriptMgr(void)
{
    m_commonWrapper = iGaiaSquirrelCommon::SharedInstance();
    m_runtimeWrapper = new iGaiaSquirrelRuntime(m_commonWrapper); 
    m_sceneWrapper = new iGaiaSquirrelScene(m_commonWrapper); 
    m_object3dWrapper = new iGaiaSquirrelObject3d(m_commonWrapper); 
    m_particleEmitterWrapper = new iGaiaSquirrelParticleEmitter(m_commonWrapper); 
}

iGaiaScriptMgr::~iGaiaScriptMgr(void)
{

}

inline iGaiaSquirrelCommon* iGaiaScriptMgr::Get_CommonWrapper(void)
{
    return m_commonWrapper;
}

inline iGaiaSquirrelRuntime* iGaiaScriptMgr::Get_RuntimeWrapper(void)
{
    return m_runtimeWrapper;
}

inline iGaiaSquirrelScene* iGaiaScriptMgr::Get_SceneWrapper(void)
{
    return m_sceneWrapper;
}

inline iGaiaSquirrelObject3d* iGaiaScriptMgr::Get_Object3dWrapper(void)
{
    return m_object3dWrapper;
}

inline iGaiaSquirrelParticleEmitter* iGaiaScriptMgr::Get_ParticleEmitterWrapper(void)
{
    return m_particleEmitterWrapper;
}

bool iGaiaScriptMgr::LoadScript(const string& _name)
{
    return m_commonWrapper->LoadScript(_name);
}