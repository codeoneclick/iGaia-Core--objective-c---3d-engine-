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

class iGaiaResourceMgr
{
private:
    iGaiaTextureMgr* m_textureMgr;
    iGaiaMeshMgr* m_meshMgr;
    iGaiaShaderMgr* m_shaderMgr;
protected:

public:
    iGaiaResourceMgr(void);
    ~iGaiaResourceMgr(void);

    iGaiaShader* Get_Shader(string const& _vsName, string const& _fsName);
    iGaiaTexture* Get_Texture(string const& _name);
    iGaiaMesh* Get_Mesh(string const& _name);
};

#endif
