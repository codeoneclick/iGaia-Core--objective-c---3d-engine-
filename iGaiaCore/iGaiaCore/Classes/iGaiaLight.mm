//
//  iGaiaLight.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaLight.h"

iGaiaLight::iGaiaLight(void)
{
    
}

iGaiaLight::~iGaiaLight(void)
{
    
}

void iGaiaLight::Set_Position(const vec3 &_position)
{
    m_position = _position;
}

vec3 iGaiaLight::Get_Position(void)
{
    return m_position;
}
