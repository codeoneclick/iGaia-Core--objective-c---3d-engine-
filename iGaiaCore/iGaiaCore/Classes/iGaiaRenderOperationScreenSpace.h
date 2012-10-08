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

#import "iGaiaMaterial.h"
#import "iGaiaRenderCallback.h"

@interface iGaiaRenderOperationScreenSpace : NSObject

@property(nonatomic, readonly) iGaiaTexture* m_externalTexture;
@property(nonatomic, readonly) iGaiaMaterial* m_material;

- (id)initWithSize:(glm::vec2)size withShader:(E_SHADER)shader withName:(NSString*)name;

- (void)bind;
- (void)unbind;

- (void)draw;

@end
