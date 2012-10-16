//
//  iGaiaParticleEmitter.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

static NSInteger k_IGAIA_PARTICLE_RENDER_PRIORITY = 7;

#import "iGaiaParticleEmitter.h"

#import "iGaiaLogger.h"

@interface iGaiaParticleEmitter()

@property(nonatomic, assign) NSUInteger m_numParticles;
@property(nonatomic, assign) iGaiaParticle* m_particles;

@property(nonatomic, assign) float m_lifetime;
@property(nonatomic, assign) glm::vec3 m_startSize;
@property(nonatomic, assign) glm::vec3 m_endSize;

@end

@implementation iGaiaParticleEmitter

@synthesize m_numParticles = _m_numParticles;
@synthesize m_particles = _m_particles;

- (id)initWithNumParticles:(NSUInteger)numParticles withSize:(const glm::vec2&)size withLifetime:(float)lifetime;
{
    self = [super init];
    {
        _m_numParticles = numParticles;
        
        _m_particles = new iGaiaParticle[_m_numParticles];
        
        iGaiaVertexBufferObject* vertexBuffer = [[iGaiaVertexBufferObject alloc] initWithNumVertexes:_m_numParticles * 4 withMode:GL_STREAM_DRAW];
        iGaiaVertex* vertexData = [vertexBuffer lock];

        for(NSUInteger i = 0; i < _m_numParticles; ++i)
        {
            _m_particles[i].m_position = glm::vec3(0.0f, 0.0f, 0.0f);
            _m_particles[i].m_velocity = glm::vec3(0.0f, 0.0f, 0.0f);
            _m_particles[i].m_size = size;
            _m_particles[i].m_color = glm::u8vec4(255, 255, 255, 255);
            _m_particles[i].m_lifetime = 0;
            

            vertexData[i * 4 + 0].m_position = glm::vec3(_m_particles[i].m_position.x - _m_particles[i].m_size.x, _m_particles[i].m_position.y, _m_particles[i].m_position.z - _m_particles[i].m_size.y);
            vertexData[i * 4 + 1].m_position = glm::vec3(_m_particles[i].m_position.x + _m_particles[i].m_size.x, _m_particles[i].m_position.y, _m_particles[i].m_position.z - _m_particles[i].m_size.y);
            vertexData[i * 4 + 2].m_position = glm::vec3(_m_particles[i].m_position.x + _m_particles[i].m_size.x, _m_particles[i].m_position.y, _m_particles[i].m_position.z + _m_particles[i].m_size.y);
            vertexData[i * 4 + 3].m_position = glm::vec3(_m_particles[i].m_position.x - _m_particles[i].m_size.x, _m_particles[i].m_position.y, _m_particles[i].m_position.z + _m_particles[i].m_size.y);

            vertexData[i * 4 + 0].m_texcoord = glm::vec2( 0.0f,  0.0f);
            vertexData[i * 4 + 1].m_texcoord = glm::vec2( 1.0f,  0.0f);
            vertexData[i * 4 + 2].m_texcoord = glm::vec2( 1.0f,  1.0f);
            vertexData[i * 4 + 3].m_texcoord = glm::vec2( 0.0f,  1.0f);

            vertexData[i * 4 + 0].m_color = _m_particles[i].m_color;
            vertexData[i * 4 + 1].m_color = _m_particles[i].m_color;
            vertexData[i * 4 + 2].m_color = _m_particles[i].m_color;
            vertexData[i * 4 + 3].m_color = _m_particles[i].m_color;
        }

        [vertexBuffer unlock];

        iGaiaIndexBufferObject* indexBuffer = [[iGaiaIndexBufferObject alloc] initWithNumIndexes:_m_numParticles * 6 withMode:GL_STREAM_DRAW];
        unsigned short* indexData = [indexBuffer lock];

        for(unsigned int i = 0; i < _m_numParticles; ++i)
        {
            indexData[i * 6 + 0] = static_cast<unsigned short>(i * 4 + 0);
            indexData[i * 6 + 1] = static_cast<unsigned short>(i * 4 + 1);
            indexData[i * 6 + 2] = static_cast<unsigned short>(i * 4 + 2);

            indexData[i * 6 + 3] = static_cast<unsigned short>(i * 4 + 0);
            indexData[i * 6 + 4] = static_cast<unsigned short>(i * 4 + 2);
            indexData[i * 6 + 5] = static_cast<unsigned short>(i * 4 + 3);
        }

        [indexBuffer unlock];

        _m_mesh = [[iGaiaMesh alloc] initWithVertexBuffer:vertexBuffer withIndexBuffer:indexBuffer withName:@"igaia.mesh.particle.emitter" withCreationMode:E_CREATION_MODE_CUSTOM];

        [_m_material invalidateState:E_RENDER_STATE_CULL_MODE withValue:NO];
        [_m_material invalidateState:E_RENDER_STATE_DEPTH_MASK withValue:NO];
        [_m_material invalidateState:E_RENDER_STATE_DEPTH_TEST withValue:YES];
        [_m_material invalidateState:E_RENDER_STATE_BLEND_MODE withValue:YES];
        _m_material.m_cullFaceMode = GL_FRONT;
        _m_material.m_blendFunctionSource = GL_SRC_ALPHA;
        _m_material.m_blendFunctionDest = GL_ONE;

        _m_priority = k_IGAIA_PARTICLE_RENDER_PRIORITY;
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

- (void)onUpdate
{
    [super onUpdate];
    iGaiaVertex* vertexData = [_m_mesh.m_vertexBuffer lock];

    for(NSUInteger i = 0; i < _m_numParticles; ++i)
    {
        glm::mat4x4 matrixSpherical = [_m_camera retriveSphericalMatrixForPosition:_m_particles[i].m_position + _m_position]; 

        glm::vec4 position = glm::vec4(-_m_particles[i].m_size.x, -_m_particles[i].m_size.y, 0.0f, 1.0f);
        position = matrixSpherical * position;
        vertexData[i * 4 + 0].m_position = glm::vec3(position.x, position.y, position.z);

        position = glm::vec4(_m_particles[i].m_size.x, -_m_particles[i].m_size.y, 0.0f, 1.0f);
        position = matrixSpherical * position;
        vertexData[i * 4 + 1].m_position = glm::vec3(position.x, position.y, position.z);

        position = glm::vec4(_m_particles[i].m_size.x, _m_particles[i].m_size.y, 0.0f, 1.0f);
        position = matrixSpherical * position;
        vertexData[i * 4 + 2].m_position = glm::vec3(position.x, position.y, position.z);

        position = glm::vec4(-_m_particles[i].m_size.x, _m_particles[i].m_size.y, 0.0f, 1.0f);
        position = matrixSpherical * position;
        vertexData[i * 4 + 3].m_position = glm::vec3(position.x, position.y, position.z);

        vertexData[i * 4 + 0].m_color = _m_particles[i].m_color;
        vertexData[i * 4 + 1].m_color = _m_particles[i].m_color;
        vertexData[i * 4 + 2].m_color = _m_particles[i].m_color;
        vertexData[i * 4 + 3].m_color = _m_particles[i].m_color;
    }
    [_m_mesh.m_vertexBuffer unlock];
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
