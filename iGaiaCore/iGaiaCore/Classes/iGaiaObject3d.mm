//
//  iGaiaObject3d.mm
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaObject3d.h"
#include "iGaiaResourceMgr.h"
#include "iGaiaStageMgr.h"
#include "iGaiaLogger.h"
#include "iGaiaException.h"
#include "iGaiaThreadQueue.h"

dispatch_queue_t g_onUpdateQueue;
string g_updateQueueName = "igaia.onupdate.queue";

iGaiaObject3d::iGaiaObject3d(void)
{
    m_renderCallback.Set_OnDrawIndexListener(std::bind(&iGaiaObject3d::OnDrawIndex, this));
    m_renderCallback.Set_OnBindListener(std::bind(&iGaiaObject3d::OnBind, this, std::placeholders::_1));
    m_renderCallback.Set_OnDrawListener(std::bind(&iGaiaObject3d::OnDraw, this, std::placeholders::_1));
    m_renderCallback.Set_OnUnbindListener(std::bind(&iGaiaObject3d::OnUnbind, this, std::placeholders::_1));

    m_updateCallback.Set_OnUpdateListener(std::bind(&iGaiaObject3d::OnUpdate, this));

    m_matrixWorld = mat4x4();
    
    m_position = vec3(0.0f, 0.0f, 0.0f);
    m_rotation = vec3(0.0f, 0.0f, 0.0f);
    m_scale = vec3(1.0f, 1.0f, 1.0f);
    
    m_maxBound = vec3(0.0f, 0.0f, 0.0f);
    m_minBound = vec3(0.0f, 0.0f, 0.0f);
    
    m_material = new iGaiaMaterial();
    m_mesh = nullptr;
    m_camera = nullptr;
    m_light = nullptr;

    m_renderMgr = nullptr;
    m_updateMgr = nullptr;
    
    ConnectColliderDataCallback();
    
    m_updateMode = iGaia_E_UpdateModeSync;
}

iGaiaObject3d::~iGaiaObject3d(void)
{
    
}

void iGaiaObject3d::Set_Position(const vec3& _position)
{
    m_position = _position;
}

vec3 iGaiaObject3d::Get_Position(void)
{
    return m_position;
}

void iGaiaObject3d::Set_Rotation(const vec3& _rotation)
{
    m_rotation = _rotation;
}

vec3 iGaiaObject3d::Get_Rotation(void)
{
    return m_rotation;
}

void iGaiaObject3d::Set_Scale(const vec3& _scale)
{
    m_scale = _scale;
}

vec3 iGaiaObject3d::Get_Scale(void)
{
    return m_scale;
}

vec3 iGaiaObject3d::Get_MaxBound(void)
{
    return m_maxBound;
}

vec3 iGaiaObject3d::Get_MinBound(void)
{
    return m_minBound;
}

void iGaiaObject3d::Set_Camera(iGaiaCamera* _camera)
{
    m_camera = _camera;
}

void iGaiaObject3d::Set_Light(iGaiaLight* _light)
{
    m_light = _light;
}

void iGaiaObject3d::Set_RenderMgr(iGaiaRenderMgr *_renderMgr)
{
    m_renderMgr = _renderMgr;
}

void iGaiaObject3d::Set_UpdateMgr(iGaiaUpdateMgr* _updateMgr)
{
    m_updateMgr = _updateMgr;
}

void iGaiaObject3d::Set_Shader(iGaiaShader::iGaia_E_Shader _shader, ui32 _mode)
{
    m_material->Set_Shader(_shader, _mode);
    if(m_renderMgr != nullptr)
    {
        m_renderMgr->AddEventListener(&m_renderCallback, static_cast<iGaiaMaterial::iGaia_E_RenderModeWorldSpace>(_mode));
    }
}

void iGaiaObject3d::Set_Texture(const string& _name, iGaiaShader::iGaia_E_ShaderTextureSlot _slot, iGaiaTexture::iGaia_E_TextureSettingsValue _wrap)
{
    m_material->Set_Texture(_name, _slot, _wrap);
}

