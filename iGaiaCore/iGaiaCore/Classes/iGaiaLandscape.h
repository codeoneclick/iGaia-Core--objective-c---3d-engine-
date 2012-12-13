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

class iGaiaLandscape : public iGaiaObject3d
{
public:
    
    struct iGaiaLandscapeSettings
    {
        vector<iGaiaObject3dShaderSettings> m_shaders;
        vector<iGaiaObject3dTextureSettings> m_textures;
        f32 m_width;
        f32 m_height;
        vec2 m_scaleFactor;
    };
    
private:
    f32 m_width;
    f32 m_height;
    vec2 m_scaleFactor;
protected:
    
    void OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    
    ui32 OnDrawIndex(void);
    
    void OnLoad(iGaiaResource* _resource);
    
public:
    iGaiaLandscape(const iGaiaLandscapeSettings& _settings);
    ~iGaiaLandscape(void);
    
    void OnUpdate(void);
};

#endif