//
//  iGaiaTextureMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#import "iGaiaTexture.h"

@interface iGaiaTextureMgr : NSObject

+ (iGaiaTextureMgr*)sharedInstance;

- (iGaiaTexture*)getTextureWithName:(NSString*)name;
- (void)removeTextureWithName:(NSString*)name;

@end
