//
//  iGaiaCoreWorldSpaceRenderState.h
//  iGaiaCoreRenderMgr
//
//  Created by Sergey Sergeev on 9/25/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "iGaiaCoreCommunicator.h"

@interface iGaiaCoreWorldSpaceRenderState : NSObject

@property(nonatomic, readonly) iGaiaCoreTextureObjectRule texture;

- (id)initWithSize:(CGSize)size;
- (void)bind;
- (void)unbind;

@end
