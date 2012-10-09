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
#import <glm/gtc/matrix_transform.hpp>

#import "iGaiaMaterial.h"
#import "iGaiaMesh.h"

#import "iGaiaCamera.h"
#import "iGaiaLight.h"

#import "iGaiaUpdateCallback.h"
#import "iGaiaRenderCallback.h"
#import "iGaiaLoadCallback.h"

@interface iGaiaObject3d : NSObject<iGaiaUpdateCallback, iGaiaRenderCallback, iGaiaLoadCallback>
{
@protected
    enum E_UPDATE_MODE
    {
        E_UPDATE_MODE_SYNC = 0,
        E_UPDATE_MODE_ASYNC
    };

    glm::mat4x4 _m_worldMatrix;
    
    iGaiaMaterial* _m_material;
    iGaiaMesh* _m_mesh;
    
    glm::vec3 _m_position;
    glm::vec3 _m_rotation;
    glm::vec3 _m_scale;
    
    glm::vec3 _m_maxBound;
    glm::vec3 _m_minBound;
    
    __unsafe_unretained iGaiaCamera* _m_camera;
    __unsafe_unretained iGaiaLight* _m_light;
    
    NSUInteger _m_priority;
    E_UPDATE_MODE _m_updateMode;
}

@property(nonatomic, assign) glm::vec3 m_position;
@property(nonatomic, assign) glm::vec3 m_rotation;
@property(nonatomic, assign) glm::vec3 m_scale;

@property(nonatomic, readonly) glm::vec3 m_maxBound;
@property(nonatomic, readonly) glm::vec3 m_minBound;

@property(nonatomic, assign) iGaiaCamera* m_camera;
@property(nonatomic, assign) iGaiaLight* m_light;

- (void)setShader:(E_SHADER)shader forMode:(NSUInteger)mode;
- (void)setTextureWithFileName:(NSString *)name forSlot:(E_TEXTURE_SLOT)slot withWrap:(NSString*)wrap;

@end
