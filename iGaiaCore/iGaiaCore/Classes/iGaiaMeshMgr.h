//
//  iGaiaMeshMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaMeshMgrClass
#define iGaiaMeshMgrClass

#include "iGaiaResource.h"
#include "iGaiaLoadCallback.h"
#include "iGaiaLoader_MDL.h"
#include "iGaiaMesh.h"

class iGaiaMeshMgr
{
private:
    map<string, iGaiaLoader_MDL*> m_tasks;
    map<string, iGaiaMesh*> m_resources;
protected:

public:
    iGaiaMeshMgr(void);
    ~iGaiaMeshMgr(void);

    iGaiaResource* LoadResourceSync(const string& _name);
    iGaiaResource* LoadResourceAsync(const string& _name, iGaiaLoadCallback* _listener);
};

#endif