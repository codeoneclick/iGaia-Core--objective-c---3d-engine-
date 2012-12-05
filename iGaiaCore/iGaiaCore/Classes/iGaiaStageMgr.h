//
//  iGaiaStageMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaCamera.h"
#import "iGaiaLight.h"
#import "iGaiaShape3d.h"
#import "iGaiaBillboard.h"
#import "iGaiaOcean.h"
#import "iGaiaSkyDome.h"
#import "iGaiaScriptMgr.h"
#import "iGaiaTouchMgr.h"
#import "iGaiaRenderMgr.h"
#import "iGaiaParticleMgr.h"
#import "iGaiaSoundMgr.h"

@interface iGaiaStageMgr : NSObject

@property(nonatomic, readonly) iGaiaRenderMgr* m_renderMgr;
@property(nonatomic, readonly) iGaiaScriptMgr* m_scriptMgr;
@property(nonatomic, readonly) iGaiaTouchMgr* m_touchMgr;
@property(nonatomic, readonly) iGaiaParticleMgr* m_particleMgr;
@property(nonatomic, readonly) iGaiaSoundMgr* m_soundMgr;

+ (iGaiaStageMgr *)sharedInstance;

- (iGaiaCamera*)createCameraWithFov:(float)fov withNear:(float)near withFar:(float)far forScreenWidth:(NSUInteger)width forScreenHeight:(NSUInteger)height;
- (iGaiaLight*)createLight;
- (iGaiaShape3d*)createShape3dWithFileName:(NSString*)name;
- (iGaiaOcean*)createOceanWithWidth:(float)witdh withHeight:(float)height withAltitude:(float)altitude;
- (iGaiaSkyDome*)createSkyDome;

@end
