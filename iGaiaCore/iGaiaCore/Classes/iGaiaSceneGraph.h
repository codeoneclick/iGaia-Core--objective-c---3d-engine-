//
//  iGaiaSceneGraph.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/24/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#ifndef __iGaiaCore__iGaiaSceneGraph__
#define __iGaiaCore__iGaiaSceneGraph__

#include "iGaiaCommon.h"
#include "iGaiaRenderMgr.h"
#include "iGaiaUpdateMgr.h"

#include "iGaiaCamera.h"
#include "iGaiaLight.h"
#include "iGaiaShape3d.h"
#include "iGaiaOcean.h"
#include "iGaiaSkyDome.h"
#include "iGaiaLandscape.h"
#include "iGaiaParticleEmitter.h"
#include "iGaiaNavigationHelper.h"

class iGaiaSceneGraph
{
private:
    iGaiaCamera* m_camera;
    iGaiaLight* m_light;
    
    iGaiaOcean* m_ocean;
    iGaiaSkyDome* m_skyDome;
    iGaiaLandscape* m_landscape;
    
    set<iGaiaShape3d*> m_shapes3d;
    set<iGaiaParticleEmitter*> m_particleEmitters;
protected:
    iGaiaRenderMgr* m_renderMgr;
    iGaiaUpdateMgr* m_updateMgr;
    
    iGaiaSceneGraph(void) = default;
    virtual ~iGaiaSceneGraph(void) = default;
    
public:
    
    void Set_Camera(iGaiaCamera* _camera);
    void Set_Light(iGaiaLight* _light);
    void Set_Ocean(iGaiaOcean* _ocean);
    void Set_Landscape(iGaiaLandscape* _landscape);
    void Set_SkyDome(iGaiaSkyDome* _skyDome);
    
    void PushShape3d(iGaiaShape3d* _shape3d);
    void PushParticleEmitter(iGaiaParticleEmitter* _particleEmitter);
    
    void PopShape3d(iGaiaShape3d* _shape3d);
    void PopParticleEmitter(iGaiaParticleEmitter* _particleEmitter);
};

#endif
