//
//  iGaiaResourceLoadListener.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol iGaiaResource;
@protocol iGaiaResourceLoadListener <NSObject>

- (void)onResourceLoad:(id<iGaiaResource>)resource;

@end
