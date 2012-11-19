//
//  iGaiaResource.c
//  iGaiaCore
//
//  Created by Sergey Sergeev on 11/5/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaResource.h"

iGaiaResource::iGaiaResource(void)
{
    m_referencesCount = 0;
    m_creationMode = iGaia_E_CreationModeNative;
    m_resourceType = iGaia_E_ResourceTypeUnknown;
}

inline void iGaiaResource::IncReferenceCount(void)
{
    m_referencesCount++;
}

inline void iGaiaResource::DecReferenceCount(void)
{
    m_referencesCount--;
}

inline i32 iGaiaResource::Get_ReferenceCount(void)
{
    return m_referencesCount;
}

inline string iGaiaResource::Get_Name(void)
{
    return m_name;
}

inline iGaiaResource::iGaia_E_CreationMode iGaiaResource::Get_CreationMode(void)
{
    return m_creationMode;
}

inline iGaiaResource::iGaia_E_ResourceType iGaiaResource::Get_ResourceType(void)
{
    return m_resourceType;
}
