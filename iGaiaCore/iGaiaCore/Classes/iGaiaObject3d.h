//
//  iGaiaObject3d.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <glm/glm.hpp>
#import <glm/gtc/type_precision.hpp>

#import "iGaiaMaterial.h"
#import "iGaiaMesh.h"

#import "iGaiaRenderListener.h"
#import "iGaiaResourceLoadListener.h"

@protocol iGaiaObject3d <iGaiaRenderListener, iGaiaResourceLoadListener>

@property(nonatomic, assign) glm::vec3 m_position;
@property(nonatomic, assign) glm::vec3 m_rotation;
@property(nonatomic, assign) glm::vec3 m_scale;

@property(nonatomic, readonly) glm::vec3 m_maxBound;
@property(nonatomic, readonly) glm::vec3 m_minBound;

- (void)setShader:(E_SHADER)shader;
- (void)setTexture:(NSString*)texture forSlot:(E_TEXTURE_SLOT)slot;

- (void)onUpdate;

@optional

- (void)setMesh:(NSString*)mesh;

@end
