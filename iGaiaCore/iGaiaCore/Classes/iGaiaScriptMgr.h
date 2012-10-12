//
//  iGaiaScriptMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/10/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <squirrel.h>

@interface iGaiaScriptMgr : NSObject

- (BOOL)loadScriptWithFileName:(NSString*)name;

@end
