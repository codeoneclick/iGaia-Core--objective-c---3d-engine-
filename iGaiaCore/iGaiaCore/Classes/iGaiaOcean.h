//
//  iGaiaOcean.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaOceanClass
#define iGaiaOceanClass

#include "iGaiaObject3d.h"

class iGaiaOcean : public iGaiaObject3d
{
public:

    struct iGaiaOceanSettings
    {
        vector<iGaiaObject3dShaderSettings> m_shaders;
        vector<iGaiaObject3dTextureSettings> m_textures;
        f32 m_width;
        f32 m_height;
        f32 m_altitude;
    };

private:
    
    iGaiaTexture* m_reflectionTexture;
    iGaiaTexture* m_refractionTexture;
    iGaiaTexture* m_heightmapTexture;
    f32 m_width;
    f32 m_height;
    f32 m_altitude;
    f32 m_waveGeneratorTimer;
    f32 m_waveGeneratorInterval;
    
protected:
    
    void OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);

    ui32 OnDrawIndex(void);

    void OnLoad(iGaiaResource* _resource);
    
public:
    iGaiaOcean(const iGaiaOceanSettings& _settings);
    ~iGaiaOcean(void);

    void Set_ReflectionTexture(iGaiaTexture* _texture);
    void Set_RefractionTexture(iGaiaTexture* _texture);
    void Set_HeightmapTexture(iGaiaTexture* _texture);

    f32 Get_Altitude(void);

    void OnUpdate(void);
};

#endif