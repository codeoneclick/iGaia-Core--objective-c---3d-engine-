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
#include "iGaiaResourceMgr.h"

#include "iGaiaCrossCallback.h"
#include "iGaiaTouchCrossCallback.h"

class iGaiaObject3d : public iGaiaRenderInterface, public iGaiaUpdateInterface
{
public:

    struct iGaiaTextureSettings
    {
        string m_name;
        ui32 m_slot;
        ui32 m_wrap;
    };

    struct iGaiaShaderSettings
    {
        string m_vsName;
        string m_fsName;
    };

    struct iGaiaMaterialSettings
    {
        bool m_isCullFace;
        bool m_isBlend;
        bool m_isDepthTest;
        bool m_isDepthMask;
        ui32 m_cullFaceMode;
        ui32 m_blendFunctionSource;
        ui32 m_blendFunctionDestination;

        vector<iGaiaTextureSettings> m_texturesSettings;
        iGaiaShaderSettings m_shaderSettings;

        ui32 m_renderMode;
    };

    struct iGaiaObject3dSettings
    {
        vector<iGaiaMaterialSettings> m_materialsSettings;
    };
    
private:

protected:
    
    mat4x4 m_worldMatrix;
    
    map<ui32, iGaiaMaterial*> m_materials;
    iGaiaMesh* m_mesh;
    
    vec3 m_position;
    vec3 m_rotation;
    vec3 m_scale;
    
    vec3 m_maxBound;
    vec3 m_minBound;
    
    iGaiaCamera* m_camera;
    iGaiaLight* m_light;
    
    ui32 GetDrawPriority_Receiver(void);
    virtual void Bind_Receiver(ui32 _mode);
    virtual void Unbind_Receiver(ui32 _mode);
    virtual void Draw_Receiver(ui32 _mode);
    
    virtual void Update_Receiver(f32 _deltaTime);

    void ApplyObject3dSettings(iGaiaResourceMgr* _resourceMgr, iGaiaObject3dSettings const& _settings);

    iGaiaRenderMgr* m_renderMgr;
    iGaiaUpdateMgr* m_updateMgr;

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

    void Set_Material(iGaiaMaterial* _material, ui32 _mode);
    void Set_Shader(iGaiaShader* _shader, ui32 _mode);
    void Set_Texture(iGaiaTexture* _texture, ui32 _slot, ui32 _mode);

    void Set_RenderMgr(iGaiaRenderMgr* _renderMgr);
    void Set_UpdateMgr(iGaiaUpdateMgr* _updateMgr);

    void ListenRenderMgr(bool _value);
    void ListenUpdateMgr(bool _value);
};

#endif
