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
    map<string, iGaiaLoader_PVR*> m_tasks;
    map<string, iGaiaTexture*> m_resources;
protected:

public:
    iGaiaTextureMgr(void);
    ~iGaiaTextureMgr(void);

    iGaiaResource* LoadResourceSync(const string& _name);
    iGaiaResource* LoadResourceAsync(const string& _name, iGaiaLoadCallback* _listener);
};

#endif