//
//  iGaiaMeshMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#import "iGaiaMesh.h"

@interface iGaiaMeshMgr : NSObject

+ (iGaiaMeshMgr*)sharedInstance;

- (iGaiaMesh*)getMeshWithName:(NSString*)name;
- (void)removeMeshWithName:(NSString*)name;

@end
