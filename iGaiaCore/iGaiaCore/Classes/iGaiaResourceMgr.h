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

class iGaiaResourceMgr
{
private:
    iGaiaTextureMgr* m_textureMgr;
    iGaiaMeshMgr* m_meshMgr;
protected:

public:
    iGaiaResourceMgr(void);
    ~iGaiaResourceMgr(void);

    static iGaiaResourceMgr* SharedInstance(void);

    iGaiaResource* LoadResourceSync(const string& _name);
    iGaiaResource* LoadResourceAsync(const string& _name, iGaiaLoadCallback* _listener);
};

#endif
