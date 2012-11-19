//
//  iGaiaLoader.c
//  iGaiaCore
//
//  Created by Sergey Sergeev on 11/7/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaLoader.h"

iGaiaLoader::iGaia_E_LoadStatus iGaiaLoader::Get_Status(void)
{
    return m_status;
}

string iGaiaLoader::Get_Name(void)
{
    return m_name;
}

void iGaiaLoader::AddEventListener(iGaiaLoadCallback *_listener)
{
    m_listeners.insert(_listener);
}

void iGaiaLoader::RemoveEventListener(iGaiaLoadCallback *_listener)
{
    m_listeners.erase(_listener);
}


