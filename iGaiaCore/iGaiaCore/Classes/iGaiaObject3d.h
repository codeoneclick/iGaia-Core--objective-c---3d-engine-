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
#include "iGaiaTouchMgr.h"

#include "iGaiaCrossCallback.h"
#include "iGaiaTouchCrossCallback.h"

class iGaiaObject3d
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
    
    mat4x4 m_worldMatrix;
    
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
    
    iGaiaCrossCallback m_crossCallback;
    iGaiaVertexBufferObject::iGaiaVertex* m_crossVertexData;

    virtual void OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    virtual void OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    virtual void OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    virtual ui32 OnDrawIndex(void);
    
    string OnRetriveGuid(void);
    virtual iGaiaVertexBufferObject::iGaiaVertex* OnRetriveVertexData(void);
    virtual ui16* OnRetriveIndexData(void);
    virtual ui32 OnRetriveNumVertexes(void);
    virtual ui32 OnRetriveNumIndexes(void);

    virtual void OnUpdate(void);

    iGaiaRenderMgr* m_renderMgr;
    iGaiaUpdateMgr* m_updateMgr;
    iGaiaTouchMgr* m_touchMgr;

public:
    
    iGaiaObject3d(void);
    virtual ~iGaiaObject3d(void);
    
    void Set_Position(vec3 const& _position);
    vec3 Get_Position(void);

    void Set_Rotation(vec3 const& _rotation);
    vec3 Get_Rotation(void);
    
    void Set_Scale(vec3 const& _scale);
    vec3 Get_Scale(void);

    vec3 Get_MaxBound(void);
    vec3 Get_MinBound(void);

    void Set_Camera(iGaiaCamera* _camera);
    void Set_Light(iGaiaLight* _light);

    void Set_Shader(iGaiaShader::iGaia_E_Shader _shader, ui32 _mode);
    void Set_Texture(string const& _name, iGaiaShader::iGaia_E_ShaderTextureSlot _slot, iGaiaTexture::iGaia_E_TextureSettingsValue _wrap);

    void Set_RenderMgr(iGaiaRenderMgr* _renderMgr);
    void Set_UpdateMgr(iGaiaUpdateMgr* _updateMgr);
    void Set_TouchMgr(iGaiaTouchMgr* _touchMgr);

    void ListenRenderMgr(bool _value);
    void ListenUpdateMgr(bool _value);
    
    void ListenUserInteraction(bool _value, iGaiaTouchCrossCallback* _listener);
};

#endif
