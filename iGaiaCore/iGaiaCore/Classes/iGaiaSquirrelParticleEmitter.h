//
//  iGaiaSquirrelParticleEmitter.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/18/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaSquirrelParticleEmitterClass
#define iGaiaSquirrelParticleEmitterClass

#import "iGaiaSquirrelCommon.h"

class iGaiaSquirrelParticleEmitter
{
private:
    iGaiaSquirrelCommon* m_commonWrapper;
    void Bind(void);
protected:

public:
    iGaiaSquirrelParticleEmitter(iGaiaSquirrelCommon* _commonWrapper);
    ~iGaiaSquirrelParticleEmitter(void);
};

#endif