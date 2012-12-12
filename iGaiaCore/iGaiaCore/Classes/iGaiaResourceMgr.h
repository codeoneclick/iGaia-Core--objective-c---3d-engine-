//
//  iGaiaResourceMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaResourceMgrClass
#define iGaiaResourceMgrClass

#include "iGaiaResource.h"
#include "iGaiaTextureMgr.h"
#include "iGaiaMeshMgr.h"
#include "iGaiaShaderMgr.h"
#include "iGaiaParticleMgr.h"
#include "iGaiaStageMgr.h"

class iGaiaResourceMgr
{
private:
    iGaiaTextureMgr* m_textureMgr;
    iGaiaMeshMgr* m_meshMgr;
    iGaiaShaderMgr* m_shaderMgr;
    iGaiaParticleMgr* m_particleMgr;
    iGaiaStageMgr* m_stageMgr;
protected:

public:
    iGaiaResourceMgr(void);
    ~iGaiaResourceMgr(void);

    static iGaiaResourceMgr* SharedInstance(void);

    iGaiaShader* Get_Shader(iGaiaShader::iGaia_E_Shader _shader);
    iGaiaTexture* Get_Texture(const string& _name);
    iGaiaMesh* Get_Mesh(const string& _name);
    
    iGaiaParticleEmitter::iGaiaParticleEmitterSettings Get_ParticleEmitterSettings(const string& _name);
    iGaiaShape3d::iGaiaShape3dSettings Get_Shape3dSettings(const string& _name);
    iGaiaOcean::iGaiaOceanSettings Get_OceanSettings(const string& _name);
    iGaiaSkyDome::iGaiaSkyDomeSettings Get_SkyDomeSettings(const string& _name);
};

#endif
