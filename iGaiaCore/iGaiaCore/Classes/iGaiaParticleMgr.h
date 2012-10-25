//
//  iGaiaParticleMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaParticleEmitter.h"

@interface iGaiaParticleMgr : NSObject

@property(nonatomic, assign) iGaiaCamera* m_camera;

- (iGaiaParticleEmitter*)createParticleEmitterFromFile:(NSString*)name;
- (void)removeParticleEmitter:(iGaiaParticleEmitter*)emitter;

- (void)onUpdate;

@end
