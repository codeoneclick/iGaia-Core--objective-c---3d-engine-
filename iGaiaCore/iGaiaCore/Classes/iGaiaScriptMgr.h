//
//  iGaiaScriptMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/10/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaScriptMgrClass
#define iGaiaScriptMgrClass

#include <squirrel.h>

#include "iGaiaSquirrelRuntime.h"
#include "iGaiaSquirrelCommon.h"
#include "iGaiaSquirrelScene.h"
#include "iGaiaSquirrelObject3d.h"
#include "iGaiaSquirrelParticleMgr.h"
#include "iGaiaSquirrelParticleEmitter.h"

class iGaiaScriptMgr
{
private:
    iGaiaSquirrelCommon* m_commonWrapper;
    iGaiaSquirrelRuntime* m_runtimeWrapper;
    iGaiaSquirrelScene* m_sceneWrapper;
    iGaiaSquirrelObject3d* m_object3dWrapper;
    iGaiaSquirrelParticleEmitter* m_particleEmitterWrapper;
protected:

public:
    iGaiaScriptMgr(void);
    ~iGaiaScriptMgr(void);

    iGaiaSquirrelCommon* Get_CommonWrapper(void);
    iGaiaSquirrelRuntime* Get_RuntimeWrapper(void);
    iGaiaSquirrelScene* Get_SceneWrapper(void);
    iGaiaSquirrelObject3d* Get_Object3dWrapper(void);
    iGaiaSquirrelParticleEmitter* Get_ParticleEmitterWrapper(void);

    bool LoadScript(const string& _name);
};


#endif