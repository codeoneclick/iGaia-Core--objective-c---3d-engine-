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

iGaiaResource* iGaiaMeshMgr::LoadResourceSync(const string &_name)
{
    iGaiaMesh* mesh = nullptr;
    if(m_resources.find(_name) != m_resources.end())
    {
        mesh = m_resources.find(_name)->second;
    }
    else
    {
        iGaiaLoader_MDL* loader = new iGaiaLoader_MDL();
        loader->ParseFileWithName(_name);
        if(loader->Get_Status() == iGaiaLoader::iGaia_E_LoadStatusDone)
        {
            mesh = static_cast<iGaiaMesh*>(loader->CommitToVRAM());
            mesh->IncReferenceCount();
            m_resources[_name] = mesh;
        }
    }
    return mesh;
}

iGaiaResource* iGaiaMeshMgr::LoadResourceAsync(const string &_name, iGaiaLoadCallback *_listener)
{
    iGaiaMesh* mesh = nullptr;
    if(m_resources.find(_name) != m_resources.end())
    {
        mesh = m_resources.find(_name)->second;
    }
    else
    {
        mesh = new iGaiaMesh(nil, nil, _name, iGaiaResource::iGaia_E_CreationModeNative);
        if(m_tasks.find(_name) != m_tasks.end())
        {
            iGaiaLoader_MDL* loader = m_tasks.find(_name)->second;
            loader->AddEventListener(_listener);
        }
        else
        {
            iGaiaLoader_MDL* loader = new iGaiaLoader_MDL();
            m_tasks[_name] = loader;
            loader->AddEventListener(_listener);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
            {
                loader->ParseFileWithName(_name);
                dispatch_async(dispatch_get_main_queue(), ^
                {
                    if(loader->Get_Status() == iGaiaLoader::iGaia_E_LoadStatusDone)
                    {
                        iGaiaMesh* mesh = static_cast<iGaiaMesh*>(loader->CommitToVRAM());
                        m_resources[_name] = mesh;
                    }
                });
            });
        }
    }
    return mesh;
}

