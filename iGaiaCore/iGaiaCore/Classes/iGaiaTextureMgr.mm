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

iGaiaTexture* iGaiaTextureMgr::Get_Texture(const string &_name)
{
    iGaiaTexture* texture = nullptr;
    if(m_textures.find(_name) != m_textures.end())
    {
        texture = m_textures.find(_name)->second;
        texture->IncReferenceCount();
    }
    else
    {
        iGaiaLoader_PVR* loader = new iGaiaLoader_PVR();
        loader->ParseFileWithName(_name);
        if(loader->Get_Status() == iGaiaLoader::iGaia_E_LoadStatusDone)
        {
            texture = static_cast<iGaiaTexture*>(loader->CommitToVRAM());
            m_textures[_name] = texture;
            texture->IncReferenceCount();
        }
    }
    return texture;
}

