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
    map<string, iGaiaMesh*> m_meshes;
protected:

public:
    iGaiaMeshMgr(void);
    ~iGaiaMeshMgr(void);

    iGaiaMesh* Get_Mesh(const string& _name);
};

#endif