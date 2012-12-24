//
//  iGaiaLandscape.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/13/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaLandscapeClass
#define iGaiaLandscapeClass

#include "iGaiaObject3d.h"
#include "iGaiaQuadTreeObject3d.h"

class iGaiaLandscape : public iGaiaObject3d
{
public:

    struct iGaiaHeightmap
    {
        f32* m_data;
        ui32 m_width;
        ui32 m_height;
        vec2 m_scaleFactor;
    };
    
    struct iGaiaLandscapeSettings
    {
        vector<iGaiaObject3dShaderSettings> m_shaders;
        vector<iGaiaObject3dTextureSettings> m_textures;
        f32 m_width;
        f32 m_height;
        vec2 m_scaleFactor;
    };
    
private:
    
    ui32 m_width;
    ui32 m_height;
    vec2 m_scaleFactor;
    f32* m_heightmapData;
    f32 m_maxAltitude;

    iGaiaTexture* m_heightmapTexture;
    iGaiaTexture* m_splattingTexture;
    
    iGaiaQuadTreeObject3d* m_quadTree;
    
protected:
    
    void OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    
    ui32 OnDrawIndex(void);
    
    void OnLoad(iGaiaResource* _resource);
    void OnUpdate(void);
    
public:
    
    iGaiaLandscape(const iGaiaLandscapeSettings& _settings);
    ~iGaiaLandscape(void);
    
    void Set_Clipping(const glm::vec4& _clipping);

    iGaiaTexture* Get_HeightmapTexture(void);
    iGaiaTexture* Get_SplattingTexture(void);

    ui32 Get_Width(void);
    ui32 Get_Height(void);
    vec2 Get_ScaleFactor(void);
    f32* Get_HeightmapData(void);
};

#endif