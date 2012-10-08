//
//  iGaiaSceneMgr.h
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

@interface iGaiaSceneMgr : NSObject

+ (iGaiaSceneMgr *)sharedInstance;

- (iGaiaCamera*)createCameraWithFov:(float)fov withNear:(float)near withFar:(float)far forScreenWidth:(NSUInteger)width forScreenHeight:(NSUInteger)height;
- (iGaiaLight*)createLight;
- (iGaiaShape3d*)createShape3dWithFileName:(NSString*)name;
- (iGaiaOcean*)createOceanWithWidth:(float)witdh withHeight:(float)height withAltitude:(float)altitude;
- (iGaiaSkyDome*)createSkyDome;

@end
