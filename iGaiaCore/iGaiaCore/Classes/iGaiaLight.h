//
//  iGaiaLight.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaLightClass
#define iGaiaLightClass

#include "iGaiaCommon.h"

class iGaiaLight
{
private:
    vec3 m_position;
protected:
    
public:
    iGaiaLight(void);
    ~iGaiaLight(void);
    
    void Set_Position(const vec3& _position);
    vec3 Get_Position(void);
};

#endif