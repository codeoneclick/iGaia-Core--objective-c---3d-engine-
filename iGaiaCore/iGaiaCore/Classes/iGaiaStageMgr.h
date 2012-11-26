//
//  iGaiaStageMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaStageMgrClass
#define iGaiaStageMgrClass

#include "iGaiaCamera.h"
#include "iGaiaLight.h"
#include "iGaiaShape3d.h"
#include "iGaiaBillboard.h"
#include "iGaiaOcean.h"
#include "iGaiaSkyDome.h"
#include "iGaiaScriptMgr.h"
#include "iGaiaTouchMgr.h"
#include "iGaiaRenderMgr.h"
#include "iGaiaParticleMgr.h"
#include "iGaiaSoundMgr.h"
#include "iGaiaiOSGameLoop.h"

class iGaiaStageMgr
{
private:
    
    iGaiaRenderMgr* m_renderMgr;
    iGaiaScriptMgr* m_scriptMgr;
    iGaiaTouchMgr* m_touchMgr;
    iGaiaParticleMgr* m_particleMgr;
    iGaiaSoundMgr* m_soundMgr;

    set<iGaiaObject3d*> m_listeners;
    iGaiaCamera* m_camera;
    iGaiaLight* m_light;
    iGaiaOcean* m_ocean;
    
    iGaiaLoopCallback m_loopCallback;
    
protected:
    
public:
    iGaiaStageMgr(void);
    ~iGaiaStageMgr(void);

    static iGaiaStageMgr* SharedInstance(void);

    iGaiaRenderMgr* Get_RenderMgr(void);
    iGaiaScriptMgr* Get_ScriptMgr(void);
    iGaiaTouchMgr* Get_TouchMgr(void);
    iGaiaParticleMgr* Get_ParticleMgr(void);
    iGaiaSoundMgr* Get_SoundMgr(void);

    iGaiaCamera* CreateCamera(f32 _fov, f32 _near, f32 _far, ui32 _width, ui32 _height);
    iGaiaLight* CreateLight(void);
    iGaiaShape3d* CreateShape3d(const string& _name);
    iGaiaOcean* CreateOcean(f32 _width, f32 _height, f32 _altitude);
    iGaiaSkyDome* CreateSkyDome(void);

    void OnUpdate(void);
};

#endif