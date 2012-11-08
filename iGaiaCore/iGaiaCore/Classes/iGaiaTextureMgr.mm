//
//  iGaiaTextureMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaTextureMgr.h"

iGaiaTextureMgr::iGaiaTextureMgr(void)
{

}

iGaiaTextureMgr::~iGaiaTextureMgr(void)
{
    
}

iGaiaResource* iGaiaTextureMgr::LoadResourceSync(const string &_name)
{
    iGaiaTexture* texture = nullptr;
    if(m_resources.find(_name) != m_resources.end())
    {
        texture = m_resources.find(_name)->second;
    }
    else
    {
        iGaiaLoader_PVR* loader = new iGaiaLoader_PVR();
        loader->ParseFileWithName(_name);
        if(loader->Get_Status() == iGaiaLoader::iGaia_E_LoadStatusDone)
        {
            texture = static_cast<iGaiaTexture*>(loader->CommitToVRAM());
            texture->IncReferenceCount();
            m_resources[_name] = texture;
        }
    }
    return texture;
}

iGaiaResource* iGaiaTextureMgr::LoadResourceAsync(const string &_name, iGaiaLoadCallback *_listener)
{
    iGaiaTexture* texture = nullptr;
    if(m_resources.find(_name) != m_resources.end())
    {
       texture = m_resources.find(_name)->second;
    }
    else
    {
        texture = new  iGaiaTexture(0, 0, 0, _name, iGaiaResource::iGaia_E_CreationModeNative);
        if(m_tasks.find(_name) != m_tasks.end())
        {
            iGaiaLoader_PVR* loader = m_tasks.find(_name)->second;
            loader->AddEventListener(_listener);
        }
        else
        {
            iGaiaLoader_PVR* loader = new iGaiaLoader_PVR();
            m_tasks[_name] = loader;
            loader->AddEventListener(_listener);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
            {
                loader->ParseFileWithName(_name);
                dispatch_async(dispatch_get_main_queue(), ^
                {
                    if(loader->Get_Status() == iGaiaLoader::iGaia_E_LoadStatusDone)
                    {
                        iGaiaTexture* texture = static_cast<iGaiaTexture*>(loader->CommitToVRAM());
                        m_resources[_name] = texture;
                    }
                });
            });
        }
    }
    return texture;
}


