//
//  iGaiaOcean.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaOcean.h"
#import "iGaiaLogger.h"

static ui32 kiGaiaOceanRenderPriority = 6;

iGaiaOcean::iGaiaOcean(f32 _width, f32 _height, f32 _altitude)
{
    m_width = _width;
    m_height = _height;
    m_altitude = _altitude;

    m_reflectionTexture = nullptr;
    m_refractionTexture = nullptr;

    iGaiaVertexBufferObject* vertexBuffer = new iGaiaVertexBufferObject(4, GL_STATIC_DRAW);
    iGaiaVertexBufferObject::iGaiaVertex* vertexData = vertexBuffer->Lock();

    vertexData[0].m_position = vec3(0.0f,  _altitude,  0.0f);
    vertexData[1].m_position = vec3(m_width, _altitude,  0.0f);
    vertexData[2].m_position = vec3(m_width, _altitude,  m_height);
    vertexData[3].m_position = vec3(0.0f,  _altitude,  m_height);

    vertexData[0].m_texcoord = vec2(0.0f,  0.0f);
    vertexData[1].m_texcoord = vec2(1.0f,  0.0f);
    vertexData[2].m_texcoord = vec2(1.0f,  1.0f);
    vertexData[3].m_texcoord = vec2(0.0f,  1.0f);

    vertexBuffer->Unlock();

    iGaiaIndexBufferObject* indexBuffer = new iGaiaIndexBufferObject(6, GL_STATIC_DRAW); 
    ui16* indexData = indexBuffer->Lock();

    indexData[0] = 0;
    indexData[1] = 1;
    indexData[2] = 2;
    indexData[3] = 0;
    indexData[4] = 2;
    indexData[5] = 3;

    indexBuffer->Unlock();

    m_mesh = new iGaiaMesh(vertexBuffer, indexBuffer, "igaia.mesh.ocean", iGaiaResource::iGaia_E_CreationModeCustom);

    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateCullMode, true);
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateDepthMask, true);
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateDepthTest, true);
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateBlendMode, true);
    m_material->Set_CullFaceMode(GL_FRONT);
    m_material->Set_BlendFunctionSource(GL_SRC_ALPHA);
    m_material->Set_BlendFunctionDest(GL_ONE_MINUS_SRC_ALPHA);

   m_updateMode = iGaia_E_UpdateModeSync;
}

iGaiaOcean::~iGaiaOcean(void)
{

}

void iGaiaOcean::Set_ReflectionTexture(iGaiaTexture* _texture)
{
    if(_texture == m_reflectionTexture)
    {
        // TODO : log
        return;
    }
    m_reflectionTexture = _texture;
    m_material->Set_Texture(m_reflectionTexture, iGaiaShader::iGaia_E_ShaderTextureSlot_01);
}

void iGaiaOcean::Set_RefractionTexture(iGaiaTexture* _texture)
{
    if(_texture == m_refractionTexture)
    {
        // TODO : log
        return;
    }
    m_refractionTexture = _texture;
    m_material->Set_Texture(m_refractionTexture, iGaiaShader::iGaia_E_ShaderTextureSlot_02);
}

f32 iGaiaOcean::Get_Altitude(void)
{
    return m_altitude;
}

void iGaiaOcean::OnUpdate(void)
{
    m_position.x = m_camera->Get_LookAt().x - m_width / 2.0f;
    m_position.z = m_camera->Get_LookAt().z - m_height / 2.0f;
    iGaiaObject3d::OnUpdate();
}

void iGaiaOcean::OnLoad(iGaiaResource* _resource)
{
    
}

ui32 iGaiaOcean::OnDrawIndex(void)
{
    return kiGaiaOceanRenderPriority;
}

void iGaiaOcean::OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    iGaiaObject3d::OnBind(_mode);
}

void iGaiaOcean::OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    iGaiaObject3d::OnUnbind(_mode);
}

void iGaiaOcean::OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
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
            
            static f32 time = 0.0f;
            time += 0.005f;
            
            m_material->Get_OperatingShader()->Set_Matrix4x4(m_worldMatrix, iGaiaShader::iGaia_E_ShaderAttributeMatrixWorld);
            m_material->Get_OperatingShader()->Set_Matrix4x4(m_camera->Get_ProjectionMatrix(), iGaiaShader::iGaia_E_ShaderAttributeMatrixProjection);
            m_material->Get_OperatingShader()->Set_Matrix4x4(m_camera->Get_ViewMatrix(), iGaiaShader::iGaia_E_ShaderAttributeMatrixView);
            
            m_material->Get_OperatingShader()->Set_Vector3(m_camera->Get_Position(), iGaiaShader::iGaia_E_ShaderAttributeVectorEyePosition);
            m_material->Get_OperatingShader()->Set_Vector3(m_light->Get_Position(), iGaiaShader::iGaia_E_ShaderAttributeVectorLightPosition);
            m_material->Get_OperatingShader()->Set_Vector3Custom(vec3(m_position.x + m_width / 2.0f, 0.0f, m_position.z + m_height / 2.0f), "EXT_Center");
            m_material->Get_OperatingShader()->Set_FloatCustom(time, "EXT_Timer");
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
