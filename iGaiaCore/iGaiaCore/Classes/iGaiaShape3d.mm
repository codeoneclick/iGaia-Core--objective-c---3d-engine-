//
//  iGaiaShape3d.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaShape3d.h"
#import "iGaiaLogger.h"
#import "iGaiaResourceMgr.h"

static NSInteger k_IGAIA_SHAPE3D_RENDER_PRIORITY = 5;

@interface iGaiaShape3d()

@end

@implementation iGaiaShape3d

- (id)initWithMeshFileName:(NSString *)name
{
    self = [super init];
    if(self)
    {
        [[iGaiaResourceMgr sharedInstance] loadResourceAsyncWithName:name withListener:self];

        [_m_material invalidateState:E_RENDER_STATE_CULL_MODE withValue:YES];
        [_m_material invalidateState:E_RENDER_STATE_DEPTH_MASK withValue:YES];
        [_m_material invalidateState:E_RENDER_STATE_DEPTH_TEST withValue:YES];
        [_m_material invalidateState:E_RENDER_STATE_BLEND_MODE withValue:YES];
        _m_material.m_cullFaceMode = GL_FRONT;
        _m_material.m_blendFunctionSource = GL_SRC_ALPHA;
        _m_material.m_blendFunctionDest = GL_ONE_MINUS_SRC_ALPHA;

        _m_priority = k_IGAIA_SHAPE3D_RENDER_PRIORITY;
        _m_updateMode = E_UPDATE_MODE_ASYNC;
    }
    return self;
}

- (void)setShader:(E_SHADER)shader forMode:(NSUInteger)mode
{
    [super setShader:shader forMode:mode];
}

- (void)setTextureWithFaleName:(NSString *)name forSlot:(E_TEXTURE_SLOT)slot withWrap:(NSString*)wrap
{
    [super setTextureWithFileName:name forSlot:slot withWrap:wrap];
}

- (void)setMeshWithFileName:(NSString *)name;
{
    if(_m_mesh == nil)
    {
        [[iGaiaResourceMgr sharedInstance] loadResourceAsyncWithName:name withListener:self];
    }
    else
    {
        iGaiaLog(@"Mesh is not nil");
    }
}

- (void)setClipping:(glm::vec4)clipping
{
    _m_material.m_clipping = clipping;
}

- (void)onLoad:(id<iGaiaResource>)resource
{
    if(resource.m_resourceType == E_RESOURCE_TYPE_MESH)
    {
        iGaiaMesh* mesh = resource;
        _m_mesh = mesh;
    }
}

- (void)onUpdate
{
    [super onUpdate];
}

- (void)onDrawWithRenderMode:(E_RENDER_MODE_WORLD_SPACE)mode
{
    [super onDrawWithRenderMode:mode];
    
    [_m_material bindWithMode:mode];
    
    switch (mode)
    {
        case E_RENDER_MODE_WORLD_SPACE_SIMPLE:
        {
            if(_m_material.m_shader == nil)
            {
                iGaiaLog(@"Shader MODE_SIMPLE == nil");
            }
            
            [_m_material.m_shader setMatrix4x4:_m_worldMatrix forAttribute:E_ATTRIBUTE_MATRIX_WORLD];
            [_m_material.m_shader setMatrix4x4:_m_camera.m_projection forAttribute:E_ATTRIBUTE_MATRIX_PROJECTION];
            [_m_material.m_shader setMatrix4x4:_m_camera.m_view forAttribute:E_ATTRIBUTE_MATRIX_VIEW];
            
            [_m_material.m_shader setVector3:_m_camera.m_position forAttribute:E_ATTRIBUTE_VECTOR_CAMERA_POSITION];
            [_m_material.m_shader setVector3:_m_light.m_position forAttribute:E_ATTRIBUTE_VECTOR_LIGHT_POSITION];
        }
            break;
        case E_RENDER_MODE_WORLD_SPACE_REFLECTION:
        {
            if(_m_material.m_shader == nil)
            {
                iGaiaLog(@"Shader MODE_REFLECTION == nil");
            }

            [_m_material.m_shader setMatrix4x4:_m_worldMatrix forAttribute:E_ATTRIBUTE_MATRIX_WORLD];
            [_m_material.m_shader setMatrix4x4:_m_camera.m_projection forAttribute:E_ATTRIBUTE_MATRIX_PROJECTION];
            [_m_material.m_shader setMatrix4x4:_m_camera.m_reflection forAttribute:E_ATTRIBUTE_MATRIX_VIEW];

            [_m_material.m_shader setVector3:_m_camera.m_position forAttribute:E_ATTRIBUTE_VECTOR_CAMERA_POSITION];
            [_m_material.m_shader setVector3:_m_light.m_position forAttribute:E_ATTRIBUTE_VECTOR_LIGHT_POSITION];
            glm::vec4 clipping = _m_material.m_clipping;
            [_m_material.m_shader setVector4:clipping forAttribute:E_ATTRIBUTE_VECTOR_CLIPPING];
        }
            break;
        case E_RENDER_MODE_WORLD_SPACE_REFRACTION:
        {
            if(_m_material.m_shader == nil)
            {
                iGaiaLog(@"Shader MODE_REFRACTION == nil");
            }

            [_m_material.m_shader setMatrix4x4:_m_worldMatrix forAttribute:E_ATTRIBUTE_MATRIX_WORLD];
            [_m_material.m_shader setMatrix4x4:_m_camera.m_projection forAttribute:E_ATTRIBUTE_MATRIX_PROJECTION];
            [_m_material.m_shader setMatrix4x4:_m_camera.m_view forAttribute:E_ATTRIBUTE_MATRIX_VIEW];

            [_m_material.m_shader setVector3:_m_camera.m_position forAttribute:E_ATTRIBUTE_VECTOR_CAMERA_POSITION];
            [_m_material.m_shader setVector3:_m_light.m_position forAttribute:E_ATTRIBUTE_VECTOR_LIGHT_POSITION];
            glm::vec4 clipping = _m_material.m_clipping;
            clipping.y *= -1.0f;
            [_m_material.m_shader setVector4:clipping forAttribute:E_ATTRIBUTE_VECTOR_CLIPPING];
        }
            break;
        case E_RENDER_MODE_WORLD_SPACE_SCREEN_NORMAL_MAP:
        {
        }
            break;
        default:
            break;
    }
    
    [_m_mesh bind];

    glDrawElements(GL_TRIANGLES, _m_mesh.m_numIndexes, GL_UNSIGNED_SHORT, (void*)NULL);

    [_m_mesh unbind];

    [_m_material unbindWithMode:mode];
}

@end
