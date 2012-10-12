//
//  iGaiaTouchCrosser.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaTouchCrosser.h"

#import <glm/glm.hpp>
#import <glm/gtc/type_precision.hpp>
#import <glm/gtc/matrix_transform.hpp>
#import "iGaiaLogger.h"

@interface iGaiaTouchCrosser()

@property(nonatomic, strong) NSMutableSet* m_listeners;
@property(nonatomic, assign) glm::vec3 m_rayDirection;
@property(nonatomic, assign) glm::vec3 m_rayOrigin;

@end

@implementation iGaiaTouchCrosser

@synthesize m_camera = _m_camera;
@synthesize m_listeners = _m_listeners;
@synthesize m_rayDirection = _m_rayDirection;
@synthesize m_rayOrigin = _m_rayOrigin;

- (id)init
{
    self = [super init];
    if(self)
    {
        _m_listeners = [NSMutableSet new];
    }
    return self;
}

- (void)unproject:(const glm::vec2&)vector
{
    glm::mat4x4 projection = _m_camera.m_projection;
    CGRect viewport = [[UIScreen mainScreen] bounds];
    float screenX =  -((( 2.0f * vector.x ) / viewport.size.width) - 1.0f ) / projection[0][0];
    float screenY =  -((( 2.0f * vector.y ) / viewport.size.height) - 1.0f ) / projection[1][1];
    glm::mat4x4 inverseView = glm::inverse(_m_camera.m_view);

    _m_rayDirection.x  = (screenX * inverseView[0][0] + screenY * inverseView[1][0] + inverseView[2][0]);
    _m_rayDirection.y  = (screenX * inverseView[0][1] + screenY * inverseView[1][1] + inverseView[2][1]);
    _m_rayDirection.z  = (screenX * inverseView[0][2] + screenY * inverseView[1][2] + inverseView[2][2]);
    _m_rayOrigin.x = inverseView[3][0];
    _m_rayOrigin.y = inverseView[3][1];
    _m_rayOrigin.z = inverseView[3][2];
}

- (BOOL)isCrossWithVertexBufferObject:(iGaiaVertexBufferObject*)vertexBuffer withIndexBufferObject:(iGaiaIndexBufferObject*)indexBuffer;
{
    iGaiaVertex* vertexData = [vertexBuffer lock];
    unsigned short* indexData = [indexBuffer lock];
    for(NSUInteger i = 0; i < indexBuffer.m_numIndexes; i += 3)
    {
        glm::vec3 point_01 = vertexData[indexData[i + 0]].m_position;
        glm::vec3 point_02 = vertexData[indexData[i + 1]].m_position;
        glm::vec3 point_03 = vertexData[indexData[i + 2]].m_position;

        glm::vec3 edge_01 = point_02 - point_01;
        glm::vec3 edge_02 = point_03 - point_01;

        glm::vec3 p_vector = glm::cross(_m_rayDirection, edge_02);
        float determinant = glm::dot(edge_01, p_vector);
        if(fabs(determinant) < 0.0001f)
        {
            continue;
        }

        float inverseDeterminant = 1.0f / determinant;

        glm::vec3 t_vector = _m_rayOrigin - point_01;
        float u = glm::dot(t_vector, p_vector) * inverseDeterminant;
        if(u < -0.0001f || u > 1.0001f)
        {
            continue;
        }

        glm::vec3 q_vector = glm::cross(t_vector, edge_01);
        float v = glm::dot(_m_rayDirection, q_vector) * inverseDeterminant;
        if(v < -0.0001f || (v + u) > 1.0001f)
        {
            continue;
        }

        glm::vec3 crossPoint = point_01 + (edge_01 * u) + (edge_02 * v);
        iGaiaLog(@"Cross Point : x :%f, y :%f, z :%f", crossPoint.x, crossPoint.y, crossPoint.z);
        return YES;
    }
    return NO;
}

- (void)addEventListener:(id<iGaiaCrossCallback>)listener
{
    [_m_listeners addObject:listener];
}

- (void)removeEventListener:(id<iGaiaCrossCallback>)listener
{
    [_m_listeners removeObject:listener];
}

- (void)onTouchX:(float)x Y:(float)y
{
    [self unproject:glm::vec2(x,y)];

    for(id<iGaiaCrossCallback> listener in _m_listeners)
    {
        if([self isCrossWithVertexBufferObject:listener.m_crossOperationVertexBuffer withIndexBufferObject:listener.m_crossOperationIndexBuffer]);
        {
            [listener onCross];
        }
    }
}

@end
