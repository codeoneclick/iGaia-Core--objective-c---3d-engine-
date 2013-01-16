//
//  iGaiaParser_ParticleEmitterSettings.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/10/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaCommon.h"
#include "iGaiaParser_Object3dSettings.h"

class iGaiaParser_ParticleEmitterSettings
{
private:

protected:
    iGaiaParser_Object3dSettings m_parserObject3d;
public:
    
    iGaiaParser_ParticleEmitterSettings(void);
    ~iGaiaParser_ParticleEmitterSettings(void);

    iGaiaSettingsProvider::ParticleEmitterSettings DeserializeSettings(string const& _name);
    
};

