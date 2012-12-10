//
//  iGaiaTextureMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaTextureMgrClass
#define iGaiaTextureMgrClass

#include "iGaiaResource.h"
#include "iGaiaLoadCallback.h"
#include "iGaiaLoader_PVR.h"
#include "iGaiaTexture.h"

class iGaiaTextureMgr
{
private:
    map<string, iGaiaTexture*> m_textures;
protected:

public:
    iGaiaTextureMgr(void);
    ~iGaiaTextureMgr(void);

    iGaiaTexture* Get_Texture(const string& _name);
};

#endif