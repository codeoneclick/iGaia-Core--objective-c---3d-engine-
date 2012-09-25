//
//  iGaiaCoreRenderMgr.h
//  iGaiaCoreRenderMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "iGaiaCoreCommunicator.h"

@protocol iGaiaCoreRenderViewProtocol, iGaiaCoreTextureProtocol, iGaiaCoreShaderProtocol;
@interface iGaiaCoreRenderMgr : NSObject

+ (iGaiaCoreRenderMgr*)sharedInstance;
- (UIView*)createViewWithFrame:(CGRect)frame withOwner:(id<iGaiaCoreRenderViewProtocol>)owner;
- (void)createRelationForObjectOwner:(id<iGaiaCoreRenderProtocol>)owner withRenderState:(NSString*)renderState;


/*
- (void)addWorldSpaceRenderModeWithName:(NSString*)name withFrameSize:(CGSize)size;
- (void)removeWorldSpaceRenderModeWithName:(NSString*)name;

- (void)addScreenSpaceRenderModeWithName:(NSString*)name withFrameSize:(CGSize)size withShader:(id<iGaiaCoreShaderProtocol>)shader;
- (void)removeScreenSpaceRenderModeWithName:(NSString*)name;

- (void)startDrawSurfaceForWorldSpaceRenderModeWithName:(NSString*)name;
- (void)endDrawSurfaceForWorldSpaceRenderModeWithName:(NSString*)name;

- (void)drawSurfaceForScreenSpaceRenderModeWithName:(NSString*)name;

- (void)setDefaultScreenRenderModeWithName:(NSString*)name;

- (id<iGaiaCoreTextureProtocol>)getSurfaceForRenderMode:(NSString*)renderMode;
*/

@end
