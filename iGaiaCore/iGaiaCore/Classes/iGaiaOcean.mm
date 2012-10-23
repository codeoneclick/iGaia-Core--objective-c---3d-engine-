//
//  iGaiaOcean.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaOcean.h"
#import "iGaiaLogger.h"

static NSInteger k_IGAIA_OCEAN_RENDER_PRIORITY = 6;

@interface iGaiaOcean()

@property(nonatomic, assign) float m_width;
@property(nonatomic, assign) float m_height;

@end

@implementation iGaiaOcean

@synthesize m_reflectionTexture = _m_reflectionTexture;
@synthesize m_refractionTexture = _m_refractionTexture;

@synthesize m_width = _m_width;
@synthesize m_height = _m_height;

- (id)initWithWidth:(float)witdh withHeight:(float)height withAltitude:(float)altitude;
{
    self = [super init];
    {
        _m_width = witdh;
        _m_height = height;
        
        iGaiaVertexBufferObject* vertexBuffer = [[iGaiaVertexBufferObject alloc] initWithNumVertexes:4 withMode:GL_STATIC_DRAW];
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

        iGaiaIndexBufferObject* indexBuffer = [[iGaiaIndexBufferObject alloc] initWithNumIndexes:6 withMode:GL_STATIC_DRAW];
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

- (void)setM_reflectionTexture:(iGaiaTexture *)m_reflectionTexture
{
    if(_m_reflectionTexture == m_reflectionTexture)
    {
        return;
    }
    _m_reflectionTexture = m_reflectionTexture;
    [_m_material setTexture:_m_reflectionTexture forSlot:E_TEXTURE_SLOT_01];
}

- (void)setM_refractionTexture:(iGaiaTexture *)m_refractionTexture
{
    if(_m_refractionTexture == m_refractionTexture)
    {
        return;
    }
    _m_refractionTexture = m_refractionTexture;
    [_m_material setTexture:_m_refractionTexture forSlot:E_TEXTURE_SLOT_02];
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
    _m_position.x = _m_camera.m_look.x - _m_width / 2.0f;
    _m_position.z = _m_camera.m_look.z - _m_height / 2.0f;
    [super onUpdate];
}

- (void)onBindWithRenderMode:(E_RENDER_MODE_WORLD_SPACE)mode
{
    [super onBindWithRenderMode:mode];
}

- (void)onUnbindWithRenderMode:(E_RENDER_MODE_WORLD_SPACE)mode
{
    [super onUnbindWithRenderMode:mode];
}

- (void)onDrawWithRenderMode:(E_RENDER_MODE_WORLD_SPACE)mode
{
    return;
    [super onDrawWithRenderMode:mode];

    switch (mode)
    {
        case E_RENDER_MODE_WORLD_SPACE_SIMPLE:
        {
            if(_m_material.m_operatingShader == nil)
            {
                iGaiaLog(@"Shader MODE_SIMPLE == nil.");
            }

            [_m_material.m_operatingShader setMatrix4x4:_m_worldMatrix forAttribute:E_ATTRIBUTE_MATRIX_WORLD];
            [_m_material.m_operatingShader setMatrix4x4:_m_camera.m_projection forAttribute:E_ATTRIBUTE_MATRIX_PROJECTION];
            [_m_material.m_operatingShader setMatrix4x4:_m_camera.m_view forAttribute:E_ATTRIBUTE_MATRIX_VIEW];

            [_m_material.m_operatingShader setVector3:_m_camera.m_position forAttribute:E_ATTRIBUTE_VECTOR_CAMERA_POSITION];
            [_m_material.m_operatingShader setVector3:_m_light.m_position forAttribute:E_ATTRIBUTE_VECTOR_LIGHT_POSITION];
            [_m_material.m_operatingShader setVector3:glm::vec3(_m_position.x + _m_width / 2.0f, 0.0f, _m_position.z + _m_height / 2.0f) forCustomAttribute:@"EXT_Center"];
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
    
    glDrawElements(GL_TRIANGLES, _m_mesh.m_numIndexes, GL_UNSIGNED_SHORT, NULL);
}



@end
