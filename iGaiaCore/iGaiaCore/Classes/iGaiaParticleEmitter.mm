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
#import "iGaiaCommon.h"

@interface iGaiaParticleEmitter()

@property(nonatomic, assign) NSUInteger m_numParticles;
@property(nonatomic, assign) iGaiaParticle* m_particles;

@property(nonatomic, strong) NSString* m_textureName;

@property(nonatomic, assign) float m_duration;
@property(nonatomic, assign) float m_durationRandomness;

@property(nonatomic, assign) float m_velocitySensitivity;

@property(nonatomic, assign) float m_minHorizontalVelocity;
@property(nonatomic, assign) float m_maxHorizontalVelocity;

@property(nonatomic, assign) float m_minVerticalVelocity;
@property(nonatomic, assign) float m_maxVerticalVelocity;

@property(nonatomic, assign) float m_endVelocity;

@property(nonatomic, assign) glm::vec3 m_gravity;

@property(nonatomic, assign) glm::u8vec4 m_startColor;
@property(nonatomic, assign) glm::u8vec4 m_endColor;

@property(nonatomic, assign) glm::vec2 m_startSize;
@property(nonatomic, assign) glm::vec2 m_endSize;

@property(nonatomic, assign) float m_minParticleEmittInterval;
@property(nonatomic, assign) float m_maxParticleEmittInterval;

@property(nonatomic, assign) float m_lastParticleEmittTime;

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

        _m_startSize = glm::vec2(0.05f, 0.05f);
        _m_endSize = glm::vec2(2.0f, 2.0f);

        _m_velocitySensitivity = 1.0f;
        _m_endVelocity = 1.0f;

        _m_duration = 2000.0f;
        _m_durationRandomness = 1.0f;

        _m_minHorizontalVelocity = -0.0001f;
        _m_maxHorizontalVelocity = 0.0001f;

        _m_minVerticalVelocity = 0.0001f;
        _m_maxVerticalVelocity = 0.0003f;

        _m_gravity = glm::vec3(0.0f, 0.0001f, 0.0f);
        
        _m_startColor = glm::u8vec4(0, 0, 255, 255);
        _m_endColor = glm::u8vec4(255, 0, 0, 0);
        
        _m_minParticleEmittInterval = 66.0f;
        _m_maxParticleEmittInterval = 133.0f;
        
        _m_lastParticleEmittTime = 0.0f;
        
        iGaiaVertexBufferObject* vertexBuffer = [[iGaiaVertexBufferObject alloc] initWithNumVertexes:_m_numParticles * 4 withMode:GL_STREAM_DRAW];
        iGaiaVertex* vertexData = [vertexBuffer lock];

        for(NSUInteger i = 0; i < _m_numParticles; ++i)
        {
            _m_particles[i].m_size = glm::vec2(0.0f, 0.0f);
            _m_particles[i].m_color = glm::u8vec4(0, 0, 0, 0);
            
            vertexData[i * 4 + 0].m_texcoord = glm::vec2( 0.0f,  0.0f);
            vertexData[i * 4 + 1].m_texcoord = glm::vec2( 1.0f,  0.0f);
            vertexData[i * 4 + 2].m_texcoord = glm::vec2( 1.0f,  1.0f);
            vertexData[i * 4 + 3].m_texcoord = glm::vec2( 0.0f,  1.0f);
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

        [_m_material invalidateState:E_RENDER_STATE_CULL_MODE withValue:YES];
        [_m_material invalidateState:E_RENDER_STATE_DEPTH_MASK withValue:NO];
        [_m_material invalidateState:E_RENDER_STATE_DEPTH_TEST withValue:YES];
        [_m_material invalidateState:E_RENDER_STATE_BLEND_MODE withValue:YES];
        _m_material.m_cullFaceMode = GL_FRONT;
        _m_material.m_blendFunctionSource = GL_SRC_ALPHA;
        _m_material.m_blendFunctionDest = GL_ONE_MINUS_SRC_ALPHA;

        _m_priority = k_IGAIA_PARTICLE_RENDER_PRIORITY;
        _m_updateMode = E_UPDATE_MODE_ASYNC;
    }
    return self;
}

- (void)createParticleWithIndex:(NSUInteger)index
{
    _m_particles[index].m_position = glm::vec3(0.0f, 0.0f, 0.0f);
    _m_particles[index].m_velocity = glm::vec3(0.0f, 0.0f, 0.0f);
    _m_particles[index].m_size = _m_startSize;
    _m_particles[index].m_color = _m_startColor;
    _m_particles[index].m_timestamp = [iGaiaCommon retriveTickCount];

    float horizontalVelocity = glm::mix(_m_minHorizontalVelocity, _m_maxHorizontalVelocity, [iGaiaCommon retriveRandomValueWithMinBound:0.0f withMaxBound:1.0f]);

    float horizontalAngle = [iGaiaCommon retriveRandomValueWithMinBound:0.0f withMaxBound:1.0f] * M_PI * 2.0f;

    _m_particles[index].m_velocity.x += horizontalVelocity * cosf(horizontalAngle);
    _m_particles[index].m_velocity.z += horizontalVelocity * sinf(horizontalAngle);

    _m_particles[index].m_velocity.y += glm::mix(_m_minVerticalVelocity, _m_maxVerticalVelocity, [iGaiaCommon retriveRandomValueWithMinBound:0.0f withMaxBound:1.0f]);
    _m_particles[index].m_velocity *= _m_velocitySensitivity;
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

    float currentTime = [iGaiaCommon retriveTickCount];

    for(NSUInteger i = 0; i < _m_numParticles; ++i)
    {
        float particleAge = currentTime - _m_particles[i].m_timestamp;

        if(particleAge > _m_duration)
        {
            float emittParticleInterval = [iGaiaCommon retriveRandomValueWithMinBound:_m_minParticleEmittInterval withMaxBound:_m_maxParticleEmittInterval];
            if((currentTime - _m_lastParticleEmittTime) > emittParticleInterval)
            {
                _m_lastParticleEmittTime = currentTime;
                [self createParticleWithIndex:i];
            }
            else
            {
                _m_particles[i].m_size = glm::vec2(0.0f, 0.0f);
                _m_particles[i].m_color = glm::u8vec4(0, 0, 0, 0);
            }
        }
        
        float particleClampAge = glm::clamp( particleAge / _m_duration, 0.0f, 1.0f);

        float startVelocity = glm::length(_m_particles[i].m_velocity);
        float endVelocity = _m_endVelocity * startVelocity;
        float velocityIntegral = startVelocity * particleClampAge + (endVelocity - startVelocity) * particleClampAge * particleClampAge / 2.0f;
        _m_particles[i].m_position += glm::normalize(_m_particles[i].m_velocity) * velocityIntegral * _m_duration;
        _m_particles[i].m_position += _m_gravity * particleAge * particleClampAge;

        float randomValue = [iGaiaCommon retriveRandomValueWithMinBound:0.0f withMaxBound:1.0];
        float startSize = glm::mix(_m_startSize.x, _m_startSize.y, randomValue);
        float endSize = glm::mix(_m_endSize.x, _m_endSize.y, randomValue);
        _m_particles[i].m_size = glm::vec2(glm::mix(startSize, endSize, particleClampAge));
        
        _m_particles[i].m_color = glm::mix(_m_startColor, _m_endColor, particleClampAge);
        _m_particles[i].m_color.a = glm::mix(_m_startColor.a, _m_endColor.a, particleClampAge);
    }
    
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
