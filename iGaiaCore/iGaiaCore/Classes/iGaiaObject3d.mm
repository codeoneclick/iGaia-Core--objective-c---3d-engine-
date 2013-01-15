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
string g_updateQueueName = "igaia.update.queue";

iGaiaObject3d::iGaiaObject3d(void)
{
    m_worldMatrix = mat4x4();
    
    m_position = vec3(0.0f, 0.0f, 0.0f);
    m_rotation = vec3(0.0f, 0.0f, 0.0f);
    m_scale = vec3(1.0f, 1.0f, 1.0f);
    
    m_maxBound = vec3(0.0f, 0.0f, 0.0f);
    m_minBound = vec3(0.0f, 0.0f, 0.0f);

    m_mesh = nullptr;
    m_camera = nullptr;
    m_light = nullptr;

    m_renderMgr = nullptr;
    m_updateMgr = nullptr;
}

iGaiaObject3d::~iGaiaObject3d(void)
{

}

void iGaiaObject3d::ApplyObject3dSettings(iGaiaResourceMgr* _resourceMgr, iGaiaObject3dSettings const& _settings)
{
    for (ui32 i = 0; i < _settings.m_materialsSettings.size(); ++i)
    {
        iGaiaMaterialSettings materialSettings = _settings.m_materialsSettings[i];
        iGaiaMaterial* material = new iGaiaMaterial();
        material->Set_RenderState(iGaiaMaterial::RenderState::CullFace, materialSettings.m_isCullFace);
        material->Set_RenderState(iGaiaMaterial::RenderState::DepthTest , materialSettings.m_isDepthTest);
        material->Set_RenderState(iGaiaMaterial::RenderState::DepthMask , materialSettings.m_isDepthMask);
        material->Set_RenderState(iGaiaMaterial::RenderState::Blend , materialSettings.m_isBlend);
        material->Set_CullFaceMode(materialSettings.m_cullFaceMode);
        material->Set_BlendFunctionSource(materialSettings.m_blendFunctionSource);
        material->Set_BlendFunctionDestination(materialSettings.m_blendFunctionDestination);

        iGaiaShader* shader = nullptr;

        for (ui32 j = 0; j < materialSettings.m_texturesSettings.size(); ++j)
        {
            iGaiaTextureSettings textureSettings = materialSettings.m_texturesSettings[j];
            iGaiaTexture* texture = _resourceMgr->Get_Texture(textureSettings.m_name);
            texture->Set_WrapMode(textureSettings.m_wrap);
            material->Set_Texture(texture, textureSettings.m_slot);
        }
        m_materials.insert(make_pair(materialSettings.m_renderMode, material));
    }
}

void iGaiaObject3d::Set_Position(vec3 const& _position)
{
    m_position = _position;
}

vec3 iGaiaObject3d::Get_Position(void)
{
    return m_position;
}

void iGaiaObject3d::Set_Rotation(vec3 const& _rotation)
{
    m_rotation = _rotation;
}

vec3 iGaiaObject3d::Get_Rotation(void)
{
    return m_rotation;
}

void iGaiaObject3d::Set_Scale(vec3 const& _scale)
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

void iGaiaObject3d::Set_Material(iGaiaMaterial* _material, ui32 _mode)
{
    m_materials.insert(make_pair(_mode, _material));
    
    if(m_renderMgr != nullptr)
    {
        m_renderMgr->AddEventListener(&m_renderCallback, _mode);
    }
}

void iGaiaObject3d::Set_Shader(iGaiaShader* _shader, ui32 _mode)
{
    assert(m_materials.find(_mode) != m_materials.end());
    iGaiaMaterial* material = m_materials.find(_mode)->second;
    material->Set_Shader(_shader);
}

void iGaiaObject3d::Set_Texture(iGaiaTexture* _texture, ui32 _slot, ui32 _mode)
{
    assert(m_materials.find(_mode) != m_materials.end());
    iGaiaMaterial* material = m_materials.find(_mode)->second;
    material->Set_Texture(_texture, _slot);
}

void iGaiaObject3d::Set_RenderMgr(iGaiaRenderMgr *_renderMgr)
{
    m_renderMgr = _renderMgr;
}

void iGaiaObject3d::Set_UpdateMgr(iGaiaUpdateMgr* _updateMgr)
{
    m_updateMgr = _updateMgr;
}

void iGaiaObject3d::ListenRenderMgr(bool _value)
{
    assert(m_renderMgr != nullptr);
    if(_value)
    {
        for(map<ui32, iGaiaMaterial*>::iterator iterator = m_materials.begin(); iterator != m_materials.end(); ++iterator)
        {
            m_renderMgr->AddEventListener(&m_renderCallback, iterator->first);
        }
    }
    else
    {
        for(map<ui32, iGaiaMaterial*>::iterator iterator = m_materials.begin(); iterator != m_materials.end(); ++iterator)
        {
            m_renderMgr->RemoveEventListener(&m_renderCallback, iterator->first);
        }
    }
}

void iGaiaObject3d::ListenUpdateMgr(bool _value)
{
    assert(m_updateMgr != nullptr);
    if(_value)
    {
        m_updateMgr->AddEventListener(&m_updateCallback);
    }
    else
    {
        m_updateMgr->RemoveEventListener(&m_updateCallback);
    }
}

void iGaiaObject3d::Update_Receiver(f32 _deltaTime)
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_onUpdateQueue = dispatch_queue_create(g_updateQueueName.c_str(), DISPATCH_QUEUE_SERIAL);
    });
    
    if(m_updateMode == async)
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
                m_worldMatrix = worldMatrix;
            });
        });
    }
    else if(m_updateMode == sync)
    {
        mat4x4 rotationMatrix, translationMatrix, scaleMatrix, worldMatrix;
        rotationMatrix = rotate(mat4(1.0f), m_rotation.x, vec3(1.0f, 0.0f, 0.0f));
        rotationMatrix = rotate(rotationMatrix, m_rotation.z, vec3(0.0f, 0.0f, 1.0f));
        rotationMatrix = rotate(rotationMatrix, m_rotation.y, vec3(0.0f, 1.0f, 0.0f));
        
        translationMatrix = translate(mat4(1.0f), m_position);
        
        scaleMatrix = scale(mat4(1.0f), m_scale);
        
        m_worldMatrix = translationMatrix * rotationMatrix * scaleMatrix;
    }
}

ui32 iGaiaObject3d::GetDrawPriority_Receiver(void)
{
    return m_drawPriority;
}

void iGaiaObject3d::Bind_Receiver(ui32 _mode)
{
    assert(m_materials.find(_mode) != m_materials.end());
    assert(m_mesh != nullptr);
    iGaiaMaterial* material = m_materials.find(_mode)->second;
    material->Bind();
    m_mesh->Get_VertexBuffer()->Set_OperatingShader(material->Get_Shader());
    m_mesh->Bind();
}

void iGaiaObject3d::Unbind_Receiver(ui32 _mode)
{
    assert(m_materials.find(_mode) != m_materials.end());
    assert(m_mesh != nullptr);
    iGaiaMaterial* material = m_materials.find(_mode)->second;
    material->Unbind();
    m_mesh->Unbind();
}

void iGaiaObject3d::Draw_Receiver(ui32 _mode)
{
    
}
