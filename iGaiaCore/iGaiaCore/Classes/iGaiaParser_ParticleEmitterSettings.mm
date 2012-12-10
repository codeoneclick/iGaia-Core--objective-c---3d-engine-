//
//  iGaiaParser_ParticleEmitterSettings.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/10/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaParser_ParticleEmitterSettings.h"

iGaiaParser_ParticleEmitterSettings::iGaiaParser_ParticleEmitterSettings(void)
{
    
}

iGaiaParser_ParticleEmitterSettings::~iGaiaParser_ParticleEmitterSettings(void)
{

}

iGaiaParticleEmitter::iGaiaParticleEmitterSettings iGaiaParser_ParticleEmitterSettings::Get_Settings(const string &_name)
{
    xml_document document;
    xml_parse_result result = document.load_file(_name.c_str());
    std::cout << "Load result: " << result.description() << ", mesh name: " << document.child("mesh").attribute("name").value() << std::endl;
}