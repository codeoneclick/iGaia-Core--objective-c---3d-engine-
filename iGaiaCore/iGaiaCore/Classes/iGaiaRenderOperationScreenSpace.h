//
//  iGaiaRenderOperationScreenSpace.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <glm/glm.hpp>
#import <glm/gtc/type_precision.hpp>

#import "iGaiaTexture.h"
#import "iGaiaShader.h"
#import "iGaiaRenderListener.h"

@interface iGaiaRenderOperationScreenSpace : NSObject

@property(nonatomic, readonly) iGaiaTexture* m_texture;

- (id)initWithSize:(glm::vec2)size withShader:(E_SHADER)shader forRenderMode:(E_RENDER_MODE_SCREEN_SPACE)renderMode withName:(NSString*)name;

- (void)bind;
- (void)unbind;

- (void)draw;

@end
