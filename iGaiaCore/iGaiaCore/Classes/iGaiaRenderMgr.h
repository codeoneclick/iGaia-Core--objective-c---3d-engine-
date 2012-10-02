//
//  iGaiaRenderMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "iGaiaRenderListener.h"
#import "iGaiaShader.h"

@interface iGaiaRenderMgr : NSObject

@property(nonatomic, assign) iGaiaShader* m_activeShader;

+ (iGaiaRenderMgr *)sharedInstance;

- (UIView*)createViewWithFrame:(CGRect)frame;

- (void)addEventListener:(id<iGaiaRenderListener>)listener forRendeMode:(E_RENDER_MODE_WORLD_SPACE)renderMode;

@end