void iGaiaObject3d::ListenRenderMgr(bool _value)
{
    if(_value)
    {
        for(ui32 _mode = 0; _mode < iGaiaMaterial::iGaia_E_RenderModeScreenSpaceMaxValue; ++_mode)
        {
            if(m_material->IsContainRenderMode(_mode) == true)
            {
                m_renderMgr->AddEventListener(&m_renderCallback, static_cast<iGaiaMaterial::iGaia_E_RenderModeWorldSpace>(_mode));
            }
        }
    }
    else
    {
        for(ui32 _mode = 0; _mode < iGaiaMaterial::iGaia_E_RenderModeScreenSpaceMaxValue; ++_mode)
        {
            if(m_material->IsContainRenderMode(_mode) == true)
            {
                m_renderMgr->RemoveEventListener(&m_renderCallback, static_cast<iGaiaMaterial::iGaia_E_RenderModeWorldSpace>(_mode));
            }
        }
    }
}

void iGaiaObject3d::ListenUpdateMgr(bool _value)
{
    if(_value)
    {
        m_updateMgr->AddEventListener(&m_updateCallback);
    }
    else
    {
        m_updateMgr->RemoveEventListener(&m_updateCallback);
    }
}

void iGaiaObject3d::ColliderDataDeserializeReceiver(iGaiaColliderDataMapper *_mapper)
{
    assert(m_mesh != nullptr);
    assert(m_mesh->Get_VertexBuffer() != nullptr);
    assert(m_mesh->Get_IndexBuffer() != nullptr);

    _mapper->Deserialize(m_mesh->Get_VertexBuffer(), m_mesh->Get_IndexBuffer(), m_matrixWorld);
}

void iGaiaObject3d::OnUpdate(void)
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_onUpdateQueue = dispatch_queue_create(g_updateQueueName.c_str(), DISPATCH_QUEUE_SERIAL);
    });
    
    if(m_updateMode == iGaia_E_UpdateModeAsync)
    {
        vec3 position = m_position;
        vec3 rotation = m_rotation;
        vec3 scale = m_scale;
        dispatch_async(g_onUpdateQueue, ^{
            mat4x4 rotationMatrix, translationMatrix, scaleMatrix, worldMatrix;
            rotationMatrix = rotate(mat4(1.0f), rotation.x, vec3(1.0f, 0.0f, 0.0f));
            rotationMatrix = rotate(rotationMatrix, rotation.z, vec3(0.0f, 0.0f, 1.0f));
            rotationMatrix = rotate(rotationMatrix, rotation.y, vec3(0.0f, 1.0f, 0.0f));
            
            translationMatrix = translate(mat4(1.0f), position);
            
            scaleMatrix = glm::scale(mat4(1.0f), scale);
            
            worldMatrix = translationMatrix * rotationMatrix * scaleMatrix;
            dispatch_async(dispatch_get_main_queue(), ^{
                m_matrixWorld = worldMatrix;
            });
        });
    }
    else if(m_updateMode == iGaia_E_UpdateModeSync)
    {
        mat4x4 rotationMatrix, translationMatrix, scaleMatrix, worldMatrix;
        rotationMatrix = rotate(mat4(1.0f), m_rotation.x, vec3(1.0f, 0.0f, 0.0f));
        rotationMatrix = rotate(rotationMatrix, m_rotation.z, vec3(0.0f, 0.0f, 1.0f));
        rotationMatrix = rotate(rotationMatrix, m_rotation.y, vec3(0.0f, 1.0f, 0.0f));
        
        translationMatrix = translate(mat4(1.0f), m_position);
        
        scaleMatrix = scale(mat4(1.0f), m_scale);
        
        m_matrixWorld = translationMatrix * rotationMatrix * scaleMatrix;
    }
}

ui32 iGaiaObject3d::OnDrawIndex(void)
{
    return 0;
}

void iGaiaObject3d::OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    m_material->Bind(_mode);
    m_mesh->Get_VertexBuffer()->Set_OperatingShader(m_material->Get_OperatingShader());
    m_mesh->Bind();
}

void iGaiaObject3d::OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    m_material->Unbind(_mode);
    m_mesh->Unbind();
}

void iGaiaObject3d::OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    
}
