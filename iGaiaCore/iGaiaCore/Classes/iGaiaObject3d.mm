//
//  iGaiaObject3d.mm
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaObject3d.h"
#import "iGaiaResourceMgr.h"
#import "iGaiaStageMgr.h"
#import "iGaiaLogger.h"

static dispatch_queue_t g_onUpdateQueue;

iGaiaObject3d::iGaiaObject3d(void)
{
    m_worldMatrix = mat4x4();
    
    m_position = vec3(0.0f, 0.0f, 0.0f);
    m_rotation = vec3(0.0f, 0.0f, 0.0f);
    m_scale = vec3(1.0f, 1.0f, 1.0f);
    
    m_maxBound = vec3(0.0f, 0.0f, 0.0f);
    m_minBound = vec3(0.0f, 0.0f, 0.0f);
    
    m_material = new iGaiaMaterial();
    m_mesh = nullptr;
    
    m_updateMode = iGaia_E_UpdateModeSync;

}

iGaiaObject3d::~iGaiaObject3d(void)
{
    
}

inline void iGaiaObject3d::Set_Position(const vec3& _position)
{
    m_position = _position;
}

inline vec3 iGaiaObject3d::Get_Position(void)
{
    return m_position;
}

inline void iGaiaObject3d::Set_Rotation(const vec3& _rotation)
{
    m_rotation = _rotation;
}

inline vec3 iGaiaObject3d::Get_Rotation(void)
{
    return m_rotation;
}

inline void iGaiaObject3d::Set_Scale(const vec3& _scale)
{
    m_scale = _scale;
}

inline vec3 iGaiaObject3d::Get_Scale(void)
{
    return m_scale;
}

inline vec3 iGaiaObject3d::Get_MaxBound(void)
{
    return m_maxBound;
}

inline vec3 iGaiaObject3d::Get_MinBound(void)
{
    return m_minBound;
}

inline void iGaiaObject3d::Set_Camera(iGaiaCamera* _camera)
{
    m_camera = _camera;
}

inline void iGaiaObject3d::Set_Light(iGaiaLight* _light)
{
    m_light = _light;
}

void iGaiaObject3d::Set_Shader(iGaiaShader::iGaia_E_Shader _shader, ui32 _mode)
{
    m_material->Set_Shader(_shader, _mode);
    //[[iGaiaStageMgr sharedInstance].m_renderMgr addEventListener:self forRendeMode:(E_RENDER_MODE_WORLD_SPACE)mode];
}

void iGaiaObject3d::Set_Texture(const string& _name, iGaiaShader::iGaia_E_ShaderTextureSlot _slot, iGaiaTexture::iGaia_E_TextureSettingsValue _wrap)
{
    m_material->Set_Texture(_name, _slot, _wrap);
}

void iGaiaObject3d::OnUpdate(void)
{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        g_onUpdateQueue = dispatch_queue_create("igaia.onupdate.queue", DISPATCH_QUEUE_SERIAL);
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
                m_worldMatrix = worldMatrix;
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
        
        m_worldMatrix = translationMatrix * rotationMatrix * scaleMatrix;
    }
}

void iGaiaObject3d::OnLoad(iGaiaResource* _resource)
{
    
}

ui32 iGaiaObject3d::Get_Priority(void)
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
