//
//  iGaiaLoadCallback.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol iGaiaResource;
@protocol iGaiaLoadCallback <NSObject>

- (void)onLoad:(id<iGaiaResource>)resource;

@end
