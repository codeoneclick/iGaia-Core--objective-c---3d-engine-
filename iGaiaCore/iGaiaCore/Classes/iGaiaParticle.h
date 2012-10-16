//
//  iGaiaParticle.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <glm/glm.hpp>
#import <glm/gtc/type_precision.hpp>
#import <glm/gtc/matrix_transform.hpp>

@interface iGaiaParticle : NSObject

@property(nonatomic, assign) glm::vec3 m_position;
@property(nonatomic, assign) glm::vec3 m_velocity;
@property(nonatomic, assign) glm::vec2 m_size;
@property(nonatomic, assign) glm::vec4 m_color;
@property(nonatomic, assign) float m_lifetime;

@end
