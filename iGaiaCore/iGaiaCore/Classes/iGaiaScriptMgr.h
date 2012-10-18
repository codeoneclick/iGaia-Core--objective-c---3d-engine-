//
//  iGaiaScriptMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/10/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <squirrel.h>

#import "iGaiaSquirrelRuntime.h"
#import "iGaiaSquirrelCommon.h"
#import "iGaiaSquirrelScene.h"
#import "iGaiaSquirrelObject3d.h"
#import "iGaiaSquirrelParticleMgr.h"
#import "iGaiaSquirrelParticleEmitter.h"

@interface iGaiaScriptMgr : NSObject

@property(nonatomic, readonly) iGaiaSquirrelCommon* m_commonWrapper;
@property(nonatomic, readonly) iGaiaSquirrelRuntime* m_runtimeWrapper;
@property(nonatomic, readonly) iGaiaSquirrelScene* m_sceneWrapper;
@property(nonatomic, readonly) iGaiaSquirrelObject3d* m_object3dWrapper;
@property(nonatomic, readonly) iGaiaSquirrelParticleMgr* m_particleMgrWrapper;
@property(nonatomic, readonly) iGaiaSquirrelParticleEmitter* m_particleEmitterWrapper;

- (BOOL)loadScriptWithFileName:(NSString*)name;

@end
