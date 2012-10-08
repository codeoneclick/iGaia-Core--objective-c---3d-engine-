//
//  iGaiaMeshMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaResource.h"

@protocol iGaiaLoadCallback;
@interface iGaiaMeshMgr : NSObject

- (id<iGaiaResource>)loadResourceSyncWithName:(NSString*)name;
- (id<iGaiaResource>)loadResourceAsyncWithName:(NSString*)name withListener:(id<iGaiaLoadCallback>)listener;

@end
