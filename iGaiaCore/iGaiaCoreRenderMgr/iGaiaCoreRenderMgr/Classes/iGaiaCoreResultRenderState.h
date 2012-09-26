//
//  iGaiaCoreResultRenderState.h
//  iGaiaCoreRenderMgr
//
//  Created by Sergey Sergeev on 9/26/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "iGaiaCoreCommunicator.h"

@interface iGaiaCoreResultRenderState : NSObject

- (id)initWithSize:(CGSize)size withShaderName:(NSString*)shaderName withFrameBufferHandle:(NSUInteger)frameBufferHandle withRenderBufferHandle:(NSUInteger)renderBufferHandle;
- (void)bindWithOriginTexture:(iGaiaCoreTextureObjectRule)texture;
- (void)draw;
- (void)unbind;

@end
