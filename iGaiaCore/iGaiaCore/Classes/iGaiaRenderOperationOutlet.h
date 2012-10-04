//
//  iGaiaRenderOperationOutlet.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <glm/glm.hpp>
#import <glm/gtc/type_precision.hpp>

#import "iGaiaMaterial.h"
#import "iGaiaRenderListener.h"

@interface iGaiaRenderOperationOutlet : NSObject

@property(nonatomic, readonly) iGaiaMaterial* m_material;

- (id)initWithSize:(glm::vec2)size withShaderName:(E_SHADER)shader withFrameBufferHandle:(NSUInteger)frameBufferHandle withRenderBufferHandle:(NSUInteger)renderBufferHandle;

- (void)bind;
- (void)unbind;

- (void)draw;

@end
