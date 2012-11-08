//
//  iGaiaResourceMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaResourceMgr.h"

#import "iGaiaTextureMgr.h"
#import "iGaiaMeshMgr.h"

extern const struct iGaiaResourceExtensions
{
    string pvr;
    string mdl;
    
} iGaiaResourceExtensions;

const struct iGaiaResourceExtensions iGaiaResourceExtensions =
{
    .pvr = ".pvr",
    .mdl = ".mdl",
};

iGaiaResourceMgr::iGaiaResourceMgr(void)
{
    m_textureMgr = new iGaiaTextureMgr();
    m_meshMgr = new iGaiaMeshMgr();
}

iGaiaResourceMgr::~iGaiaResourceMgr(void)
{

}

iGaiaResourceMgr* iGaiaResourceMgr::SharedInstance(void)
{
    static iGaiaResourceMgr *instance = nullptr;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        instance = new iGaiaResourceMgr();
    });
    return instance;
}

iGaiaResource* iGaiaResourceMgr::LoadResourceSync(const string &_name)
{
    size_t found = _name.find(iGaiaResourceExtensions.pvr);
    if(found != string::npos)
    {
        return m_textureMgr->LoadResourceSync(_name);
    }

    found = _name.find(iGaiaResourceExtensions.mdl);
    if(found != string::npos)
    {
        return m_meshMgr->LoadResourceSync(_name);
    }
    return nullptr;
}

iGaiaResource* iGaiaResourceMgr::LoadResourceAsync(const string &_name, iGaiaLoadCallback *_listener)
{
    size_t found = _name.find(iGaiaResourceExtensions.pvr);
    if(found != string::npos)
    {
        return m_textureMgr->LoadResourceAsync(_name, _listener);
    }

    found = _name.find(iGaiaResourceExtensions.mdl);
    if(found != string::npos)
    {
        return m_meshMgr->LoadResourceAsync(_name, _listener);
    }
    return nullptr;
}


