//
//  iGaiaParticleEmitter.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaParticleEmitter.h"
#include "iGaiaLogger.h"

static ui32 kiGaiaParticlesRenderPriority = 7;
static dispatch_queue_t g_onUpdateEmitterQueue;

iGaiaParticleEmitter::iGaiaParticleEmitter(iGaiaParticleEmitterSettings* _settings)
{
    m_settings = _settings;
    m_particles = new iGaiaParticle[m_settings->m_numParticles];
    
    iGaiaVertexBufferObject* vertexBuffer = new iGaiaVertexBufferObject(m_settings->m_numParticles * 4, GL_STREAM_DRAW);
    iGaiaVertexBufferObject::iGaiaVertex* vertexData = vertexBuffer->Lock();
    
    for(ui32 i = 0; i < m_settings->m_numParticles; ++i)
    {
        m_particles[i].m_size = vec2(0.0f, 0.0f);
        m_particles[i].m_color = u8vec4(0, 0, 0, 0);
        
        vertexData[i * 4 + 0].m_texcoord = vec2( 0.0f,  0.0f);
        vertexData[i * 4 + 1].m_texcoord = vec2( 1.0f,  0.0f);
        vertexData[i * 4 + 2].m_texcoord = vec2( 1.0f,  1.0f);
        vertexData[i * 4 + 3].m_texcoord = vec2( 0.0f,  1.0f);
    }
    vertexBuffer->Unlock();
    
    iGaiaIndexBufferObject* indexBuffer = new iGaiaIndexBufferObject(m_settings->m_numParticles * 6, GL_STREAM_DRAW);
    ui16* indexData = indexBuffer->Lock();
    
    for(unsigned int i = 0; i < m_settings->m_numParticles; ++i)
    {
        indexData[i * 6 + 0] = static_cast<ui16>(i * 4 + 0);
        indexData[i * 6 + 1] = static_cast<ui16>(i * 4 + 1);
        indexData[i * 6 + 2] = static_cast<ui16>(i * 4 + 2);
        
        indexData[i * 6 + 3] = static_cast<ui16>(i * 4 + 0);
        indexData[i * 6 + 4] = static_cast<ui16>(i * 4 + 2);
        indexData[i * 6 + 5] = static_cast<ui16>(i * 4 + 3);
    }
    
    indexBuffer->Unlock();
    
    m_mesh = new iGaiaMesh(vertexBuffer, indexBuffer, "igaia.mesh.particle.emitter", iGaiaResource::iGaia_E_CreationModeCustom);
    
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateCullMode, true);
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateDepthMask, false);
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateDepthTest, true);
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateBlendMode, true);
    m_material->Set_CullFaceMode(GL_FRONT);
    m_material->Set_BlendFunctionSource(GL_SRC_ALPHA);
    m_material->Set_BlendFunctionDest(GL_ONE_MINUS_SRC_ALPHA);
    
    m_updateMode = iGaia_E_UpdateModeAsync;
    m_lastEmittTimestamp = 0;
}

iGaiaParticleEmitter::~iGaiaParticleEmitter(void)
{
    
}

void iGaiaParticleEmitter::CreateParticle(ui32 _index)
{
    m_particles[_index].m_position = m_position;
    m_particles[_index].m_velocity = vec3(0.0f, 0.0f, 0.0f);
    
    m_particles[_index].m_size = m_settings->m_startSize;
    m_particles[_index].m_color = m_settings->m_startColor;
    
    m_particles[_index].m_timestamp = Get_TickCount();
    
    f32 horizontalVelocity = mix(m_settings->m_minHorizontalVelocity, m_settings->m_maxHorizontalVelocity, Get_Random(0.0f, 1.0f));
    
    f32 horizontalAngle = Get_Random(0.0f, 1.0f) * M_PI * 2.0f;
    
    m_particles[_index].m_velocity.x += horizontalVelocity * cosf(horizontalAngle);
    m_particles[_index].m_velocity.z += horizontalVelocity * sinf(horizontalAngle);
    
    m_particles[_index].m_velocity.y += mix(m_settings->m_minVerticalVelocity, m_settings->m_maxVerticalVelocity, Get_Random(0.0f, 1.0f));
    m_particles[_index].m_velocity *= m_settings->m_velocitySensitivity;
}

