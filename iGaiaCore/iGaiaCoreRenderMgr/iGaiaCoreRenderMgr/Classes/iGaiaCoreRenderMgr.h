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


extern const struct iGaiaCoreWorldSpaceRenderMode
{
    NSString *simple;
    NSString *reflection;
    NSString *refraction;
    NSString *screenNormalMapping;

} iGaiaCoreWorldSpaceRenderMode;

extern const struct iGaiaCoreScreenSpaceRenderMode
{
    NSString *simple;
    NSString *blur;
    NSString *bloom;
    NSString *edgeDetect;
    NSString *sepia;

} iGaiaCoreScreenSpaceRenderMode;

@protocol iGaiaCoreRenderViewProtocol, iGaiaCoreTextureProtocol, iGaiaCoreShaderProtocol;
@interface iGaiaCoreRenderMgr : NSObject

+ (iGaiaCoreRenderMgr*)sharedInstance;
- (UIView*)createViewWithFrame:(CGRect)frame withOwner:(id<iGaiaCoreRenderViewProtocol>)owner;
- (void)addRenderNodeWithOwner:(id<iGaiaCoreRenderProtocol>)owner forRenderState:(NSString*)renderState;

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
