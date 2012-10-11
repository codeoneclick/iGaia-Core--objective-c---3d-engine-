//
//  iGaiaOcean.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaOcean.h"
#import "iGaiaLogger.h"
#import "iGaiaRenderMgr.h"

static NSInteger k_IGAIA_OCEAN_RENDER_PRIORITY = 6;

@implementation iGaiaOcean

- (id)initWithWidth:(float)witdh withHeight:(float)height withAltitude:(float)altitude;
{
    self = [super init];
    {
        iGaiaVertexBufferObject* vertexBuffer = [[iGaiaVertexBufferObject alloc] initWithNumVertexes:24 withMode:GL_STATIC_DRAW];
        iGaiaVertex* vertexData = [vertexBuffer lock];

        vertexData[0].m_position = glm::vec3(0.0f,  altitude,  0.0f);
        vertexData[1].m_position = glm::vec3(witdh, altitude,  0.0f);
        vertexData[2].m_position = glm::vec3(witdh, altitude,  height);
        vertexData[3].m_position = glm::vec3(0.0f,  altitude,  height);

        vertexData[0].m_texcoord = glm::vec2(0.0f,  0.0f);
        vertexData[1].m_texcoord = glm::vec2(1.0f,  0.0f);
        vertexData[2].m_texcoord = glm::vec2(1.0f,  1.0f);
        vertexData[3].m_texcoord = glm::vec2(0.0f,  1.0f);

        [vertexBuffer unlock];

        iGaiaIndexBufferObject* indexBuffer = [[iGaiaIndexBufferObject alloc] initWithNumIndexes:36 withMode:GL_STATIC_DRAW];
        unsigned short* indexData = [indexBuffer lock];

        indexData[0] = 0;
        indexData[1] = 1;
        indexData[2] = 2;
        indexData[3] = 0;
        indexData[4] = 2;
        indexData[5] = 3;

        [indexBuffer unlock];

        _m_mesh = [[iGaiaMesh alloc] initWithVertexBuffer:vertexBuffer withIndexBuffer:indexBuffer withName:@"igaia.mesh.ocean" withCreationMode:E_CREATION_MODE_CUSTOM];

        [_m_material invalidateState:E_RENDER_STATE_CULL_MODE withValue:YES];
        [_m_material invalidateState:E_RENDER_STATE_DEPTH_MASK withValue:YES];
        [_m_material invalidateState:E_RENDER_STATE_DEPTH_TEST withValue:YES];
        [_m_material invalidateState:E_RENDER_STATE_BLEND_MODE withValue:YES];
        _m_material.m_cullFaceMode = GL_FRONT;
        _m_material.m_blendFunctionSource = GL_SRC_ALPHA;
        _m_material.m_blendFunctionDest = GL_ONE_MINUS_SRC_ALPHA;

        _m_priority = k_IGAIA_OCEAN_RENDER_PRIORITY;
        _m_updateMode = E_UPDATE_MODE_SYNC;
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

- (void)onUpdate
{
    [_m_material setTexture:[[iGaiaRenderMgr sharedInstance] retriveTextureFromWorldSpaceRenderMode:E_RENDER_MODE_WORLD_SPACE_REFLECTION] forSlot:E_TEXTURE_SLOT_01];
    [_m_material setTexture:[[iGaiaRenderMgr sharedInstance] retriveTextureFromWorldSpaceRenderMode:E_RENDER_MODE_WORLD_SPACE_REFRACTION] forSlot:E_TEXTURE_SLOT_02];
    [super onUpdate];
}

- (void)onDrawWithRenderMode:(E_RENDER_MODE_WORLD_SPACE)mode
{
    if(_m_mesh.m_numIndexes == 0)
    {
        iGaiaLog(@"Draw mesh with name %@ failure.Reason -> zero index data.",_m_mesh.m_name);
        return;
    }
    
    [super onDrawWithRenderMode:mode];

    [_m_material bindWithMode:mode];

    switch (mode)
    {
        case E_RENDER_MODE_WORLD_SPACE_SIMPLE:
        {
            if(_m_material.m_shader == nil)
            {
                iGaiaLog(@"Shader MODE_SIMPLE == nil.");
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
        }
            break;
        case E_RENDER_MODE_WORLD_SPACE_REFRACTION:
        {
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