void iGaiaParticleEmitter::OnUpdate(void)
{
    iGaiaObject3d::OnUpdate();
    
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        g_onUpdateEmitterQueue = dispatch_queue_create("igaia.onupdate.emitter.queue", DISPATCH_QUEUE_SERIAL);
    });
    
    dispatch_async(g_onUpdateEmitterQueue, ^{
        
        iGaiaVertexBufferObject::iGaiaVertex* vertexData = m_mesh->Get_VertexBuffer()->Lock();
        f32 currentTime = Get_TickCount();
        
        for(ui32 i = 0; i < m_settings->m_numParticles; ++i)
        {
            f32 particleAge = currentTime - m_particles[i].m_timestamp;
            
            if(particleAge > m_settings->m_duration)
            {
                if((currentTime - m_lastEmittTimestamp) > Get_Random(m_settings->m_minParticleEmittInterval, m_settings->m_maxParticleEmittInterval))
                {
                    m_lastEmittTimestamp = currentTime;
                    CreateParticle(i);
                }
                else
                {
                    m_particles[i].m_size = vec2(0.0f, 0.0f);
                    m_particles[i].m_color = u8vec4(0, 0, 0, 0);
                }
            }
            
            f32 particleClampAge = clamp( particleAge / m_settings->m_duration, 0.0f, 1.0f);
            
            f32 startVelocity = length(m_particles[i].m_velocity);
            f32 endVelocity = m_settings->m_endVelocity * startVelocity;
            f32 velocityIntegral = startVelocity * particleClampAge + (endVelocity - startVelocity) * particleClampAge * particleClampAge / 2.0f;
            m_particles[i].m_position += normalize(m_particles[i].m_velocity) * velocityIntegral * m_settings->m_duration;
            m_particles[i].m_position += m_settings->m_gravity * particleAge * particleClampAge;
            
            f32 randomValue = Get_Random(0.0f, 1.0f);
            f32 startSize = mix(m_settings->m_startSize.x, m_settings->m_startSize.y, randomValue);
            f32 endSize = mix(m_settings->m_endSize.x, m_settings->m_endSize.y, randomValue);
            m_particles[i].m_size = vec2(mix(startSize, endSize, particleClampAge));
            
            m_particles[i].m_color = mix(m_settings->m_startColor, m_settings->m_endColor, particleClampAge);
            m_particles[i].m_color.a = mix(m_settings->m_startColor.a, m_settings->m_endColor.a, particleClampAge);
            
            mat4x4 matrixSpherical = m_camera->Get_SphericalMatrixForPosition(m_particles[i].m_position);
            
            vec4 position = vec4(-m_particles[i].m_size.x, -m_particles[i].m_size.y, 0.0f, 1.0f);
            position = matrixSpherical * position;
            vertexData[i * 4 + 0].m_position = glm::vec3(position.x, position.y, position.z);
            
            position = vec4(m_particles[i].m_size.x, -m_particles[i].m_size.y, 0.0f, 1.0f);
            position = matrixSpherical * position;
            vertexData[i * 4 + 1].m_position = glm::vec3(position.x, position.y, position.z);
            
            position = vec4(m_particles[i].m_size.x, m_particles[i].m_size.y, 0.0f, 1.0f);
            position = matrixSpherical * position;
            vertexData[i * 4 + 2].m_position = glm::vec3(position.x, position.y, position.z);
            
            position = vec4(-m_particles[i].m_size.x, m_particles[i].m_size.y, 0.0f, 1.0f);
            position = matrixSpherical * position;
            vertexData[i * 4 + 3].m_position = glm::vec3(position.x, position.y, position.z);
            
            vertexData[i * 4 + 0].m_color = m_particles[i].m_color;
            vertexData[i * 4 + 1].m_color = m_particles[i].m_color;
            vertexData[i * 4 + 2].m_color = m_particles[i].m_color;
            vertexData[i * 4 + 3].m_color = m_particles[i].m_color;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            m_mesh->Get_VertexBuffer()->Unlock();
        });
    });
}

void iGaiaParticleEmitter::OnLoad(iGaiaResource* _resource)
{
    
}

ui32 iGaiaParticleEmitter::Get_Priority(void)
{
    return kiGaiaParticlesRenderPriority;
}

void iGaiaParticleEmitter::OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    iGaiaObject3d::OnBind(_mode);
}

void iGaiaParticleEmitter::OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    iGaiaObject3d::OnUnbind(_mode);
}

void iGaiaParticleEmitter::OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    iGaiaObject3d::OnDraw(_mode);
    
    switch (_mode)
    {
        case iGaiaMaterial::iGaia_E_RenderModeWorldSpaceSimple:
        {
            if(m_material->Get_OperatingShader() == nil)
            {
                iGaiaLog(@"Shader MODE_SIMPLE == nil");
            }
            
            m_material->Get_OperatingShader()->Set_Matrix4x4(m_worldMatrix, iGaiaShader::iGaia_E_ShaderAttributeMatrixWorld);
            m_material->Get_OperatingShader()->Set_Matrix4x4(m_camera->Get_ProjectionMatrix(), iGaiaShader::iGaia_E_ShaderAttributeMatrixProjection);
            m_material->Get_OperatingShader()->Set_Matrix4x4(m_camera->Get_ViewMatrix(), iGaiaShader::iGaia_E_ShaderAttributeMatrixView);
            
            m_material->Get_OperatingShader()->Set_Vector3(m_camera->Get_Position(), iGaiaShader::iGaia_E_ShaderAttributeVectorEyePosition);
            m_material->Get_OperatingShader()->Set_Vector3(m_light->Get_Position(), iGaiaShader::iGaia_E_ShaderAttributeVectorLightPosition);
        }
            break;
        case iGaiaMaterial::iGaia_E_RenderModeWorldSpaceReflection:
        {
            
        }
            break;
        case iGaiaMaterial::iGaia_E_RenderModeWorldSpaceRefraction:
        {
            
        }
            break;
        case iGaiaMaterial::iGaia_E_RenderModeWorldSpaceScreenNormalMap:
        {
        }
            break;
        default:
            break;
    }
    glDrawElements(GL_TRIANGLES, m_mesh->Get_NumIndexes(), GL_UNSIGNED_SHORT, NULL);
}
