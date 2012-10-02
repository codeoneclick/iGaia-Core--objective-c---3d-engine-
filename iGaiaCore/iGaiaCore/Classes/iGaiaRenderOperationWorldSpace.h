//
//  iGaiaRenderOperationWorldSpace.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <glm/glm.hpp>
#import <glm/gtc/type_precision.hpp>

#import "iGaiaTexture.h"
#import "iGaiaRenderListener.h"

@interface iGaiaRenderOperationWorldSpace : NSObject

@property(nonatomic, readonly) iGaiaTexture* m_texture;

- (id)initWithSize:(glm::vec2)size forRenderMode:(E_RENDER_MODE_WORLD_SPACE)renderMode withName:(NSString*)name;

- (void)addEventListener:(id<iGaiaRenderListener>)listener;
- (void)removeEventListener:(id<iGaiaRenderListener>)listener;

- (void)bind;
- (void)unbind;

- (void)draw;

@end
