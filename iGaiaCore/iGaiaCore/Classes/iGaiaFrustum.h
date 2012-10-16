//
//  iGaiaFrustum.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <glm/glm.hpp>
#import <glm/gtc/type_precision.hpp>
#import <glm/gtc/matrix_transform.hpp>

enum E_FRUSTUM_RESULT
{
    E_FRUSTUM_RESULT_OUTSIDE = 0,
    E_FRUSTUM_RESULT_INTERSECT,
    E_FRUSTUM_RESULT_INSIDE
};

@interface iGaiaFrustum : NSObject

- (id)initWithCamera:(id)camera;
- (void)onUpdate;
- (int)isPointInFrustum:(const glm::vec3 &)point;
- (int)isSphereInFrustum:(const glm::vec3&)position withRadius:(float)radius;
- (int)isBoundBoxInFrustumWithMaxBound:(const glm::vec3&)maxBound withMinBound:(const glm::vec3&)minBound;

@end
