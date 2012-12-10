//
//  iGaiaMeshMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaMeshMgr.h"

iGaiaMeshMgr::iGaiaMeshMgr(void)
{

}

iGaiaMeshMgr::~iGaiaMeshMgr(void)
{

}

iGaiaMesh* iGaiaMeshMgr::Get_Mesh(const string &_name)
{
    iGaiaMesh* mesh = nullptr;
    if(m_meshes.find(_name) != m_meshes.end())
    {
        mesh = m_meshes.find(_name)->second;
        mesh->IncReferenceCount();
    }
    else
    {
        iGaiaLoader_MDL* loader = new iGaiaLoader_MDL();
        loader->ParseFileWithName(_name);
        if(loader->Get_Status() == iGaiaLoader::iGaia_E_LoadStatusDone)
        {
            mesh = static_cast<iGaiaMesh*>(loader->CommitToVRAM());
            m_meshes[_name] = mesh;
            mesh->IncReferenceCount();
        }
    }
    return mesh;
}
