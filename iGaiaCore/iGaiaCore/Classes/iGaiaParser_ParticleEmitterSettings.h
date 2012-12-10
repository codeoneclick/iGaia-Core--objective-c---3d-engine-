//
//  iGaiaParser_ParticleEmitterSettings.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/10/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaCommon.h"
#include "iGaiaParticleEmitter.h"

class iGaiaParser_ParticleEmitterSettings
{
private:

protected:

public:
    
    iGaiaParser_ParticleEmitterSettings(void);
    ~iGaiaParser_ParticleEmitterSettings(void);

    iGaiaParticleEmitter::iGaiaParticleEmitterSettings Get_Settings(const string& _name);
    
};

