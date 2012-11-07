//
//  iGaiaLoader.c
//  iGaiaCore
//
//  Created by Sergey Sergeev on 11/7/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaLoader.h"

inline iGaiaLoader::iGaia_E_LoadStatus iGaiaLoader::Get_Status(void)
{
    return m_status;
}

inline string iGaiaLoader::Get_Name(void)
{
    return m_name;
}

inline void iGaiaLoader::AddEventListener(iGaiaLoadCallback *_listener)
{
    m_listeners.insert(_listener);
}

inline void iGaiaLoader::RemoveEventListener(iGaiaLoadCallback *_listener)
{
    m_listeners.erase(_listener);
}


