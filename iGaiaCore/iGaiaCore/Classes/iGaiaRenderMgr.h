//
//  iGaiaRenderMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "iGaiaRenderCallback.h"
#import "iGaiaShader.h"
#import "iGaiaTexture.h"

@interface iGaiaRenderMgr : NSObject

@property(nonatomic, readonly) UIView* m_glView;

+ (iGaiaRenderMgr *)sharedInstance;

- (UIView*)createViewWithFrame:(CGRect)frame;

- (void)addEventListener:(id<iGaiaRenderCallback>)listener forRendeMode:(E_RENDER_MODE_WORLD_SPACE)mode;

- (iGaiaTexture*)retriveTextureFromWorldSpaceRenderMode:(E_RENDER_MODE_WORLD_SPACE)mode;
- (iGaiaTexture*)retriveTextureFromScreenSpaceRenderMode:(E_RENDER_MODE_SCREEN_SPACE)mode;

@end
