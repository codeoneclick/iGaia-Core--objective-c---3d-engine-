//
//  iGaiaObject3d.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaObject3dClass
#define iGaiaObject3dClass

#include "iGaiaMaterial.h"
#include "iGaiaMesh.h"

#include "iGaiaCamera.h"
#include "iGaiaLight.h"

#include "iGaiaUpdateCallback.h"
#include "iGaiaRenderCallback.h"
#include "iGaiaLoadCallback.h"

#include "iGaiaRenderMgr.h"
#include "iGaiaUpdateMgr.h"

#include "iGaiaCollider.h"

class iGaiaObject3d : public iGaiaColliderData_PROTOCOL
{
public:
    
    struct iGaiaObject3dShaderSettings
    {
        iGaiaShader::iGaia_E_Shader m_shader;
        iGaiaMaterial::iGaia_E_RenderModeWorldSpace m_mode;
    };

    struct iGaiaObject3dTextureSettings
    {
        string m_name;
        iGaiaShader::iGaia_E_ShaderTextureSlot m_slot;
        iGaiaTexture::iGaia_E_TextureSettingsValue m_wrap;
    };
    
private:

protected:
    
    enum iGaia_E_UpdateMode
    {
        iGaia_E_UpdateModeSync = 0,
        iGaia_E_UpdateModeAsync
    };
    
    mat4x4 m_matrixWorld;
    
    iGaiaMaterial* m_material;
    iGaiaMesh* m_mesh;
    
    vec3 m_position;
    vec3 m_rotation;
    vec3 m_scale;
    
    vec3 m_maxBound;
    vec3 m_minBound;
    
    iGaiaCamera* m_camera;
    iGaiaLight* m_light;

    iGaia_E_UpdateMode m_updateMode;
    
    iGaiaRenderCallback m_renderCallback;
    iGaiaUpdateCallback m_updateCallback;

    virtual void OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    virtual void OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    virtual void OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    virtual ui32 OnDrawIndex(void);

    virtual void OnUpdate(void);

    virtual void ColliderDataDeserializeReceiver(iGaiaColliderDataMapper* _mapper);

    iGaiaRenderMgr* m_renderMgr;
    iGaiaUpdateMgr* m_updateMgr;

public:
    
    iGaiaObject3d(void);
    virtual ~iGaiaObject3d(void);
    
    void Set_Position(const vec3& _position);
    vec3 Get_Position(void);

    void Set_Rotation(const vec3& _rotation);
    vec3 Get_Rotation(void);
    
    void Set_Scale(const vec3& _scale);
    vec3 Get_Scale(void);

    vec3 Get_MaxBound(void);
    vec3 Get_MinBound(void);

    virtual void Set_Camera(iGaiaCamera* _camera);
    virtual void Set_Light(iGaiaLight* _light);

    void Set_Shader(iGaiaShader::iGaia_E_Shader _shader, ui32 _mode);
    void Set_Texture(const string& _name, iGaiaShader::iGaia_E_ShaderTextureSlot _slot, iGaiaTexture::iGaia_E_TextureSettingsValue _wrap);

    virtual void Set_RenderMgr(iGaiaRenderMgr* _renderMgr);
    virtual void Set_UpdateMgr(iGaiaUpdateMgr* _updateMgr);

    virtual void ListenRenderMgr(bool _value);
    virtual void ListenUpdateMgr(bool _value);
    
};

#endif
