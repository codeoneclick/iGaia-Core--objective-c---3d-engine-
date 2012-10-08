//
//  iGaiaRenderListener.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/2/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

enum E_RENDER_MODE_WORLD_SPACE
{
    E_RENDER_MODE_WORLD_SPACE_SIMPLE = 0,
    E_RENDER_MODE_WORLD_SPACE_REFLECTION,
    E_RENDER_MODE_WORLD_SPACE_REFRACTION,
    E_RENDER_MODE_WORLD_SPACE_SCREEN_NORMAL_MAP,
    E_RENDER_MODE_WORLD_SPACE_MAX
};

enum E_RENDER_MODE_SCREEN_SPACE
{
    E_RENDER_MODE_SCREEN_SPACE_SIMPLE = 0,
    E_RENDER_MODE_SCREEN_SPACE_BLOOM_EXTRACT,
    E_RENDER_MODE_SCREEN_SPACE_BLOOM_COMBINE,
    E_RENDER_MODE_SCREEN_SPACE_BLUR,
    E_RENDER_MODE_SCREEN_SPACE_EDGE_DETECT,
    E_RENDER_MODE_SCREEN_SPACE_MAX
};

@protocol iGaiaRenderCallback <NSObject>

@property(nonatomic, assign) NSUInteger m_priority;

- (void)onDrawWithRenderMode:(E_RENDER_MODE_WORLD_SPACE)mode;

@end
