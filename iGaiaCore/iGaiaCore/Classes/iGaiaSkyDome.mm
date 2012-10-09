//
//  iGaiaSkyDome.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaSkyDome.h"
#import "iGaiaLogger.h"

static NSInteger k_IGAIA_SKYDOME_RENDER_PRIORITY = 0;

@implementation iGaiaSkyDome

- (id)init
{
    self = [super init];
    {
        iGaiaVertexBufferObject* vertexBuffer = [[iGaiaVertexBufferObject alloc] initWithNumVertexes:24 withMode:GL_STATIC_DRAW];
        iGaiaVertex* vertexData = [vertexBuffer lock];
        
        glm::vec3 minBound = glm::vec3( -1.0f, -1.0f, -1.0f);
        glm::vec3 maxBound = glm::vec3(  1.0f,  1.0f,  1.0f);
        
        vertexData[0].m_position = glm::vec3(minBound.x,  minBound.y, maxBound.z);
        vertexData[1].m_position = glm::vec3(maxBound.x,  minBound.y, maxBound.z);
        vertexData[2].m_position = glm::vec3(maxBound.x,  maxBound.y, maxBound.z);
        vertexData[3].m_position = glm::vec3(minBound.x,  maxBound.y, maxBound.z);
        
        vertexData[4].m_position = glm::vec3(minBound.x,  minBound.y,  minBound.z);
        vertexData[5].m_position = glm::vec3(minBound.x,  maxBound.y,  minBound.z);
        vertexData[6].m_position = glm::vec3(maxBound.x,  maxBound.y,  minBound.z);
        vertexData[7].m_position = glm::vec3(maxBound.x,  minBound.y,  minBound.z);
        
        vertexData[8].m_position = glm::vec3(minBound.x,  maxBound.y,  minBound.z);
        vertexData[9].m_position = glm::vec3(minBound.x,  maxBound.y,  maxBound.z);
        vertexData[10].m_position = glm::vec3(maxBound.x,  maxBound.y,  maxBound.z);
        vertexData[11].m_position = glm::vec3(maxBound.x,  maxBound.y,  minBound.z);
        
        vertexData[12].m_position = glm::vec3(minBound.x,  maxBound.y,  minBound.z);
        vertexData[13].m_position = glm::vec3(maxBound.x,  maxBound.y,  minBound.z);
        vertexData[14].m_position = glm::vec3(maxBound.x,  maxBound.y,  maxBound.z);
        vertexData[15].m_position = glm::vec3(minBound.x,  maxBound.y,  maxBound.z);
        
        vertexData[16].m_position = glm::vec3(maxBound.x,  minBound.y,  minBound.z);
        vertexData[17].m_position = glm::vec3(maxBound.x,  maxBound.y,  minBound.z);
        vertexData[18].m_position = glm::vec3(maxBound.x,  maxBound.y,  maxBound.z);
        vertexData[19].m_position = glm::vec3(maxBound.x,  minBound.y,  maxBound.z);
        
        vertexData[20].m_position = glm::vec3(minBound.x,  minBound.y,  minBound.z);
        vertexData[21].m_position = glm::vec3(minBound.x,  minBound.y,  maxBound.z);
        vertexData[22].m_position = glm::vec3(minBound.x,  maxBound.y,  maxBound.z);
        vertexData[23].m_position = glm::vec3(minBound.x,  maxBound.y,  minBound.z);
        
        vertexData[0].m_texcoord = glm::vec2(0.0f, 0.0f);
        vertexData[1].m_texcoord = glm::vec2(1.0f, 0.0f);
        vertexData[2].m_texcoord = glm::vec2(1.0f, 1.0f);
        vertexData[3].m_texcoord = glm::vec2(0.0f, 1.0f);
        
        vertexData[4].m_texcoord = glm::vec2(1.0f, 0.0f);
        vertexData[5].m_texcoord = glm::vec2(1.0f, 1.0f);
        vertexData[6].m_texcoord = glm::vec2(0.0f, 1.0f);
        vertexData[7].m_texcoord = glm::vec2(0.0f, 0.0f);
        
        vertexData[8].m_texcoord = glm::vec2(1.0f, 0.0f);
        vertexData[9].m_texcoord = glm::vec2(1.0f, 1.0f);
        vertexData[10].m_texcoord = glm::vec2(0.0f, 1.0f);
        vertexData[11].m_texcoord = glm::vec2(0.0f, 0.0f);
        
        vertexData[12].m_texcoord = glm::vec2(0.0f, 0.0f);
        vertexData[13].m_texcoord = glm::vec2(1.0f, 0.0f);
        vertexData[14].m_texcoord = glm::vec2(1.0f, 1.0f);
        vertexData[15].m_texcoord = glm::vec2(0.0f, 1.0f);
        
        vertexData[16].m_texcoord = glm::vec2(1.0f, 0.0f);
        vertexData[17].m_texcoord = glm::vec2(1.0f, 1.0f);
        vertexData[18].m_texcoord = glm::vec2(0.0f, 1.0f);
        vertexData[19].m_texcoord = glm::vec2(0.0f, 0.0f);
        
        vertexData[20].m_texcoord = glm::vec2(0.0f, 0.0f);
        vertexData[21].m_texcoord = glm::vec2(1.0f, 0.0f);
        vertexData[22].m_texcoord = glm::vec2(1.0f, 1.0f);
        vertexData[23].m_texcoord = glm::vec2(0.0f, 1.0f);
        
        [vertexBuffer unlock];
        
        iGaiaIndexBufferObject* indexBuffer = [[iGaiaIndexBufferObject alloc] initWithNumIndexes:36 withMode:GL_STATIC_DRAW];
        unsigned short* indexData = [indexBuffer lock];

        indexData[0] = 0;
        indexData[1] = 1;
        indexData[2] = 2;
        indexData[3] = 0;
        indexData[4] = 2;
        indexData[5] = 3;

        indexData[6] = 4;
        indexData[7] = 5;
        indexData[8] = 6;
        indexData[9] = 4;
        indexData[10] = 6;
        indexData[11] = 7;

        indexData[12] = 8;
        indexData[13] = 9;
        indexData[14] = 10;
        indexData[15] = 8;
        indexData[16] = 10;
        indexData[17] = 11;

        indexData[18] = 12;
        indexData[19] = 13;
        indexData[20] = 14;
        indexData[21] = 12;
        indexData[22] = 14;
        indexData[23] = 15;

        indexData[24] = 16;
        indexData[25] = 17;
        indexData[26] = 18;
        indexData[27] = 16;
        indexData[28] = 18;
        indexData[29] = 19;

        indexData[30] = 20;
        indexData[31] = 21;
        indexData[32] = 22;
        indexData[33] = 20;
        indexData[34] = 22;
        indexData[35] = 23;
        
        [indexBuffer unlock];
        
        _m_mesh = [[iGaiaMesh alloc] initWithVertexBuffer:vertexBuffer withIndexBuffer:indexBuffer withName:@"igaia.mesh.skydome" withCreationMode:E_CREATION_MODE_CUSTOM];
        
        [_m_material invalidateState:E_RENDER_STATE_CULL_MODE withValue:YES];
        [_m_material invalidateState:E_RENDER_STATE_DEPTH_MASK withValue:NO];
        [_m_material invalidateState:E_RENDER_STATE_DEPTH_TEST withValue:NO];
        [_m_material invalidateState:E_RENDER_STATE_BLEND_MODE withValue:NO];
        _m_material.m_cullFaceMode = GL_FRONT;
        _m_material.m_blendFunctionSource = GL_SRC_ALPHA;
        _m_material.m_blendFunctionDest = GL_ONE_MINUS_SRC_ALPHA;
        
        _m_priority = k_IGAIA_SKYDOME_RENDER_PRIORITY;
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
    _m_position = _m_camera.m_position;
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
