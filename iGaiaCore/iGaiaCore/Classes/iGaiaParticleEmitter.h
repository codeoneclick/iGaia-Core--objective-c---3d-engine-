//
//  iGaiaParticleEmitter.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaObject3d.h"
#import "iGaiaParticleEmitterSettings.h"

@interface iGaiaParticleEmitter : iGaiaObject3d

- (id)initWithSettings:(id<iGaiaParticleEmitterSettings>)settings;

@end
