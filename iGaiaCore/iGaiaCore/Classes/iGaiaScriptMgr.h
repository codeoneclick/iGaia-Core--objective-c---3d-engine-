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

@interface iGaiaScriptMgr : NSObject

@property(nonatomic, readonly) iGaiaSquirrelCommon* m_commonWrapper;
@property(nonatomic, readonly) iGaiaSquirrelRuntime* m_runtimeWrapper;
@property(nonatomic, readonly) iGaiaSquirrelScene* m_sceneWrapper;
@property(nonatomic, readonly) iGaiaSquirrelObject3d* m_object3dWrapper;

- (BOOL)loadScriptWithFileName:(NSString*)name;

@end
