//
//  iGaiaSquirrelCommon.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <squirrel.h>

@interface iGaiaSquirrelCommon : NSObject

+ (iGaiaSquirrelCommon*)sharedInstance;

- (void)registerTable:(NSString*)t_name;
- (void)registerClass:(NSString*)c_name;
- (void)registerFunction:(SQFUNCTION)function withName:(NSString*)f_name forClass:(NSString*)c_name;

- (BOOL)loadScriptWithFileName:(NSString*)name;

- (SQBool)callFunctionWithName:(NSString*)name withParams:(SQFloat[])params withCount:(NSUInteger)count;

- (void)popVector3dX:(SQFloat*)x Y:(SQFloat*)y Z:(SQFloat*)z forIndex:(NSInteger)index;
- (void)pushVector3dX:(SQFloat)x Y:(SQFloat)y Z:(SQFloat)z;

@end
